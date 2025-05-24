<script setup>
import { ref, toRaw } from "vue";
import { ethers } from "ethers";

const provider = ref("");
const signer = ref("");
const userAddress = ref("");
const error = ref(false);

const emits = defineEmits(["walletConnected"]);

const connectWallet = async () => {
  if (!window.ethereum) {
    alert("MetaMask not detected. Please install it.");
    return;
  }
  try {
    await window.ethereum.request({ method: "eth_requestAccounts" });
    provider.value = new ethers.BrowserProvider(window.ethereum);
    signer.value = await toRaw(provider.value).getSigner();
    userAddress.value = await signer.value.getAddress();
    error.value = false;
    emits("walletConnected", userAddress.value);    
  } catch (err) {
    console.error("Wallet connection failed:", err);
    error.value = true;
  }
  
};

// Expose provider & signer so the parent can access them
defineExpose({ userAddress, connectWallet });
</script>

<template>
  <div>
  <button @click="connectWallet" v-if="!error">
      {{ userAddress ? `Connected: ${userAddress.slice(0, 6)}...${userAddress.slice(-4)}` : "Connect Wallet" }}
  </button>
  <button @click="connectWallet" v-else class="errorClass">
      Error connecting wallet. Try again.
  </button>
  </div>
</template>

<style scoped>
div {
  width:100%; 
}

button {
  width: 80%;
  margin: 2% 1%;
  padding: 10px 20px;
  background-color: green;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button.errorClass {
  background-color:red;
}

</style>
