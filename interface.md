# 接口文档

## C++/QML交互函数

### QML发出的请求信号与C++槽函数（响应QML）

```c++
尽量用全局信号

signal loginSignal(int usrID,string usrPSW)

void login(int id,QString password);

这一对信号和槽函数负责像服务器发出登录请求

signal registerSignal(string usrName,string usrPassword)

void registerAccount(QString user,QString password);

这一对信号和槽函数负责注册像服务器发出注册请求

signal sendToFriendSignal(int targetId,string content,string time)

void sendToFriend(int targetId,QString content,QString time);

这一对槽函数负责像服务器发出发消息请求

signal sendToGroupSignal()//参数待商定
```

### 客户端通信函数

```c++

void on_udpSocket_readyRead();

基本监听函数，负责从Socket监听udp报文

void sendMessage(QString content,QString ip,QString port);

void sendMessage(QString content,QHostAddress ip,quint16 port);

void sendMessage(QByteArray content,QHostAddress ip,quint16 port);

void sendMessage(QByteArray content,QString ip,QString port);

基本发送函数，负责将报文发送到对应的ip和port，四种重载适应不同格式的数据

void parseCommand(QString jsonStr,QHostAddress ip,quint16 port);

用于将收到的Json报文解析，进行对应的函数调用

```
    
  
### C++客户端响应函数与QML受控函数





