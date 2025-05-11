<script setup>
  import OptionsComponent from "../components/OptionsComponent.vue"
</script>

<template>
  <main>
    <div class="intro">
      <p>Select an option</p>
    </div>
      
    <div class="options">
        <OptionsComponent link="admin" desc="For administrative actions" title="Admin Section" />
        <OptionsComponent link="voters" desc="For voting and electorial activities" title="Voters Section" />
    </div>
  </main>
</template>


<style>

  div.intro>p{
    font-size: 14pt;
    font-weight: bold;
    text-align: center;
  }

  div.options{
    margin: auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 5vh;
  }
  main{
    height: 100%;
  }
  
</style>
