# Godot - Simple WebRTC Server
It was kind of hard to piece this together since Godot's resources are a bit here and there. I'm also still trying to figure out how this all intertwines. 😖

This comes in 5 parts:
- `webrtc_signaling`: The Godot client project
- `webrtc_signaling_demo`: A Nextjs App that serves the Godot game
- `webrtc_signaling_server`: The Godot server project
- `webrtc_signaling_demo_server`: Container for the Godot server logic
- `nginx`: Helps with routing. This isn't essential at this stage, but good to have later down the road to make sure that the webserver isn't mixed up with the Godot server.

# Quickstart
- Make sure to install [docker](https://www.docker.com/). 
- `webrtc_signaling` and `webrtc_signaling_server` have already been exported into their respective folders, so all that needs to be done is to start up docker. If you want to see the code, just open them up in Godot Engine.
    - `cd` into this README's directory
    - Run `docker-compose up -d --build`
- Once you've got everything working, head to `localhost` and try connecting multiple peers together.

# Troubleshooting
I ran into a lot of problems getting this to work, so this section is detected to calling them out.
- To get WebRTC to work with Godot, I had to download a plugin. This plugin can be downloaded [here](https://github.com/godotengine/webrtc-native/releases). Extract into the client Godot project's base folder (`webrtc_signaling`). You may see `.dll` loading errors while launching the client Godot project in the Godot Engine. I used [Dependencies](https://github.com/lucasg/Dependencies) to find out any missing dll dependencies and downloaded them.
- If you're getting an X11 error on your server docker container, it could be because you're not exporting the Godot server project correctly. Make sure that the project's export settings has the [dedicated server template](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_dedicated_servers.html) hooked up.

# References
- [WebRTC Signaling Demo](https://godotengine.org/asset-library/asset/537)