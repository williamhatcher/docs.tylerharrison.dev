# Linux

## Debian APT Mirrors

I ran into a strange issue where Debian kept trying to pull from mirrors I never specified like `debian.gtisc.gatech.edu`. Turns out, there is another file where mirrors are stored:

```bash
/usr/share/python-apt/templates/Debian.mirrors
```

