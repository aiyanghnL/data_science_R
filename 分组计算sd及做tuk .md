
对alpha多样性进行分组计算均值和标准差，并用multcomp包做多重tukey比较


```R
# # 读取多样性表格
# hp <- read.table("hp.csv",header = T,sep = ",")
# alpha <- c("observed_species","shannon","simpson","chao1","ACE","goods_coverage","PD_whole_tree")
# 
# (x1 <- aggregate(hp[alpha], by=list(Sample = hp$Sample), mean))
# 
# (x2 <- aggregate(hp[alpha], by=list(Sample = hp$Sample), sd))
# 
# write_csv(x2,"hpsd.csv")
# # install.packages("multcomp")
# library(multcomp)
# attach(hp)
# aov(ACE~Sample,data = hp) %>%
# # summary()
# # TukeyHSD()
# glht(linfct = mcp(Sample = "Tukey")) %>%
# summary()
# detach(hp)

```


```R
# 读取多样性表格
hp <- read.table("hp.csv",header = T,sep = ",")
```


```R
hp
```


<table>
<caption>A data.frame: 15 × 8</caption>
<thead>
	<tr><th scope=col>Sample</th><th scope=col>observed_species</th><th scope=col>shannon</th><th scope=col>simpson</th><th scope=col>chao1</th><th scope=col>ACE</th><th scope=col>goods_coverage</th><th scope=col>PD_whole_tree</th></tr>
	<tr><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>CWB</td><td>2139</td><td>8.217</td><td>0.986</td><td>3209.049</td><td>2462.558</td><td>0.992</td><td>185.989</td></tr>
	<tr><td>CWB</td><td>1982</td><td>8.197</td><td>0.988</td><td>2126.850</td><td>2121.087</td><td>0.996</td><td>177.511</td></tr>
	<tr><td>CWB</td><td>1925</td><td>8.365</td><td>0.991</td><td>2046.026</td><td>2040.442</td><td>0.996</td><td>166.796</td></tr>
	<tr><td>YH </td><td>1458</td><td>7.173</td><td>0.949</td><td>1637.286</td><td>1622.451</td><td>0.996</td><td>132.709</td></tr>
	<tr><td>YH </td><td>1461</td><td>7.550</td><td>0.985</td><td>1592.204</td><td>1601.046</td><td>0.996</td><td>133.500</td></tr>
	<tr><td>YH </td><td>1144</td><td>4.325</td><td>0.679</td><td>1285.984</td><td>1309.131</td><td>0.996</td><td>108.495</td></tr>
	<tr><td>Bar</td><td> 678</td><td>6.262</td><td>0.971</td><td> 737.202</td><td> 747.892</td><td>0.998</td><td> 76.106</td></tr>
	<tr><td>Bar</td><td> 756</td><td>6.871</td><td>0.982</td><td> 825.727</td><td> 832.240</td><td>0.998</td><td> 86.784</td></tr>
	<tr><td>Bar</td><td> 767</td><td>6.787</td><td>0.980</td><td> 808.941</td><td> 821.047</td><td>0.998</td><td> 85.042</td></tr>
	<tr><td>YW </td><td> 402</td><td>1.784</td><td>0.420</td><td> 451.714</td><td> 465.886</td><td>0.999</td><td> 49.019</td></tr>
	<tr><td>YW </td><td> 381</td><td>1.779</td><td>0.419</td><td> 417.076</td><td> 434.272</td><td>0.999</td><td> 49.527</td></tr>
	<tr><td>YW </td><td> 519</td><td>2.475</td><td>0.511</td><td> 572.517</td><td> 584.482</td><td>0.998</td><td> 63.068</td></tr>
	<tr><td>EB </td><td> 867</td><td>5.229</td><td>0.865</td><td> 935.343</td><td> 932.281</td><td>0.998</td><td> 88.707</td></tr>
	<tr><td>EB </td><td> 909</td><td>6.091</td><td>0.929</td><td> 952.545</td><td> 961.399</td><td>0.998</td><td> 91.895</td></tr>
	<tr><td>EB </td><td> 905</td><td>5.981</td><td>0.924</td><td> 964.500</td><td> 971.086</td><td>0.998</td><td> 91.253</td></tr>
</tbody>
</table>




```R
alpha <- c("observed_species","shannon","simpson","chao1","ACE","goods_coverage","PD_whole_tree")

(x1 <- aggregate(hp[alpha], by=list(Sample = hp$Sample), mean))

(x2 <- aggregate(hp[alpha], by=list(Sample = hp$Sample), sd))

write_csv(x2,"hpsd.csv")

```


<table>
<caption>A data.frame: 5 × 8</caption>
<thead>
	<tr><th scope=col>Sample</th><th scope=col>observed_species</th><th scope=col>shannon</th><th scope=col>simpson</th><th scope=col>chao1</th><th scope=col>ACE</th><th scope=col>goods_coverage</th><th scope=col>PD_whole_tree</th></tr>
	<tr><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Bar</td><td> 733.6667</td><td>6.640000</td><td>0.9776667</td><td> 790.6233</td><td> 800.393</td><td>0.9980000</td><td> 82.64400</td></tr>
	<tr><td>CWB</td><td>2015.3333</td><td>8.259667</td><td>0.9883333</td><td>2460.6417</td><td>2208.029</td><td>0.9946667</td><td>176.76533</td></tr>
	<tr><td>EB </td><td> 893.6667</td><td>5.767000</td><td>0.9060000</td><td> 950.7960</td><td> 954.922</td><td>0.9980000</td><td> 90.61833</td></tr>
	<tr><td>YH </td><td>1354.3333</td><td>6.349333</td><td>0.8710000</td><td>1505.1580</td><td>1510.876</td><td>0.9960000</td><td>124.90133</td></tr>
	<tr><td>YW </td><td> 434.0000</td><td>2.012667</td><td>0.4500000</td><td> 480.4357</td><td> 494.880</td><td>0.9986667</td><td> 53.87133</td></tr>
</tbody>
</table>




<table>
<caption>A data.frame: 5 × 8</caption>
<thead>
	<tr><th scope=col>Sample</th><th scope=col>observed_species</th><th scope=col>shannon</th><th scope=col>simpson</th><th scope=col>chao1</th><th scope=col>ACE</th><th scope=col>goods_coverage</th><th scope=col>PD_whole_tree</th></tr>
	<tr><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Bar</td><td> 48.52147</td><td>0.33004091</td><td>0.005859465</td><td> 47.01937</td><td> 45.81034</td><td>0.0000000000</td><td> 5.728676</td></tr>
	<tr><td>CWB</td><td>110.82569</td><td>0.09176782</td><td>0.002516611</td><td>649.39840</td><td>224.08628</td><td>0.0023094011</td><td> 9.618203</td></tr>
	<tr><td>EB </td><td> 23.18045</td><td>0.46915669</td><td>0.035594943</td><td> 14.65697</td><td> 20.19705</td><td>0.0000000000</td><td> 1.686101</td></tr>
	<tr><td>YH </td><td>182.16019</td><td>1.76322895</td><td>0.167248318</td><td>191.14400</td><td>175.04379</td><td>0.0000000000</td><td>14.213805</td></tr>
	<tr><td>YW </td><td> 74.35725</td><td>0.40040022</td><td>0.052829916</td><td> 81.60378</td><td> 79.19122</td><td>0.0005773503</td><td> 7.968596</td></tr>
</tbody>
</table>




```R
attach(hp)
```


```R
library(multcomp)
```

    Loading required package: mvtnorm
    Loading required package: survival
    Loading required package: TH.data
    Loading required package: MASS
    
    Attaching package: ‘MASS’
    
    The following object is masked from ‘package:dplyr’:
    
        select
    
    
    Attaching package: ‘TH.data’
    
    The following object is masked from ‘package:MASS’:
    
        geyser
    



```R
fit <- aov(shannon~Sample,data = hp)#  %>%
# summary()
# TukeyHSD()
tuk <- glht(fit, linfct = mcp(Sample = "Tukey")) # %>%
(xx <- summary(tuk))


# write_file(xx,"shanaov.txt")
```


    
    	 Simultaneous Tests for General Linear Hypotheses
    
    Multiple Comparisons of Means: Tukey Contrasts
    
    
    Fit: aov(formula = shannon ~ Sample, data = hp)
    
    Linear Hypotheses:
                   Estimate Std. Error t value Pr(>|t|)    
    CWB - Bar == 0   1.6197     0.6935   2.336  0.21069    
    EB - Bar == 0   -0.8730     0.6935  -1.259  0.71997    
    YH - Bar == 0   -0.2907     0.6935  -0.419  0.99250    
    YW - Bar == 0   -4.6273     0.6935  -6.673  < 0.001 ***
    EB - CWB == 0   -2.4927     0.6935  -3.594  0.03116 *  
    YH - CWB == 0   -1.9103     0.6935  -2.755  0.11396    
    YW - CWB == 0   -6.2470     0.6935  -9.008  < 0.001 ***
    YH - EB == 0     0.5823     0.6935   0.840  0.91200    
    YW - EB == 0    -3.7543     0.6935  -5.414  0.00208 ** 
    YW - YH == 0    -4.3367     0.6935  -6.254  < 0.001 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    (Adjusted p values reported -- single-step method)




```R
aov(observed_species~Sample,data = hp) %>%
# summary()
# TukeyHSD()
glht(linfct = mcp(Sample = "Tukey")) %>%
summary()
```


    
    	 Simultaneous Tests for General Linear Hypotheses
    
    Multiple Comparisons of Means: Tukey Contrasts
    
    
    Fit: aov(formula = observed_species ~ Sample, data = hp)
    
    Linear Hypotheses:
                   Estimate Std. Error t value Pr(>|t|)    
    CWB - Bar == 0  1281.67      84.76  15.121  < 1e-04 ***
    EB - Bar == 0    160.00      84.76   1.888 0.381635    
    YH - Bar == 0    620.67      84.76   7.322 0.000164 ***
    YW - Bar == 0   -299.67      84.76  -3.535 0.034203 *  
    EB - CWB == 0  -1121.67      84.76 -13.233  < 1e-04 ***
    YH - CWB == 0   -661.00      84.76  -7.798 0.000123 ***
    YW - CWB == 0  -1581.33      84.76 -18.656  < 1e-04 ***
    YH - EB == 0     460.67      84.76   5.435 0.002094 ** 
    YW - EB == 0    -459.67      84.76  -5.423 0.002090 ** 
    YW - YH == 0    -920.33      84.76 -10.858  < 1e-04 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    (Adjusted p values reported -- single-step method)




```R
aov(simpson~Sample,data = hp) %>%
# summary()
# TukeyHSD()
glht(linfct = mcp(Sample = "Tukey")) %>%
summary()
```


    
    	 Simultaneous Tests for General Linear Hypotheses
    
    Multiple Comparisons of Means: Tukey Contrasts
    
    
    Fit: aov(formula = simpson ~ Sample, data = hp)
    
    Linear Hypotheses:
                   Estimate Std. Error t value Pr(>|t|)    
    CWB - Bar == 0  0.01067    0.06539   0.163 0.999811    
    EB - Bar == 0  -0.07167    0.06539  -1.096 0.804930    
    YH - Bar == 0  -0.10667    0.06539  -1.631 0.511841    
    YW - Bar == 0  -0.52767    0.06539  -8.069 0.000101 ***
    EB - CWB == 0  -0.08233    0.06539  -1.259 0.719873    
    YH - CWB == 0  -0.11733    0.06539  -1.794 0.426702    
    YW - CWB == 0  -0.53833    0.06539  -8.232  < 1e-04 ***
    YH - EB == 0   -0.03500    0.06539  -0.535 0.981395    
    YW - EB == 0   -0.45600    0.06539  -6.973 0.000247 ***
    YW - YH == 0   -0.42100    0.06539  -6.438 0.000534 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    (Adjusted p values reported -- single-step method)




```R
aov(chao1~Sample,data = hp) %>%
# summary()
# TukeyHSD()
glht(linfct = mcp(Sample = "Tukey")) %>%
summary()
```


    
    	 Simultaneous Tests for General Linear Hypotheses
    
    Multiple Comparisons of Means: Tukey Contrasts
    
    
    Fit: aov(formula = chao1 ~ Sample, data = hp)
    
    Linear Hypotheses:
                   Estimate Std. Error t value Pr(>|t|)    
    CWB - Bar == 0   1670.0      249.6   6.690   <0.001 ***
    EB - Bar == 0     160.2      249.6   0.642   0.9644    
    YH - Bar == 0     714.5      249.6   2.862   0.0968 .  
    YW - Bar == 0    -310.2      249.6  -1.243   0.7288    
    EB - CWB == 0   -1509.8      249.6  -6.048   <0.001 ***
    YH - CWB == 0    -955.5      249.6  -3.828   0.0218 *  
    YW - CWB == 0   -1980.2      249.6  -7.933   <0.001 ***
    YH - EB == 0      554.4      249.6   2.221   0.2473    
    YW - EB == 0     -470.4      249.6  -1.884   0.3832    
    YW - YH == 0    -1024.7      249.6  -4.105   0.0141 *  
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    (Adjusted p values reported -- single-step method)




```R
aov(ACE~Sample,data = hp) %>%
# summary()
# TukeyHSD()
glht(linfct = mcp(Sample = "Tukey")) %>%
summary()
```


    
    	 Simultaneous Tests for General Linear Hypotheses
    
    Multiple Comparisons of Means: Tukey Contrasts
    
    
    Fit: aov(formula = ACE ~ Sample, data = hp)
    
    Linear Hypotheses:
                   Estimate Std. Error t value Pr(>|t|)    
    CWB - Bar == 0   1407.6      109.3  12.876  < 1e-04 ***
    EB - Bar == 0     154.5      109.3   1.414 0.633433    
    YH - Bar == 0     710.5      109.3   6.499 0.000544 ***
    YW - Bar == 0    -305.5      109.3  -2.795 0.107353    
    EB - CWB == 0   -1253.1      109.3 -11.463  < 1e-04 ***
    YH - CWB == 0    -697.2      109.3  -6.377 0.000581 ***
    YW - CWB == 0   -1713.1      109.3 -15.671  < 1e-04 ***
    YH - EB == 0      556.0      109.3   5.086 0.003343 ** 
    YW - EB == 0     -460.0      109.3  -4.208 0.012183 *  
    YW - YH == 0    -1016.0      109.3  -9.294  < 1e-04 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    (Adjusted p values reported -- single-step method)




```R
detach(hp)
```
