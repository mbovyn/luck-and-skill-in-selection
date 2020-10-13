using Statistics
using Plots

#napplicants=18000
#nwinners=11

## simulate

function findluck(napplicants,nwinners,f_luck)

    selskill=[]
    selluck=[]

    for n=1:1000

        skill=rand(napplicants)
        luck=rand(napplicants)

        score=(1-f_luck)*skill+f_luck*luck

        scoresrt=sortperm(score)

        append!(selskill,skill[scoresrt[end-nwinners+1:end]])
        append!(selluck,luck[scoresrt[end-nwinners+1:end]])

    end

    p=plot(sort(selskill),(1:length(selskill))/length(selskill),linetype=:steppre,label="skill",legend=:topleft)
    plot!(p,sort(selluck),(1:length(selluck))/length(selluck),linetype=:steppre,label="luck")
    xaxis!(p,(0,1))
    xlabel!(p,"Value")
    ylabel!(p,"CDF")
    title!(p,string(nwinners," people selected from ",napplicants," applicants,\nwhere luck is ",100*f_luck,"% of the weighting"))

    p2=plot(sort(rand(napplicants)),(1:napplicants)/napplicants,linetype=:steppre,label="skill",legend=:topleft)
    plot!(p2,sort(rand(napplicants)),(1:napplicants)/napplicants,linetype=:steppre,label="luck")
    xlabel!(p2,"Value")
    ylabel!(p2,"CDF")
    title!(p2,"Whole applicant pool")

    p3=plot(p2,p,layout=(2,1))

    return ([mean(selskill),mean(selluck)],selskill,selluck,p3)
end

## Numbers from video

a=findluck(18000,11,.05)
a[1]
a[4]

## sweep over luck weighting

ws=[.05,.01,.005,.001,.0005,.0001]
p=plot(legend=:topleft,linetype=:steppre,legendtitle="Weight (%)")
for i=1:length(ws)
    a=findluck(18000,11,ws[i])
    plot!(p,sort(a[3]),(1:length(a[3]))/length(a[3]),label=string(ws[i]*100))
end
xlabel!("Luck Value")
ylabel!("CDF")
p
