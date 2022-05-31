import React, { useState } from 'react'
import Box from '@mui/material/Box'
import Button from '@mui/material/Button'
import { graphql } from '@apollo/react-hoc'
import { useLazyQuery } from '@apollo/client'
import { getWords } from 'query/words'
import SearchBar from 'components/SearchBar/SearchBar'
import { formValidationPattern } from 'utils/validation'
import { debounce } from 'lodash'
import InputField from '../InputField/InputField'
import './Form.scss'

console.log(getWords)

function Form() {
  const [formState, setFormState] = useState({
    startsWith: { value: '', errors: [] },
    endsWith: { value: '', errors: [] },
    contains: { value: '', errors: [] },
    length: { value: '', errors: [] },
    containsLetters: { value: '', errors: [] },
    excludesLetters: { value: '', errors: [] },
  })
  // const [getAllWords, { loading, error: reqError, data }] = useLazyQuery(getWords)

  const onFormSubmit = async () => {
    const validationFailedFields = Object.values(formState).filter(val => val.error)
    // if (!validationFailedFields.length) {
    //   await getAllWords({ variables: {
    //     startsWith: formState.startsWith.value,
    //     endsWith: formState.endsWith.value,
    //     contains: formState.contains.value,
    //     length: formState.length.value,
    //     containsLetters: formState.containsLetters.value,
    //     excludesLetters: formState.excludesLetters.value,
    //   } })
    //   console.log('data ', data)
    // }
  }

  const validateField = (value, name) => {
    if (!value) return []
    const validationRules = formValidationPattern[name]
    let errors = [...formState[name].errors]
    validationRules.forEach(rule => {
      if (rule.pattern.test(value)) {
        errors = errors.filter(error => error !== rule.message)
      } else {
        !errors.includes(rule.message) && errors.push(rule.message)
      }
    })
    return errors
  }

  const onChange = (e) => {
    const { value, name } = e.target
    const errors = validateField(value, name)
    setFormState({ ...formState, [name]: { ...formState[name], value, errors } })
  }

  const debouncedSubmit = debounce(onFormSubmit, 750)

  return (
    <>
      <SearchBar />
      <Box className="form">
        <div className="input-row">
          <InputField
            name="startsWith"
            label="У пачатку"
            placeholder="У пачатку"
            errors={formState.startsWith.errors}
            onChange={onChange}
          />
          <InputField
            name="endsWith"
            label="У канцы"
            placeholder="У канцы"
            errors={formState.endsWith.errors}
            onChange={onChange}
          />
        </div>
        <div className="input-row">
          <InputField
            name="contains"
            label="Спалучэнне"
            placeholder="Спалучэнне"
            errors={formState.contains.errors}
            onChange={onChange}
          />
          <InputField
            name="length"
            label="Даужыня"
            placeholder="Даужыня"
            errors={formState.length.errors}
            onChange={onChange}
          />
        </div>
        <div className="input-row">
          <InputField
            name="containsLetters"
            label="Ëсць"
            placeholder="Ëсць"
            errors={formState.containsLetters.errors}
            onChange={onChange}
          />
          <InputField
            name="excludesLetters"
            label="Няма"
            placeholder="Няма"
            errors={formState.excludesLetters.errors}
            onChange={onChange}
          />
        </div>
        <Button className="form-submit" variant="contained" onClick={debouncedSubmit}>Спецпошук</Button>
      </Box>
    </>
  )
}

export default Form
