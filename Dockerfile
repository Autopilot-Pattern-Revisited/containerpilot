FROM golang:1.26.4-trixie AS builder

WORKDIR /build
ENV CGO_ENABLED=0

RUN --mount=type=bind,source=.,target=/source cd /source && GIT_HASH="$(git rev-parse --short HEAD 2>/dev/null || echo unknown)" && VERSION="$(git describe --tags --always --dirty 2>/dev/null || echo dev-build-not-for-release)" && go build -o /build/containerpilot -ldflags "-X github.com/Autopilot-Pattern-Revisited/containerpilot/version.GitHash=${GIT_HASH} -X github.com/Autopilot-Pattern-Revisited/containerpilot/version.Version=${VERSION}"

FROM scratch AS target

COPY --from=builder /build/containerpilot /containerpilot
ENTRYPOINT ["/containerpilot"]
