workflow "New workflow" {
  on = "push"
  resolves = ["CI", "PushTestImage"]
}

action "Show Environment" {
  uses = "docker://alpine"
  args = "printenv"
}

action "Build" {
  uses = "actions/docker/cli@76ff57a"
  args = "build -t $APP_IMAGE ."
  env = {
    APP_IMAGE = "my-image",
  }
  needs = ["Show Environment"]  
}

action "CI" {
  uses = "actions/docker/cli@76ff57a"
  args = "run $APP_IMAGE composer ci"
  env = {
    APP_IMAGE = "my-image"
  }  
  needs = ["Build"]
}

action "Deploy Test Image" {
  uses = "keboola/actions/ecr-deploy@master"
  args = "tag $APP_IMAGE:latest $REPOSITORY:test"
  env = {
    KBC_DEVELOPERPORTAL_APP = "keboola-test.app-acme-anvil-service",
    KBC_DEVELOPERPORTAL_VENDOR = "keboola-test",
    KBC_DEVELOPERPORTAL_USERNAME = "keboola-test+odin_action_test",
    KBC_DEVELOPERPORTAL_PASSWORD = "SNAwULmpdQ_Dye2AnHzofLQJZ2tABgkNGphWbknC9Z5TItpZNSOaVRK+xOwIZNN6",
    APP_IMAGE = "my-image",
    REPOSITORY_TAG = "test"
  }
  needs = ["Build"]
}

action "Run Test Job" {  
  uses = "actions/docker/cli@76ff57a"
  args = "run -e KBC_STORAGE_TOKEN quay.io/keboola/syrup-cli:latest run-job $KBC_DEVELOPERPORTAL_APP $KBC_APP_TEST_CONFIG_ID test"
  env = {
    KBC_DEVELOPERPORTAL_APP = "keboola-test.app-acme-anvil-service",
    KBC_APP_TEST_CONFIG_ID = "433630062",
    KBC_STORAGE_TOKEN = "578-150061-9amR3LoxoG8FtJX9eSbkLSFcWl7BH1z0GTLhXN7x",
  } 
  needs = ["Deploy Test Image"]
}

action "Deploy Production Image Filter" {
  uses = "actions/bin/filter@master"
  args = "tag"
  needs = ["Build"]
}

action "Deploy Production Image" {  
  uses = "keboola/actions/ecr-deploy@master"
  args = "run -e KBC_STORAGE_TOKEN quay.io/keboola/syrup-cli:latest run-job $KBC_DEVELOPERPORTAL_APP $KBC_APP_TEST_CONFIG_ID test"
  env = {
    KBC_DEVELOPERPORTAL_APP = "keboola-test.app-acme-anvil-service",
    KBC_DEVELOPERPORTAL_VENDOR = "keboola-test",
    KBC_DEVELOPERPORTAL_USERNAME = "keboola-test+odin_action_test",
    KBC_DEVELOPERPORTAL_PASSWORD = "SNAwULmpdQ_Dye2AnHzofLQJZ2tABgkNGphWbknC9Z5TItpZNSOaVRK+xOwIZNN6",
    APP_IMAGE = "my-image",
    REPOSITORY_TAG = "U.N.Owen"    
  } 
  needs = ["Deploy Production Image Filter"]
}

action "Deploy KBC Filter" {
  uses = "actions/bin/filter@master"
  args = "tag v?[0-9]+\\.[0-9]+\\.[0-9]+"
  needs = ["Build"]
}

action "Deploy KBC" {  
  uses = "docker://alpine"
  args = "printenv"
  env = {
    KBC_DEVELOPERPORTAL_APP = "keboola-test.app-acme-anvil-service",
    KBC_DEVELOPERPORTAL_VENDOR = "keboola-test",
    KBC_DEVELOPERPORTAL_USERNAME = "keboola-test+odin_action_test",
    KBC_DEVELOPERPORTAL_PASSWORD = "SNAwULmpdQ_Dye2AnHzofLQJZ2tABgkNGphWbknC9Z5TItpZNSOaVRK+xOwIZNN6",
    APP_IMAGE = "my-image",
    REPOSITORY_TAG = "U.N.Owen"
  }
  needs = ["Deploy KBC"]
}

action "test1" {
  uses = "./"
  args = "ls -la"
}

action "test2" {
  uses = "docker://alpine"
  runs = "ls"
  args = "-la"
}

action "test3" {
  uses = "actions/docker/cli@76ff57a"
  args = "build -t my-image ."
}

action "test4" {
  uses = "actions/docker/cli@76ff57a"
  args = "show images"
  needs = ["test3"]
}

action "run tests" {
  uses = "./"
  args = "sh -c 'yarn && yarn test'"
}

action "Docker Tag" {
  uses = "actions/docker/tag@76ff57a"
  env = {
    envvar = "somevaliue"
  }
}

action "GitHub Action for AWS" {
  uses = "actions/aws/cli@8d31870"
  needs = ["Docker Tag"]
}

action "dev" {
  uses = "actions/docker/cli@76ff57a"
  secrets = ["secret"]
  args = "pull abc"
}
