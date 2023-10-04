const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');

module.exports = {
    entry: {
      main: './src/js/main.js',
      prism: './src/js/prism.js',
    },
  output: {
//    filename: 'js/[name].min.js',
    filename: '[name].min.js',
    path: path.resolve(__dirname, 'dist'),
  },
  module: {

    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: 'babel-loader',
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader'],
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/,
        use: [
            {
              loader: 'url-loader',
              options: {
                limit: 8192, // Convert files smaller than 8KB to base64-encoded data URLs
//                name: 'fonts/[name].[ext]', // Output font files to 'dist/fonts' directory
                name: '[name].[ext]', // Output font files to 'dist/fonts' directory
              },
            },
        ],
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/,
        use: [
            {
              loader: 'file-loader',
              options: {
//                name: 'fonts/[name].[ext]', // Output font files to 'dist/fonts' directory
                name: '[name].[ext]', // Output font files to 'dist/fonts' directory
              },
            },
          ],
        },

    ],
  },
  optimization: {
    minimizer: [
      new TerserPlugin(),
      new CssMinimizerPlugin()
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/html/index.html',
      filename: 'index.html'
    }),
    new HtmlWebpackPlugin({
      template: './src/html/code.html',
      filename: 'code.html',
    }),
    new MiniCssExtractPlugin({
//      filename: 'css/[name].min.css',
      filename: '[name].min.css',
    }),
  ]
};