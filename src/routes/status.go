package routes

import (
	"net/http"

	"github.com/pocketbase/pocketbase/core"
)

func HandleStatus(e *core.RequestEvent) error {
	return e.String(http.StatusOK, "It's alive")
}
