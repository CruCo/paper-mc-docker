FROM eclipse-temurin:21-jre-alpine

RUN apk update && \
    apk upgrade && \
    apk add jq curl

ARG PROJECT="paper" \
    MC_VERSION \
    UNAME \
    UID \
    GID

ENV MIN_RAM \
    MAX_RAM

RUN addgroup -g ${GID} ${UNAME} && \
    adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "$UNAME" \
    --no-create-home \
    --uid "$UID" \
    ${UNAME}

USER ${UNAME}

WORKDIR /minecraft

COPY --chown=${UNAME} start.sh .

RUN echo "eula=true" > eula.txt && chmod +x ./start.sh && \
    export LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MC_VERSION}/builds | jq -r '.builds | .[-1] | .build'); \
    export JAR_NAME=${PROJECT}-${MC_VERSION}-${LATEST_BUILD}.jar; \
    curl -o server.jar "https://api.papermc.io/v2/projects/${PROJECT}/versions/${MC_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"

EXPOSE 25565/tcp
EXPOSE 25565/udp

ENTRYPOINT ["sh", "start.sh"]