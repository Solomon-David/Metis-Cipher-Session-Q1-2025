<script setup>
import { ref } from "vue";
import AddContestantComponent from "../components/AddContestantComponent.vue";
import RegisterVoterComponent from "../components/RegisterVoterComponent.vue";
import ElectionControlComponent from "../components/ElectionControlComponent.vue";

const activeSection = ref(null);

// Toggle visibility of sections
const toggleSection = (section) => {
  activeSection.value = activeSection.value === section ? null : section;
  
};
</script>

<template>
  <main class="admin-container">
    <h1>Admin Dashboard</h1>

    <div class="section">
      <button :class="{active : activeSection === 'contestants'}" @click="toggleSection('contestants')">➤ Add Contestants</button>
      <div v-if="activeSection === 'contestants'" class="content">
        <AddContestantComponent />
      </div>
    </div>

    <div class="section">
      <button :class="{active:activeSection === 'voters'}" @click="toggleSection('voters')">➤ Register Voters</button>
      <div v-if="activeSection === 'voters'" class="content">
        <RegisterVoterComponent />
      </div>
    </div>

    <div class="section">
      <button :class="{active:activeSection === 'election'}" @click="toggleSection('election')">➤ Election Control</button>
      <div v-if="activeSection === 'election'" class="content">
        <ElectionControlComponent />
      </div>
    </div>
  </main>
</template>

<style scoped>
.admin-container {
  width:50%;
  height:100%;
  align-self: center;
  justify-self: center;
  text-align: center;
}

.section {
  width: 50vw;
  margin-bottom: 15px;
  position: relative;
}

button {
  width: 100%;
  padding: 10px;
  background: white;
  color: green;
  border: 2px solid green;
  cursor: pointer;
  font-size: 16px;
  text-align: left;
}

button.active, button:hover {
  background: darkgreen;
  color:white;
}

button.active{
  border-bottom: none;
  
}

.content {
  display:content;
  width: 99%;
  border: 2px solid green;
  border-top: none;
  border-radius: 0 0 7.5px 7.5px;
  background: white;
  position: absolute;
  z-index: 5;
}


</style>
