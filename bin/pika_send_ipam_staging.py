#!/usr/bin/env python
import pika
parameters = pika.URLParameters('amqp://ipam:q1w2e3r4@195.175.249.90:5672/%2Fipam_staging')
connection = pika.BlockingConnection(parameters)

channel = connection.channel()

channel.queue_declare(queue='hello')

channel.basic_publish(exchange='',
                      routing_key='hello',
                      body='Hello World!')
print " [x] Sent 'Hello World!'"
connection.close()
