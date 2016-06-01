#!/usr/bin/env python
import pika
parameters = pika.URLParameters('amqp://orkun:1@172.17.0.2:5672/')
connection = pika.BlockingConnection(parameters)

channel = connection.channel()

channel.queue_declare(queue='iyi')

channel.basic_publish(exchange='',
                      routing_key='slm',
                      body='naber!')
print " [x] Sent 'naber!'"
connection.close()
