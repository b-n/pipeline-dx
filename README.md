# Pipeline DX + Ant for Salesforce

## Intro

Bitbucket pipelines allow you to choose your own image to build against. This
image comes with java, ant, and a bunch of other dependencies, however it is
(of course) missing some Salesforce stuff. This repo builds an image that comes
with

- SFDX (Latest version)
- Force Migration Tool - ant-salesforce.jar (v40.0)

## Prebuilt images

I am going to try and build images every release hosted at [hub.docker.com](https://hub.docker.com/r/nzchicken/sfdx/)

## Using with Bitbucket Pipelines

Should be as simple as adding `image: nzchicken/sfdx:latest` to the top of your
bitbucket-pipelines.yml fiels in your repo. It is recommended that you use a
version that you know will work with your source (e.g. `nzchicken/sfdx:v40.0.1`)

### Sample bitbucket-pipelines.yml

Add the following to your archive (and set env settings in your repo)

```yaml
image: nzchicken/sfdx:v40.0.1

pipelines:
  default:
    - step:
        script:
          - sfdx force --version
          - ant deploy -Dsf.username=$USERNAME -Dsf.password=$PASSWORD -Dsf.testlevel=$TESTLEVEL
```

Note: The above will just display the sfdx force version, and then deploy to
an org using ant based on the package.xml in the src folder (build.xml below).
Adjust to suit your needs, and feel free to remove the sfdx/ant command etc.

### Sample build.xml (Force Migration Tool)

```xml
<project name="Saleforce Pipeline Builds" default="test" basedir="." xmlns:sf="antlib:com.salesforce">
    <property environment="env"/>

    <condition property="sf.username" value=""> <not> <isset property="sf.username"/> </not> </condition>
    <condition property="sf.password" value=""> <not> <isset property="sf.password"/> </not> </condition>
    <condition property="sf.testlevel" value=""> <not> <isset property="sf.testlevel"/> </not> </condition>
    <condition property="sf.sessionId" value=""> <not> <isset property="sf.sessionId"/> </not> </condition>

    <target name="deploy">
        <sf:deploy
            username="${sf.username}"
            password="${sf.password}"
            serverurl="https://test.salesforce.com"
            maxPoll="400"
            deployRoot="src"
            checkOnly="false"
            testLevel="${sf.testlevel}" />
    </target>
</project>
```
