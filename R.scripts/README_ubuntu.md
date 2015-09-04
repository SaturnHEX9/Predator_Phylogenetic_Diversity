# Building on Ubuntu Linux

The output document in this project, predatordiversity.pdf, is built 
using the R computer language and numerous dependencies. These 
instructions describe how to setup and build the document on Ubuntu 
Linux operating system version 14.04 or 15.04.

You should be comfortable with basic system adminitration concepts and 
tasks. You will need sudo/root access, several gigabytes of free diskspace 
and preferably at least 2 Gigabytes of RAM.

First, make sure you have some build tools. Copy/paste each line to a terminal:

    sudo apt-get update
    sudo apt-get install build-essential libxml2-dev libssl-dev
    sudo apt-get install libcurl4-openssl-dev libssh2-1-dev
    sudo apt-get install libgit2-dev
    sudo apt-get install texlive-xetex texlive-latex-extra
    sudo apt-get install texlive-humanities texlive-fonts-recommended

### Installing Pandoc 

You will need to install a very new version of pandoc to avoid build errors.
First, make sure your system pandoc is purged

    sudo apt-get purge pandoc pandoc-data pandoc-citeproc

Now install pandoc from the haskell Cabal repository.

    sudo apt-get install haskell-platform
    cabal update
    cabal install pandoc
    cabal install pandoc-citeproc

This will take a long time as the system downloads and compiles the files. 
It will build, by default, under $HOME/.cabal/bin so add this directory
to your PATH

    export PATH=$HOME/.cabal/bin:$PATH

Copy/paste the above command to the end of your $HOME/.bashrc to make it 
permanent every time you login from here forward.

    gedit $HOME/.bashrc   # (gedit, or your editor of choice)

Save and quit. cat $HOME/.bashrc to verify the last line has the export PATH
command. Logout and log back in, then type

    echo $PATH

to verify that $HOME/.cabal/bin is the first entry.

Now go to the section below corresponding to your verison of Ubuntu. You 
can find out which version you have by entering the following command 
into a terminal:

    cat /etc/issue

### Ubuntu 15.04 R language

On Ubuntu 15.04 you can install R like so:

    sudo apt-get install r-base r-base-dev

Then skip down to the section "Getting dependencies inside of R".

### Ubuntu 14.04 

On Ubuntu 14.04 first get rid of the system version of R, it is too old 
and will generate build errors.

    sudo apt-get purge r-base r-base-dev

Then update your Gnu Privacy Guard (GPG) keys to prepare for rstudio.com

    gpg --keyserver pgpkeys.mit.edu --recv-key 51716619E084DAB9
    gpg -a --export 51716619E084DAB9 | sudo apt-key add -

Next, edit your /etc/apt/sources.list file as root

    sudo gedit /etc/apt/sources.list

Add the following line to the end of the sources.list file, and remove any
leading spaces from the line.

    deb http://cran.rstudio.com/bin/linux/ubuntu trusty/

Save and exit. Update your apt package system to reflect the above changes.

    sudo apt-get update

Now install R:

    sudo apt-get install r-base r-base-dev

This should install an up-to-date version of R from rstudio.com and 
dependency packages from the standard locations.

You should now be ready for the section below, "Getting dependencies 
inside of R".

## Getting dependenices inside of R 

Several R tools are required. They can be installed from within R 
itself. Start R

    R

Now copy/paste each of the following R commands to the R terminal. Pick 
'yes' for local install. It may ask you to choose a mirror site for 
downloading. Choose one close to you. Each command may take several 
minutes as it downloads and compiles files. On each success it should 
say "DONE".

    install.packages("devtools")
    install.packages(c("R6", "yaml", "digest", "crayon", "optparse"))
    install.packages(c("dplyr", "magrittr", "lubridate", "tidyr", "ggplot2"))
    install.packages(c("pryr", "rmarkdown", "readr", "gridExtra"))
    install.packages(c("reshape2", "picante", "stargazer", "pander", "xtable"))
    devtools::install_github("richfitz/storr")
    devtools::install_github("richfitz/remake")

After completion your system should now be ready to build the project 
document.

## Building the project document

First, fetch the source code (if you don't already have it)

    git clone https://github.com/aammd/Predator_Phylogenetic_Diversity

Switch to the base directory

    cd Predator_Phylogenetic_Diversity

Now start R and build the project using 'remake'
    
    R

    > remake::make()

After a few minutes the machine should create a file named 
predatordiversity.pdf under the MS directory. The pdf file should be
openable in any PDF reader or in the Ubuntu file browser.

## See Also

Tool homes:

* https://github.com/richfitz/storr
* https://github.com/richfitz/remake
* http://pandoc.org/installing.html
* https://cran.rstudio.com/bin/linux/ubuntu/README.html

Troubleshooting:

* http://stackoverflow.com/questions/30794035/install-packagesdevtools-on-r-3-0-2-fails-in-ubuntu-14-04
* http://ubuntuforums.org/archive/index.php/t-2154184.html
* http://r.789695.n4.nabble.com/Problem-with-gridExtra-td4711572.html

