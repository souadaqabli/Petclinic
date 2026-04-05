pipeline {
    agent any
    
    tools { 
        maven 'Maven3' 
    }
    
    environment {
        // On récupère le chemin du scanner configuré dans Jenkins
        SCANNER_HOME = tool 'sonar-scanner'
    }
    
    stages {
        stage('Build (Avec saut des tests)') {
            steps { 
                // Le fameux -DskipTests pour éviter le crash Java 21
                sh 'mvn clean package -DskipTests' 
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                // Utilise la clé SonarQube que tu as enregistrée
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.projectName=Petclinic \
                    -Dsonar.java.binaries=target/classes \
                    -Dsonar.projectKey=Petclinic '''
                }
            }
        }
        
        stage('Docker Build & Push') {
            steps {
                script {
                    // Utilise l'ID exact des credentials Docker ajoutés dans Jenkins
                    withDockerRegistry([credentialsId: 'dockerhub-creds', url: '']) {
                        def app = docker.build("souads20/petclinic:${env.BUILD_ID}")
                        app.push()
                    }
                }
            }
        }
        
        stage('Update Git Manifest (Pour ArgoCD)') {
            steps {
                script {
                    sh """
                        sed -i 's|image: TON_PSEUDO_DOCKERHUB/petclinic:.*|image: souads20/petclinic:${env.BUILD_ID}|g' k8s/deployment.yaml
                        git config user.email "jenkins@devops.com"
                        git config user.name "Jenkins CI"
                        git add k8s/deployment.yaml
                        git commit -m "Update image tag to ${env.BUILD_ID}"
                    """
                    // Utilise l'ID exact du Token Github ajouté dans Jenkins
                    withCredentials([usernamePassword(credentialsId: 'github-creds', passwordVariable: 'GIT_PAT', usernameVariable: 'GIT_USER')]) {
                        sh 'git push https://${GIT_USER}:${GIT_PAT}@github.com/souadaqabli/petclinic-gitops.git HEAD:main'
                    }
                }
            }
        }
    }
}
