export default{

	state: {
	    userList: [],
	    usermessage: [],
	  },

	getters:{

		getUserLIst:state=>{
			return state.userList;
		},

		userMessage:state=>{
			return state.usermessage;
		}

	  },
	mutations: {
	    
	    setUserList(state, payload){
	    	state.userList = payload;
	    },

	    userMessage(state, payload){
	    	state.usermessage = payload;
	    }
	  },

	actions:{


		userList(context){
			axios.get('/userlist')
			.then(response=>{
				context.commit("setUserList", response.data);
			})
		},

		userMessage(context, payload){
			axios.get('/usermessage/'+payload)
			.then(response=>{
				context.commit("userMessage", response.data);
			})
		}

	  }
}