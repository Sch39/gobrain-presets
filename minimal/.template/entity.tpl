package domain

import "time"

type {{ pascal_case .Name }} struct {
	ID        string
	CreatedAt time.Time
	UpdatedAt time.Time
}
