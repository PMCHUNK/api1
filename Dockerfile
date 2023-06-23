FROM node:18

ENV PORT 1337
ENV HOST 0.0.0.0
ENV NODE_ENV production
ENV APP_KEYS b9TGvkgjm1jUkHCHgUGgZQ==,awVR1MXtZsP1Snv/HhWkNw==,YIeO6RKpM01HQ/Z16dMnUw==,f+DaPEAvi54tylk9JToLoA==

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json /usr/src/app/
RUN npm install --global yarn --force
COPY yarn.lock /usr/src/app/
RUN yarn install

# Bundle app source
COPY . /usr/src/app

RUN yarn build
EXPOSE 1337

CMD [ "yarn", "start" ]
