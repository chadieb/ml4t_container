FROM ubuntu

RUN apt -y update
RUN apt -y install vim python2.7 python-pip git 
COPY ./files  /build
RUN python -m pip install --requirement /build/ml4t-libraries.txt
RUN pip install IPython==5.2.2 jupyter &&  pip install jupyter 
RUN mkdir ~/.jupyter && cp /build/jupyter*.* ~/.jupyter
RUN export IP_ADDR=`/sbin/ip route|awk '/default/ { print $3 }'`
RUN mkdir /workbook && cd /workbook
CMD jupyter notebook --no-browser --ip=$IP_ADDR --port 9999 --allow-root --notebook-dir='/workbook'
