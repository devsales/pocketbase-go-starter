<script setup lang="ts">
import { onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { subscribeToAuthChange } from '../pocketbase'
import { userStore } from '../user-store'
import Navbar from '@/components/Navbar.vue'

const router = useRouter()

onMounted(() => {
  const returnFunc = subscribeToAuthChange()

  if (!userStore.user) {
    router.push('/login')
  }

  return returnFunc
})
</script>

<template>
  <Navbar />
  <main class="">
    <div
      class="min-h-[calc(100vh-3.5rem)] bg-base-200 flex flex-col justify-center items-center gap-14"
    >
      <div class="prose lg:prose-xl text-center">
        <h1>Pocketbase Starter Project</h1>
        <p>
          A Pocketbase setup as a Go framework with Litestream for continuous backup (to S3 bucket)
          and Vue.js as a front-end framework. DaisyUI is used for styling.
        </p>
      </div>
      <div class="flex gap-4">
        <a class="btn btn-accent" href="https://pocketbase.io/docs/go-overview/" target="_blank">
          Pocketbase Doc
        </a>
        <a class="btn btn-primary" href="https://daisyui.com/" target="_blank">DaisyUI</a>
      </div>
    </div>
  </main>
</template>
