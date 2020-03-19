# CloudFormation With Sceptre Deploy Action


## Usage
```yaml
name: "Deploy CloudFormation Stacks with Sceptre"
on: 
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: world-mastery/sceptre-deploy-action@v0.0.1
      with:
        aws_access_key_id: ${{secrets.AWS_ACCESS_KEY_ID}}
        aws_secret_access_key: ${{secrets.AWS_SECRET_ACCESS_KEY}}
        aws_region: 'us-east-1'
        sceptre_base_directory: my-path/cloudformation/
        sceptre_path: pre
      env:
        VARS_DESIRED_COUNT: '1'
        VARS_FOO: bar
```

## Environment variables
Anything prefixed with `VARS_` will be processed (prefix will be removed and full string will be converted to lower case) and used in sceptre as variables.


**Be careful because values will be converted to lower case as well** (this will be fixed in next versions)


If we take the previous example, action will run:
```bash
sceptre --var foo="bar" --var "desired_count='1'" launch -y pre
```
inside `my-path/cloudformation` in our repository.
