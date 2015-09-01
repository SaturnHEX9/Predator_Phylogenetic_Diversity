# Building on Ubuntu Linux

The output document in this project, predatordiversity.pdf, is built 
using the R computer language and numerous dependencies. These 
instructions describe how to setup and build the document on 
Ubuntu Linux version 14.04 or 15.04.

First, make sure you have some build tools. Copy/paste each line to a terminal:

    sudo apt-get update
    sudo apt-get install build-essential libxml2-dev libssl-dev
    sudo apt-get install libcurl4-openssl-dev libssh2-1-dev
    sudo apt-get install libgit2-dev libicu-dev
    sudo apt-get install texlive-xetex texlive-humanities

On Ubuntu 15.04 you can now install R and Pandoc like so:

    sudo apt-get install r-base r-base-dev pandoc pandoc-citeproc

For Ubuntu 14.04, you will have to install R and pandoc manually, per
instructions below. 

After you install R and Pandoc, skip down to the section "Getting 
dependencies inside of R".

### Ubuntu 14.04 

On Ubuntu 14.04 both Pandoc and R are too old to work (R devtools bitrot). 
You need to purge the existing R and Pandoc packages and install them 
yourself. First, purge old packages.

    sudo apt-get purge r-base r-base-dev pandoc

#### Ubuntu 14.04 Pandoc 

    sudo apt-get install haskell-platform
    cabal update
    cabal install pandoc
    cabal install pandoc pandoc-citeproc

This will take a long time as the system downloads and compiles the files. 
The pandoc program will be under $HOME/.cabal/bin so add it to your PATH

    export PATH=$HOME/.cabal/bin:$PATH

Copy/paste the above command to the end of your $HOME/.bashrc to make it 
permanent every time you login from here forward.

    gedit $HOME/.bashrc

Save and quit. Note that if you ever upgrade ubuntu 14 to ubuntu 15, you 
will probably want to remove this line from .bashrc and remove the 
$HOME/.cabal directory.

#### Ubuntu 14 R 

Next, get R from the rstudio.com repository. Edit your 
/etc/apt/sources.list file as root

    sudo gedit /etc/apt/sources.list

Add the following line to the end of the sources.list file (no leading spaces):

    deb http://cran.rstudio.com/bin/linux/ubuntu trusty/

Save and exit. Now update your Gnu Privacy Guard (GPG) keys

    gpg --keyserver pgpkeys.mit.edu --recv-key 51716619E084DAB9
    gpg -a --export 51716619E084DAB9 | sudo apt-key add -

Update your apt package system with the new rstudio.com entries like so:

    sudo apt-get update

Now install R from rstudio.com:

    sudo apt-get install r-base r-base-dev

This should install R from rstudio.com and dependency packages from
the standard locations. 

## Getting dependenices inside of R 

Several R tools are required. They can be installed from within R 
itself. Start R as root

    sudo R

Now copy/paste each of these R commands to the R terminal. This will 
install dependencies. It may ask you to choose a mirror site for 
downloading. Choose one close to you. Each command may take several
minutes as it downloads and compiles files. On success it should say "DONE".

    install.packages("devtools")
    install.packages(c("R6", "yaml", "digest", "crayon", "optparse"))
    install.packages(c("dplyr", "magrittr", "lubridate", "tidyr", "ggplot2"))
    install.packages(c("pryr", "rmarkdown", "readr", "gridExtra"))
    install.packages(c("reshape2", "picante", "stargazer", "pander", "xtable"))
    devtools::install_github("richfitz/storr")
    devtools::install_github("richfitz/remake")

You should now be ready to build the project.

## Building the project 

First, fetch the source code (if you don't already have it)

    git clone https://github.com/aammd/Predator_Phylogenetic_Diversity

Switch to the base directory

    cd Predator_Phylogenetic_Diversity

Now start R and build the project using 'remake' (you do not need to be root)
    
    R

    > remake::make()

After a few minutes the machine should create a file named 
predatordiversity.pdf under the MS directory. The pdf file should be
openable in any PDF reader or in the Ubuntu file browser.

## See Also

Tool homes:

*https://github.com/richfitz/storr
*https://github.com/richfitz/remake
*http://pandoc.org/installing.html

Troubleshooting:

*http://stackoverflow.com/questions/30794035/install-packagesdevtools-on-r-3-0-2-fails-in-ubuntu-14-04
*http://ubuntuforums.org/archive/index.php/t-2154184.html
*http://r.789695.n4.nabble.com/Problem-with-gridExtra-td4711572.html

