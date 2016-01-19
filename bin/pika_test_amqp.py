#!/usr/bin/env python
import pika
parameters = pika.URLParameters('amqp://ipam:q1w2e3r4@172.17.0.2:5672/%2Fipam3')
connection = pika.BlockingConnection(parameters)

channel = connection.channel()

channel.queue_declare(queue='naber')

channel.basic_publish(exchange='',
                      routing_key='hello',
                      body='Hello World!')
print " [x] Sent 'Hello World!'"
connection.close()
