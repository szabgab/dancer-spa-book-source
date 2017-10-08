# Server Side Error handling

<<[code/errors.psgi](code/errors.psgi)

If we access a URL where the route throws an exception, e.g. by calling `die`, normally Dancer would return an HTTP code `500 - Internal Server Error`
and a page that sais the same.

```
curl -X POST -d "x=20&y=4" http://127.0.0.1:5000/api/calc
```

```
curl -X POST -d "x=20&y=0" http://127.0.0.1:5000/api/calc -D header.txt
```


<<[code/errors.t](code/errors.t)


