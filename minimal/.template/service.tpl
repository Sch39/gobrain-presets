package service

import (
	"context"
	"time"
	"{{ .ModuleName }}/internal/domain"
	"{{ .ModuleName }}/internal/repository"
	"github.com/google/uuid"
)

type {{ pascal_case .Name }}Service interface {
	Create(ctx context.Context, e *domain.{{ pascal_case .Entity }}) (*domain.{{ pascal_case .Entity }}, error)
	FindByID(ctx context.Context, id string) (*domain.{{ pascal_case .Entity }}, error)
	Fetch{{ pascal_case .Name }}s(ctx context.Context, limit int, offset int) ([]domain.{{ pascal_case .Entity }}, int, error)
	Update(ctx context.Context, e *domain.{{ pascal_case .Entity }}) error
	Delete(ctx context.Context, id string) error
}

type {{ pascal_case .Name }}ServiceImpl struct {
	repo repository.{{ pascal_case .Name }}Repository
}

func New{{ pascal_case .Name }}Service(repo repository.{{ pascal_case .Name }}Repository) {{ pascal_case .Name }}Service {
	return &{{ pascal_case .Name }}ServiceImpl{repo: repo}
}

func (s *{{ pascal_case .Name }}ServiceImpl) Create(ctx context.Context, e *domain.{{ pascal_case .Entity }}) (*domain.{{ pascal_case .Entity }}, error) {
	e.ID = uuid.NewString()
	now := time.Now()
	e.CreatedAt = now
	e.UpdatedAt = now
	if err := s.repo.Create(ctx, e); err != nil {
		return nil, err
	}
	return e, nil
}

func (s *{{ pascal_case .Name }}ServiceImpl) FindByID(ctx context.Context, id string) (*domain.{{ pascal_case .Entity }}, error) {
	return s.repo.FindByID(ctx, id)
}

func (s *{{ pascal_case .Name }}ServiceImpl) Fetch{{ pascal_case .Name }}s(ctx context.Context, limit int, offset int) ([]domain.{{ pascal_case .Entity }}, int, error) {
	return s.repo.Fetch(ctx, limit, offset)
}

func (s *{{ pascal_case .Name }}ServiceImpl) Update(ctx context.Context, e *domain.{{ pascal_case .Entity }}) error {
	e.UpdatedAt = time.Now()
	return s.repo.Update(ctx, e)
}

func (s *{{ pascal_case .Name }}ServiceImpl) Delete(ctx context.Context, id string) error {
	return s.repo.Delete(ctx, id)
}
