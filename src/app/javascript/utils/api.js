import rp from 'request-promise'

export const getApi = (endpoint, jwt) => {
  console.log()
  return rp(authenticatedOptions(endpoint, {jwt}))
}

const authenticatedOptions = (endpoint, {jwt}) => (
  {
    uri: `${window.constants.API_PATH}${endpoint}`,
    qs: { },  // query
    headers: {
      'Authorization': `Bearer ${jwt}`
    },
    json: true // Automatically parses the JSON string in the response
  }
)

export const getArtists = (opts={}) => {
  rp.get
}
