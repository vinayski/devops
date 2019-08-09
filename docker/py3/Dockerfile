FROM python:3 as builder
RUN  pip3 install numpy

FROM gcr.io/distroless/python3
COPY --from=builder /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.5/
