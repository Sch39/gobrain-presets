package repository

import(
    "context"

    "{{ .ModuleName }}/internal/domain"
)

type {{ .Name }}Repository interface{
    Create(ctx context.Context, {{ .Entity | lower }} *domain.{{ .Entity }}) error
    FindByID(ctx context.Context, id string) (*domain.{{ .Entity }}, error)
    Fetch(ctx context.Context, limit int, offset int) ([]domain.{{ .Entity }}, int, error)
    Update(ctx context.Context, {{ .Entity | lower }} *domain.{{ .Entity }}) error
    Delete(ctx context.Context, id string) error
}