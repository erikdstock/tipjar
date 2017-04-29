import $ from 'teaspoon'
import Header from 'components/common/Header'
import sinon from 'sinon'
// import { saleFixture } from '__test__/helpers/fixtures'

describe('Header', () => {
  let props

  beforeEach(() => {
    props = {
      sale: saleFixture(),
      onRegisterToBid: sinon.stub()
    }
  })

  it('displays the right message', () => {
    expect(
      $(RegisterButton(null, context))
        .text()
      ).toMatch('Register to bid')
  })

  it('calls onRegisterToBid when clicked', () => {
    expect(context.onRegisterToBid.callCount).toEqual(0)
    const node = $(RegisterButton(null, context)).find('a').unwrap()
    node.props.onClick()
    expect(context.onRegisterToBid.callCount).toEqual(1)
  })
})