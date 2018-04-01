FROM ubuntu:16.04
RUN apt-get update && apt-get install -y libltdl7 && rm -rf /var/lib/apt/lists/*
ADD run.sh /run.sh
RUN ["chmod", "+x", "/run.sh"]
ENTRYPOINT ["./run.sh"]
