package service

import (
    "context"

    "github.com/google/uuid"   
)

type {{ .Name }}Service interface{
    Fetch{{ .Name }}s(ctx context.Context, limit int, offset int) ([]domain.{{ .Entity }}, error)
}

type {{ .Name | lower }}Service struct {
    repo repository.{{ .Name }}Repository
}

func New{{ .Name }}Service(repo repository.{{ .Name | lower }}Repository) {{ .Name | lower }}Service {
    return &{{ .Name | lower }}Service{repo: repo}
}

func (s *{{ .Name }}Service) Fetch{{ .Name }}s(ctx context.Context, limit int, offset int) ([]domain.{{ .Entity }}, error){
    return s.repo.Fetch(ctx, limit, offset)
}