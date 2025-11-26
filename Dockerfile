# Use the specified Jupyter minimal-notebook base image
FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Become root to install packages
USER root

# Copy the explicit conda lock file into the container
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# Create a new conda environment from the lock file
RUN conda create --name dsci522 --file /tmp/conda-linux-64.lock && \
    conda clean -afy && \
    rm -f /tmp/conda-linux-64.lock

# Prepend the new environment's bin directory to PATH so it's activated by default
ENV PATH="/opt/conda/envs/dsci522/bin:${PATH}"

# Drop back to the default notebook user
USER ${NB_USER}

