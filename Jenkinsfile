//aYo Assignment - Jenkinfile for deploying Sample Application
pipeline{
 agent any
 triggers { 
  pollSCM('H/15 * * * *')
}
    stages {
            //Checkout of sample application war file and other dependent files
              stage('Checkout') {
                  steps { 
                  checkout([$class: 'GitSCM', branches: [[name: '**']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ashajain0190/Deployment-to-K8.git']]])
                  }
              }
              //Creating Docker image and tagging it
              stage('Docker Build and Taging') {
              steps {
                   sh """docker build -t k8deployment:v${env.BUILD_NUMBER} ."""
                   sh """docker tag k8deployment asha0190/k8deployment:v${env.BUILD_NUMBER}"""
                  }
             }
             //Publish Docker image
              stage('Publish image to DockerHub') {
              steps {
              withDockerRegistry(credentialsId: '9041890f-2abd-4c91-9537-ab206b5d2df7', url: '') {
              sh  """docker push asha0190/k8deployment:v${env.BUILD_NUMBER}"""
              }
             }
            }      
            // Deploy to K8 Minikube Cluster
              stage('Deploy to K8 Cluster') {
               steps {
               sh """chmod +x ./changeversion.sh"""
               sh """./changeversion.sh v${env.BUILD_NUMBER}"""
               sh """rm ./deployment.yml"""
               kubernetesDeploy configs: '*.yml', kubeConfig: [path: '.kube/config'], kubeconfigId: 'KubeConfig', secretName: '', ssh: [sshCredentialsId: 'e77c6f04-7221-4d18-b1e0-6b1f6aea0833', sshServer: 'https://192.168.99.100'], textCredentials: [certificateAuthorityData: '/home/ashajain0190/.minikube/ca.crt', clientCertificateData: '/home/ashajain0190/.minikube/profiles/minikube/client.crt', clientKeyData: '/home/ashajain0190/.minikube/profiles/minikube/client.key', serverUrl: 'https://192.168.99.100:8443']
                  }  
               }
         }
      }
