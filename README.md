# ExtDN Interoperability Testing
This repository contains files and scripts, so that ExtDN members can share their extensions with other other members.

## Setup your own private repository
Create a new git repository and make sure it is only readable to you and a few others (because
we are going to exchange private details with it). For instance, this could be a private
repository on GitHub or BitBucket:

    mkdir extdn-helloworld/
    cd extdn-helloworld/
    git init

Add a file `scripts/helloworld.sh` (where `helloworld` is your company name) with the following contents:

     composer config repositories.helloworld composer https://your-url-to-your-package
     composer require your/extension
     bin/magento module:enable Your_Extension

Then add it to git:

    git add scripts/helloworld.sh
    git remote add origin git@github.com:helloworld/extdn-helloworld.git
    git push -u origin master

Add a remote back to this generic ExtDN project:

    git remote add upstream git@github.com:extdn/extdn-interoperability-testing.git
    git pull upstream master

Now, on top of your local file `scripts/helloworld.sh`, you should see a copy of all of the
original ExtDN files. 

Optionally, add your own line to `dev/tests/integration/phpunit-extdn.xml`.

## Add upstreams from other ExtDN members
Now, add upstreams from other members as well. As an example, the following adds in a dummy:

    git remote add jisse git@github.com:jissereitsma/extdn-interoperability-testing-jisse.git
    git pull jisse master

This should create a file `scripts/jisse.sh`. Now, if you want, you can commit this file as
well into your own repository:

    git add scripts/jisse.sh
    git push -u origin master

Following this procedure, you can manually add multiple sources and commit them locally in your own private repository:

    git pull origin master
    git pull upstream master
    git pull jisse master
    git add scripts/
    git commit -m 'Update' .

Please note that this procedure is meant to share sensitive details (API keys) between ExtDN
members. Make sure at all times that your own repository is private and the API keys are only
visible to you.

## Setup your Integration Testing environment
Start with a fresh Magento installation. Next, follow the procedure of setting up Integration Testing:

- Empty testing database
- Modify details of `dev/tests/integration/etc/install-config-mysql.php`
- Perhaps create a simple testsuite to double-check that the basics are working

Copy the `dev/tests/integration/phpunit-extdn.xml` file of this repository to Magento

## Add your own private repo to your Integration Testing environment
Add your own private repository to the Magento environment. Do not add the generic ExtDN repository, because it is supposed to be an empty shell. If your repository would be hosted on GitHub, this could be similar to the following:

    composer config repositories.extdn-helloworld vcs git@github.com:helloworld/extdn-helloworld.git

If this is a local folder instead, you could use this:

    composer config repositories.extdn-helloworld path /path/to/extdn-helloworld

Next, install the actual package:

    composer require extdn/extdn-interoperability-testing:@dev

Remember that this should not install the generic package, but your own copy of it. Afterwards, confirm that the folder `vendor/extdn/extdn-interoperability-testing` contains a `scripts/` folder with various commands.

## Run the actual tests
Run the actual command:
```bash
cd dev/tests/integration
../../../vendor/bin/phpunit -c phpunit-extdn.xml --testsuite ExtDN
```

# End
