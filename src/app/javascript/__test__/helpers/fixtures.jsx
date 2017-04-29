const fixture = (opts, proto) => Object.assign({}, proto, opts)

const userFixture = (opts) => (
  fixture(opts, {
    email: 'hello@friendship.com',
    name: 'Dana Barrett',
    image: 'https://images.com/pic.jpg'
  })
)
export { userFixture }
