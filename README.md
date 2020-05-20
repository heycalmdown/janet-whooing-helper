# janet-whooing-helper
https://whooing.com 가계부 작성 유틸

## main.janet

쿠팡 [쿠페이 사용 내역](https://rocketpay.coupang.com/rocketpay/mypage)을 후잉의 [어썸 박스](https://new.whooing.com/help/tips#tips/awesomebox) 문법에 맞게 바꾸기

원본

```
-6,990원결제 34,170원 (잔액) 2020.05.12 (화) 21:23 [결제] 크리넥스 디럭스 미니 카카오 230매, 6개입, 10000070721321
-60,280원결제 41,160원 (잔액) 2020.05.11 (월) 22:32 [결제] [홍콩직구] 제니베이커리 제니쿠키 마카다미아 초코칩 255g, 1개, 10000070637942
100,000원충전 101,440원 (잔액) 2020.05.11 (월) 22:32 [잔액충전] [홍콩직구] 제니베이커리 제니쿠키 마카다미아 초코칩 255g, 1개, 10000070637942
```

대상

```
2020-05-12 6990 기타+ 쿠페이머니- ?; 34170원 (잔액)   (화) 21:23 [결제] 크리넥스 디럭스 미니 카카오 230매 6개입 10000070721321
2020-05-11 60280 기타+ 쿠페이머니- ?; 41160원 (잔액)   (월) 22:32 [결제] [홍콩직구] 제니베이커리 제니쿠키 마카다미아 초코칩 255g 1개 10000070637942
2020-05-11 100000 쿠페이머니+ 하나- 쿠페이 충전 ; 101440원 (잔액)   (월) 22:32 [잔액충전] [홍콩직구] 제니베이커리 제니쿠키 마카다미아 초코칩 255g 1개 10000070637942
```
