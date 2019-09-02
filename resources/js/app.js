require('./bootstrap');

window.Vue = require('vue');

import Vuex from 'vuex'
import Store from './store/index'
import filter from './filter'

Vue.use(Vuex)
const store = new Vuex.Store(Store)

Vue.component('main-app', require('./components/MainApp.vue').default);


const app = new Vue({
    el: '#app',
    store
});
