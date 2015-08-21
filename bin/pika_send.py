#!/usr/bin/env python
import pika
parameters = pika.URLParameters('amqp://pims:q1w2e3r4@10.11.1.101:5672/%2Fpims')
connection = pika.BlockingConnection(parameters)

channel = connection.channel()

channel.queue_declare(queue='selam')

channel.basic_publish(exchange='',
                      routing_key='selam',
                      body='selam World!')
print " [x] Sent 'selam World!'"
connection.close()
