# livekit-meet-docker

This repository is dedicated to deploying a video conferencing application using LiveKit with Docker. It serves as a demonstration and is meant for testing and development purposes, not for production use. The `meet` component is a sample application to showcase how LiveKit can be integrated and utilized.

## Project Structure

This project is composed of the following main components:

- `meet`: A sample video conferencing application powered by LiveKit. This is not intended for real-world production use.
- `livekit`: The LiveKit server.
- `caddy`: A Caddy server functioning as a reverse proxy.

## Setup

Follow these steps to get the project up and running:

1. **Clone the repository:**

    ```bash
    git clone https://github.com/roamer7038/livekit-meet-docker.git
    cd livekit-meet-docker
    ```

2. **Copy the `.env.example` file to create a `.env` file and set the necessary environment variables:**

    ```bash
    cp .env.example .env
    ```

3. **Generate an API key and secret using the `generate_keypair.py` script:**

    ```bash
    python3 generate_keypair.py
    ```

4. **Edit the `.env` and `livekit.yaml` files with the generated keys and appropriate domain names. This is required to run the application correctly.**

5. **Build and launch the project using Docker:**

    ```bash
    docker-compose up --build
    ```

## Required Domains and Ports

You will need three publicly accessible servers, configured with the following domains:
- LIVEKIT_MEET_FQDN=livekit-meet.example.com
- LIVEKIT_SERVER_FQDN=livekit-server.example.com
- LIVEKIT_TURN_FQDN=livekit-turn.example.com

Please ensure the following ports are open:
- 80 - TLS issuance
- 443 - primary HTTPS and TURN/TLS
- 3478/UDP - TURN/UDP
- 7881 - WebRTC over TCP
- 7882/UDP - WebRTC over UDP

## Additional Resources

- For more on the `meet` application component, visit the repository: [LiveKit Meet](https://github.com/livekit-examples/meet)

## License

This project is released under the MIT License. For more details, please refer to the [LICENSE](./LICENSE) file.
