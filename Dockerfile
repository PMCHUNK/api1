# Creating multi-stage build for production
FROM node:18.16-alpine3.18 as build
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev > /dev/null 2>&1
ARG NODE_ENV=production
ENV NODE_ENV=production

WORKDIR /opt/
COPY package.json yarn.lock ./
RUN yarn config set network-timeout 600000 -g && yarn install --production
ENV PATH /opt/node_modules/.bin:$PATH
ENV APP_KEYS b9TGvkgjm1jUkHCHgUGgZQ==,awVR1MXtZsP1Snv/HhWkNw==,YIeO6RKpM01HQ/Z16dMnUw==,f+DaPEAvi54tylk9JToLoA==
WORKDIR /opt/app
COPY . .
RUN yarn build

# Creating final production image
FROM ode:18.16-alpine3.18
RUN apk add --no-cache vips-dev
ARG NODE_ENV=production
ENV NODE_ENV=production
WORKDIR /opt/
COPY --from=build /opt/node_modules ./node_modules
WORKDIR /opt/app
COPY --from=build /opt/app ./
ENV PATH /opt/node_modules/.bin:$PATH
ENV APP_KEYS b9TGvkgjm1jUkHCHgUGgZQ==,awVR1MXtZsP1Snv/HhWkNw==,YIeO6RKpM01HQ/Z16dMnUw==,f+DaPEAvi54tylk9JToLoA==

RUN chown -R node:node /opt/app
USER node
EXPOSE 1337
CMD ["yarn", "start"]

