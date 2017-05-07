import $ from 'teaspoon'
import React from 'react'
// import ReactTestRenderer from 'react-test-renderer'
// import sinon from 'sinon'
// import ReactDOM
import { Header } from 'components/common/Header'
import { userFixture } from '__test__/helpers/fixtures'

describe('Header', () => {
  let props, element

  beforeEach(() => {
    props = {}
      // user: userFixture(),
    // }
  })

  describe('not logged in', () => {
    it('displays the login link', () => {
      props.isLoggedIn = false
      element = <Header {...props} />
      expect($(element).render().text()).toMatch('Log In')
    })
  })
})
