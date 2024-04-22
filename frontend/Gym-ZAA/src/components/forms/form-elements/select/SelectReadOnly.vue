<script setup lang="ts">
import { ref } from "vue";
const items = ref(["Foo", "Bar", "Fizz", "Buzz"]);
</script>
<template>
    <div>
        <v-select
          :items="items"
          label="Selecciona"
          readonly 
          hide-details
        ></v-select>
    </div>
  </template>

  