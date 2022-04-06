import configparser
import psycopg2
import json

##########################################################################################################################
#CONFIG FILE
##########################################################################################################################
config = configparser.ConfigParser()
config.read('param.ini')
##########################################################################################################################
#GET COUNT/LIMIT
##########################################################################################################################
try:
    connection = psycopg2.connect(
        user = config.get('db','user'),
        password = config.get('db','password'),
        host = config.get('db','host'),
        port = config.get('db','port'),
        database = config.get('db','database')
    )
    #get count
    print("PostgreSQL connection is now open")
    cursor = connection.cursor()
    cursor.execute("select * from count_data();")
    result = cursor.fetchone()
    count = result[0]
    print("count_data(): {} rows ".format(count))  
    limit = int(config.get('records','limit'))    
    #count = 25000
    #limit = 25000
except(Exception, psycopg2.Error) as error:
    print("Error connecting to PostgreSQL database", error)
    connection = None
finally:
    if(connection != None):
        cursor.close()
        connection.close()
        print("PostgreSQL connection is now closed")
##########################################################################################################################
#EXTRACT DATA
##########################################################################################################################
if eval(config.get('action','extract')):   
    try:
        connection = psycopg2.connect(
            user = config.get('db','user'),
            password = config.get('db','password'),
            host = config.get('db','host'),
            port = config.get('db','port'),
            database = config.get('db','database')
        )
        #get count
        print("PostgreSQL connection is now open")
        cursor = connection.cursor()
        print("BEGIN GET DATA offset: {} and limit: {}".format(count, limit))
        j = 0
        for i in range(0, count, limit):        
            cursor.execute("select  * from get_data('{"+'"limit"'+": %s, "+'"offset"'+": %s}'::json);",(limit, i))   
            record = cursor.fetchone()
            destinationfile = '{}{}'.format(j, config.get('filepath','result'))
            with open(destinationfile, 'w') as f:
                json.dump(record[0], f, ensure_ascii=False)
            print("\tget_data from: {} to: {} offset: {} limit: {} in: {}".format(i+1, i+limit, i, limit, destinationfile))
            j+=1
        print("END GET DATA offset: {} and limit: {}".format(count, limit))    
    except(Exception, psycopg2.Error) as error:
        print("Error connecting to PostgreSQL database", error)
        connection = None
    finally:
        if(connection != None):
            cursor.close()
            connection.close()
            print("PostgreSQL connection is now closed")
##########################################################################################################################
#TRANSFORM DATA
##########################################################################################################################
if eval(config.get('action','transform')):   
    print("BEGIN JSON TO NDJSON")
    j = 0
    for i in range(0, count, limit):    
        sourcefile = '{}{}'.format(j, config.get('filepath','result'))
        destinationfile= '{}{}'.format(j, config.get('filepath','result-processed'))
        with open(sourcefile, 'r') as read_file:
            data = json.load(read_file)
        result = [json.dumps(toto, ensure_ascii=False) for toto in data]
        with open(destinationfile, 'w') as obj:
            for i in result:
                if eval(config.get('action','transform.bulk.manually')):  
                    obj.write('{ "index":{ } }'+ "\n" + i + "\n")
                else:
                    obj.write(i + "\n")
        print("\tjson: {} to ndjson: {}".format(sourcefile, destinationfile))      
        j+=1
    print("END JSON TO NDJSON")
