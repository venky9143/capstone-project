pipeline{
    agent any
    environment {
        // DockerHub credentials from Jenkins credentials store
        DOCKER_CREDENTIALS = credentials('dockerhub')

        // AWS credentials from Jenkins credentials store
        AWS_ACCESS = credentials('AWS ACCESS ')

        // Kubeconfig file stored as Jenkins secret file
        KUBECONFIG_FILE = credentials('KUBECONFIG')
        REGISTRY= "venky9143"
        IMAGE = "capstone-project"
        TAG = "${BUILD_ID}"
        AWS_REGION = "us-east-1"            // change if needed
        ACCOUNT_ID =  "905418376874" // replace with your AWS account ID
        REPO_NAME  = "capstone-project"
        ECR_URL    = "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    }
    stages{
        stage('CHECKOUT'){
            steps{
                echo "Checking out the code..."
                git branch: 'main', url: 'https://github.com/venky9143/capstone-project.git'
            }
        }
        stage('LIST FILES IN DIRECTORY '){
            steps{
                echo "Listing the files in the repository..."
                bat 'dir'
            }
        }
        stage('parallel'){
            parallel{
                stage('LIST OF DOCKR IMAGES '){
                    steps{
                        echo "Listing Docker images..."
                        bat 'docker images'
                    }
                }
                stage('DELETEING OLD IMAGES'){
                    steps{
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

        stage('BUILD DOKCR IMAGE WITH BUILD ID'){
            steps{
                echo "Building the Docker image..."
                bat 'docker build -t %REGISTRY%/%IMAGE%:%TAG% .'
            }
        }
        stage('LIST OF NEWLY CEREATED DOCKER IMAGES '){
            steps{
                echo "Listing Docker images..."
                bat 'docker images'
            }
        }
        stage('ECR LOGIN'){
            steps{
                bat'''
                echo "Logging to AWS ECR "
                aws ecr get-login-password --region %AWS_REGION% | docker login --username AWS --password-stdin %ECR_URL%
                '''
            }
        }
        stage('Create ECR Repo if not exists') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS ACCESS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                bat '''
                    echo "Checking if ECR repo exists..."
                    aws ecr describe-repositories --repository-names %REPO_NAME% --region %AWS_REGION% >nul 2>&1

                    if %ERRORLEVEL% NEQ 0 (
                    echo "Repository not found, creating new repo: %REPO_NAME%"
                    aws ecr create-repository --repository-name %REPO_NAME% --region %AWS_REGION%
                    ) 

                    if %ERRORLEVEL% EQU 0 (
                    echo Repository already exists: %REPO_NAME%
                    )
                    '''
                }
            }
        }
        stage('REPO NAME DISPLAY'){
            steps{
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS ACCESS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    bat '''
                    echo "Repo Name Output"
                    aws ecr describe-repositories --repository-names %REPO_NAME% --region %AWS_REGION%
                    '''
                }
            }
        }
        stage('DOCKER TAGGING AND PUSH TO ECR') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS ACCESS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {


                    bat '''
                    echo "docker image tagging and push to ECR"
                    docker tag %REGISTRY%/%IMAGE%:%TAG% %ECR_URL%/%REPO_NAME%:%TAG%

                    echo "Finding and deleting the manifest list (if any)"
                    for /f %%i in ('aws ecr list-images --repository-name %REPO_NAME% --region %AWS_REGION% --filter "tagStatus=ANY" --query "imageIds[?type==`MANIFEST_LIST`].imageDigest" --output text') do (
                        echo "Deleting manifest list digest %%i"
                        aws ecr batch-delete-image --repository-name %REPO_NAME% --region %AWS_REGION% --image-ids imageDigest=%%i
                    )

                    echo "Listing the old images in ECR (excluding current tag) into images.json"
                    aws ecr list-images --repository-name %REPO_NAME% --region %AWS_REGION% --query "imageIds[?imageTag!='%TAG%']" --output json > images.json

                    echo "Deleting the old images ECR listed in the file images.json"
                    if exist images.json (
                        echo "Deleting old images..."
                        aws ecr batch-delete-image --repository-name %REPO_NAME% --region %AWS_REGION% --image-ids file://images.json
                    ) else (
                        echo "No Old images are found"
                    )

                    echo "Pushing new Docker image to ECR"
                    docker push %ECR_URL%/%REPO_NAME%:%TAG%
                    '''
                }
            }
        }
        stage('Terraform Init'){
            steps{
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS ACCESS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    bat '''
                    echo "Change Directory to Terraform"
                    cd terraform
                    terraform init
                    '''
                }
            }
        }
        stage('Terraform Format'){
            steps{
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS ACCESS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]){

                bat '''
                echo "Terraform Formatting"
                cd terraform
                terraform fmt
                '''
                }
            }
        }
        stage('Terrafor validate'){
            steps{
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS ACCESS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]){
                    bat '''
                    echo "Terraform validating"
                    cd terraform
                    terraform validate
                    '''
                }
            }
        }
        stage('terraform plan'){
            steps{
                withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID', credentialsId: 'AWS ACCESS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]){
                    bat '''
                    echo "Terraform Plan"
                    cd terraform
                    terraform plan
                    '''
                }
            }
        }
    }
}