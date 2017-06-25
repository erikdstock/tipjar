// Actions
import { LOG_IN_SUCCESS, LOG_OUT } from 'actions/actionTypes'

// Action Creators
export const logInSuccess = (jwt) => (
  {
    type: LOG_IN_SUCCESS,
    jwt
  }
)

export const logOut = () => (
  { type: LOG_OUT }
)
