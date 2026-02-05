package handler

import (
	"context"
	"net/http"
	"strconv"

	"{{ .ModuleName }}/internal/service"
	"{{ .ModuleName }}/pkg/response"
)

type {{ .Name | lower }}Handler struct {
	svc service.{{ .Name }}Service
}

func New{{ .Name }}Handler(svc service.{{ .Name }}Service) *{{ .Name | lower }}Handler {
	return &{{ .Name | lower }}Handler{svc: svc}
}

func (h *{{ .Name | lower }}Handler) Fetch(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	limit, offset := parsePagination(r)
	items, total, err := h.svc.Fetch{{ .Name }}s(ctx, limit, offset)
	if err != nil {
		response.Error(w, http.StatusInternalServerError, "fetch_failed")
		return
	}
	response.JSON(w, http.StatusOK, map[string]any{
		"items": items,
		"total": total,
	})
}

func parsePagination(r *http.Request) (int, int) {
	q := r.URL.Query()
	limit, _ := strconv.Atoi(q.Get("limit"))
	offset, _ := strconv.Atoi(q.Get("offset"))
	if limit <= 0 {
		limit = 10
	}
	if offset < 0 {
		offset = 0
	}
	return limit, offset
}
