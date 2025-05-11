<script setup>
import { RouterLink } from "vue-router";
    defineProps({
        title: String,
        desc: String,
        link: String
    })
</script>

<template>
    <RouterLink :to="link">        
        <h3>{{ title }}</h3>
        <span>{{ desc }}</span>
    </RouterLink>
</template>

<style>

    a{
        text-decoration: none;
        border:3px solid green;
        background-color: lightcyan;
        color:black;
        padding:1vh 2vw 3vh;
        border-radius: 0.8vw;
        width: 40vw;
        align-self: center;
        transition: all 0.45s 1ms;
    }

    a:hover{
        background-color: green;
        color:white;
        /* padding: 1vh 2vw 2.5vh; */
        font-size: 16pt;
    }

    a:hover h3{
        color:white;
        font-size: 18pt;
    }

    h3{
        margin-block: 0;
        color:green;
    }

    @media screen and (max-width:750px) {
        a{
            padding: 1vh;
            width:75vw;
            border-radius: 2vw;
        }

    }
</style>

