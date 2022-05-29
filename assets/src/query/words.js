import { gql } from '@apollo/client'

export const getWords = gql`
  query {
    words {
      startsWith
      endsWith
      limit
      length
      containsLetters
      excludesLetters
      like
    }
  }
`
