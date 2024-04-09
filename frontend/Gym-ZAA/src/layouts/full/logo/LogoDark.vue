<script setup lang="ts">
import { RouterLink } from 'vue-router';
import logo from '@/assets/images/logos/bulls_logo-white.svg';
</script>
<template>
    <div class="logo">
        <RouterLink to="/home">
            <img :src="logo" alt="home" />
        </RouterLink>
    </div>
</template>
