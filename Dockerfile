ARG TAG="20181204"
ARG BASEIMAGE="huggla/postgres-alpine:postgis-$TAG"
ARG CITYDBVERSION="v4.0.1"
ARG CLONEGITS="-b \"${CITYDBVERSION}\" --depth 1 https://github.com/3dcitydb/3dcitydb.git"
ARG BUILDCMDS=\
"   cp -a 

#--------Generic template (don't edit)--------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
ARG CONTENTSOURCE1="${CONTENTSOURCE1:-/}"
ARG CONTENTDESTINATION1="${CONTENTDESTINATION1:-/buildfs/}"
ARG CONTENTSOURCE2="${CONTENTSOURCE2:-/}"
ARG CONTENTDESTINATION2="${CONTENTDESTINATION2:-/buildfs/}"
ARG CLONEGITSDIR
ARG DOWNLOADSDIR
ARG MAKEDIRS
ARG MAKEFILES
ARG EXECUTABLES
ARG EXPOSEFUNCTIONS
COPY --from=build /imagefs /
#---------------------------------------------

RUN chgrp -R 101 /usr/lib/sudo /usr/local/bin/sudo \
 && chmod u+s /usr/local/bin/sudo \
 && chmod u=,g=rx /.r

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/start" \
    VAR_LINUX_USER="root" \
    VAR_FINAL_COMMAND="pause" \
    VAR_ARGON2_PARAMS="-r" \
    VAR_SALT_FILE="/proc/sys/kernel/hostname" \
    HISTFILE="/dev/null"

#--------Generic template (don't edit)--------
USER starter
ONBUILD USER root
#---------------------------------------------

CMD ["sudo","start"]
