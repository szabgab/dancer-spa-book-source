# Create a Dancer Application



```
$ dancer2 gen -a Demo::App
```

This will create a directory called `Demo-App` right where you are, a bunch of subdirectories and files in it.
This is the skeleton of an application.

You can now change directory into the newly created directory:

```
$ prove -l
t/001_base.t ......... ok
t/002_index_route.t .. 1/2 [Demo::App:72178] core @2017-09-23 22:40:16> looking for get / in /Users/gabor/perl5/perlbrew/perls/perl-5.22.0_WITH_THREADS/lib/site_perl/5.22.0/Dancer2/Core/App.pm l. 36
[Demo::App:72178] core @2017-09-23 22:40:16> Entering hook core.app.before_request in (eval 220) l. 1
[Demo::App:72178] core @2017-09-23 22:40:16> Entering hook core.app.after_request in (eval 220) l. 1
t/002_index_route.t .. ok
All tests successful.
Files=2, Tests=3,  1 wallclock secs ( 0.04 usr  0.01 sys +  1.30 cusr  0.13 csys =  1.48 CPU)
Result: PASS
```


