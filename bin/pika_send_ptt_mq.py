#!/usr/bin/env python
import pika
parameters = pika.URLParameters('amqp://pttuser:q1w2e3r4@172.25.0.82:5672/%2Fpttpims')
connection = pika.BlockingConnection(parameters)

channel = connection.channel()

channel.queue_declare(queue='hello')

channel.basic_publish(exchange='',
                      routing_key='hello',
                      body='Hello World!')
print " [x] Sent 'Hello World!'"
connection.close()
