# 接口文档

## 客户端

### 成员变量

```c++

QUdpSocket* udpSocket;

储存客户端udp套接字

QHostAddress hostIp=QHostAddress("127.0.0.1");
quint16 hostPort=9990;

储存服务器ip和端口

int clientId=0;

储存当前id

QQmlApplicationEngine* engine=NULL;
QObject* root=NULL;

储存代表QML对象的engine和root
```

### QML发出的请求信号与C++槽函数（响应QML）

```c++
尽量用全局信号（信号为了显示美观，加了；，实际应用不需要；符号）

signal loginSignal(int usrID,string usrPSW);

void login(int id,QString password);

这一对信号和槽函数负责像服务器发出登录请求

signal registerSignal(string usrName,string usrPassword);

void registerAccount(QString user,QString password);

这一对信号和槽函数负责注册像服务器发出注册请求

signal sendToFriendSignal(int targetId,string content,string time);

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


将服务器返回的Json处理后调用QML中同名函数

```c++

void registerBack(QJsonObject obj);

负责注册后显示结果

void loginBack(QJsonObject obj);

负责登录后显示结果

void sendToFriendBack(QJsonObject obj);

收到消息后显示新消息

```

## 服务端

### 成员变量

class User

储存在线用户的节点，属性为ip，port，id

QUdpSocket* udpSocket=NULL;

储存当前服务端的Udp套接字

QList<User*> onlineUser;

储存当前在线用户的链表节点

SqlAccountModel *atModel;
SqlFriendModel *fdModel;

指向数据库操作的实例对象。


### 基本通信函数

这一部分和客户端的逻辑一模一样。

```c++
//数据包通信解析
void QQServer::parseCommand(QString jsonStr,QHostAddress ip,quint16 port);
//不同参数类型的的发送信息
void QQServer::sendMessage(QString content,QString ip,QString port);
void QQServer::sendMessage(QString content,QHostAddress ip,quint16 port);
void QQServer::sendMessage(QByteArray content,QHostAddress ip,quint16 port);
void QQServer::sendMessage(QByteArray content,QString ip,QString port);
```
### 响应函数

void QQServer::registerRespond(QJsonObject obj,QHostAddress ip,quint16 port);

注册响应。将用户信息插入数据库，向客户端回传Json

void QQServer::loginRespond(QJsonObject obj,QHostAddress ip,quint16 port);

登录响应。登录后将当前用户的id，ip，port加入在线用户链表中，向客户端回传Json

void QQServer::sendToFriendRespond(QJsonObject obj,QHostAddress ip,quint16 port);

发消息响应。将用户的消息转发到目标客户端，同时将聊天记录插入数据库

## 数据库





