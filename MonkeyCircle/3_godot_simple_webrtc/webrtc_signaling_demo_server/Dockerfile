FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y libxcursor1 libxinerama1 libxrandr2 libxi6 libgl1
WORKDIR /webrtc_signaling_demo_server
COPY . .
CMD ["./server.x86_64"]