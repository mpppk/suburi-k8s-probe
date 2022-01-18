FROM node
ENV PORT=3001
COPY package.json .
RUN npm install
COPY . .
ENTRYPOINT [ "npm", "start" ]