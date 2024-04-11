## Jenkins Pipeline

### Pipeline Steps

- writeFile -- write given content to a named file in the current directory, e.g. build information

### Plugins
All available Jenkins Plugins can be searched under [Jenkins Plungins Index](https://plugins.jenkins.io/).

### Plugins for Build Management
All build management plugins can be found under [Plugins Build Management](https://plugins.jenkins.io/ui/search/?categories=buildManagement), which is also available through a link in the [Jenkins Plungins Index](https://plugins.jenkins.io/).

The plugins have been listed in the order of percentage of usage in all jenkins instances.

### Plugin Timestamp
Install the Timestampe Plugin if want to use the timestamps option.
```
// Global Variable goes here
// Pipeline block
pipeline {
   // Agent block
   agent { node { label 'Manage_Contact_Demo'}}
   options {
      buildDiscarder(logRotator(numToKeepStr: '30'))
      timestamps()
   }
}
```

### when
```
 stage("Push to Dockerhub") {
     when { 
       equals 
          expected: "true", 
          actual: "${params.PushImage}" }
     steps {
     ...
     }
 }    
```

## Appendix A -- useful links
- Jenkins -- extending with shared library
https://www.jenkins.io/doc/book/pipeline/shared-libraries/