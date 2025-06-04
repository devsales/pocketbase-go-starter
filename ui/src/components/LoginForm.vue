<script setup lang="ts">
import { ref } from 'vue'
import { login } from '../pocketbase'
import IconXCircle from './icons/IconXCircle.vue'

const emit = defineEmits(['on-logged-in'])

const loading = ref(false)
const hasError = ref(false)
const email = ref('')
const password = ref('')

async function submit() {
  try {
    hasError.value = false
    loading.value = true

    await login(email.value, password.value)

    emit('on-logged-in')
  } catch (error) {
    console.error(error)
    hasError.value = true
    setTimeout(() => {
      hasError.value = false
    }, 3000)
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <form class="card bg-base-100 w-full max-w-sm shrink-0 shadow-xl" @submit.prevent="submit">
    <div class="card-body">
      <fieldset class="fieldset">
        <label for="login-email" class="label">Email</label>
        <input
          v-model="email"
          id="login-email"
          class="input"
          type="text"
          placeholder="Email"
          required
        />

        <label for="login-password" class="label">Password</label>
        <input
          v-model="password"
          id="login-password"
          type="password"
          class="input"
          placeholder="Password"
          required
        />

        <!-- <div><a class="link link-hover">Forgot password?</a></div> -->
        <button class="btn btn-primary mt-4" type="submit">
          <span v-if="loading" class="loading loading-spinner loading-xs"></span>
          Login
        </button>
      </fieldset>
    </div>
  </form>

  <div v-if="hasError" class="toast toast-center">
    <div role="alert" class="alert alert-error">
      <span>Login failed</span>
      <div>
        <button class="btn btn-sm btn-square btn-ghost" @click="hasError = false">
          <IconXCircle class="h-6 w-6 shrink-0 stroke-current" />
        </button>
      </div>
    </div>
  </div>
</template>
