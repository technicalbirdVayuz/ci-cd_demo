FROM mhart/alpine-node:12.18.3
MAINTAINER Gary Ascuy <gary.ascuy@gmail.com>

ENV BUILD_PACKAGES="python make gcc g++ git libuv bash curl tar bzip2" \
    NODE_ENV=production \
    ROOT_URL=http://localhost:3000 \
    PORT=3000

WORKDIR /root/app/bundle

ADD demo.tar.gz /root/app
RUN apk --update add ${BUILD_PACKAGES} \
    && (cd programs/server/ && npm install --unsafe-perm) \
    && apk --update del ${BUILD_PACKAGES}

EXPOSE 3000
CMD node main.js


#docker build -t interviewcracker8.0 .
#docker run -d -e  ROOT_URL=http://localhost -e #MONGO_URL=mongodb://cracker1:cracker1@ds119028.mlab.com:19028/cracker_db -p 3000:3000 technicalbird/cracker:9.6.1
#docker tag technicalbird/cracker:7.0 technicalbird/cracker:7.0
#docker push technicalbird/cracker:7.0
#docker pull technicalbird/cracker:7.0

#docker run -d -e  ROOT_URL=http://localhost -e MONGO_URL=mongodb://cracker1:cracker1@ds119028.mlab.com:19028/cracker_db -p 3000:3000 technicalbird/cracker:9.6.1