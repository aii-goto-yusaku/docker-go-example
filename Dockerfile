FROM golang:1.13 AS builder

ARG prj="/go/src/github.com/aii-goto-yusaku/docker-go-example"

RUN mkdir -p ${prj}
WORKDIR ${prj}
COPY . .
RUN CGO_ENABLED=0 go build -o /app

# 実行
FROM alpine:3 AS runtime

COPY --from=builder /app /app
RUN chmod +x /app

ENTRYPOINT ["/app"]
