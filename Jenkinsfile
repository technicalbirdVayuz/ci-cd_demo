pipeline {
   agent any

   environment {
     // You must set the following environment variables
     // ORGANIZATION_NAME
     // YOUR_DOCKERHUB_USERNAME (it doesn't matter if you don't have one)
     ORGANIZATION_NAME = "bird-orgranization"
     SERVICE_NAME = "ci-cd_demo"
     REPOSITORY_TAG="${YOUR_DOCKERHUB_USERNAME}/${ORGANIZATION_NAME}-${SERVICE_NAME}:${BUILD_ID}"
   }

   stages {
      stage('Preparation') {
         steps {
            git credentialsId: 'GitHub', url: "https://github.com/${ORGANIZATION_NAME}/${SERVICE_NAME}"
         }
      }
      stage('Build') {
         steps {
            sh 'meteor build .'
         }
      }

      stage('Build and Push Image') {
         steps {
           sh 'docker image build -t ${REPOSITORY_TAG} .'
         }
      }
      
      stage('Clearing other Running Containers') {
         steps {      
             sh 'docker rm -f $(docker ps -aq) >/dev/null 2>&1 || true'
         }
      }

      stage('Deploy to Cluster') {
          steps {
            sh 'docker run -d -e  ROOT_URL=http://localhost -e MONGO_URL=mongodb://cracker1:cracker1@ds119028.mlab.com:19028/cracker_db -p 3000:3000 ${REPOSITORY_TAG}'
          }
      }
   }
}