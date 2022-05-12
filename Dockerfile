FROM hub.opensciencegrid.org/osg-jupyter/htc-minimal-notebook:latest

## Update the base install.

USER root

RUN apt-get update \
    && apt-get install -y sssd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY opt /opt/

USER $NB_UID:$NB_GID

## Install packages needed for the tutorial.

RUN python3 -m pip install -U --no-cache-dir \
      pip \
      setuptools \
      wheel \
    && python3 -m pip install -U --no-cache-dir \
      bash_kernel \
      scitokens \
    && python3 -m bash_kernel.install --sys-prefix

ENTRYPOINT ["tini", "-g", "--", "/opt/sciauth/bin/entrypoint.sh"]
