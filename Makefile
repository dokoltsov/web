
webpack:
	npx webpack --config webpack.config.js --mode production


build-local:
	docker build -t forzalino/web:dev .


run-local:
	docker run -it --rm -p 8080:80 forzalino/web:dev


build-push:
	docker buildx build -f ./Dockerfile -t forzalino/web:dev --push . --platform linux/amd64,linux/arm64


npm-install:
	npm install --save-dev webpack webpack-cli file-loader url-loader html-webpack-plugin mini-css-extract-plugin css-minimizer-webpack-plugin terser-webpack-plugin @babel/core babel-loader @babel/preset-env css-loader style-loader


hey:
	hey -c 10 -z 30s -m GET goxo.cc
	# -n num requests
	# -c num concurrent requests
	# -z duration of test
	# -m http method
	# -q rate limit per second per worker
	# -t timeout per request