## HELLO_AH_WORLD INSTALLATION STEPS ... in progress version
1) Install Virtualbox <br/>
  - Choose your platform and download the installer.
      - [Windows](https://download.virtualbox.org/virtualbox/6.1.18/VirtualBox-6.1.18-142142-Win.exe)
      - [OS X](https://download.virtualbox.org/virtualbox/6.1.18/VirtualBox-6.1.18-142142-OSX.dmg)
      - [Linux](https://www.virtualbox.org/wiki/Linux_Downloads)
      - [FreeBSD](https://docs.freebsd.org/en_US.ISO8859-1/books/handbook/virtualization-host-virtualbox.html)
  - Or go to the [VirtualBox download site](https://www.virtualbox.org/wiki/Downloads) for adittional platform options
  - Run installer - click, click, next ... <br />
---
2) Download virtual machine <br />
  - Go to the [Download site](https://github.com/MaGaMeGa/helloVM)
  - Pick a download link
  - Download the virtual machine <br />
---
3) Import virtual machine <br />
  - In the folder where you downloaded the HELLO_AH_WORLD.ova open a command line/terminal.
  - In command line/terminal type: `vboxmanage import HELLO_AH_WORLD.ova` <br />
---
4) Start virtual machine <br />
  In command line type: `vboxmanage startvm HELLO_AH_WORLD` <br />
---
5) Start using virtual machine <br />
    In the pop up terminal 
   - login : `root`
   - password : default arrowhead password as [in](https://github.com/eclipse-arrowhead/core-java-spring#certificates) <br />
---

### Optional steps <br />
 After each download, check download checksum. [HOW TO CHECK CHECKSUM](https://duckduckgo.com/?t=canonical&q=verifiy+download+checksum&ia=web) <br />
 checksum verification script support / in progress... <br />

---

### Troubleshooting
- issue : *vboxmanage not found*<br />
  solution : add the VirtualBox installation folder to the systems path environment variable as explained [here](https://stackoverflow.com/questions/44272416/how-to-add-a-folder-to-path-environment-variable-in-windows-10-with-screensho). <br />
  

