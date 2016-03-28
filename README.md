# Platanus fastlane base

This is a collection of *lanes* and *actions* ment to streamline the
platanus workflow for app developemnt and deployment.

## What is fastlane

From the fastlane [repository][fastlane-repo]

> fastlane lets you define and run your deployment pipelines for different
> environments. It helps you unify your apps release process and automate the
> whole process.

## Getting started

You need to install the fastlane gem and setup your project to load the
fastlane-cordova collections into your project

    gem install fastlane

In you app repository, add the fastlane configuration file

    mkdir fastlane
    touch fastlane/Fastfile

In the `Fastfile` you need to import the `Fastfile` located in this repository

```ruby
# <app_repo>/fastlane/Fastfile

# import from an online repository
import_from_git(url:"https://github.com/platanus/fastlane-cordova")

# or
# import from a local checkout
# this is usefull for development
import "~/fastlane-cordova/fastlane/Fastfile"
```

You'll need to add a `config.yml` with the base configuration.

```yaml
---
default: &default
  apple_id: "ios-dev@platan.us"
  team_id: "35EKS95Z97"
  configuration: Debug

stages:
  staging:
    <<: *default

  production:
    <<: *default
    configuration: Release
```

** Configuration options:**

- **stages** (required):
Is a map of stage specific configuration where the *key*
is the name of the stage

  - `apple_id` (required): The Apple ID account to use

  - `team_id` (required): The apple developer team ID

  - `configuration` (optional): `[Debug, Release]` is the configuration
    that xcode will use to compile your project

## How to use it

Just run fastlane with the lane and options you want to use

    fastlane ios <lane> [option_key:option_value,...]

1. Create the application and app ids in iTunes Connect and the developer
center with the `create` lane

1. Then you should create the certificates and provisioning profiles running
the `certs` lane

1. Then you should be able to deploy with the `deploy` lane

## Available lanes

### `create`

Creates app ids for each of the stages. The apps are created using the
information in the cordova `config.xml` file with a `stage` suffix.
It use the following values:

| value        | template                       | example                   |
| ------------ | ------------------------------ | ------------------------- |
| **App Id**   | `<cordova_app_id>.<stage>`     | us.platan.madbill.staging |
| **App Name** | `<cordova_app_name> - <stage>` | Madbill - Staging         |

> **Note**: If a stage is named **production**, the `app_id` and `app_name` are
> used as are defined in the `config.xml` without the `stage` suffix

### `certs`

Create necessary profiles and certificates

It use [match][fastlane-match] and follows the
[code signing guide][codesigning-guide]

### `deploy`

Deploy app to testflight or appstore. To deploy you need to specify
distribution type and the stage.

```shell
fastlane ios deploy to:<distribution> stage:<stage>

# To deploy the staging app to the appstore
fastlane ios deploy to:appstore stage:staging
```

- **distribution types**: `testflight` or `appstore`
- **stage**: the stages are defined in the `config.yml` file

### `service`

Enable or disable services in the application.

```shell
fastlane ios service enable:<service, ...> disable:<service, ...>

# To deploy enable push notifications
fastlane ios service enable:push-notification
```

- **supported service types**:

  - `healthkit` HealthKit
  - `homekit` HomeKit
  - `wireless-conf` Wireless Accessory Configuration
  - `inter-app-audio` Inter-App-Audio
  - `passbook` Passbook
  - `push-notification` Push notification
  - `vpn-conf` VPN Configuration

When enabling `push-notification` the lane also creates a new certificate for
each stage and upload them to the SNS platform creating a new application.

> **Important** You need to have a valid AWS credentials in your
> environment. `ENV['AWS_ACCESS_KEY_ID'] and ENV['AWS_SECRET_ACCESS_KEY']`

## Credits

Thank you [contributors](https://github.com/platanus/fastlane-cordova/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

fastlane-cordova is maintained by [platanus](http://platan.us).

## License

Potassium is © 2016 platanus, spa. It is free software and may be redistributed
under the terms specified in the LICENSE file.

[fastlane-repo]: https://github.com/fastlane/fastlane
[fastlane-match]: https://github.com/fastlane/match
[codesigning-guide]: https://codesigning.guide
