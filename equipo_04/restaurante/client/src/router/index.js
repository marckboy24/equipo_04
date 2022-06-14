import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: () => import('../views/HomeView.vue')
  },
  {
    path: '/clientes',
    name: 'clientes',
    component: () => import('../views/ClientesView.vue')

  },
  {
    path: '/mesa',
    name: 'mesa',
    component: () => import('../views/MesaView.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
