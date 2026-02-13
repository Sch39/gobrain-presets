package repository

import (
	"context"
	"{{ .ModuleName }}/internal/domain"
)

type {{ pascal_case .Name }}Repository interface {
	Create(ctx context.Context, {{ camel_case .Entity }} *domain.{{ pascal_case .Entity }}) error
	FindByID(ctx context.Context, id string) (*domain.{{ pascal_case .Entity }}, error)
	Fetch(ctx context.Context, limit int, offset int) ([]domain.{{ pascal_case .Entity }}, int, error)
	Update(ctx context.Context, {{ camel_case .Entity }} *domain.{{ pascal_case .Entity }}) error
	Delete(ctx context.Context, id string) error
}
