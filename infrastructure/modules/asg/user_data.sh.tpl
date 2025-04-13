#!/bin/bash
yum update -y
amazon-linux-extras enable python3.8
yum clean metadata
yum install -y python3.8
alternatives --set python3 /usr/bin/python3.8
python3 --version