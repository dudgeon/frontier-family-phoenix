const [,, target] = process.argv
if (!target) {
  console.error('Usage: npm run gen:test <path>')
  process.exit(1)
}
console.log(`Generating test skeleton for ${target}`)
