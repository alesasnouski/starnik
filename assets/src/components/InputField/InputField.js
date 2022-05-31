import React from 'react'
import PropTypes from 'prop-types'
import QuestionMark from '@mui/icons-material/QuestionMark'
import IconButton from '@mui/material/IconButton'
import { TextField, Tooltip } from '@mui/material'
import { helpers } from 'utils/helpers'
import './InputField.scss'

function InputField({ name, label, placeholder, errors, onChange }) {
  return (
    <div className="input-filed-wrapper">
      <TextField
        name={name}
        className="input-filed"
        size="small"
        label={label}
        placeholder={placeholder}
        multiline
        helperText={errors}
        error={errors.length > 0}
        onChange={onChange}
      />
      <Tooltip title={helpers[name]} arrow className="tooltip">
        <IconButton>
          <QuestionMark className="tooltip-icon" />
        </IconButton>
      </Tooltip>
    </div>
  )
}

InputField.propTypes = {
  name: PropTypes.string,
  label: PropTypes.string,
  placeholder: PropTypes.string,
  errors: PropTypes.arrayOf(PropTypes.string),
  onChange: PropTypes.func
}

export default InputField
