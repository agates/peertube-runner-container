FROM docker.io/node:18-bookworm-slim

RUN useradd --create-home peertube-runner

COPY install-packages.sh .
RUN ./install-packages.sh

RUN npm install -g @peertube/peertube-runner

USER peertube-runner
WORKDIR /home/peertube-runner

COPY runner.sh .

ENV PEERTUBE_RUNNER_URL=
ENV PEERTUBE_RUNNER_REGISTRATION_TOKEN=
ENV PEERTUBE_RUNNER_NAME=

CMD ["/home/peertube-runner/runner.sh"]
