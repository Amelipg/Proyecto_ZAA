<script setup lang="ts">
import { RouterLink } from 'vue-router';
import Darklogo from '@/assets/images/logos/bulls_logo.svg';
</script>
<template>
    <div class="logo">
        <RouterLink to="/home">
            <img :src="Darklogo" alt="home" />
        </RouterLink>
    </div>
</template>
