#Tugas Day 5
#Data 10 Tikus
set.seed(1234) 
my_data <- data.frame( name = paste0(rep("M_", 10), 1:10), weight = round(rnorm(10, 20, 2), 1) )
#1. Summary statistik (mean, median)
mean(my_data$weight)
median(my_data$weight)
summary(my_data)
#2. Visualisasi Boxplot
boxplot(my_data$weight,
        main = "Boxplot Berat Badan 10 Ekor Tikus",
        ylab = "Berat Badan Tikus (kg)",
        col = "light blue")
#3. Visualisasi Histogram
hist(my_data$weight, breaks = 4,
     main = "Histogram Berat Badan 10 Ekor Tikus",
     xlab = "Berat Badan Tikus (kg)",
     ylab = "Frekuensi data",
     col = "light green")
#4. Interpretasi Visualisasi
print("Dari gambar boxplot data memiliki pola sedikit Negative Skew dari ekor bawah yang sedikit lebih panjang, jarak rentang keseluruhan boxplot maupun boxnya sendiri relatif berukuran sedang, kesimpulannya data berat badan tersebar cukup merata")
print("Dari gambar histogram  terlihat modus data terletak pada rentang 18-20, begitu juga dengan nilai mean dan median, kesimpulannya bahwa data terdistribusi secara normal, namun terlihat pola sedikit negative skew ditandai dengan ekor di kiri, mungkin karena jumlah sampel yang sedikit")
#5. Uji t-test apakah rata-rata = 25kg
test <- t.test(my_data$weight, mu = 25, alternative = "two.sided")
test
#6. Interpretasi hasil t-test
p_value <- test$p.value
print(p_value < 0.05)
print("H0 ditolak karena p value kurang dari 0.05, kesimpulannya adalah -> rata-rata berat badan 10 tikus tidak sama dengan 25")
  