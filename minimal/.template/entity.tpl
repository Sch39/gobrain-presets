package domain

import "time"

type {{ .Name }} struct {
    ID  string
    
    CreatedAt time.Time
	UpdatedAt time.Time
}