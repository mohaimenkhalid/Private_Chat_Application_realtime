<template>
	<div>
		<div class="container">
   <div class="row justify-content-center">

<div id="frame">
    <div id="sidepanel">
        <div id="profile">
            <div class="wrap">
                <img id="profile-img" src="images/from.png" class="online" alt="" />
                <p>Mike Ross</p>
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
                        <span class="contact-status busy"></span>
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
            <div class="wrap">
            <input  @keydown.enter="sendMessage" v-model="message" type="text" placeholder="Write your message..." />
            <i class="fa fa-paperclip attachment" aria-hidden="true"></i>
            <button class="submit"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
            </div>
        </div>
    </div>
</div>


    </div>
</div>
	</div>
</template>

<script>
	export default{

        name: 'ChatApp',
        data(){
            return{

                searchuser: "",
                message: ""

            }
        },

        mounted(){

            Echo.private(`chat.${authuser.id}`)
                .listen('MessageSend', (e) => {
                   this.selectUser(e.message.from);
                    /*console.log(e.message.message);*/
                });


            this.$store.dispatch('userList');

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

        created(){

        },

        methods:{

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
            }

        }

	}
</script>