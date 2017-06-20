FROM centos

RUN curl -L -H "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm && \
rpm -ivh jdk-8u131-linux-x64.rpm && \
rm -f jdk-8u131-linux-x64.rpm

RUN mkdir -p /opt/hadoop && \
curl http://apache.melbourneitmirror.net/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz | tar -xz -C /opt/hadoop --strip-components 1

RUN mkdir -p /opt/hive && \
curl http://apache.melbourneitmirror.net/hive/hive-2.1.1/apache-hive-2.1.1-bin.tar.gz | tar -xz -C /opt/hive --strip-components 1

RUN yum update -y && \
yum install -y which openssh-server openssh-clients && \
yum clean -y all 

RUN ssh-keygen -A && \
/usr/sbin/sshd && \
ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' -q && \
ssh-keyscan localhost >> ~/.ssh/known_hosts && \
ssh-keyscan 0.0.0.0 >> ~/.ssh/known_hosts && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
chmod 0600 ~/.ssh/authorized_keys

ADD hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml
ADD mapred-site.xml /opt/hadoop/etc/hadoop/mapred-site.xml
ADD bashrc /root/.bashrc
ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 8088
CMD /docker-entrypoint.sh
