1) Install Virtualbox
   - Go to the [VirtualBox download site](https://www.virtualbox.org/wiki/Downloads)
   - Choose your platform and download installer
   - Run installer - click, click, next ...
2) Check if VirtualBox is on your path:<br />
   - In command line type: `vboxmanage -v`
   - If you see something, ( like this: `5.2.42_Ubuntur137960` or `6.1.18r142142`) you are good to go
   - If not, add installation folder to path as explaned [here](https://stackoverflow.com/questions/44272416/how-to-add-a-folder-to-path-environment-variable-in-windows-10-with-screensho).
3) Download virtual machine <br />
   - Go to the [Download site](https://github.com/MaGaMeGa/helloVM)
   - Pick a download link
   - Download the virtual machine
4) Import virtual machine <br />
  In command line type: `vboxmanage import HELLO_AH_WORLD.ova`
5) Start virtual machine <br />
  In command line type: `vboxmanage stratvm HELLO_AH_WORLD`
6) Start using virtual machine <br />
    In the pop up terminal 
    - login : `root`
    - password : default arrowhead password as [in](https://github.com/eclipse-arrowhead/core-java-spring#certificates)
