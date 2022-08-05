## 🕸 Kimurai (scraping framework for Ruby)  

Ruby版Scrapy(python)を試すリポ  
[公式](https://github.com/vifreefly/kimuraframework )

### Test
:   
|- nokogiri (通常のnokogiriを試す)  
|- selenium (通常のseleniumを試す)  
|  
|- spider (kimuraiを試す)   
:　　|- 並列処理でも試してみる  
:    
|- README.md  
|-spider.rb (spider sample file)
```
$ ruby spider.rb
```


<br/>

### 🕷参考・エラー対処等：
> https://qiita.com/hibiheion/items/502b1a4091d54d05fb53  

> chromedriverのバージョンエラーが出た際：  
https://qiita.com/iHacat/items/9c5c186f0d146bc98784
>
>「"chromedriver"は開発元を検証できないため開けません。」(PC側から):  
https://qiita.com/apukasukabian/items/77832dd42e85ab7aa568