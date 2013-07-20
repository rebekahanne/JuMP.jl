# hygiene.jl
# Make sure that our macros have good hygiene
using Base.Test

require("JuMP")

mymod = JuMP.Model(:Min)
JuMP.@defVar(mymod, x >= 0)
r = 3:5
JuMP.@defVar(mymod, y[i=r] <= i)
JuMP.@addConstraint(mymod, x + sum{ j*y[j], j=r } <= 1)
JuMP.@addConstraint(mymod, sum{ y[j], j=r ; j == 4} <= 1)
JuMP.@addConstraint(mymod, -1 <= x + y[3] <= 1)
JuMP.@setObjective(mymod, y[4])
