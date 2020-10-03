using Statistics
using Plots

napplicants=18000
nwinners=11

selskill=[]
selluck=[]

## simulate

for n=1:1000
    skill=rand(napplicants)
    luck=rand(napplicants)

    score=.95*skill+.05*luck

    scoresrt=sortperm(score)

    append!(selskill,skill[scoresrt[end-nwinners+1:end]])
    append!(selluck,luck[scoresrt[end-nwinners+1:end]])
end

println("mean skill: ",mean(selskill))
println("mean luck: ",mean(selluck))

## Plots

#ECDF plots of distrubutions of Skill and Luck values
p=plot(sort(selskill),(1:length(selskill))/length(selskill),linetype=:steppre,label="skill",legend=:topleft)
plot!(p,sort(selluck),(1:length(selluck))/length(selluck),linetype=:steppre,label="luck")
xaxis!(p,(0,1))
xlabel!(p,"Value")
ylabel!(p,"CDF")
title!(p,"11 astronauts selected from 18000 applicants")

#=
This way of plotting is equivalent to
d=StatsBase.ecdf(selskill)
plot(sort(a),d(sort(a)),linetype=:steppre)
=#

##

p2=plot(sort(rand(napplicants)),(1:napplicants)/napplicants,linetype=:steppre,label="skill",legend=:topleft)
plot!(p2,sort(rand(napplicants)),(1:napplicants)/napplicants,linetype=:steppre,label="luck")
xlabel!(p2,"Value")
ylabel!(p2,"CDF")
title!(p2,"Whole applicant pool")

##

plot(p2,p,layout=(2,1))
