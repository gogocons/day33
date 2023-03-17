<script lang="ts">
  import { ethers } from "ethers";
  import token from "./lib/token.json";

  let provider;

  let transferAddress: string;
  let transferAmount: number;

  async function connectWallet() {
    const provider = new ethers.providers.Web3Provider(
      (window as any).ethereum,
      "any"
    );

    // await provider.send("eth_requestAccounts", []);

    const tokenAddress = "0x5BAbEDD8CAf495909a89162Fc359d6E4a00dEbA3";
    const contract = new ethers.Contract(tokenAddress, token.abi, provider);

    const tokenSymbol = await contract.symbol();

    const balance = await contract.balanceOf(
      await provider.getSigner().getAddress()
    );

    alert(balance);
  }

  async function transfer() {
    const provider = new ethers.providers.Web3Provider(
      (window as any).ethereum,
      "any"
    );

    // await provider.send("eth_requestAccounts", []);

    const tokenAddress = "0x5BAbEDD8CAf495909a89162Fc359d6E4a00dEbA3";
    const contract = new ethers.Contract(tokenAddress, token.abi, provider.getSigner());

    const transfer = await contract.transfer(transferAddress, transferAmount * 1000000000000);

    console.log(transfer);
  }
</script>

<main>
  <div class="container mx-auto pt-4 space-y-4">
    <button class="btn" on:click={connectWallet}>Connect</button>
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
          bind:value={transferAmount}
          placeholder="1000"
          class="input input-bordered"
        />
        <span>GOGO</span>
      </label>
    </div>
    <button class="btn" on:click={transfer}>Transfer</button>
  </div>
</main>
