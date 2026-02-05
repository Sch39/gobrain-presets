package service

import (
    "context"
    "time"

    "{{ .ModuleName }}/internal/domain"
    "{{ .ModuleName }}/internal/repository"
    "github.com/google/uuid"
)

type {{ .Name }}Service interface {
    Create(ctx context.Context, e *domain.{{ .Entity }}) (*domain.{{ .Entity }}, error)
    FindByID(ctx context.Context, id string) (*domain.{{ .Entity }}, error)
    Fetch{{ .Name }}s(ctx context.Context, limit int, offset int) ([]domain.{{ .Entity }}, int, error)
    Update(ctx context.Context, e *domain.{{ .Entity }}) error
    Delete(ctx context.Context, id string) error
}

type {{ .Name | lower }}Service struct {
    repo repository.{{ .Name }}Repository
}

func New{{ .Name }}Service(repo repository.{{ .Name }}Repository) {{ .Name }}Service {
    return &{{ .Name | lower }}Service{repo: repo}
}

func (s *{{ .Name | lower }}Service) Create(ctx context.Context, e *domain.{{ .Entity }}) (*domain.{{ .Entity }}, error) {
    e.ID = uuid.NewString()
    now := time.Now()
    e.CreatedAt = now
    e.UpdatedAt = now
    if err := s.repo.Create(ctx, e); err != nil {
        return nil, err
    }
    return e, nil
}

func (s *{{ .Name | lower }}Service) FindByID(ctx context.Context, id string) (*domain.{{ .Entity }}, error) {
    return s.repo.FindByID(ctx, id)
}

func (s *{{ .Name | lower }}Service) Fetch{{ .Name }}s(ctx context.Context, limit int, offset int) ([]domain.{{ .Entity }}, int, error) {
    return s.repo.Fetch(ctx, limit, offset)
}

func (s *{{ .Name | lower }}Service) Update(ctx context.Context, e *domain.{{ .Entity }}) error {
    e.UpdatedAt = time.Now()
    return s.repo.Update(ctx, e)
}

func (s *{{ .Name | lower }}Service) Delete(ctx context.Context, id string) error {
    return s.repo.Delete(ctx, id)
}
