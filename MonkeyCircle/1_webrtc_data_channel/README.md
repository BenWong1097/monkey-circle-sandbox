# WebRTC - Vz. Data Channel
I was thinking about putting together a demo for this, but couldn't think about when I'd really need this. Data channels seem to be implemented in SCTP which builds on UDP<sup>[1](https://stackoverflow.com/questions/18897917/does-webrtc-use-tcp-or-udp)</sup>

UDP should only be used for data that needs to be firehosed to its destination without caring if it actually arrives. This could potentially be used for a roll-back netcode implementation, but Godot has its own WebRTC set up<sup>[2](https://docs.godotengine.org/en/stable/tutorials/networking/webrtc.html)</sup> so it'd be better to revisit it then.

## Resources
- [Stack Overflow: Does WebRTC use TCP or UDP?](https://stackoverflow.com/questions/18897917/does-webrtc-use-tcp-or-udp)
- [Godot: WebRTC](https://docs.godotengine.org/en/stable/tutorials/networking/webrtc.html)
- [WebRTC: Data Channels](https://webrtc.org/getting-started/data-channels)