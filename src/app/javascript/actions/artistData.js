import { getApi } from 'utils/api'

// Actions
import { FETCH_ARTISTS_SUCCESS, FETCH_ARTISTS_FAILURE } from 'actions/actionTypes'

// Action Creators

export const fetchArtists = ({jwt}) => {
  console.log('feltching artists...') // eslint-disable-line
  debugger
  return (dispatch) => (
    getApi('/my_top_artists', jwt)
      .then(fetchArtistsSuccess)
      .catch(fetchArtistsFailure)
  )
}

const fetchArtistsSuccess = (data) => (
  {
    type: FETCH_ARTISTS_SUCCESS,
    payload: data
  }
)

const fetchArtistsFailure = (err) => (
  {
    type: FETCH_ARTISTS_FAILURE,
    payload: err,
    error: true
  }
)
