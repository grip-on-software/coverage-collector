pipeline {
    agent { label 'docker' }

    environment {
        IMAGE_TAG = env.BRANCH_NAME.replaceFirst('^master$', 'latest')
        GITLAB_TOKEN = credentials('coverage-collector-gitlab-token')
        SCANNER_HOME = tool name: 'SonarQube Scanner 3', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
    }

    options {
        gitLabConnection('gitlab')
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }
    triggers {
        gitlab(triggerOnPush: true, triggerOnMergeRequest: true, branchFilterType: 'All', secretToken: env.GITLAB_TOKEN)
    }

    post {
        success {
            updateGitlabCommitStatus name: env.JOB_NAME, state: 'success'
        }
        failure {
            updateGitlabCommitStatus name: env.JOB_NAME, state: 'failed'
        }
        aborted {
            updateGitlabCommitStatus name: env.JOB_NAME, state: 'canceled'
        }
    }

    stages {
        stage('Build') {
            steps {
                checkout scm
                updateGitlabCommitStatus name: env.JOB_NAME, state: 'running'
                sh 'docker build -t $DOCKER_REGISTRY/gros-coverage-collector:$IMAGE_TAG . --build-arg NPM_REGISTRY=$NPM_REGISTRY'
            }
        }
        stage('Push') {
            when { branch 'master' }
            steps {
                sh 'docker push $DOCKER_REGISTRY/gros-coverage-collector:latest'
            }
        }
    }
}
