# Solutions {#solutions} #

## Hello World

[Exercise](#exercise-hello-world)

![code/hello_world_solution.psgi](code/hello_world_solution.psgi)

![code/hello_world_solution.t](code/hello_world_solution.t)

## Calculator

[Exercise](#exercise-calculator)

![code/calc_solution.psgi](code/calc_solution.psgi)


![code/calc_solution.t](code/calc_solution.t)

## Counters

[Exercise](#exercise-counters)

Global counter that restarts when the application restarts:

![](code/count_till_restart.psgi)

Global counter that is persistent between restarts of the application:

![](code/count_persistent.psgi)


## Personalized Counters

[Exercise](#exercise-counters-with-session)

Per browser counter that restarts when the appllication restarts:

![](code/count_session_till_restart.psgi)

Per browser persistent counter:

![](code/count_session_persistent.psgi)

It will create a directrory called "sessions" and save a YAML file for each cookie. Such as this "W0es7gAA5BGeMA8hTuGvFm287n76fexT.yml"

