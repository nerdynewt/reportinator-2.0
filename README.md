# reportinator-2.0

Makes your lab reports for you.

*NOTE: In development. Prepare for dissapointments*

## Installation

Clone the repo:

```bash
git clone "https://github.com/nerdynewt/reportinator-2.0.git"
```

Make a root folder for all your LaTeX projects:

```
mkdir ~/Documents/Lab\ Reports/
```

Configure Reportinator:

```bash
cd reportinator-2.0
./main.sh
```

This will run the configuration script. 

## Usage

- Set up a root folder: This is the folder where you'll be keeping all your LaTeX projects. ex. `$ mkdir ~/Documents/Lab\ Reports`

- Make a folder inside the root folder (ex `$ mkdir ~/Documents/Lab\ Reports/Fabry-Perot`), and place one or more of the following files inside:

  - A template file: this is your `.tex` file with ~placeholders~ in place of tables, graphs etc. See below for a list of supported placeholders. ex:

  - ```
    $ cat ~/Documents/Lab Reports/Fabry-Perot/template.tex
    ...
    \section{Observations}
    ~tables~
    \section{Graphs and Calculations}
    ~graphs~
    ...
    ```

  - Table data as `.csv` files which need to be drawn as tables or plotted as graphs. 

  - ```
    $ ls ~"/Documents/Lab Reports/Fabry-Perot/"
    table1.csv
    table2.csv
    table3.csv
    template.tex
    ```

  - Call `main.sh`: `$ ./path/to/reportinator-2.0/main.sh`

  - You will be asked to choose a Folder/Project. In this case, we will be choosing `Fabry-Perot`.

  - If everything goes well, you will be greeted with your final `.tex` file in your favourite editor.

  ## Default Modules

  Modules replace certain lines in your `template.tex` file with LaTeX code.  A module is triggered by a `~<module_name>-<arguments>~` line in your template `.tex` file. For example, keeping a `~tables~` line in your `template.tex` will replace that line with LaTeX tables created from your `.csv` files. The following modules come by default:

  ### `tables`

  Draws tables for you. This module is triggered whenever Reportinator encounters a `~tables-<arguments>~` line in your `template.tex` file.

  The following arguments are supported:

  - Filename: `~tables-table1.csv,table2.csv~` draws only `table1.csv` and `table2.csv` 
  - Default: if passed without arguments, i.e., as `~tables~`,  `tables.py` draws all `.csv` files in your project folder. 

  ### `graphs`

  Draws graphs from  `.csv` files using `pyplot`, when a `~graphs~` line is encountered. Arguments should be written in the **last row** of `.csv` files that need to be plotted. The following arguments are supported.

  - `graph(xcloumn;ycolumn)`: Specifies the x-axis and y-axis columns to be plotted. Column numbers start from zero. Multiple y values are supported
  - `line-fit`: Performs linear fit, and also gives the line equation and $R^2$ value to the graph
  - `curve-fit`: Performs curve fitting
  - `error-calc`: Calculates error in the slope and such. Mandatory if you are going to use the `error` module below.
  - `title(<title)`: Specify the title of the graph

  An example last row of a valid `.csv` file is shown:

  ```
  graph(0;2), title(Calibration), line-fit, error-calc
  ```

  ### `errors`

  Does error analysis.

  

  ## Creating More Modules

  If you know what you're doing, you can create more modules for Reportinator. **Each module is just a python script kept in the `modules/` directory that spits out some LaTeX code to `stdout`.** When the module name is encountered in the `template.tex` file, the module will be called. 

  For example, if you make a `new_module.py` and keep it in `modules/`, every time there is a `~new_module-<argument>~` line in the input `template.tex` file, `new_module.py` will be called with the arguments `<argument>`. The output from `new_module.py` will replace the `~new_module-<argument>~` line in the final document.

  

  
