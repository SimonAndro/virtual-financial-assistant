#!e:\ampps\python-virtual-environments\biweeklybudget\scripts\python.exe
# EASY-INSTALL-ENTRY-SCRIPT: 'captain==4.1.1','console_scripts','captain'
__requires__ = 'captain==4.1.1'
import re
import sys
from pkg_resources import load_entry_point

if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(
        load_entry_point('captain==4.1.1', 'console_scripts', 'captain')()
    )
