# Server Side Error handling

<<[code/errors.psgi](code/errors.psgi)

If we access a URL where the route throws an exception, e.g. by calling `die`, normally Dancer would return an HTTP code `500 - Internal Server Error`
and a page that sais the same.



<<[code/errors.t](code/errors.t)


