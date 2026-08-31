const { ethers } = require('hardhat');
const { expect } = require('chai');
const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');

const name = 'My Token';
const symbol = 'MTKN';
const initialSupply = 100n;

async function fixture() {
  const [holder, recipient] = await ethers.getSigners();

  const token = await ethers.deployContract('$ERC20Seizable', [name, symbol]);
  await token.$_mint(holder, initialSupply);

  return { holder, recipient, token };
}

// Composition with restriction-based extensions (freeze / block bypass) is covered by the
// ERC20Freezable, ERC20Restricted and ERC20uRWA suites; here we test ERC20Seizable in isolation.
describe('ERC20Seizable', function () {
  beforeEach(async function () {
    Object.assign(this, await loadFixture(fixture));
  });

  describe('_seize', function () {
    it('moves tokens from one account to another, emitting Transfer and ForcedTransfer', async function () {
      const value = 40n;
      await expect(this.token.$_seize(this.holder, this.recipient, value))
        .to.emit(this.token, 'Transfer')
        .withArgs(this.holder, this.recipient, value)
        .to.emit(this.token, 'ForcedTransfer')
        .withArgs(this.holder, this.recipient, value);

      await expect(this.token.balanceOf(this.holder)).to.eventually.equal(initialSupply - value);
      await expect(this.token.balanceOf(this.recipient)).to.eventually.equal(value);
    });

    it('reverts when seizing more than the balance', async function () {
      await expect(this.token.$_seize(this.holder, this.recipient, initialSupply + 1n))
        .to.be.revertedWithCustomError(this.token, 'ERC20InsufficientBalance')
        .withArgs(this.holder, initialSupply, initialSupply + 1n);
    });
  });

  describe('forced context', function () {
    // $ERC20SeizableMock adds a stand-in _update restriction that rejects non-forced transfers,
    // so we can observe that _seize runs _update within the forced context (skipping such logic).
    beforeEach(async function () {
      this.token = await ethers.deployContract('$ERC20SeizableMock', [name, symbol]);
      await this.token.$_mint(this.holder, initialSupply);
    });

    it('runs _update in the forced context, skipping logic that honors _isForcedTransfer', async function () {
      // a normal transfer is rejected by the stand-in restriction...
      await expect(this.token.connect(this.holder).transfer(this.recipient, 10n)).to.be.revertedWithCustomError(
        this.token,
        'ERC20SeizableMockNotForced',
      );

      // ...but a seizure runs _update with _isForcedTransfer() == true, so the restriction stands down
      await expect(this.token.$_seize(this.holder, this.recipient, 10n))
        .to.emit(this.token, 'ForcedTransfer')
        .withArgs(this.holder, this.recipient, 10n);
      await expect(this.token.balanceOf(this.recipient)).to.eventually.equal(10n);
    });

    it('clears the forced context after seizing (a later normal transfer is restricted again)', async function () {
      await this.token.$_seize(this.holder, this.recipient, 10n);

      // the context is scoped to the seizure: a subsequent normal transfer is restricted again
      await expect(this.token.connect(this.recipient).transfer(this.holder, 1n)).to.be.revertedWithCustomError(
        this.token,
        'ERC20SeizableMockNotForced',
      );
    });
  });
});
