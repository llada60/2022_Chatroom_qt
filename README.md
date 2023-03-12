# 2022_Chatroom_qt

### 1 Introduction

---

The purpose of this project is to design a chat software based on *QtQuick, QML, Qt, SQLite and cloud server*, which can provide remote communication with friends all over the world. 

It can be used in office, entertainment, daily life and other scenarios, and keep the information smooth at all times. In the project, we mainly learned from the relevant functions of QQ and Wechat for development.

### 2 Project Design

---

#### 2.1 Environment

**Client**: Windows/Linux/Mac

**Server**: Ubuntu 20.04 LTS

#### 2.2 Design Thought

The project is divided into **Client, Server** and **Database**. The Server is placed on the cloud server under Internet to achieve the purpose of public instant communication. With the Server as the center, the communication between the three parts is connected.

In the development process, the front and back end are seperated, and the corresponding interface functions and signals are written, and the connection adjustment is carried out at the end of the merger. This helps us develop independently, with clear division of labor and high efficiency.

The overall architecture of the project system and the contents under each architecture are shown below.

![image-20230312205417853](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312205417853.png)

 #### 2.3 Introduction of Module Function

**Client**:

1. **Login and registration**: Users log in with a new account and need to pass the email verification code; Or log in to an existing account.
2. **Home Page**: Users can switch to different functional modules or interfaces through various buttons on the main interface, including chat interface and friends/group chat list, and click the avatar to view the detailed information of corresponding users or groups.
3. **Chat Page**: Users can carry out private chat and group chat in this interface.
4. **Contact**: Users can view the list of friends/group chats in this interface, and click Chat to switch to the chat interface.
5. **Add Friends/group**: Users can search for the id of corresponding user/group chat to add new friends.
6. **Detailed of user/group**: Users can view detailed information of themselves, others or groups. In particular, users can modify their own details as well as the group information under which they are the host.
7. **Create group**: Users can apply to the server to create a group chat and return the group chat id to judge whether the group chat is created successfully.

**Server**:

1. **Login and registration response**: receive login and registration requests from clients, write user information to the database during registration, verify and compare with the database when logging in, and return whether the login is successful.
2. **Search information**: receives the search request from the client, obtains the search information from the server and returns it to the client according to different request types (search group or search user).
3. **Change information**: Receive personal and group information from the client and write it to the database to complete the update.
4. **Message transmission**: receives messages from clients, judges the nature of chat (private chat or group chat), forwards messages to target clients, and completes the storage of chat records to the database.
5. **Search response**: receives retrieval request from client, searches for group or user information with corresponding id in database, and returns search result to client.
6. **Add friends or group**: receives the information of adding friends or groups from the client, returns the information of adding success or failure to the client and updates the database.
7. **List refresh response**: receive server refresh request, analyze the nature of request (refresh friend list or group list), and return the latest information in the database to server.

#### 2.4 Module structure diagram

![image-20230312210839354](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312210839354.png)

#### 3 Display

1. Registration

![image-20230312211049754](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211049754.png)

2. Verification code sending

<img src="/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211223849.png" alt="image-20230312211223849" style="zoom:50%;" />

3. Login

![image-20230312211255732](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211255732.png)

4. Contact

![image-20230312211308344](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211308344.png)

5. Add friend/group

![image-20230312211748656](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211748656.png)

6. Add friend successfully

![image-20230312211754181](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211754181.png)

7. Chat page and history message (WAN, support offline information collection)

![image-20230312211803556](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211803556.png)

8. Group Chat

![image-20230312211808143](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211808143.png)

9. Sending emoji

![image-20230312211830776](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211830776.png)

10. Click the profile to view personal information

![image-20230312211841721](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211841721.png)

11. Personal information modification (The information shown can be modified, modify the birthday automatically calculate the age and zodiac. Avatar is optional)

![image-20230312211852457](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211852457.png)

![image-20230312211857005](/Users/ll/code/Qt/2022_Chatroom_qt/pic/image-20230312211857005.png)

