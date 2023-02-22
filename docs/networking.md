# Networking

A deep dive into the world of networking, from basic concepts to advanced topics.

## SSH Tunneling

SSH tunneling is a way to securely connect to a remote server through a local server. This is useful for accessing a remote server that is behind a firewall or NAT. It can also be used to access a remote server that is not directly accessible from the internet.

### SSH Port Forwarding

Forward port from local host to remote host:

```bash
ssh -R <remote_port>:<local_host>:<local_port> <remote_user>@<remote_host>
```

Forward port from remote host to local host:

```bash
ssh -L <local_port>:<remote_host>:<remote_port> <remote_user>@<remote_host>
```

### SSH Dynamic Port Forwarding

This works by creating a SOCKS proxy on the local host. This allows you to route all traffic through the remote host. This application-level port forwarding can only be run as root.

Forward all traffic from local host to remote host:

```bash
ssh -D <local_port> <remote_user>@<remote_host>
```
