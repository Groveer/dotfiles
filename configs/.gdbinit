python
import os,sys
sys.path.insert(0, os.environ['HOME'] + "/.gdb/")
from qt import register_qt_printers

register_qt_printers (None)
end

set print pretty on
