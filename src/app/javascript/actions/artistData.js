import { FETCH_ARTISTS_SUCCESS } from 'actions/actionTypes'

export const fetchArtists = () => {
  console.log('fetching artists...')
  return (dispatch) => {
    dispatch(fetchArtistsSuccess([{name: 'Barry'}]))
  }
}

export const fetchArtistsSuccess = (artists) => (
  {
    type: FETCH_ARTISTS_SUCCESS,
    artists
  }
)
