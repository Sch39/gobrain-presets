TOOLS=air golangci-lint
.PHONY: tools install-air install-golangci dev lint test verify build clean
tools: install-air install-golangci
install-air:
	go install github.com/air-verse/air@latest
install-golangci:
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
dev:
	air
lint:
	golangci-lint run
test:
	go test ./... -cover
verify:
	go fmt ./...
	go vet ./...
	golangci-lint run
	go test ./... -short
build:
	go build ./...
clean:
	go clean
