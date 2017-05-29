// // Set session storage to the store's jwt or use an existing one
// // ... TODO: Recognize expired/rejected tokens
// export const storeSessionJwt = (jwt) => {
//   if (jwt) return sessionStorage.jwt = jwt
//   return sessionStorage.jwt
// }

// remove JWT from session storage (?needed?)
export const logoutSession = () => {
  console.log('logging out of session')
  delete sessionStorage.jwt
}

