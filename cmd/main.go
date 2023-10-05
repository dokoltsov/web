package main

import (
	"github.com/aerogo/aero"
	"io/ioutil"
)

type Hello struct {
	Message string `json:"message"`
}

func main() {
	app := aero.New()

	app.Get("/", IndexHandler())
	app.Get("/code", CodeHandler())
	app.Get("/css/*file", CssHandler())
	app.Get("/js/*file", JsHandler())
	app.Get("/fonts/*file", FileHandler())
	app.Any("/*", NotFound404Handler())
	app.Config.Ports.HTTP = 8080
	app.Run()
}

func NotFound404Handler() func(ctx aero.Context) error {
	return func(ctx aero.Context) error {
		html, err := ReadFile("dist/404.html")
		if err != nil {
			return ctx.Error(400, err)
		}
		//log.Println("404")
		return ctx.HTML(html)
	}
}

func IndexHandler() func(ctx aero.Context) error {
	return func(ctx aero.Context) error {
		html, err := ReadFile("dist/index.html")
		if err != nil {
			return ctx.Error(400, err)
		}
		//log.Println("index")
		return ctx.HTML(html)
	}
}

func CodeHandler() func(ctx aero.Context) error {
	return func(ctx aero.Context) error {
		html, err := ReadFile("dist/code.html")
		if err != nil {
			return ctx.Error(400, err)
		}
		//log.Println("code")
		return ctx.HTML(html)
	}
}

func CssHandler() func(ctx aero.Context) error {
	return func(ctx aero.Context) error {
		css, err := ReadFile("dist/css/" + ctx.Get("file"))
		if err != nil {
			return ctx.Error(400, err)
		}
		//log.Println("css")
		return ctx.CSS(css)
	}
}

func JsHandler() func(ctx aero.Context) error {
	return func(ctx aero.Context) error {
		js, err := ReadFile("dist/js/" + ctx.Get("file"))
		if err != nil {
			return ctx.Error(400, err)
		}
		//log.Println("js")
		return ctx.JavaScript(js)
	}
}

func FileHandler() func(ctx aero.Context) error {
	return func(ctx aero.Context) error {
		//log.Println("fonts")
		return ctx.File("dist/fonts/" + ctx.Get("file"))
	}
}

func ReadFile(filename string) (string, error) {
	// read file from disk
	file, err := ioutil.ReadFile(filename)
	if err != nil {
		return "", err
	}
	return string(file), nil
}
