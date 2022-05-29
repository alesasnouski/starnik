import React from 'react'
import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider,
  // useQuery,
  // gql
} from '@apollo/client'
import MainPage from 'components/MainPage/MainPage'
import './index.scss'

const client = new ApolloClient({
  uri: 'http://localhost:8000/graphiql?',
  cache: new InMemoryCache()
})

function App() {
  return (
    <ApolloProvider client={client}>
      <MainPage />
    </ApolloProvider>
  )
}

export default App
