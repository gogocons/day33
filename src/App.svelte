<script lang="ts">
  import { ethers } from "ethers";
  import token from "./lib/token.json";

  let provider;

  let tokenData = {
    tokenName: null,
    tokenSymbol: null,
    totalSupply: null,
  };

  let transferAddress: string;
  let transferEntry: string;

  async function connectWallet() {
    const provider = new ethers.providers.Web3Provider(
      (window as any).ethereum,
      "any"
    );

    // await provider.send("eth_requestAccounts", []);

    const tokenAddress = "0x5BAbEDD8CAf495909a89162Fc359d6E4a00dEbA3";
    const contract = new ethers.Contract(tokenAddress, token.abi, provider);

    tokenData.tokenName = await contract.name();
    tokenData.tokenSymbol = await contract.symbol();
    const totalSupplyWei = await contract.totalSupply();

    tokenData.totalSupply = ethers.utils.formatEther(totalSupplyWei);

    const balance = await contract.balanceOf(
      await provider.getSigner().getAddress()
    );
  }

  async function transfer() {
    const provider = new ethers.providers.Web3Provider(
      (window as any).ethereum,
      "any"
    );

    const tokenAddress = "0x5BAbEDD8CAf495909a89162Fc359d6E4a00dEbA3";
    const contract = new ethers.Contract(
      tokenAddress,
      token.abi,
      provider.getSigner()
    );

    const validAddress = await ethers.utils.isAddress(transferAddress);
    const transferInWei = ethers.utils.parseEther(transferEntry);

    if (validAddress) {
      await contract.transfer(transferAddress, transferInWei);
    }
  }
</script>

<main>
  <div class="container mx-auto pt-4">
    <div class="grid place-items-center space-y-4">
      {#if tokenData.tokenName !== null}
        <div class="stats shadow">
          <div class="stat place-items-center">
            <div class="stat-title">Name</div>
            <div class="stat-value">{tokenData.tokenName}</div>
          </div>

          <div class="stat place-items-center">
            <div class="stat-title">Symbol</div>
            <div class="stat-value">{tokenData.tokenSymbol}</div>
          </div>

          <div class="stat place-items-center">
            <div class="stat-title">Total Supply</div>
            <div class="stat-value">{tokenData.totalSupply}</div>
          </div>
        </div>
      {/if}
      <button class="btn" on:click={connectWallet}>Get Token Stats</button>
      <div class="form-control">
        <label for="transfer" class="label">
          <span class="label-text">Enter address:</span>
        </label>
        <label class="input-group">
          <input
            type="text"
            bind:value={transferAddress}
            placeholder="0xBLABLA"
            class="input input-bordered"
          />
          <span>ADDY</span>
        </label>
      </div>
      <div class="form-control">
        <label for="transfer" class="label">
          <span class="label-text">Enter amount:</span>
        </label>
        <label class="input-group">
          <input
            type="text"
            bind:value={transferEntry}
            placeholder="1"
            class="input input-bordered"
          />
          <span>GOGO</span>
        </label>
      </div>
      <button class="btn" on:click={transfer}>Transfer</button>
    </div>
  </div>
</main>
