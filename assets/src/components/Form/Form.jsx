import React, { useState } from 'react'
import Box from '@mui/material/Box'
import { TextField } from '@mui/material'
import Button from '@mui/material/Button'
import { graphql } from '@apollo/react-hoc'
import { useLazyQuery } from '@apollo/client'
import SearchBar from 'components/SearchBar/SearchBar'
import { formValidationPattern } from 'utils/validation'
import { getWords } from 'query/words'
import './Form.scss'

console.log(getWords)
function Form() {
  const [searchInput, setSearchInput] = useState('')
  const [formState, setFormState] = useState({
    startsWith: { value: '', error: false },
    endsWith: { value: '', error: false },
    contains: { value: '', error: false },
    length: { value: '', error: false },
    containsLetters: { value: '', error: false },
    excludesLetters: { value: '', error: false },
  })
  const [getAllWords, { loading, error: reqError, data }] = useLazyQuery(getWords)

  const onSubmit = () => {
    if (searchInput) {
      console.log(searchInput)
    }
  }

  const onFormSubmit = async () => {
    const validationFailedFields = Object.values(formState).filter(val => val.error)
    if (!validationFailedFields.length) {
      await getAllWords({ variables: {
        startsWith: formState.startsWith.value,
        endsWith: formState.endsWith.value,
        contains: formState.contains.value,
        length: formState.length.value,
        containsLetters: formState.containsLetters.value,
        excludesLetters: formState.excludesLetters.value,
      } })
      console.log('data ', data)
    }
  }

  const validateField = (value, name) => value && !formValidationPattern[name].test(value)

  const onChange = (e) => {
    const { value, name } = e.target
    const error = validateField(value, name)
    setFormState({ ...formState, [name]: { ...formState[name], value, error } })
    console.log(formState)
  }

  return (
    <>
      <SearchBar onSubmit={onSubmit} setSearchInput={setSearchInput} />
      <Box className="form">
        <div className="input-row">
          <TextField
            name="startsWith"
            className="input-filed"
            size="small"
            label="Starts with"
            placeholder="Starts with"
            multiline
            helperText={formState.startsWith.error ? 'Only letters' : ''}
            error={formState.startsWith.error}
            onChange={onChange}
          />
          <TextField
            name="endsWith"
            className="input-filed"
            size="small"
            label="Ends with"
            placeholder="Ends with"
            multiline
            helperText={formState.endsWith.error ? 'Only letters' : ''}
            error={formState.endsWith.error}
            onChange={onChange}
          />
        </div>
        <div className="input-row">
          <TextField
            name="contains"
            className="input-filed"
            size="small"
            label="Contains"
            placeholder="Contains"
            multiline
            helperText={formState.contains.error ? 'Only letters' : ''}
            error={formState.contains.error}
            onChange={onChange}
          />
          <TextField
            name="length"
            className="input-filed"
            size="small"
            label="Length"
            placeholder="Length"
            multiline
            helperText={formState.length.error ? 'Only numbers' : ''}
            error={formState.length.error}
            onChange={onChange}
          />
        </div>
        <div className="input-row">
          <TextField
            name="containsLetters"
            className="input-filed"
            size="small"
            label="Includes"
            placeholder="Includes"
            multiline
            helperText={formState.containsLetters.error ? 'Only letters' : ''}
            error={formState.containsLetters.error}
            onChange={onChange}
          />
          <TextField
            name="excludesLetters"
            className="input-filed"
            size="small"
            label="Excludes"
            placeholder="Excludes"
            multiline
            helperText={formState.excludesLetters.error ? 'Only letters' : ''}
            error={formState.excludesLetters.error}
            onChange={onChange}
          />
        </div>
        <Button className="form-submit" variant="contained" onClick={onFormSubmit}>Спецпошук</Button>
      </Box>
    </>
  )
}

export default Form
