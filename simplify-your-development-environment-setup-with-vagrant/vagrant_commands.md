`vagrant init`: Creates a new Vagrantfile in the current directory, which serves as a configuration file for your virtual environment.

`vagrant up`: Launches and provisions the virtual environment defined by the Vagrantfile. If the environment is already running, it simply connects to it.

`vagrant halt`: Stops the running virtual machine, suspending it in its current state. Use vagrant up to start it again.

`vagrant suspend`: Suspends the virtual machine's state, saving it to disk and allowing you to resume from where you left off with vagrant resume.

`vagrant resume`: Resumes a suspended virtual machine, bringing it back to its previous state.

`vagrant reload`: Restarts the virtual machine, reloading the Vagrantfile configuration. Useful when you've made changes to the Vagrantfile.

`vagrant ssh`: Connects to the virtual machine via SSH, allowing you to interact with it through a command-line interface.

`vagrant status`: Shows the current status of the virtual machine, indicating whether it's running, suspended, halted, etc.

`vagrant destroy`: Stops and deletes all traces of the virtual machine, freeing up disk space.

`vagrant box list`: Lists all the available base boxes (base images) that can be used to create virtual machines.

`vagrant box add`: Adds a new box to your local collection of boxes, enabling you to use it to create virtual machines.

`vagrant box remove`: Removes a box from your local collection of boxes, freeing up disk space.
