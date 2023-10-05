# Use the official Golang image as the builder stage
FROM --platform=$BUILDPLATFORM golang:1.19-buster AS builder

# Set the working directory in the builder stage
WORKDIR /app

# Copy the Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the entire source code into the builder stage
COPY . .

# Build the Go application with CGO disabled
ARG TARGETOS
ARG TARGETARCH
RUN go mod tidy && CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /go-app ./cmd

# Create a minimal image with distroless as the final stage
FROM scratch

# Copy the built binary from the builder stage
COPY --from=builder /go-app /
COPY --from=builder /app/dist /dist

# Define the entry point for the final image
ENTRYPOINT ["/go-app"]
