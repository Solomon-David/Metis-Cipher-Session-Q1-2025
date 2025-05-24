<script setup>
import { ref, onMounted, watch } from "vue";
import { ethers } from "ethers";

const contractAddress = import.meta.env.VITE_CONTRACT;
const abi = [ /* Your Contract ABI */ ];

const provider = ref(null);
const signer = ref(null);
const contract = ref(null);

const name = ref("");
const age = ref("");
const party = ref("");
const manifesto = ref("");
const statusMessage = ref("");

// You may want to set up provider and signer here directly, or via another method
// Example placeholder for manual provider/signer setup
const setupEthers = async () => {
  // Example: window.ethereum injected by MetaMask
  if (window.ethereum) {
    provider.value = new ethers.BrowserProvider(window.ethereum);
    signer.value = await provider.value.getSigner();
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

onMounted(setupEthers);
</script>

<template>
  <div class="form-container">
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
