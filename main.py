#!/usr/bin/env python3
# h3ct0rjs@xerogroup.co 
import argparse
import os
import urllib.request
import tarfile 

from src.util import *

class WordpressInstaller(object):
    """ Worpress Class

        This is the full functionality of the installer. 
    """
    def __init__(self,**kwargs):
        self.workingdir = ''
        pass

    def download(self,location='/tmp'):

        if location != '/tmp':
            self.workingdir = location
        else:
            self.workingdir = '/tmp'
            urllib.request.urlretrieve('https://wordpress.org/latest.tar.gz',self.location+'/installer.tar.gz')
            tf = tarfile.open(self.location+'/installer.tar.gz') 
            tf.extractall() 


    def db_ops(self):
        if db_connection():
            ...
        else: 
            print('{}is your Mysql server up?, check your enviroment options. '.format(info))
            print('{}exiting...'.format())
    
    def dir_creation(self):
        pass 

    def nginx_config(self):
        pass 
    
    def run(self):
        pass
    

def main():
    cleanscreen()
    banner()
    try : 
        DB_ADMIN = os.environ['DB_USER'],
        DB_PASSWORD = os.environ['DB_PASS']

    except KeyError as e : 

        print('{} set your enviroment vars:  DB_USER, DB_PASS'.format(err))
        print('{} {}'.format(atn,e))   # Debug
        quit()

    if os.getuid() != 0 : 
        print('{}This script must be run with root permissions or sudo in order to create the proper nginx and folder files'.format(err))  
        quit()

    if not internet_connection():
        print('{}We need internet, please check your internet connection'.format(err))  
        quit()
    

    parser = argparse.ArgumentParser(description="""
        A wordpress installer for Debian based distros. This script must be run with root.
        You should set a couple of enviroment vars in order to connect to the mysql database.
        This could be achieved in your shell enviroment running:
         export DB_USER='mysql' && export DB_PASS='password' 
    """)
    parser._action_groups.pop()
    required = parser.add_argument_group('required arguments')
    required.add_argument("--folderproject", help="Location of the wordpress installation")
    required.add_argument("--domain", help="What is the domain name of the site e.g blog.xerogroup.co")

    optional = parser.add_argument_group('optional arguments')
    optional.add_argument("--verbose", help="increase output verbosity",action="store_true")
    optional.add_argument("--nocolor", help="Disable colors, colors are enabled by default",action="store_true")
    optional.add_argument("--database_name",help="Set database name for database creation, by default the domain_db")
    optional.add_argument("--database_password",help="Set database name for database creation, by default a random password")
    args = parser.parse_args()

    print('{}{}'.format(atn,args.folderproject))  # Debug
    print('{}{}'.format(atn,args.domain))         # Debug
    print('{}{}'.format(atn,args.verbose))        # Debug
    print('{}{}'.format(atn,args.colors))         # Debug

if __name__ == '__main__':
    main()