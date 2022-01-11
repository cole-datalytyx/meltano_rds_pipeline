ARG MELTANO_IMAGE=meltano/meltano:latest
FROM $MELTANO_IMAGE

WORKDIR /project

# Install any additional requirements
COPY ./requirements.txt . 
RUN pip install -r requirements.txt

# Install all plugins into the `.meltano` directory
COPY ./meltano.yml . 
RUN meltano install

# Pin `discovery.yml` manifest by copying cached version to project root
RUN cp -n .meltano/cache/discovery.yml . 2>/dev/null || :

# Don't allow changes to containerized project files
ENV MELTANO_PROJECT_READONLY 1

# Copy over remaining project files
COPY . .

# Expose default port used by `meltano ui`
EXPOSE 5000

# Install Oracle instant client
RUN apt-get update && \
    apt-get install libaio1 && \
    apt-get install -y alien && \
    wget https://download.oracle.com/otn_software/linux/instantclient/214000/oracle-instantclient-basic-21.4.0.0.0-1.x86_64.rpm && \
    alien -i oracle-instantclient-basic-21.4.0.0.0-1.x86_64.rpm && \
    rm oracle-instantclient-basic-21.4.0.0.0-1.x86_64.rpm

ENTRYPOINT ["meltano"]
