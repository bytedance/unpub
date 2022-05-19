pipeline {
  agent {
    kubernetes {
      defaultContainer 'agent'
      yaml agentPod("2", "8Gi", "2", "8Gi", "jenkins-slave")
    }
  }

  options {
    buildDiscarder(logRotator(daysToKeepStr: '7'))
    timeout(time: 90, unit: 'MINUTES')
  }

  environment {
    ECRURI = '583646779642.dkr.ecr.eu-west-2.amazonaws.com'
    APP = 'unpub'
    AWS_ACCOUNT_ID = "583646779642"
    AWS_REGION = "eu-west-2"
    CLUSTER = "staging-uk-eks-k8s"
    TASK = "deploy"
    JENKINS_SERVICE_ACCOUNT = "jenkins"
    JENKINS_URL_SUPPORT_INSTANCE = "https://jenkins.devops.plentific.com/"
  }

  libraries {
    lib('shared-pipeline-library')
  }

  stages {
    stage ('1. Prepare') {
      steps {
        container('agent') {
          sendNotifications 'STARTED'
        }
      }
    }

    stage ('2. Build unpub registry') {
      steps {
        container('kaniko') {
          sh """
            /kaniko/executor \
              -f `pwd`/airflow/Dockerfile \
              -c `pwd`/airflow \
              --cache=false \
              --cache-repo=${env.ECRURI}/kaniko \
              --destination=${env.ECRURI}/${env.APP}:airflow-${env.GIT_COMMIT}
          """
        }
      }
    }

    stage ('3. Update git repository') {
      steps {
        container('agent') {
          script {
            withCredentials([usernamePassword(credentialsId: 'github1', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
              git branch: 'master', credentialsId: 'github1', url: 'https://github.com/plentific/devops-cd.git'

              sh """
                git config --global user.email "devops+jenkinsci1@plentific.com"
                git config --global user.name "jenkinsci"
              """

              sh """
                success=0; attempts=0;
                until \$success || [ \$attempts = 20 ]; do
                  let ++attempts;
                  git pull https://$GIT_USERNAME:$GIT_PASSWORD@github.com/plentific/devops-cd.git --rebase || echo "Don't need rebase";
                  
                  yq e '.spec.template.spec.containers[0].image = "${env.ECRURI}/${env.APP}:airflow-${env.GIT_COMMIT}"' -i helm/apps/airflow/statefulset-airflow.yaml
                  yq e '.metadata.labels.deploy-commit = "${env.GIT_COMMIT}"' -i helm/apps/airflow/statefulset-airflow.yaml
                  git add helm/apps/airflow/statefulset-airflow.yaml
                  commit=\$(git commit -m "[${env.BUILD_NUMBER}] airflow -> ${env.APP}:${env.GIT_COMMIT}" || echo "No git commit needed")
                  result=\$(echo "Everything up-to-date" && git push https://$GIT_USERNAME:$GIT_PASSWORD@github.com/plentific/devops-cd.git HEAD:master || echo "Failed to push")
                  
                  if [ "\$result" == "Everything up-to-date" ]; then
                    echo "Everything up-to-date"
                    break
                  fi
                  if [ "\$commit" == "No git commit needed" ]; then
                    echo "No git commit needed"
                    break
                  fi
                  sleep 3;
                done;
                if ! \$success; then
                  echo "Gave up after \$attempts attempts";
                fi
              """
            }
          }
        }
      }
    }

    stage ('4. Sync data with ArgoCD') {
      steps {
        container('agent') {
          script {
            sh """
              unset AWS_WEB_IDENTITY_TOKEN_FILE
              unset AWS_ROLE_ARN
              success=0; attempts=0;
              until \$success || [ \$attempts = 150 ]; do
                  let ++attempts;
                  check=\$(kubectl get statefulset -l app=${env.APP},deploy-commit=${env.GIT_COMMIT} -n airflow);
                  if [ "\$check" != "" ]; then
                      echo "statefulset exist, continue waiting for correct run";
                      success=1;
                      break;
                  else
                      echo "WAIT \$attempts";
                      sleep 6;
                  fi
              done;
              if [ \$success = 0 ] ; then
                  echo "Gave up after \$attempts attempts";
                  exit 125
              else
                  sleep 60;
                  kubectl wait --for=condition=ready --timeout=600s pod -l 'app=${env.APP},statefulset.kubernetes.io/pod-name=${env.APP}-0' -n airflow
              fi
            """
          }
        }
      }
    }

  }

  post {
    always {
      sendNotifications currentBuild.result
    }
  }
}
