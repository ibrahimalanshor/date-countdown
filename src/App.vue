<template>
  <div id="app">
    <div class="wrapper countdown">
      <div class="overlay"></div>
      <div class="relative">
        <div class="title">
          <span class="now">
            {{ now }}
          </span>
          <button class="edit" @click="open">
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
            </svg>
          </button>
        </div>
        <div class="box">
          <div class="count">
            <div class="number">
              <div>
                <span class="diff">{{ diff.days }}</span>
                Hari
              </div>
            </div>
          </div>
          <div class="count">
            <div class="number">
              <div>
                <span class="diff">{{ diff.hours }}</span>
                Jam
              </div>
            </div>
          </div>
          <div class="count">
            <div class="number">
              <div>
                <span class="diff">{{ diff.minutes }}</span>
                Menit
              </div>
            </div>
          </div>
          <div class="count">
            <div class="number last">
              <div>
                <span class="diff">{{ diff.seconds }}</span>
                Detik
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <edit :save="save" :close="close" v-if="edit" />
  </div>
</template>

<script>
  import Edit from '@/components/Edit'

  export default {
    components: {
      Edit,
    },
    data() {
      return {
        date: new Date('2021-05-13'),
        diff: {
          days: 0,
          hours: 0,
          minutes: 0,
          seconds: 0
        },
        countdown: null,
        edit: false
      }
    },
    computed: {
      now() {
        const month = ['Januari', 'Ferbuari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember']

        return `${this.date.getDate()} ${month[this.date.getMonth()]} ${this.date.getFullYear()}`
      }
    },
    methods: {
      start() {
        this.countdown = setInterval(() => {
          const diff = this.date.getTime() - new Date().getTime()

          if (diff < 0) {
            clearInterval(this.diff)
            this.diff = { days: 0, hours: 0, minutes: 0, seconds: 0 }
          } else {
            this.diff = {
              days: Math.floor(diff / (1000 * 60 * 60 * 24)),
              hours: Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)),
              minutes: Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60)),
              seconds: Math.floor((diff % (1000 * 60)) / 1000)
            }
          }

        }, 1000)
      },
      open() {
        this.edit = true
      },
      close() {
        this.edit = false
      },
      setDate(date) {
        this.date = date
      },
      getDate() {
        return new Promise(function (resolve, reject) {
          const countdown = JSON.parse(localStorage.getItem('countdown'))

          countdown ? resolve(new Date(countdown)) : reject()
        })
      },
      save(date) {
        this.setDate(new Date(date))
        this.store(date)
      },
      store(date) {
        localStorage.setItem('countdown', JSON.stringify(date))
      }
    },
    mounted() {
      this.getDate().then(res => {
        this.setDate(res)
      }).catch(() => {
        const date = new Date()
        date.setYear(date.getFullYear() + 1)
       
        this.setDate(date)
      }).finally(() => {
        this.start()
      })
    }
  }
</script>