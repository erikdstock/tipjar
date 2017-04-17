import React from 'react'
import PropTypes from 'prop-types'
import ReactDOM from 'react-dom'

const DashboardPage = props => (
  <div>Dashboard Page</div>
)

DashboardPage.defaultProps = {
  name: 'David'
}

DashboardPage.propTypes = {
  name: PropTypes.string
}

export default DashboardPage
