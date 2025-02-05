#lecture on boolean + conditional
#2.2 Boolean logic

vec = c(1, 0, 2, 1)
vec
#only give me the third index
vec[c(FALSE, FALSE, TRUE, FALSE)]

1>2
vec>1 #applies to every value in vector 
vec >= 1

c(1,2,3) == c(3,2,1) #are the values in the vector equal


1 %in% c(1,2,3) #does the vector contain the value 1

world_oceans = data.frame(oceans = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
world_oceans
world_oceans$avg_depth_m > 4000
sum(world_oceans$avg_depth_m > 4000)

#show me the information for the columns of the rows that have average depth greater than 4000
world_oceans[world_oceans$avg_depth_m > 4000,]
#show me the names of the oceans
world_oceans[world_oceans$avg_depth_m > 4000, "oceans"]
#OR
world_oceans$oceans[world_oceans$avg_depth_m > 4000]

#Exercise 2.1 
my_oceans= c("Atlantic", "Pacific")
world_oceans = data.frame(oceans = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
my_oceans %in% world_oceans$oceans
smaller_oceans=world_oceans[world_oceans$area_km2 < world_oceans$area_km2[1], ]
my_oceans %in% smaller_oceans


1+2==3
0.1+0.2==0.3
(0.1+0.2)-0.3
error_threshold= 0.00001
abs((0.1+0.2) - 0.3) > error_threshold 


#Boolean operators 
x= 5
x>3 & x<15 #and
x>3 | x<15 #Or
x>3 | x %in% c(1,3,7,9)

a= c(1,2,3)
b= c(1,2,3)
c= c(1,2,4)

a==b
a==c
any(a==c) #are any of these true?
all(a==c) #are all of these true? 


dat= c(1,2,3,NA)
dat== NA
NA ==NA
is.na(dat) #special test to look at NA because other things dont work 

#Exercise 2.2
w = 15
x = c(-1, 0, 1)
y = "February"
z = c("Monday", "Tuesday", "January")

w > 10 & w < 20
any(x > 0)
all(x > 0)
y == "February"
days= c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
sum(z %in% days)

#2.3 Conditional Statements 
num = -2
if(num<0){
  num=num *-1
} #this is an absolute value function
num

num = -35
if(num<0){
  print("num is negative")
  num=num *-1
  print("we made positive")
} #this is an absolute value function
num

#Exercise 3.1
temp= 102
if(temp>98.6){
  difference= temp-98.6
  print(difference) #print out the difference between the fever and median human temp
  if(temp>101){
    print("go to the doctor!")
    }}

#else statements
grade= 53
if(grade>60){
  print("you passed!")
} else{
  print("you failed :(")
}

#try out else if statements 
a= 1
b=2
if(a>b){
  print("a wins")
} else if (b>a){
  print("b wins")
} else{
  print("they tied")
}

#try out ifelse() function
a= 9
ifelse(test= (a != 0), yes= 1/a, no= NA) #if the test is true, do yes, if not, do no

vec= c(0,1,2,-4,-5)
reciprocals= ifelse(test= (vec != 0), yes= 1/vec, no= NA)
reciprocals
cbind(vec, reciprocals)

#Exercise 3.3
data= c(1,3,5,-999,2,-999,8)
data_fix= ifelse(test= (data!=-999), yes= data, no= NA)
data_fix


#check if there is any NA
if(any(is.na(data_fix))){
  print("The dataset contains NA")
} else{
  print("The dataset does not contain NA")
}





