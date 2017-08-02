FROM debian:latest

RUN apt-get update && apt-get install -y \    
		build-essential \
		python \
		curl \
    && rm -rf /var/lib/apt/lists/*

ENV TEEWORLDS_VERSION            0.6.4
ENV TEEWORLDS_DOWNLOAD_URL       https://github.com/teeworlds/teeworlds/archive/${TEEWORLDS_VERSION}-release.tar.gz
ENV TEEWORLDS_DOWNLOAD_SHA256    831afdea9e343cd712382c74b941c6c14adfb9192d32504022b41c2abbb910d7

RUN curl -fsSL "$TEEWORLDS_DOWNLOAD_URL" -o teeworlds.tar.gz \
    && echo "$TEEWORLDS_DOWNLOAD_SHA256  teeworlds.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -zxf teeworlds.tar.gz \
    && rm teeworlds.tar.gz

ENV BAM_VERSION					0.4.0
ENV BAM_DOWNLOAD_URL			http://github.com/downloads/matricks/bam/bam-${BAM_VERSION}.tar.gz
ENV BAM_DOWNLOAD_SHA256			5e4e4920b4d265da582f66774e9b1ec8ddfbe75ddc028fba86c12f686ea18db3

RUN curl -fsSL "$BAM_DOWNLOAD_URL" -o bam.tar.gz \
    && echo "$BAM_DOWNLOAD_SHA256  bam.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -zxf bam.tar.gz \
    && rm bam.tar.gz

RUN cd /usr/local/bam-${BAM_VERSION} && \
	./make_unix.sh && \
	ln -nfs /usr/local/bam-${BAM_VERSION}/bam /usr/local/bin/bam

RUN cd /usr/local/teeworlds-${TEEWORLDS_VERSION}-release && \
	/usr/local/bin/bam server_release && \
	ln -nfs /usr/local/teeworlds-${TEEWORLDS_VERSION}-release /usr/local/bin/teeworlds
	
CMD ["/usr/local/bin/teeworlds/teeworlds_srv"]