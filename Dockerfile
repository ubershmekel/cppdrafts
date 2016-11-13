# From: https://github.com/delcypher/docker-ubuntu-cxx-dev/blob/master/Dockerfile
FROM ubuntu:16.04
MAINTAINER Yuval Greenfield <ubershmekel@gmail.com>

# Update and upgrade to avoid 'E: Unable to locate package clang'
RUN apt-get update && apt-get -y upgrade

RUN apt-get -y --no-install-recommends install git-core
RUN apt-get -y --no-install-recommends install \
  python \
  python-dev \
  python-pip \
  subversion \
  tmux \
  tree \
  unzip \
  vim \
  nano

#
#
# The real work starts here
#
#

RUN apt-get -y --no-install-recommends install tex4ht
RUN apt-get -y --no-install-recommends install latexmk

# for memoir.cls
RUN apt-get -y --no-install-recommends install texlive-latex-base
RUN apt-get -y --no-install-recommends install texlive-latex-recommended
RUN apt-get -y --no-install-recommends install texlive-latex-extra
# To avoid: Latexmk: Missing input file: 'ulem.sty' from line
RUN apt-get -y --no-install-recommends install texlive-generic-recommended
# To avoid: Latexmk: Missing input file: 'lmodern.sty' from line
RUN apt-get -y --no-install-recommends install lmodern
# To avoid: I can't find file `ecrm1000'
RUN apt-get -y --no-install-recommends install texlive-fonts-recommended

RUN apt-get -y --no-install-recommends install pdf2htmlex


RUN git clone --recursive https://github.com/cplusplus/draft.git /draft

WORKDIR /draft/source

# pdf output
#RUN latexmk -f -pdf std

# pdf to HTML conversion
#RUN pdf2htmlEX --optimize-text 1 --zoom 1.5 std.pdf std.html

#CMD cp std.html /output/
ADD . /code
CMD ["python", "-u", "/code/generate_all.py"]

# No way to get memoir.cls, needs memoir.hva
#RUN apt-get -y --no-install-recommends install hevea
#RUN cd /draft/source && hevea std.tex
#
# Just outputs a ton of dots to stdout for 10 minutes
#RUN apt-get -y --no-install-recommends install latex2html
#RUN cd /draft/source && latex2html std.tex
#
# Fatal:expected:#1 Parameters for '\chaptermark' not in order in
#RUN apt-get -y --no-install-recommends install latexml
#RUN cd /draft/source && latexml std.tex --destination=std.html
#
#RUN cd /draft/source && htlatex std.tex
#
#EXPOSE 8080
#CMD python -m SimpleHTTPServer 8080

#CMD

