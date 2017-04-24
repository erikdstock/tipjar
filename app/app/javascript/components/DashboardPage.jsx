import React from 'react'
import PropTypes from 'prop-types'
import ReactDOM from 'react-dom'
import {connect} from 'react-redux'

const DashboardPage = props => (
  <div>Dashboard Page</div>
)

DashboardPage.propTypes = {
  name: PropTypes.string
}
//TODO: Figure out if the router needs to connect() or every container component does
function mapStateToProps (state, ownProps) {
    return state
}

export default connect(mapStateToProps)(DashboardPage)
