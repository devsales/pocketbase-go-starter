import PocketBase, { type AuthModel } from "pocketbase";
import { getInitials } from "./utils";
import { userStore } from "./user-store";

const pb = new PocketBase(import.meta.env.DEV ? 'http://127.0.0.1:8090' : '/');

export function subscribeToAuthChange() {
	userStore.setUser(getInitialUser());

	return pb.authStore.onChange((_, authRecord) => {
		userStore.setUser(mapUser(authRecord));
	});
}

export function getInitialUser(): User | null {
	if (pb.authStore.isValid) {
		return mapUser(pb.authStore.record);
	}
	return null;
}

export async function login(email: string, password: string) {
	return await pb.collection("users").authWithPassword(email, password);
}

export function logout() {
	pb.authStore.clear();
}

export function mapUser(authModel: AuthModel): User | null {
	if (authModel == null) {
		return null;
	}
	return {
		...(authModel as unknown as User),
		initials: getInitials(authModel.name)
	};
}

export interface User {
	id?: string;
	name: string;
	initials?: string;
	email: string;
	emailVisibility?: boolean;
	avatar?: string;
	username?: string;
	password?: string;
	passwordConfirm?: string;
	verified?: boolean;
	collectionName?: string;
	expand?: { [key: string]: any };
	created?: string;
	updated?: string;
}
