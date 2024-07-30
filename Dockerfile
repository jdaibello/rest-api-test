FROM node:14.21.3-alpine3.17

ENV USER=node \
    USER_ID=1000 \
    HOME=/usr/app

USER root

# Recreate user using workdir
RUN deluser --remove-home $USER \
    && echo "$USER:x:$USER_ID:$USER_ID::$HOME:/bin/sh" >> /etc/passwd \
    && echo "$USER:x:$USER_ID:" >> /etc/group \
    && mkdir -p $HOME \
    && chown -R $USER:$USER $HOME

WORKDIR $HOME

# Update packages
RUN apk update

COPY --chown=$USER:$USER package.json package-lock.json $HOME/

# Install dependencies
RUN npm install

COPY --chown=$USER:$USER . $HOME/

# Used for VS Code devcontainer

RUN chown -R $USER:$USER .config

EXPOSE 3000

USER $USER

CMD ["npm", "run", "start"]