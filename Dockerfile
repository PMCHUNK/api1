FROM node:18

ENV PORT 1337
ENV HOST 0.0.0.0
ENV NODE_ENV production
ENV APP_KEYS b9TGvkgjm1jUkHCHgUGgZQ==,awVR1MXtZsP1Snv/HhWkNw==,YIeO6RKpM01HQ/Z16dMnUw==,f+DaPEAvi54tylk9JToLoA==

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY . /usr/src/app/
EXPOSE 1337
CMD ["npm", "run", "start"]
