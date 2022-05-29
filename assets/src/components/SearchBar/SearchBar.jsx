import React from 'react'
import PropTypes from 'prop-types'
import InputBase from '@mui/material/InputBase'
import IconButton from '@mui/material/IconButton'
import SearchIcon from '@mui/icons-material/Search'
import { debounce } from 'lodash'
import './SearchBar.scss'

function SearchBar({ onSubmit, setSearchInput }) {
  const onChange = (e) => {
    setSearchInput(e.target.value)
  }

  const debouncedSubmit = debounce(onSubmit, 750)

  return (
    <div className="search-bar">
      <InputBase
        className="search-bar-input"
        placeholder="Search "
        fullWidth
        onChange={onChange}
        error
      />
      <IconButton type="submit" aria-label="search" className="search-bar-submit" onClick={debouncedSubmit}>
        <SearchIcon />
      </IconButton>
    </div>
  )
}

SearchBar.propTypes = {
  onSubmit: PropTypes.func,
  setSearchInput: PropTypes.func
}

export default SearchBar
