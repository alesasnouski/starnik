const path = require('path')
const ESLintPlugin = require('eslint-webpack-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const { CleanWebpackPlugin } = require('clean-webpack-plugin')

module.exports = {
  mode: 'development',
  entry: './src/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, './dist'),
    clean: true
  },
  module: {
    rules: [
      {
        test: /\.(jsx|js)x?$/i,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              '@babel/preset-env',
              '@babel/preset-react'
            ],
          },
        },
      },
      {
        test: /\.(sa|sc|c)ss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'sass-loader',
        ]
      },
      {
        test: /\.graphql?$/,
        loader: 'graphql-tag/loader'
      }
    ],
  },
  resolve: {
    alias: {
      components: path.resolve(__dirname, './src/components/'),
      utils: path.resolve(__dirname, './src/utils/'),
      query: path.resolve(__dirname, './src/query/'),
    },
    extensions: ['.jsx', '.js']
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './public/index.html',
    }),
    new MiniCssExtractPlugin({
      filename: 'bundle.css',
    }),
    new ESLintPlugin({
      extensions: ['.jsx', '.js'],
      failOnWarning: false,
      emitWarning: false
    }),
    new CleanWebpackPlugin()
  ],
}
