# Firebase + WebRTC Demo
Gotta organize my thoughts 🤔


## Quickstart
- Make a project over at [Firebase](https://console.firebase.google.com/)
- Run the following in your terminal:
  - Install the Firebase CLI `npm -g install firebase-tools`
  - Login to Firebase `firebase login`
  - Link your Firebase project `firebase use --add`
  - Serve the demo `firebase serve --only hosting`

## Some Notes on the Nitty Gritty
WebRTC is a web peer-to-peer (P2P) solution. It's usually utilized for web-based video chat since the alternative (passing data through a web server) would result in higher latency.

WebRTC needs to know *what's being sent* and *how to send it*. It relies on *several* steps to figure this out for the P2P connection.
### Phase 1: Peer A
Peer A will represent the call initiator. Some information needs to be set up to make sure P2P connection is viable.
- Each peer needs to set up their session description protocol (SDP) which describes what sort of media will be delivered (e.g. video, audio).
    - Peer A: Set up a `MediaStream`.
    - Peer A: Instantiate an `RTCPeerConnection` and add each `track` of the `stream` via iterating over `stream.getTracks()`.
    - Peer A: Set up callbacks for the `peerConnection`'s `track` event so that you can add them to the `remoteStream` instance when they come in later. *(Note that the local and remote stream should be tied to the `srcObject` of `video` elements.)*
    - Peer A: Call `createOffer()` on the `peerConnection` and `setLocalDescription(offer)`. This creates the description based on the media tracks that were just added.
    - Peer A: Make sure to send that `offer`'s `type` and `sdp` to the database instance you're using. Peer B will need that down the line.
    - At this point, we should be storing stuff in the database instance. Make sure that this information is organized in a room/session manner and that there's some sort of identifier that can be passed to Peer B so that they can be routed to the correct information. In the demo's case, Firebase generates an ID by default for each stored reference.
- Each peer will also need to keep track of Interactive Connectivity Establishment (ICE) candidates. This contains information about the network connection to inform the other peer on how to get to them. As phrased by [`MarijnS95`](https://stackoverflow.com/questions/21069983/what-are-ice-candidates-and-how-do-the-peer-connection-choose-between-them), think of it like telling someone where your desk is in an office building.
    - Peer A: Set up callbacks for the `peerconnection`'s `icecandidate` event. As these candidates come in, they should be added to the database you have set up.
    - Peer A: Make sure there are subscriptions, or event listeners, to pick up the ice candidates from Peer B as they come in from the database instance.

### Phase 2: Peer B
Now it's time to set up Peer B! Much of what will be going on is just a mirror of Phase 1. Peer B will need to:
- Set up the `RTCPeerConnection`'s media tracks. Also listen for the remote `track`s from Peer A and add them to the `remoteStream` as they come.
- Have something kick off the next steps. We need an identifier from Peer A to know which room/session to connect to before proceeding any further!
- Collect Peer B's `icecandidates` as they come and add them to the database. Also listen for Peer A's `icecandidates` from the database instance.
- Query for Peer A's `offer` and generate an `answer` (`peerConnection.createAnswer()`). The `answer` should be set as the local description (`peerConnection.setLocalDescription(answer)`) and sent over to the database instance for Peer A.
    
## Brain Cells to Spare?
Stuff that's not essential to know right off the bat, but is nice to know.
- To make this work, a STUN or TURN server needs to be a part of this equation. What does STUN or TURN stand for? It's probably not worth mentioning because you're not going to remember 🤪. These servers allow the client to discover their public IP address and lets us figure out how to traverse their network address translation (NAT) so that we can communicate that with the external peer.

## Resources
This demo was taken from the [WebRTC Primer](https://webrtc.org/getting-started/firebase-rtc-codelab).