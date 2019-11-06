<template>
	<div>
		<div class="container">
   <div class="row justify-content-center">

<div id="frame">
    <div id="sidepanel">
        <div id="profile">
            <div class="wrap">
                <img id="profile-img" src="images/from.png" class="online" alt="" />
                <p>{{ authuser.name }}</p>
                <i class="fa fa-chevron-down expand-button" aria-hidden="true"></i>
                <div id="status-options">
                    <ul>
                        <li id="status-online" class="active"><span class="status-circle"></span> <p>Online</p></li>
                        <li id="status-away"><span class="status-circle"></span> <p>Away</p></li>
                        <li id="status-busy"><span class="status-circle"></span> <p>Busy</p></li>
                        <li id="status-offline"><span class="status-circle"></span> <p>Offline</p></li>
                    </ul>
                </div>
                <div id="expanded">
                    <label for="twitter"><i class="fa fa-facebook fa-fw" aria-hidden="true"></i></label>
                    <input name="twitter" type="text" value="mikeross" />
                    <label for="twitter"><i class="fa fa-twitter fa-fw" aria-hidden="true"></i></label>
                    <input name="twitter" type="text" value="ross81" />
                    <label for="twitter"><i class="fa fa-instagram fa-fw" aria-hidden="true"></i></label>
                    <input name="twitter" type="text" value="mike.ross" />
                </div>
            </div>
        </div>
        <div id="search">
            <label for=""><i class="fa fa-search" aria-hidden="true"></i></label>
            <input type="text" placeholder="Search contacts..." v-model="searchuser"/>
        </div>
        <div id="contacts">
            <ul>
               
                <li class="contact" v-for="user in filtersearch" @click.prevent="selectUser(user.id)">
                    <div class="wrap">

                        <span class="contact-status online" v-if="onlineUser(user.id) || online.id == user.id"></span>
                        <!-- <span class="contact-status offline" v-if="offline.id == user.id"></span> -->
                        <span class="contact-status offline" v-else></span>

                        <img src="images/to.png" alt="" />
                        <div class="meta">
                            <p class="name">{{ user.name }}</p>
                            <p class="preview">Wrong. You take the gun, or you pull out a bigger one. Or, you call their bluff. Or, you do any one of a hundred and forty six other things.</p>
                        </div>
                    </div>
                </li>
               
            </ul>
        </div>
        <div id="bottom-bar">
            <button id="addcontact"><i class="fa fa-user-plus fa-fw" aria-hidden="true"></i> <span>Add contact</span></button>
            <button id="settings"><i class="fa fa-cog fa-fw" aria-hidden="true"></i> <span>Settings</span></button>
        </div>
    </div>
    <div class="content">
        <div class="contact-profile">
            <img src="images/to.png" alt="" />
            <p v-if="userMessage.user">{{ userMessage.user.name }}</p>
            <div class="social-media">
                <i class="fa fa-facebook" aria-hidden="true"></i>
                <i class="fa fa-twitter" aria-hidden="true"></i>
                 <i class="fa fa-instagram" aria-hidden="true"></i>
            </div>
        </div>
        <div class="messages" v-chat-scroll="{always: false, smooth: true, scrollonremoved:true}" >
            <ul >    <!-- sent/replies -->
                <li :class="`${message.user.id == userMessage.user.id ? 'sent' : 'replies'}`" v-for="message in userMessage.message">
                    <img :src="`${message.user.id == userMessage.user.id ? 'images/to.png' : 'images/from.png'}`" alt="" :title="message.user.name " />
                    <p :title="message.created_at | timeformate">{{ message.message}}</p>

                </li>
                
               
            </ul>
        </div>
        <div class="message-input">
            <p style="text-align: center; margin-bottom: 15px" v-if="typing"><span>{{ typing }} is typing<span><img width="25" src="images/typing.gif"></span></span></p>
            <div class="wrap">
            <input v-if="userMessage.user"  @keydown.enter="sendMessage" @keydown="typingEvent(userMessage.user)" v-model="message" type="text" placeholder="Write your message..." />
            <input v-else @keydown.enter="sendMessage" v-model="message" type="text" disabled="" placeholder="Select a User..." />
            
            <i class="fa fa-paperclip attachment" aria-hidden="true"></i>
            <button class="submit" @click.prevent="sendMessage"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
            </div>
        </div>
    </div>
</div>


    </div>
</div>
	</div>
</template>

<script>

    import _ from 'lodash'

	export default{

        name: 'ChatApp',
        data(){
            return{

                searchuser: "",
                message: "",
                authuser: "",
                typing: '',
                users: [],
                online: '',
                offline: ''

            }
        },

        mounted(){

            this.firstselectuser();

            this.authuser = authuser;  //this auth user from app.blade,php


            Echo.private(`chat.${authuser.id}`)
                .listen('MessageSend', (e) => {
                   this.selectUser(e.message.from);
                    /*console.log(e.message.message);*/
                });


            Echo.private('typingevent')
                .listenForWhisper('typing', (e) => {

                if ((e.user.id == this.userMessage.user.id) /*&& (e.userId == authuser.id)*/) {
                        this.typing = e.user.name;

                        setTimeout(()=>{
                        this.typing="";
                    }, 10000)

                    }
                
            });


             Echo.join('liveuser')
                .here((users) => {
                    this.users = users;
                })
                .joining((user) => {
                    this.online = user;
                })
                .leaving((user) => {
                    this.offline = user;
                });



            this.$store.dispatch('userList');

        },

        created(){

           
        },

        computed:{

            userList(){
                return this.$store.getters.getUserLIst;

            },

            filtersearch(){
               return this.userList.filter(user=>{
                  return user.name.match(this.searchuser);
                });
            },

            userMessage(){
                return this.$store.getters.userMessage;
            },

          },

        methods:{

            firstselectuser(){
                axios.get('/lastuserlist')
                .then(response=>{
                    this.$store.dispatch('userMessage', response.data.id);
                })
                
            },

            selectUser(userid){
                this.$store.dispatch('userMessage', userid);

            },

            sendMessage(){
               /* e.preventDefault();*/

                if (this.message != '') {
                    axios.post('/sendmessage', {message: this.message, user_id: this.userMessage.user.id})
                    .then(response=>{
                        this.selectUser(this.userMessage.user.id);
                    })
                    this.message = "";
                }
            },

            typingEvent(userId){

               Echo.private('typingevent')
                .whisper('typing', {
                    'user': authuser, //who send msg
                    'typing' : this.message,
                    'userId' : userId //who reciev msg 

                });
            },

            onlineUser(userid){
                return _.find(this.users, {'id': userid });
            }

        }

	}
</script>