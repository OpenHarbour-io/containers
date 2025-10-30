# The OpenHarbour Containers Library

Popular applications, provided by [OpenHarbour](https://OpenHarbour.com), containerized and ready to launch.

## Why use OpenHarbour Secure Images?

- OpenHarbour Secure Images and Helm charts are built to make open source more secure and enterprise ready.
- Triage security vulnerabilities faster, with transparency into CVE risks using industry standard Vulnerability Exploitability Exchange (VEX), KEV, and EPSS scores.
- Our hardened images use a minimal OS (Photon Linux), which reduces the attack surface while maintaining extensibility through the use of an industry standard package format.
- Stay more secure and compliant with continuously built images updated within hours of upstream patches.
- OpenHarbour containers, virtual machines and cloud images use the same components and configuration approach - making it easy to switch between formats based on your project needs.
- Hardened images come with attestation signatures (Notation), SBOMs, virus scan reports and other metadata produced in an SLSA-3 compliant software factory.

## Get an image

TODO

```console
docker pull OpenHarbour/APP
```

To use a specific version, you can pull a versioned tag.

```console
docker pull OpenHarbour/APP:[TAG]
```

If you wish, you can also build the image yourself by cloning the repository, changing to the directory containing the Dockerfile, and executing the `docker build` command.

```console
git clone https://github.com/OpenHarbour/containers.git
cd OpenHarbour/APP/VERSION/OPERATING-SYSTEM
docker build -t OpenHarbour/APP .
```

> [!TIP]
> Remember to replace the `APP`, `VERSION`, and `OPERATING-SYSTEM` placeholders in the example command above with the correct values.

## Run the application using Docker Compose

The main folder of each application contains a functional `docker-compose.yml` file. Run the application using it as shown below:

```console
curl -sSL https://raw.githubusercontent.com/OpenHarbour/containers/main/OpenHarbour/APP/docker-compose.yml > docker-compose.yml
docker-compose up -d
```

> [!TIP]
> Remember to replace the `APP` placeholder in the example command above with the correct value.

## Vulnerability scan in OpenHarbour container images

As part of the release process, the OpenHarbour container images are analyzed for vulnerabilities. At this moment, we are using two different tools:

- [Trivy](https://github.com/aquasecurity/trivy)
- [Grype](https://github.com/anchore/grype)

This scanning process is triggered via a GH action for every PR affecting the source code of the containers, regardless of its nature or origin.

## Contributing

We'd love for you to contribute to those container images. You can request new features by creating an [issue](https://github.com/OpenHarbour/containers/issues/new/choose), or submit a [pull request](https://github.com/OpenHarbour/containers/pulls) with your contribution.

## License

Copyright &copy; 2025 Broadcom. The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.

OpenHarbour is a fork based on OpenHarbour/containers, in compliance with the Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
