default: ci

ci: fmt lint cover

ci-full: ci sec dependencies-analyze bench 

test: 
	go test

cover:
	go test -coverprofile=coverage.out
	go tool cover -func=coverage.out

cover-web: cover
	go tool cover -html=coverage.out

bench:
	go test -bench . -benchmem

sec:
	go run github.com/securego/gosec/v2/cmd/gosec@latest ./...

dependencies-analyze:
	go run golang.org/x/vuln/cmd/govulncheck@latest ./...

fmt:
	go run mvdan.cc/gofumpt@latest -l -w .


# If golangci-lint is not installed, run it from latest github version found. Installed version is faster.
lint: 
	golangci-lint run || (echo "Running golangci-lint from latest github version found" && go run github.com/golangci/golangci-lint/cmd/golangci-lint@latest run)

example:
	go run ./examples/simple-crud
