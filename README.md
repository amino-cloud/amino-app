# Amino web interface - ALPHA VERSION #

This project is a Rails application for interacting with the Amino service.  It is currently in Alpha status as the basic
wireframe is in place, but many functions are not hooked up to the backend services.  Presently, one can only create a
Hypothesis, run it, and modify if need be.  Also note that the amino features were computed with a flawed version of
perfect squares, so that feature will return incorrect results.

### Why Rails? ###

Quickest & easiest way to a shiny new app.  Using JRuby for performance and compatibility with Java artifacts.

### set up ###

1. See "Setup dev vm" (for development)
2. download and install JRuby >= 1.7.13
3. git clone
4. jruby -S gem install bundler
5. jruby -S bundler install
6. mvn package
7. ./generate_dev_secrets_yml.sh
8. vagrant up 
9. jruby -S rails s

By default (config/environments/development.rb), the app is configured to hit the zookeeper at `amino-vm`.  You'll probably want to add the following to your `/etc/hosts` file

    192.168.33.15	amino-vm

If you get the following error

    OpenSSL::Cipher::CipherError: Illegal key size: possibly you need to install Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files for your JRE

then you need to install the JCE. The JCE for Java 7 can be found at http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html .  This should be installed to `${java.home}/jre/lib/security/`

An example directory for a Mac running Java 7 might be: 

    /Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home/jre/lib/security/

And on Ubuntu 14.04 LTS

    /usr/lib/jvm/java-7-oracle/jre/lib/security/

### Test users ###
There are a couple of users already set up for testing.  Try testuser1:password

### supported backends ###

* Amino native services
* Amino Thrift service

### targeted browsers (up for debate) ###

* Firefox >= 17
* Chrome >= 35
* IE >= 8

to do:
  - additional security services
  - thrift interface implementation
  - UI
  - REST endpoints

### Setup dev vm ###

- download and install vagrant (for development)
  - https://www.vagrantup.com/
- install vagrant cachier plugin
  - `vagrant plugin install vagrant-cachier`
- Add this to your `~/.vagrant.d/VagrantFile`
  - https://gist.github.com/jdstapleton/a3012be27650b1368f2c
  - http://jasdeep.ca/2013/10/installing-nokogiri-fails-os-x-mavericks/
  - key line here is enabling the cache, and then the generic www cache
- execute from the cloned directory: `vagrant up`

### Key features of the Dev VM ###
- Start all services:
  - Run: $ `aminovm-start-all.sh`
- zookeeper
  - To Start: $ `sudo aminovm-start-zookeeper.sh`
- Hadoop
  - To Start: $ `sudo aminovm-start-hadoop.sh`
- accumulo
  - To Start: $ `sudo aminovm-start-accumulo.sh`
  - Current bug: if you laptop goes to sleep while the vm is running it seems that accumulo dies.  You can run this command to restart it.
- amino-service
  - To Start: $ `sudo aminovm-start-amino-service.sh`
  - Logs: 
    - /tmp/amino.out
    - /tmp/amino/amino_amino.log
    - /tmp/amino/amino_amino.AUDIT_LOGS/*