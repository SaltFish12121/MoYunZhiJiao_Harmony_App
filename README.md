使用修改
1.修改地址为服务器地址
2.在登陆过后查看token码复制到src/main/ets/common/constants/Http.ts中的Token便于预览测试，虚拟机则无需这样。
3.src/main/ets/pages/mainpage/HomePage.ets中的ifLogin默认应该 false， 如果预览测试则改为 true。否则会让大部分功能要求登录，不好预览器测试，虚拟机测试无影响。
4.
