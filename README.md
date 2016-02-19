# Platanus fastlane base

This is a collection of *lanes* and *actions* ment to streamline the
platanus workflow for app developemnt and deployment.

## What is fastlane

From the fastlane [repository][fastlane-repo]
> fastlane lets you define and run your deployment pipelines for different environments. It helps you unify your apps release process and automate the whole process.

## Getting started

You need to install the fastlane gem and setup your project to load the
fastlane-base collections into your project

    gem install fastlane

In you app repository, add the fastlane configuration file

```
mkdir fastlane
touch fastlane/Fastfile
```

In the `Fastfile` you need to import the `Fastfile` located in this repository

```ruby
# <app_repo>/fastlane/Fastfile

# import from an online repository
import_from_git "https://github.com/platanus/fastlane-base"

# or
# import from a local checkout
# this is usefull for development
import "~/fastlane-base/fastlane/Fastfile"
```

You'll need to add a `config.yml` with the base configuration.

```yml
---
stages:
  staging:
    apple_id: "ios-dev@platan.us"
    team_id: "35EKS95Z97"

  production:
    apple_id: "ios-dev@platan.us"
    team_id: "35EKS95Z97"
```

#### Configuration options:

`stages` (required): is a map of stage specific configuration where the *key* is the name
of the stage

## Available lanes

`fastlane ios create`: Create app ids for each of the stages
`fastlane ios certs`: Create necessary profiles and certificates

[fastlane-repo]: https://github.com/fastlane/fastlane
