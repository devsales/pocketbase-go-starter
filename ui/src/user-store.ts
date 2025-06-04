import { reactive } from 'vue'
import { type User } from './pocketbase'

interface UserStore {
  user: User | null
  setUser: (newUser: User | null) => void
}

export const userStore = reactive<UserStore>({
  user: null,
  setUser(newUser) {
    this.user = newUser
  },
})
