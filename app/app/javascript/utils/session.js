// Set session storage to the store's jwt or use an existing one
// ... TODO: Recognize expired/rejected tokens
export function storeSessionJwt(jwt) {
  if (jwt) return sessionStorage.jwt = jwt
  return sessionStorage.jwt
}

// remove JWT from session storage
export function deleteSessionJwt() {
  delete sessionStorage.jwt
}