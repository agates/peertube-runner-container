# peertube-runner-container

This is a small container to run a [PeerTube runner](https://docs.joinpeertube.org/maintain/tools#peertube-runner).

It accepts the following environment variables:

- PEERTUBE_RUNNER_URL (required) - Full URL of the PeerTube (5.2+) instance to connect to
- PEERTUBE_RUNNER_REGISTRATION_TOKEN (required) - Runner Registration Token obtained from the PeerTube instance.
- PEERTUBE_RUNNER_NAME (optional) - Name of the runner to show up in the PeerTube interface
