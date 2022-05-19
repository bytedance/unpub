#!/bin/sh

dart ./unpub/bin/unpub.dart -d ${DB_URL} --proxy-origin ${HOST_NAME} -e true
