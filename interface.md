# 接口文档
返回值加粗，其他正常。

## C++/QML交互函数

### QML发出的信号与C++槽函数（响应QML）

尽量用全局信号

**signal** loginSignal(int usrID,string usrPSW) //登录请求
**void** login(int id,QString password);

**signal** registerSignal(string usrName,string usrPassword) //注册请求
**void** registerAccount(QString user,QString password);

**signal** sendToFriendSignal(int targetId,string content,string time)//单发
**void** sendToFriend(int targetId,QString content,QString time);

**signal** sendToGroupSignal()//参数待商定
    
    
private:

### C++客户端响应函数与QML受控函数


