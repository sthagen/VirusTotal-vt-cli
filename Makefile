# This how we want to name the binary output
BINARY=./build/vt

# Setup the -ldflags option for go build here, interpolate the variable values
LDFLAGS=-ldflags "-X github.com/VirusTotal/vt-cli/cmd.Version=${VERSION}"

# Builds the project
.PHONY: build
build:
	go build ${LDFLAGS} -o ${BINARY} ./vt/main.go

# Installs our project: copies binaries
.PHONY: install
install:
	go install ${LDFLAGS} github.com/VirusTotal/vt-cli/vt

# Build the project for multiple architectures
.PHONY: all
all:
	gox ${LDFLAGS} \
	-osarch="linux/amd64 linux/386 windows/amd64 windows/386 darwin/amd64 freebsd/amd64 freebsd/386" \
	-output "build/{{.OS}}/{{.Arch}}/{{.Dir}}" github.com/VirusTotal/vt-cli/vt

# Cleans our project: deletes binaries
.PHONY: clean
clean:
	rm -rf ./build
