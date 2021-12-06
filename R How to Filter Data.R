##HOMEWORK DAY 3

#Data Frame
install.packages("randomNames")
library(randomNames)
Nama <-randomNames(50)
Nama
jabodetabek <- c("Jakarta","Bogor","Depok","Tangerang","Bekasi")
Tempat_Lahir <- rep(jabodetabek,10)
Tempat_Lahir
Tanggal_Lahir <-sample(seq(as.Date('1990/01/01'), as.Date('2000/01/01'), by="day"), 50)
Tanggal_Lahir
Tanggal_Belanja <- sample(seq(as.Date('2020/01/01'), as.Date('2021/01/01'), by="day"), 50)
Tanggal_Belanja
Rata2_Bulan <- sample(seq(as.integer(70000), as.integer(150000)), 50)
Rata2_Bulan
Transaksi <- sample(seq(as.integer(1), as.integer(9)), 50, replace = TRUE)
Transaksi                    
data_customer<- data.frame(Nama,Tempat_Lahir,Tanggal_Lahir,Tanggal_Belanja,Rata2_Bulan,Transaksi)
colnames(data_customer) <- c("Nama", "Tempat Lahir","Tanggal Lahir","Tanggal Belanja Terakhir","Rata-rata Spending per Bulan (Rp)","Jumlah Transaksi")
data_customer

#Filter Data
filter_loyal <- data_customer$`Rata-rata Spending per Bulan (Rp)`>100000 & data_customer$`Jumlah Transaksi`>5
data_customer [filter_loyal,]
