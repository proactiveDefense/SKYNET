#!/bin/bash
curl -X POST \
     -H 'Content-Type: application/json' \
     -d "{\"chat_id\": \"-1001409159111\", \"text\": \"IP connection: $1\ \nState: $2 \nReverse lookup: $(dig +short -x $1)\", \"disable_notification\": true}" \
     https://api.telegram.org/bot1380103530:AAHYF-i_JyA0_iV5NP2-JFNI3UYhQ3EJsCA/sendMessage