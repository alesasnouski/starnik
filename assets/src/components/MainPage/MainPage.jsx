import React from 'react'
import { Typography } from '@mui/material'
import Form from 'components/Form/Form'
import './MainPage.scss'

function MainPage() {
  return (
    <div className="container">
      <Typography className="main-header" variant="h2">Word Finder</Typography>
      <Typography className="sub-header" variant="p">Enter up to 3 wildcards (? or space)</Typography>
      <Form />
    </div>
  )
}

export default MainPage
