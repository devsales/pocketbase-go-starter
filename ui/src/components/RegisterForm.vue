<script setup lang="ts">
import { ref } from 'vue'
import { register } from '../pocketbase'
import IconXCircle from './icons/IconXCircle.vue'

const emit = defineEmits(['on-registered'])

const loading = ref(false)
const hasError = ref(false)
const name = ref('')
const email = ref('')
const password = ref('')
const passwordConfirm = ref('')

async function submit() {
  try {
    hasError.value = false
    loading.value = true

    await register({
      name: name.value,
      email: email.value,
      password: password.value,
      passwordConfirm: passwordConfirm.value,
    })

    emit('on-registered')
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

        <label for="login-name" class="label">Name</label>
        <input
          v-model="name"
          id="login-name"
          class="input"
          type="text"
          placeholder="Name"
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

        <label for="login-password-confirm" class="label">Confirm Password</label>
        <input
          v-model="passwordConfirm"
          id="login-password-confirm"
          type="password"
          class="input"
          placeholder="Confirm Password"
          required
        />

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
