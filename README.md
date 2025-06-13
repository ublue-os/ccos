# CentOS CoreOS (CCOS)

## This project is discontinued. Our alternative effort https://github.com/ublue-os/server

CentOS Stream-based bootc image with packages and overlays from CoreOS preinstalled.

How this is expected to be consumed:

```Containerfile
FROM ghcr.io/ublue-os/ccos:stream9 # (or whatever tag you want)
RUN dnf -y install htop fastfetch

$your_hopes_and_dreams_go_here.

RUN bootc container lint
```

## Scope

This is expected to be:

- a CentOS based alternative to Fedora CoreOS (FCOS)
- ***only*** make the minimal changes required to create a CentOS bootc image which closely matches Fedora CoreOS
- the foundation for a CentOS based [uCore](https://projectucore.io)
- initially not focussed on installation since FCOS ignition install can be done and rebased to CCOS


## Goals

Taking the lessons from [Universal Blue](https://github.com/ublue-os/) but built entirely with [bootc](https://github.com/containers/bootc)

We aim to:

- Contribute to upstream as much as possible to make it so people arent entirely reliant on workarounds that we provide here (such as upstreaming packages to EPEL, fixing bugs, and whatever else)
- Leverage cloud-native tech to make our stuff MUCH easier, like kernel pinning, easier rollbacks with tons of tags, everything we already do really
- Use [Renovate](https://github.com/apps/renovate) and other automation technologies (like [pull](https://github.com/wei/pull)) to make sure everything is up-to-date and if not, it should be as easy as possible to 
- Enforce strictness and quality assurance as much as possible and prefer stability and correctness over anything else

<sub><sup>This is just a draft of this README, please add more stuff here</sup></sub>