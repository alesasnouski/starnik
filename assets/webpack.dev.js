const path = require('path')
const { merge } = require('webpack-merge')
const common = require('./webpack.common')

module.exports = merge(common, {
  devtool: 'inline-source-map',
  devServer: {
    historyApiFallback: true,
    port: 3000,
    open: true,
    hot: true,
    static: {
      directory: path.join(__dirname, 'dist'),
    },
    // compress: true,
    // proxy: {
    //   '/api': 'http://server:8000',
    // }
  }
})
