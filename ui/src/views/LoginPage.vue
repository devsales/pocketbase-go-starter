<script setup lang="ts">
import LoginForm from '../components/LoginForm.vue'
import { useRouter } from 'vue-router'

const router = useRouter()
</script>

<template>
  <div class="min-h-[100vh] flex flex-col gap-6 p-20 items-center">
    <img alt="Vue logo" class="logo" src="@/assets/logo.svg" width="60" height="60" />
    <LoginForm @on-logged-in="router.replace('/')" />

    <a class="btn-link" href="/register">No account? Register here.</a>
  </div>
</template>
