import $ from 'teaspoon'
import sinon from 'sinon'
import Header from 'components/common/Header'
import { userFixture } from '__test__/helpers/fixtures'

describe('Header', () => {
  let props

  beforeEach(() => {
    props = {
      sale: userFixture(),
      onRegisterToBid: sinon.stub()
    }
  })

  it('displays the right message', () => {
    expect(
      $(Header(props))
        .text()
      ).toMatch('Log In')
  })

  xit('calls onRegisterToBid when clicked', () => {
    expect(context.onRegisterToBid.callCount).toEqual(0)
    const node = $(RegisterButton(null, context)).find('a').unwrap()
    node.props.onClick()
    expect(context.onRegisterToBid.callCount).toEqual(1)
  })
})