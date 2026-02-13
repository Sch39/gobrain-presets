package handler

import (
	"context"
	"net/http"
	"strconv"

	"{{ .ModuleName }}/internal/service"
	"{{ .ModuleName }}/pkg/response"
)

type {{ pascal_case .Name }}Handler struct {
	svc service.{{ pascal_case .Name }}Service
}

func New{{ pascal_case .Name }}Handler(svc service.{{ pascal_case .Name }}Service) *{{ pascal_case .Name }}Handler {
	return &{{ pascal_case .Name }}Handler{svc: svc}
}

func (h *{{ pascal_case .Name }}Handler) Fetch(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	limit, offset := parsePagination(r)
	items, total, err := h.svc.Fetch{{ pascal_case .Name }}s(ctx, limit, offset)
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
