Loading Libraries

```{r}

##install.packages("tidyverse")
#install.packages("data.table")
library("tidyverse") ## for data manipulating functions
library("utils") ##for reading csv into tables
library("lubridate") ## forformatting Date columns
library("data.table")
getwd()

```

Importing data from CSVs

```{r}

people_tbl <- read.csv("people.csv")
pymt_tbl <- read.csv("payment.csv")
people_tbl
summary(people_tbl)
summary(pymt_tbl)
```

Data Manipulation
```{r}

dt1 <- people_tbl %>%  select(2, 3,4,5,6)
summary(dt1)
str(dt1) #85 obs, 6 var
View(dt1)
#combined_tbl$Date.Joined2 <- as_datetime(combined_tbl$Date.Joined)
dt1$Date.Joined2 <- as.POSIXlt.character(dt1$Date.Joined, tz="UTC", usetz="TRUE", tryformat="%Y-%m-%d %H:%M:%S")
dt1 %>% arrange(dt1$Date.Joined2 )
duplicated(dt1$Email)
duplicated(dt1$Mobile)


dt2 <- pymt_tbl %>%  select(3,4,5,6,7,8,9,12)
summary(dt2)
str(dt2) #132 obs, 8 var
View(dt2)

```

```{r}
v1 <- distinct(dt1, dt1$Email) #stores all distinct emails
#nrow(v1) 
#dim(v1)
#print(v1[2,1])

v2 <-distinct(dt1, dt1$Mobile)#stores all distinct Mobile
nrow(v2)

```

```{r}
i=1
n=1
ctbl <- data.table(Email=character(), Mobile=numeric(), Prod.Name.1=character(),Prod.AF.1=character(),Amt.1=numeric(),Prod.Name.2=character(),Prod.AF.2=character(),Amt.2=numeric(),Prod.Name.3=character(),Prod.AF.3=character(),Amt.3=numeric(),Prod.Name.4=character(),Prod.AF.4=character(),Amt.4=numeric()) 
for(i in 1:dim(v1)) {
  
  #print(v1[i,1])
  
  dt3= dt2[dt2$Email == v1[i,1] & dt2$Payment.Status == "Success" , c("Email","Mobile","Product.Name", "Product.Access.Format","Transaction.Value","Purchase.Date")]
  
  # create an empty data table
  
  if (nrow(dt3) >0) {
    # print (nrow(ctbl)+1)
    p = nrow(dt3)
    
    
    
    for(p in 1:nrow(dt3)) {
      n=1
      for(m in 1:ncol(dt3)) {
        r = nrow(ctbl) +1
        #  ctbl <- dt3[p,m]
        print(dt3, p)
      }
      
    }
  }
  
}



```


```{r}
combined_tbl <- merge(dt1, dt2, by="Email", allow.cartesian=TRUE)
View(combined_tbl)

combined_tbl2 <- merge(dt1, dt2, by.x = c("Email", "Mobile"), allow.cartesian=TRUE)
View(combined_tbl2)

combined_tbl2 <- merge(dt1, dt2, by = "Mobile", allow.cartesian=TRUE)
View(combined_tbl2)

for (i in unique(dt1$Email))
{
  v=unique(dt2$FY)
  
  if(('FY15' %in% v) & ('FY14' %in% v)) {
    testdf$Tally=='Asked Over The Past Two Years'
  }
  else if(('FY15' %in% v) & ('FY14' %in% v) & ('FY13' %in% v)) {
    testdf$Tally=='Asked Over The Past Three Years'
  }
  else if(('FY13' %in% v) & ('FY15' %in% v)) {
    testdf$Tally=='Question Asked in FY13 & FY15 Only'
  }
  else { testdf$Tally=='Question Asked Once Only'
  }
  
  
}

```



