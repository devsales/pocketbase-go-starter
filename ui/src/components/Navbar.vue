<script setup lang="ts">
import { useRouter } from 'vue-router'
import { logout } from '../pocketbase'
import { userStore } from '../user-store'
import IconMoon from './icons/IconMoon.vue'
import IconSun from './icons/IconSun.vue'

const router = useRouter()

function onLogout() {
  logout()
  router.replace('/login')
}
</script>

<template>
  <nav
    class="flex items-center w-full h-[3.5rem] px-4 bg-base-100/60 shadow-sm sticky top-0 z-50 backdrop-blur"
  >
    <a href="/">
      <img alt="Vue logo" class="logo" src="@/assets/logo.svg" width="30" height="30" />
    </a>

    <div class="flex-1"></div>

    <div class="flex gap-4">
      <label class="swap swap-rotate">
        <!-- this hidden checkbox controls the state -->
        <input
          id="navbar-theme-controller-checkbox"
          type="checkbox"
          class="theme-controller"
          value="business"
        />

        <IconSun class="swap-on h-6 w-6 fill-current" />
        <IconMoon class="swap-off h-6 w-6 fill-current" />
      </label>

      <div class="dropdown dropdown-end">
        <div tabindex="0" role="button" class="btn btn-ghost btn-circle avatar avatar-placeholder">
          <div class="bg-neutral text-neutral-content w-10 rounded-full">
            {{ userStore.user?.name?.substring(0, 1) }}
          </div>
        </div>
        <ul
          tabindex="0"
          class="menu menu-sm dropdown-content bg-base-100 rounded-box z-1 mt-3 w-52 p-2 shadow"
        >
          <li>
            {{ userStore.user?.name }}
          </li>
          <li class="text-sm opacity-60 mb-4">
            {{ userStore.user?.email }}
          </li>
          <!-- <li>
						<a class="justify-between">
							Profile
							<span class="badge">New</span>
						</a>
					</li>
					<li><a>Settings</a></li> -->
          <li><button class="" @click="onLogout">Logout</button></li>
        </ul>
      </div>
    </div>
  </nav>
</template>
