# x11-novnc
A dockerfile running SUMO, TigerVNC, and NoVNC, accessible from browser.

Inspired by
 * https://github.com/codenvy-legacy/dockerfiles/tree/master/x11_vnc
 * https://github.com/toastie89/x11-novnc
 * https://github.com/tukiyo/x11-novnc

## Run it:
```bash
podman build -t liftm/sumo-novnc . || podman pull docker.io/liftm/sumo-novnc
podman run --rm -ti -p 8080:8080 liftm/sumo-novnc
```
And access via `http://$(ip route get 255.255.255.255 | sed -nr 's/^.*src ([.0-9]*).*$/\1/p'):8080` or similar.
