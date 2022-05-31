import React from 'react'
import { Typography } from '@mui/material'
import Form from 'components/Form/Form'
import './MainPage.scss'

function MainPage() {
  return (
    <div className="container">
      <Typography className="main-header" variant="h2">Пошук</Typography>
      <Typography className="sub-header" variant="p">Не больш за 3 прабелы (літары-невядомкі)</Typography>
      <Form />
    </div>
  )
}

export default MainPage
