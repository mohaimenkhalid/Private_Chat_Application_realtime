export default{

	state: {
	    userList: [],
	  },

	getters:{

		getUserLIst:state=>{
			return state.userList;
		}

	  },
	mutations: {
	    
	    setUserList(state, payload){
	    	state.userList = payload;
	    }
	  },

	actions:{


		userList(context){
			axios.get('api/userlist')
			.then(response=>{
				context.commit("setUserList", response.data);
			})
		}

	  }
}