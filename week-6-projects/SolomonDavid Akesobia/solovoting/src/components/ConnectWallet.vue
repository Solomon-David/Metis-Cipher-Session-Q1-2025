<script setup>
import { ref } from "vue";
import { ethers } from "ethers";

const provider = ref(null);
const signer = ref(null);
const userAddress = ref("");

const connectWallet = async () => {
  if (!window.ethereum) {
    alert("MetaMask not detected. Please install it.");
    return;
  }

  try {
    // Request wallet connection
    await window.ethereum.request({ method: "eth_requestAccounts" });

    provider.value = await (new ethers.BrowserProvider(window.ethereum));
    
    // Wait until provider is ready before fetching the signer
    signer.value = await provider.value.getSigner();

    userAddress.value = await signer.value.getAddress();
    console.log("Wallet connected:", userAddress.value);
  } catch (error) {
    console.error("Wallet connection failed:", error);
    console.log("ethreum", window.ethereum.value)
    console.log("provider", provider.value)
    console.log("signer", signer.value)
    console.log("userAddress", userAddress.value)
  }
};

// Expose provider & signer so the parent can access them
defineExpose({ provider, signer, connectWallet });
</script>

<template>
  <button @click="connectWallet">
    {{ userAddress ? `Connected: ${userAddress.slice(0, 6)}...${userAddress.slice(-4)}` : "Connect Wallet" }}
  </button>
</template>

<style scoped>
button {
  padding: 10px 20px;
  background-color: green;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}
</style>
