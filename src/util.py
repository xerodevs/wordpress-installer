# encoding=utf8
import subprocess
import socket

# Set of colors in order to check status in the terminal
reset = '\x1b[0m'    # reset all colors to white on black
bold = '\x1b[1m'     # enable bold text
uline = '\x1b[4m'    # enable underlined text
nobold = '\x1b[22m'  # disable bold text
nouline = '\x1b[24m'  # disable underlined text
red = '\x1b[31m'     # red text
green = '\x1b[32m'   # green text
blue = '\x1b[34m'    # blue text
cyan = '\x1b[36m'    # cyan text
white = '\x1b[37m'   # white text (use reset unless it's only temporary)
yellow = '\x1b[33m'
# Nomenclaturas :
# err : Mensaje que genera algun tipo de error
# ok : Mensaje que genera una operacion correcta
# warning : Mensaje que genera una operacion de atencion
# info : Mensaje que presenta una operacion de informacion
# atn : Mensaje puesto para establecer ingreso e datos

err = '{}{}[✘✘✘]{} '.format(bold, red, reset)
ok = '{}{}[✓]{} '.format(bold, green, reset)
warning = '{}{}[~]{} '.format(bold, yellow, reset)
info = '{}{}[!]{} '.format(bold, cyan, reset)
atn = '{}{}[DEBUG]{} '.format(bold, yellow, reset)


version__ = '{}0.1v{}'.format(cyan, reset)
authors = '{}{}Coded by Héctor F. Jimenez S'.format(bold, red, reset)
emails = '{}hfjimenez@utp.edu.co{}'.format(white, reset)
topic = '{}{}\n\tDistributed Systems 2018-2{}'.format(
    uline, white, reset)


def cleanscreen():
    subprocess.call(['clear'], shell=False)

def banner():
    return("""{}
    ------------------------------------
    __      ___ __  _ __ ___  ___ ___
    \ \ /\ / / '_ \| '__/ _ \   / __/ 
     \ V  V /| |_) | | |  __/\__ \__\\
      \_/\_/ | .__/|_|  \___||___/___/
             |_|   {}{}XeroGroup.co
         h3ct0rjs@xerogroup.co
    ------------------------------------{}     
    """.format(yellow,bold,white,reset))

def banner(text=banner()):
    print(text)

def internet_connection(host="8.8.8.8", port=53, timeout=2): 
    """ 
    Taken from : https://stackoverflow.com/questions/3764291/checking-network-connection
    Host: 8.8.8.8 (google-public-dns-a.google.com) 
    OpenPort: 53/tcp 
    Service: domain (DNS/TCP) 
    """ 
    try: 
      socket.setdefaulttimeout(timeout) 
      socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect((host, port)) 
      return True 
    except Exception as ex: 
      print(ex.message) 
      return False
