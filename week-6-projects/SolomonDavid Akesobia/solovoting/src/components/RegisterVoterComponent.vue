<script setup>
import { ref } from "vue";
import { ethers } from "ethers";

const contractAddress = import.meta.env.VITE_CONTRACT;
const abi = [];
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = provider.getSigner();
const contract = new ethers.Contract(contractAddress, abi, signer);

const name = ref("");
const age = ref("");
const nationality = ref("");
const statusMessage = ref("");

const registerVoter = async () => {
  try {
    const tx = await contract.registerVoter(name.value, age.value, nationality.value);
    await tx.wait();
    statusMessage.value = "Voter registered successfully!";
  } catch (error) {
    statusMessage.value = "Error registering voter: " + error.message;
  }
};
</script>

<template>
  <div class="form-container">
    <h2>Register Voter</h2>
    <input v-model="name" placeholder="Name" />
    <input v-model="age" type="number" placeholder="Age" />
    <input v-model="nationality" placeholder="Nationality" />
    <button @click="registerVoter">Register Voter</button>
    <p>{{ statusMessage }}</p>
  </div>
</template>

<style src="../assets/dialog.css">
/* Add styling */
</style>
