<script setup>
import { ref, onMounted, watch } from "vue";
import { ethers } from "ethers";
import ConnectWallet from "../components/ConnectWallet.vue"; // Import component

const contractAddress = import.meta.env.VITE_CONTRACT;
const abi = [ /* Your Contract ABI */ ];

const walletRef = ref(null); // Reference for ConnectWallet component
const provider = ref(null);
const signer = ref(null);
const contract = ref(null);

const name = ref("");
const age = ref("");
const party = ref("");
const manifesto = ref("");
const statusMessage = ref("");

const setupEthers = async () => {
  if (!walletRef.value) return;

  provider.value = walletRef.value.provider;
  signer.value = walletRef.value.signer;

  if (signer.value) {
    contract.value = new ethers.Contract(contractAddress, abi, signer.value);
  }
};

const addContestant = async () => {
  if (!contract.value) {
    statusMessage.value = "Contract not loaded!";
    return;
  }

  try {
    const tx = await contract.value.addContestant(name.value, Number(age.value), party.value, manifesto.value);
    await tx.wait();
    statusMessage.value = "Contestant added successfully!";
  } catch (error) {
    statusMessage.value = "Error adding contestant: " + (error.reason || error.message);
  }
};

// Watch for wallet connection and update values
watch(walletRef, setupEthers);
</script>

<template>
  <div class="form-container">
    <ConnectWallet ref="walletRef" /> <!-- Connect Wallet Button -->

    <h2>Add Contestant</h2>
    <input v-model="name" placeholder="Name" />
    <input v-model="age" type="number" placeholder="Age" />
    <input v-model="party" placeholder="Party" />
    <textarea v-model="manifesto" placeholder="Manifesto"></textarea>
    <button @click="addContestant">Add Contestant</button>
    <p>{{ statusMessage }}</p>
  </div>
</template>

<style src="../assets/dialog.css"></style>
