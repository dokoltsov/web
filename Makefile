
webpack:
	npx webpack --config webpack.config.js --mode production


build:
	docker build -t frontend .


buildx:
	docker buildx build -f ./Dockerfile -t forzalino/frontend:dev --push . --platform linux/amd64,linux/arm64


run:
	docker run -it --rm -p 8080:80 frontend


npm:
	npm install --save-dev webpack webpack-cli file-loader url-loader html-webpack-plugin mini-css-extract-plugin css-minimizer-webpack-plugin terser-webpack-plugin @babel/core babel-loader @babel/preset-env css-loader style-loader