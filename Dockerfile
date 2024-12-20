FROM eclipse-temurin:21-jre-alpine

ARG MC_VERSION
ARG MIN_RAM
ARG MAX_RAM

ENV PROJECT="paper" \
    MC_VERSION=$MC_VERSION \
    MIN_RAM=$MIN_RAM \
    MAX_RAM=$MAX_RAM

WORKDIR /minecraft

COPY start.sh .

RUN apk update && \
    apk upgrade && \
    apk add jq curl && \
    echo "eula=true" > eula.txt && chmod +x ./start.sh && \
    export LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MC_VERSION}/builds | jq -r '.builds | .[-1] | .build'); \
    export JAR_NAME=${PROJECT}-${MC_VERSION}-${LATEST_BUILD}.jar; \
    curl -o server.jar "https://api.papermc.io/v2/projects/${PROJECT}/versions/${MC_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"
    

EXPOSE 25565/tcp
EXPOSE 25565/udp

ENTRYPOINT ["sh", "start.sh"]