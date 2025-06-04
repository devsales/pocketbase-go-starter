<script setup lang="ts">
import { useRouter } from 'vue-router'
import RegisterForm from '@/components/RegisterForm.vue'

const router = useRouter()
</script>

<template>
  <div class="min-h-[100vh] flex flex-col gap-6 p-20 items-center">
    <img alt="Vue logo" class="logo" src="@/assets/logo.svg" width="60" height="60" />
    <RegisterForm @on-registered="router.replace('/login')" />

    <a class="btn-link" href="/login">Already have an account? Login here.</a>
  </div>
</template>
