# FROM node:18.17.0-alpine

# WORKDIR /usr/src/app

# RUN apk add --no-cache bash
# RUN npm install -g @nestjs/cli typescript ts-node

# COPY package*.json ./
# RUN npm install

# COPY . .

# RUN npm run build

# EXPOSE 33000

# CMD ["npm", "run", "start:prod"]

FROM node:18.17.0-alpine

RUN apk add --no-cache bash
RUN npm i -g @nestjs/cli typescript ts-node

COPY package*.json /tmp/app/
RUN cd /tmp/app && npm install

COPY . /usr/src/app
RUN cp -a /tmp/app/node_modules /usr/src/app
COPY ./wait-for-it.sh /opt/wait-for-it.sh
RUN chmod +x /opt/wait-for-it.sh
COPY ./startup.relational.dev.sh /opt/startup.relational.dev.sh
RUN chmod +x /opt/startup.relational.dev.sh
RUN sed -i 's/\r//g' /opt/wait-for-it.sh
RUN sed -i 's/\r//g' /opt/startup.relational.dev.sh

WORKDIR /usr/src/app
COPY .env ./
# RUN if [ ! -f .env ]; then cp env-example-relational .env; fi
RUN npm run build

CMD ["/opt/startup.relational.dev.sh"]
