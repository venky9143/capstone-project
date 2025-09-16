pipeline {
    agent any

    environment {
        REGISTRY        = "venkateshkesa"
        IMAGE           = "capstoneproject"
        TAG             = "${BUILD_ID}"
        MINIKUBE_PROFILE= "jenkins-minikube"
        MINIKUBE_HOME   = "C:\\JenkinsMinikube"
        // KUBECONFIG is set for Windows PowerShell commands in 'bat' steps
        KUBECONFIG      = "C:\\JenkinsMinikube\\.kube\\config"
    }

    stages {
        stage('Check Nginx version') {
            steps {
                bat 'C:\\Users\\Infinite\\Desktop\\nginx-1.29.1\\nginx.exe -v'
            }
        }

        stage('Check Docker version') {
            steps {
                bat 'docker -v'
            }
        }

        stage('Helm version') {
            steps {
                bat 'helm version'
            }
        }

        stage('Kubectl version') {
            steps {
                bat '''
                powershell -Command "$env:KUBECONFIG='C:\\JenkinsMinikube\\.kube\\config'; kubectl version --client"
                '''
            }
        }

        stage('Docker login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    bat 'docker login -u %USERNAME% -p %PASSWORD%'
                }
            }
        }

        stage('Parallel Docker tasks') {
            parallel {
                stage('List Docker images') {
                    steps { bat 'docker images' }
                }
                stage('Remove Docker images') {
                    steps {
                        bat '''
                        FOR /F "tokens=*" %%i IN ('docker images -q') DO (
                            echo Removing image %%i
                            docker rmi -f %%i || echo Failed to remove image %%i, continuing...
                        )
                        exit 0
                        '''
                    }
                }
            }
        }

        stage('Docker Build') {
            parallel {
                stage('Copy Build Context') {
                    steps {
                        bat '''
                        copy C:\\Users\\Infinite\\Desktop\\capstone-project\\Dockerfile .
                        copy C:\\Users\\Infinite\\Desktop\\capstone-project\\index.html .
                        '''
                    }
                }
                stage('Build & Push Image') {
                    steps {
                        bat '''
                        docker build -t %REGISTRY%/%IMAGE%:%TAG% .
                        docker images
                        docker push %REGISTRY%/%IMAGE%:%TAG%
                        '''
                    }
                }
            }
        }

        stage('Check Minikube') {
            steps {
                bat '''
                  echo MINIKUBE_HOME=%MINIKUBE_HOME%
                  dir %MINIKUBE_HOME%
        
                 echo === Checking Minikube Status ===
                 minikube status --profile=%MINIKUBE_PROFILE%

                echo === Updating kubectl context ===
                minikube update-context --profile=%MINIKUBE_PROFILE%

                echo === Switching context to Jenkins Minikube ===
                kubectl config use-context %MINIKUBE_PROFILE%

                echo === Verifying Kubernetes Nodes ===
                kubectl get nodes 
                '''
            }
        }

        stage('Verify Kubernetes') {
            steps {
                bat '''
                powershell -Command "$env:KUBECONFIG='C:\\JenkinsMinikube\\.kube\\config'; kubectl get nodes"
                powershell -Command "$env:KUBECONFIG='C:\\JenkinsMinikube\\.kube\\config'; minikube status --profile=%MINIKUBE_PROFILE%"
                '''
            }
        }

        stage('Helm Deploy') {
            steps {
                bat '''
                powershell -Command "$env:KUBECONFIG='C:\\JenkinsMinikube\\.kube\\config'; cd C:\\Users\\Infinite\\Desktop\\capstone-project\\helm\\capstone-chart; helm upgrade --install capstone-chat . --set image.repository=%REGISTRY%/%IMAGE% --set image.tag=%TAG% --namespace capstone --create-namespace; kubectl get all -n capstone"
                '''
            }
        }

        stage('Check Helm Releases') {
            steps {
                bat '''
                powershell -Command "$env:KUBECONFIG='C:\\JenkinsMinikube\\.kube\\config'; helm list -n capstone"
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                bat '''
                powershell -Command "$env:KUBECONFIG='C:\\JenkinsMinikube\\.kube\\config'; kubectl get all -n capstone"
                powershell -Command "$env:KUBECONFIG='C:\\JenkinsMinikube\\.kube\\config'; kubectl get pods -n capstone"
                powershell -Command "$env:KUBECONFIG='C:\\JenkinsMinikube\\.kube\\config'; kubectl get svc -n capstone"
                '''
            }
        }

        stage('Minikube Service Access') {
            steps {
                bat '''
                echo Getting Minikube IP and NodePort...
                set MINIKUBE_IP=
                for /f "tokens=*" %%i in ('minikube ip --profile=%MINIKUBE_PROFILE%') do set MINIKUBE_IP=%%i

                echo Minikube IP is %MINIKUBE_IP%
                kubectl get svc capstone-chat -n capstone -o=jsonpath="{.spec.ports[0].nodePort}" > nodeport.txt
                set /p NODE_PORT=<nodeport.txt

                echo NodePort is %NODE_PORT%
                echo Application URL: http://%MINIKUBE_IP%:%NODE_PORT%
                '''
            }
        }
        stage('Port Forward') {
           steps {
               bat '''
               REM Kill any existing port-forward
               for /f "tokens=5" %%a in ('netstat -ano ^| findstr :9090') do taskkill /F /PID %%a

               REM Start port-forward in background
               start /B kubectl port-forward svc/capstone-chat 9090:80 -n capstone

               REM Wait a few seconds to ensure port-forward is ready
               timeout /t 5 >nul

               echo Application URL: http://localhost:9090
               curl http://localhost:9090
            '''
           }
        }

    }

    post {
        success {
            emailext(
                subject: "Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "Good news! Deployment was successful on Minikube.\n\nCheck details at ${env.BUILD_URL}",
                to: 'venkat.kesa9@gmail.com'
            )
        }
        failure {
            emailext(
                subject: "Build FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "Oops! Something went wrong.\n\nCheck logs at ${env.BUILD_URL}",
                to: 'venkat.kesa9@gmail.com'
            )
        }
    }
}
