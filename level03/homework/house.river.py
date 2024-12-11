import turtle
turtle.speed(5)
turtle.bgcolor("blue")
tf = turtle.forward
t = turtle
tr = turtle.right
tl = turtle.left
pup = turtle.penup
pdown = turtle.pendown
goto = turtle.goto
bgc = turtle.begin_fill
fillc = turtle.fillcolor
endf = turtle.end_fill
#grass
turtle.shape("circle")
fillc("green")
bgc()
pup()
goto(-1000,-40)
pdown()
tf(2000)
tr(90)
tf(460)
tr(90)
tf(2000)
tr(90)
tf(460)
endf()
#mountein
pup()
goto(-400, -100)
pdown()
fillc("dimgray")
bgc()
tr(90)
for i in range(3):
  tf(300)
  tl(120)
endf()
# Right Mountain
pup()
goto(100, -100)
pdown()
bgc()
for i in range(3):
  tf(300)
  tl(120)
endf()
#house walls
pup()
goto(600,-40)
pdown()
turtle.shape("classic")
fillc("ivory2")
bgc()
tl(90)
tf(300)
tr(90)
tf(400)
tl(90)
tf(600)
tl(90)
tf(400)
tl(90)
tf(600)
endf()
#roof
tl(90)
tf(400)
turtle.shape("square")
tr(90)
fillc("red")
bgc()
tf(20)
tl(-60)
tl(180)
tf(100)
tl(60)
tf(540)
tl(60)
tf(100)
tl(120)
tf(640)
endf()

#rightwindow
turtle.shape("turtle")
fillc("cyan")
bgc()
pup()
goto(250,250)
pdown()
tl(180)
tf(60)
tr(90)
tf(80)
tr(90)
tf(60)
tr(90)
tf(80)
endf()
#leftwindow
fillc("cyan")
bgc()
pup()
goto(-250,250)
pdown()
tl(180)
tf(80)
tr(90)
tf(60)
tr(90)
tf(80)
tr(90)
tf(60)
endf()
#door
turtle.shape("classic")
fillc("grey24")
bgc()
pup()
goto(-60,-40)
pdown()
tr(90)
tf(150)
tr(90)
tf(80)
tr(90)
tf(150)
tr(90)
tf(80)
endf()

#door heandle
fillc("black")
bgc()
pup()
goto(5,20)
pdown()
t.circle(3)
endf()
#sun
bgc()
goto(950,1950)




turtle.done()