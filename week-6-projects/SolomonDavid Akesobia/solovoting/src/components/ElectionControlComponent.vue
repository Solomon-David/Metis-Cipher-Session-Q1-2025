<script setup>
import { ref } from "vue";
import { ethers } from "ethers";

const contractAddress = import.meta.env.VITE_CONTRACT;
const abi = []; // Add your contract ABI here
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = provider.getSigner();
const contract = new ethers.Contract(contractAddress, abi, signer);

const votingStartTime = ref();
const votingEndTime = ref();
const votingActive = ref(false);
const statusMessage = ref("");

// Fetch votingActive status from the contract
const getVotingStatus = async () => {
  try {
    votingActive.value = await contract.votingActive();
  } catch (error) {
    statusMessage.value = "Error fetching voting status: " + error.message;
  }
};

// Set voting start and end times
const setVotingTimes = async () => {
  try {
    const start = votingStartTime.value;
    const end = votingEndTime.value;
    if (end <= start) {
      statusMessage.value = "End time must be greater than start time!";
      return;
    }

    const tx = await contract.setVotingTimes(start, end);
    await tx.wait();
    statusMessage.value = "Voting times set successfully!";
  } catch (error) {
    statusMessage.value = "Error setting voting times: " + error.message;
  }
};

// Start the election
const startElection = async () => {
  try {
    const tx = await contract.startElection();
    await tx.wait();
    statusMessage.value = "Election started successfully!";
  } catch (error) {
    statusMessage.value = "Error starting election: " + error.message;
  }
};

// Stop the election
const stopElection = async () => {
  try {
    const tx = await contract.stopElection();
    await tx.wait();
    statusMessage.value = "Election stopped successfully!";
  } catch (error) {
    statusMessage.value = "Error stopping election: " + error.message;
  }
};

// Get voting status on load
getVotingStatus();
</script>

<template>
  <div class="form-container">
    <h2>Election Control</h2>

    <label>Voting Start Time (Minutes):</label>
    <input v-model="votingStartTime" type="number" placeholder="Enter start time" />

    <label>Voting End Time (Minutes):</label>
    <input v-model="votingEndTime" type="number" placeholder="Enter end time" />

    <button @click="setVotingTimes">Set Voting Times</button>

    <p>Voting Active: {{ votingActive }}</p>
    <button @click="startElection">Start Election</button>
    <button @click="stopElection">Stop Election</button>

    <p>{{ statusMessage }}</p>
  </div>
</template>

<style src="../assets/dialog.css">
/* Add styling */
</style>
