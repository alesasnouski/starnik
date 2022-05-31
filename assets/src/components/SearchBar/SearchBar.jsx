import React, { useState } from 'react'
import InputBase from '@mui/material/InputBase'
import IconButton from '@mui/material/IconButton'
import SearchIcon from '@mui/icons-material/Search'
import { searchValidationPattern, validationRegs } from 'utils/validation'
import { debounce } from 'lodash'
import './SearchBar.scss'

function SearchBar() {
  const [searchInput, setSearchInput] = useState('')
  const [error, setError] = useState(false)

  const validateSearchInput = (value) => {
    if (!value) return false
    const actualSpaces = value.length - value.replace(/\s/g, '').length
    return actualSpaces > searchValidationPattern.allowedSpaces || !validationRegs.string.test(value)
  }

  const onChange = (e) => {
    const { value } = e.target
    setError(validateSearchInput(value))
    setSearchInput(value)
  }

  const onSearchSubmit = () => {
    if (searchInput && !error) {
      console.log('submit')
    }
  }

  const debouncedSubmit = debounce(onSearchSubmit, 750)

  return (
    <div className="search-bar">
      <InputBase
        className={`search-bar-input ${error ? 'error' : ''}`}
        placeholder="Пошук "
        fullWidth
        onChange={onChange}
      />
      <IconButton
        type="submit"
        aria-label="Лiтары - скласцi слова"
        className="search-bar-submit"
        onClick={debouncedSubmit}
      >
        <SearchIcon />
      </IconButton>
    </div>
  )
}

export default SearchBar
