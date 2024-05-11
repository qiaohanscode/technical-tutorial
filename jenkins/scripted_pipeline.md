### Scripted Pipeline
Scripted pipeline can be defined with
```
pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'

                script {
                    def browsers = ['chrome', 'firefox']
                    for (int i = 0; i < browsers.size(); ++i) {
                        echo "Testing the ${browsers[i]} browser"
                    }
                }
            }
        }
    }
}
```
There are two different contexts involved with the scripted pipeline,
- Groovy: within the block `script`
- environment: within all the blocks
