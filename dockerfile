# Based on rocker - https://github.com/rocker-org/rocker-versioned
FROM rocker/tidyverse:4.2.1

MAINTAINER SBaaklini (sbaaklini@ciml.univ-mrs.fr)




# ##################
# OTHER DEPENDENCIES
# ##################

#### Python
# pip
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglpk-dev \
    tcl8.6-dev \
    tk8.6-dev \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libomp-dev \
    libboost-dev \
    libboost-all-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    python3-pip \
    libudunits2-dev \
    imagemagick \
    libbz2-dev \
    libclang-dev \ 
    libmagick++-dev \  
    && pip3 install --upgrade --user pip

# Umap processing library (python)
RUN pip3 install llvmlite==0.31.0
RUN python3 -m pip install 'umap-learn==0.4.5'

# igraph and graph based clustering alorithm

# #########################################################################################
# SET PERMISSIVE RIGHTS TO HOME FOLDER FOR RETICULATE IN SINGULARITY (SEARCH FOR MINICONDA)
# #########################################################################################

RUN chmod -R 777 /home

# ##########
# R PACKAGES
# ##########


#### Figures & layout management
RUN Rscript -e 'library(devtools);devtools::install_github(repo = "tidyverse/ggplot2", ref = "0a72828caa5601d89fb3ace51dc5647ebc9b2a60")'         # ggplot2 3.3.2
RUN Rscript -e 'install.packages( "cowplot")'        # plot_grid, themes, ...
RUN Rscript -e 'install.packages( "ggpubr")'         # add_summary, geom_signif, ...
RUN Rscript -e 'install.packages( "ggrepel")'        # geom_text_repel, geom_label_repel
RUN Rscript -e 'install.packages( "gridExtra")'      # grid.arrange, ...
RUN Rscript -e 'BiocManager::install( "patchwork")'  # +/ operators for ggplots

# plotly
RUN Rscript -e 'install.packages( "plotly")'

# general
RUN Rscript -e 'install.packages( "gplots")'         # heatmap.2
RUN Rscript -e 'install.packages( "heatmaply")'      # heatmaply (interactive)
RUN Rscript -e 'BiocManager::install( "iheatmapr")'  # iheatmap (interactive, uses plotly), dependencies OK with BiocManager
RUN Rscript -e 'install.packages( "pheatmap")'       # pheatmap
RUN R -e 'BiocManager::install("ComplexHeatmap")'    # ComplexHeatmap
RUN R -e 'install.packages("dendsort")'     # dendsort
RUN R -e 'install.packages("dendextend")'     # dendextend
RUN Rscript -e 'install.packages( "ggforce")'        # visualisation tool (facet zoom, ellipse...)
RUN Rscript -e 'install.packages( "concaveman")'     # package mandatory for ggforce ellipse function
RUN Rscript -e 'install.packages( "ggcorrplot")'     # correlation plots
RUN Rscript -e 'install.packages( "rstatix")'        # add_summary, geom_signif, ...


#### Reporting
RUN Rscript -e 'install.packages( "DT")'             # datatable
RUN Rscript -e 'install.packages( "pander")'         # pander


#### General
RUN Rscript -e 'install.packages( "funr")'           # get_script_path
RUN Rscript -e 'install.packages( "reshape")'        # melt
RUN Rscript -e 'install.packages( "memisc")'        

#### Technology specific
RUN Rscript -e 'install.packages( "remotes")'
RUN Rscript -e 'install.packages( "umap")'
RUN Rscript -e 'install.packages( "reticulate")'

#### Paralell execution
RUN R -e 'install.packages("DescTools", dependancies = TRUE)'
RUN R -e 'install.packages("foreach", dependancies = TRUE)'
RUN R -e 'install.packages("doParallel", dependancies = TRUE)'





##### Packages for GeoMX
RUN R -e 'BiocManager::install("limma")'
RUN R -e 'BiocManager::install("edgeR")'
RUN R -e 'BiocManager::install("igraph")'
RUN R -e 'BiocManager::install("msigdb")'
RUN R -e 'BiocManager::install("GSEABase")'
RUN R -e 'BiocManager::install("vissE")'
RUN R -e 'BiocManager::install("SpatialExperiment")'
RUN R -e 'BiocManager::install("scater")'
RUN R -e 'BiocManager::install("Rhtslib")'
RUN R -e 'devtools::install_github("DavisLaboratory/standR")'
RUN R -e 'devtools::install_github("Nanostring-Biostats/GeomxTools")'
RUN R -e 'BiocManager::install("GeoMxWorkflows")'



# #################################################
# DECLARE EXPECTED PORTS TO BE EXPOSED
# #################################################

# Rstudio listens on port 8989 by default
# Container typically started with `-p 8989:8989`
EXPOSE 8585




