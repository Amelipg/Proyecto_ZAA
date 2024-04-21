<script setup lang="ts">
// assets
import imageEmpty from '@/assets/images/products/empty-shopping-cart.svg';
</script>

<template>
    <v-row class="justify-center mt-10">
        <v-col class="text-center" lg="7">
            <v-img :src="imageEmpty" alt="cover" />
            <h1 class="text-h1 mt-6">No existe el producto</h1>
            <p>Intente revisar su ortografía o utilice términos más generales.</p>
        </v-col>
    </v-row>
</template>
