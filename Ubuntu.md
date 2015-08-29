= Building on Ubuntu Linux =

The documents in this project are built using the R computer language. 
These instructions describe how to do this on Ubuntu Linux.

First, make sure you have some build tools. Copy/paste this to a terminal:

    sudo apt-get update
    sudo apt-get install build-essential libxml2-dev libssl-dev

On Ubuntu >15.04 you can now get R and Pandoc like so:

    apt-get install r-base r-base-dev pandoc

For older Ubuntu, read on. After you install R and Pandoc, skip down to
the section "Getting dependencies inside of R".

=== Ubuntu 14.04 ===

On Ubuntu 14.04 both Pandoc and R are too old to work (devtools bitrot). 
You need to purge the existing R and Pandoc packages and install them 
yourself. First, purge old packages.

    sudo apt-get purge r-base r-base-dev pandoc

==== Ubuntu 14 Pandoc ====

    sudo apt-get install haskell-platform
    cabal update
    cabal install pandoc
    cabal install pandoc pandoc-citeproc

This will take a while as the system downloads and compiles the files. 
The pandoc program will be under $HOME/.cabal/bin so add it to your PATH

    export PATH=$HOME/.cabal/bin:$PATH

Add the above command to the end of your $HOME/.bashrc to make it permanent
every time you log in from here forward. 

    gedit $HOME/.bashrc

Save and quit.

==== Ubuntu 14 R ====

Next, get R from the rstudio.com repository. Edit your 
/etc/apt/sources.list file as root

    sudo gedit /etc/apt/sources.list

Add the following line to the end of the sources.list file:

    deb http://cran.rstudio.com/bin/linux/ubuntu trusty

Save and exit. Now update your Gnu Privacy Guard (GPG) keys

    gpg --keyserver pgpkeys.mit.edu --recv-key 51716619E084DAB9
    gpg -a --export 51716619E084DAB9 | sudo apt-key add -

Update your apt package system with the new rstudio.com entries

    sudo apt-get update

Now install R from rstudio.com:

    sudo apt-get install r-base r-base-dev

The "get" stages of apt-get should show the computer connecting to rstudio.com
and downloading the packages.

== Getting dependenices inside of R ==

Several R tools are required. They can be installed from within R 
itself. Start R as root

    sudo R

Now copy/paste these R commands to install dependencies. It may ask you 
to choose a mirror site for downloading. Choose one close to you. On success
it should say "DONE".

    install.packages("devtools")
    install.packages("R6", "yaml", "digest", "crayon", "optparse")
    install.packages("dplyr", "magrittr", "lubridate", "tidyr", "ggplot2")
    install.packages("pryr", "rmarkdown", "readr", "gridExtra")
    install.packages("reshape2", "picante", "stargazer", "pander", "xtable")
    devtools::install_github("richfitz/storr")
    devtools::install_github("richfitz/remake")

You should now be ready to build the project.

== Building the project ==

First, fetch the source code

    git clone https://github.com/aammd/Predator_Phylogenetic_Diversity

Switch to the base directory

    cd Predator_Phylogenetic_Diversity

Now start R and build the project using 'remake' (you do not need to be root)
    
    R

    > remake::make()



=== See Also ===

Tool homes:

*https://github.com/richfitz/storr
*https://github.com/richfitz/remake
*http://pandoc.org/installing.html

Troubleshooting:

*http://stackoverflow.com/questions/30794035/install-packagesdevtools-on-r-3-0-2-fails-in-ubuntu-14-04
*http://ubuntuforums.org/archive/index.php/t-2154184.html
*http://r.789695.n4.nabble.com/Problem-with-gridExtra-td4711572.html

