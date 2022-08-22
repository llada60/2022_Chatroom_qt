# 接口文档

## C++/QML交互函数

### QML发出的信号与C++槽函数（响应QML）

尽量用全局信号
```python
signal loginSignal(int usrID,string usrPSW)

void login(int id,QString password);

这一对信号和槽函数负责登录

signal registerSignal(string usrName,string usrPassword)

void registerAccount(QString user,QString password);

这一对信号和槽函数负责注册

signal sendToFriendSignal(int targetId,string content,string time)

void sendToFriend(int targetId,QString content,QString time);

这一对槽函数负责发送消息

signal sendToGroupSignal()//参数待商定
```
    
### C++客户端响应函数与QML受控函数


