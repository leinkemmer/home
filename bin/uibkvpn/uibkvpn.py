#!/usr/bin/env python2
import os
import sys
import re
import subprocess
import time

import pygtk
import gtk
import gobject
pygtk.require('2.0')
gtk.gdk.threads_init()

class VPN(object):
    DEFAULT_INTERVAL = 5000
    tick_interval = DEFAULT_INTERVAL
    state = False
    
    def update_icon(self):
        """ Initially set self.icon and then update with the
            icon for the current state
        """
        fn = "connected.png" if self.state==True else "disconnected.png" 
        path = os.path.join(self.location, fn)
        assert os.path.exists(path), 'File not found: %s' % path
        if hasattr(self, 'icon'):
            self.icon.set_from_file(path)
        else:
            self.icon = gtk.status_icon_new_from_file(path)

    def __init__(self):
        self.location = os.path.dirname(os.path.realpath(__file__))
        self.update_icon()
        self.update()
        self.icon.connect('activate', self.icon_click)
        self.icon.set_tooltip("Checking...")
        self.icon.set_visible(True)
        self.tick_interval = self.DEFAULT_INTERVAL #number of ms between each poll
        self.state = False

    def icon_click(self, gtk_object):
        """
        Handle a click
        """
        pass

    def update(self):
        """
        This method is called everytime a tick interval occurs
        """
        if os.system("route | grep '138.232.7.0'")==0:
            self.state = True   # VPN connected
            print('VPN connected')
        else:
            self.state = False
            print('VPN not connected')
        self.icon.set_tooltip(time.strftime("%H:%M:%S"))
        self.update_icon()
        gobject.timeout_add(self.tick_interval, self.update)

    def main(self):
        """
        All PyGTK applications must have a gtk.main(). Control ends here
        and waits for an event to occur (like a key press or mouse event).
        """
      #  gobject.timeout_add(self.tick_interval, self.update)
        gtk.main()

if __name__ == "__main__":
    app = VPN()
    app.main()
