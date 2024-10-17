import psycopg2 as postgresql
import pandas as pd
import pymongo as mongo
import redis
import os
from dotenv import load_dotenv

load_dotenv(dotenv_path="../.env")

conn_1ano = postgresql.connect(host=os.getenv("HOST_POSTGRESQL"),
                               port=os.getenv("PORT_POSTGRESQL"),
                               user=os.getenv("USER_POSTGRESQL"),
                               password=os.getenv("PSWD_POSTGRESQL"),
                               dbname=os.getenv("SEGU_POSTGRESQL"))

conn_2ano = postgresql.connect(host=os.getenv("HOST_POSTGRESQL"),
                               port=os.getenv("PORT_POSTGRESQL"),
                               user=os.getenv("USER_POSTGRESQL"),
                               password=os.getenv("PSWD_POSTGRESQL"),
                               dbname=os.getenv("PRIM_POSTGRESQL"))

conn_mongo = mongo.MongoClient(os.getenv("LINK_MONGO"))

conn_redis = redis.Redis(host=os.getenv("HOST_REDIS"),
                         port=os.getenv("PORT_REDIS"),
                         password=os.getenv("PSWD_REDIS"))



 