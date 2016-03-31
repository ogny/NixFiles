#!/usr/bin/env python
import pika
parameters = pika.URLParameters('amqp://logger:q1w2e3r4@172.25.6.67:5672/%2Flogger')
connection = pika.BlockingConnection(parameters)

channel = connection.channel()

channel.queue_declare(queue='naber')

channel.basic_publish(exchange='',
                      routing_key='hello',
                      body='Hello World!')
print " [x] Sent 'Hello World!'"
connection.close()
