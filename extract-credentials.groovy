// This Jenkins Groovy script extracts credentials in Jenkins and outputs them
// in a JSON format that can be digested by "Jenkins Configuration as Code".
// Just pass the output into a JSON to YAML converter.  You can run this
// through the Jenkins Script Console or similar.
//
// Thank you:
//  - https://github.com/tkrzeminski/jenkins-groovy-scripts/blob/master/show-all-credentials.groovy
//
// To conver to YAML `json2yaml | sed '/^[[:space:]]*$/d'`
//
import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey
import com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl
import org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl
import org.jenkinsci.plugins.plaincredentials.StringCredentials
import com.microsoft.azure.util.AzureCredentials
import com.microsoftopentechnologies.windowsazurestorage.helper.AzureStorageAccount
import groovy.json.JsonOutput


// set Credentials domain name (null means is it global)
domainName = null

credentialsStore = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0]?.getStore()
domain = new Domain(domainName, null, Collections.<DomainSpecification>emptyList())

def credentials = []
credentialsStore?.getCredentials(domain).each{
  if (it instanceof UsernamePasswordCredentialsImpl)
    credentials += [
      usernamePassword: [
        scope: 'GLOBAL',
        id: it.id,
        username: it.username,
        password: it.password?.getPlainText(),
        description: it.description,
      ]
    ]
  else if (it instanceof BasicSSHUserPrivateKey) {
    data = [
      basicSSHUserPrivateKey: [
        scope: 'GLOBAL',
        id: it.id,
        username: it.username,
        passphrase: it.passphrase ? it.passphrase.getPlainText() : '',
        description: it.description,
        privateKeySource: [
          directEntry: [
            privateKey: it.privateKeySource?.getPrivateKey(),
          ]
        ]
      ]
    ]
    credentials += data
  } else if (it instanceof AWSCredentialsImpl)
    credentials += [
      aws: [
        scope: 'GLOBAL',
        id: it.id,
        accessKey: it.accessKey,
        secretKey: it.secretKey?.getPlainText(),
        description: it.description,
      ]
    ]
  else if (it instanceof AzureCredentials)
    credentials += [
      azure: [
        scope: 'GLOBAL',
        id: it.id,
        description: it.description,
        subscriptionId: it.subscriptionId,
        clientId: it.clientId,
        clientSecret: it.getPlainClientSecret(),
        azureEnvironmentName: it.azureEnvironmentName,
        tenant: it.tenant,

      ]
    ]
  else if (it instanceof StringCredentials)
    credentials += [
      string: [
        scope: 'GLOBAL',
        id: it.id,
        secret: it.secret?.getPlainText(),
        description: it.description,
      ]
    ]
  else if (it instanceof FileCredentialsImpl)
    credentials += [
      file: [
        scope: 'GLOBAL',
        id: it.id,
        fileName: it.fileName,
        secretBytes: it.secretBytes?.toString(),
        description: it.description,
      ]
    ]
  else if (it instanceof AzureStorageAccount)
    credentials += [
      azureStorageAccount: [
          scope: 'GLOBAL',
          blobEndpointURL: it.blobEndpointURL,
          description: it.description,
          id: it.id,
          storageAccountName: it.storageAccountName,
          storageKey: it.plainStorageKey,
      ]
    ]
  else
    credentials += [
      UNKNOWN: [
        id: it.id
      ]
    ]
}

def result = [
  credentials: [
    system: [
      domainCredentials: [
        [
          credentials: credentials
        ]
      ]
    ]
  ]
]
def json = JsonOutput.toJson(result)
println JsonOutput.prettyPrint(json)

return
