package main

import (
	"log"

	"github.com/devsales/pocketbase-go-starter/src/routes"
	"github.com/devsales/pocketbase-go-starter/ui"
	"github.com/pocketbase/pocketbase"
	"github.com/pocketbase/pocketbase/apis"
	"github.com/pocketbase/pocketbase/core"
)

func main() {
	app := pocketbase.New()

	app.OnServe().BindFunc(func(se *core.ServeEvent) error {
		// serves static files from the provided public dir (if exists)
		se.Router.GET("/{path...}", apis.Static(ui.DistDirFS, true)).
			BindFunc(func(e *core.RequestEvent) error {
				// add default Cache-Control header for all ui resources // (ignoring the root path)
				if e.Request.URL.Path != "/" {
					e.Response.Header().Set("Cache-Control", "max-age=1209600, stale-while-revalidate=86400")
				}
				return e.Next()
			}).Bind(apis.Gzip())

		routes.RegisterRoutes(se)

		return se.Next()
	})

	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
