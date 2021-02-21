<template>
	<div class="modal">
		<div class="overlay"></div>
		<div class="form">
			<div class="input">
				<label>Tanggal</label>
				<input type="date" :class="{ 'error': error }" placeholder="Tanggal" v-model="date">
				<small v-if="error" class="error">Kosong</small>
			</div>
			<button class="submit" @click="submit">Simpan</button>
			<button class="close" @click="close">
				<svg class="icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
				</svg>
			</button>
		</div>
	</div>
</template>

<script>
	export default {
		props: ['close', 'save'],
		data() {
			return {
				date: '',
				error: false
			}
		},
		methods: {
			submit() {
				if (this.date === '') this.error = true
				else {
					this.save(this.date)
					this.close()
				}
			}
		}
	}
</script>