package routes

import (
	"net/http"

	"github.com/pocketbase/pocketbase/core"
)

func RegisterRoutes(se *core.ServeEvent) {
	// register "GET /hello/{name}" route (allowed for everyone)
	se.Router.GET("/hello/{name}", func(e *core.RequestEvent) error {
		name := e.Request.PathValue("name")

		return e.String(http.StatusOK, "Hello "+name)
	})

	// https://pocketbase.io/docs/go-routing/
	// If your route path starts with /api/ consider combining it with your unique app name like /api/myapp/... to avoid collisions with system routes.
	se.Router.GET("/api/myapp/status", func(e *core.RequestEvent) error {
		return HandleStatus(e)
	})
}
