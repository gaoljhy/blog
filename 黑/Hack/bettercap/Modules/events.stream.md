events.stream
===============

this module is enabled by default and is responsible for reporting events (`logs, new hosts being found, etc`) during your interactive session.

Commands
========

| command                       | description                                                                                                |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `events.stream on/off`        | Start/Stop the events stream.                                                                              |
| `events.show LIMIT?`          | Show the events stream ( LIMIT is an optional parameter ).                                                 |
| `events.waitfor TAG TIMEOUT?` | Wait for an event with the given tag either forever or for a timeout in seconds.                           |
| `events.ignore FILTER`        | Events with an identifier matching this filter will not be shown (use multiple times to add more filters). |
| `events.include FILTER`       | Used to remove filters passed with the events.ignore command.                                              |
| `events.clear`                | Clear the events stream buffer.                                                                            |

Parameters
==========

| parameter                          | default | description                                                                       |
| ---------------------------------- | ------- | --------------------------------------------------------------------------------- |
| `events.stream.output`             |         | If not empty, events will be written to this file instead of the standard output. |
| `events.stream.http.request.dump`  | `false` | If true all HTTP requests will be dumped.                                         |
| `events.stream.http.response.dump` | `false` | If true all HTTP responses will be dumped.                                        |

示例:

Ignore events from WiFi clients while using one of the wifi modules:

> `events.ignore wifi.client `