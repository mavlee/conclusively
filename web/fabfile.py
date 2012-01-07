from fabric.api import cd, run, env, sudo
from fabric.context_managers import settings
from fabric.context_managers import prefix

env.hosts = ['ubuntu@ec2-107-21-64-22.compute-1.amazonaws.com']

code_dir = '/opt/conclusively'
log_dir = '%s/log' % code_dir

def compile_js():
    with cd(code_dir):
        run('make compile')

def deploy():
    with cd(code_dir):
        run('git checkout .')
        with settings(warn_only=True):
            update = run('git pull')
        if update.failed:
            run('git checkout .')
        with prefix("source $HOME/.nvm/nvm.sh"):
            run('npm install')
            #compile_js()

        sudo('make upstart_prod')
        sudo('stop conclusively || true')
        sudo('start conclusively')
