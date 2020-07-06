module.exports = {
  purge: [],
  theme: {
    boxShadow: {
      none: '0 0 0 0 #fff',
      default: '8px 8px 0 0 #32322F'
    },
    extend: {
      colors: {
        'white-fade': '#f6ebce',
        'blue-fade': '#8ECEC6',
        'black-fade': '#32322F',
        'yellow-fade': '#ebd5ab',
        'red-fade': '#B23434'
      },
      translate: {
        '-1/2': '-0.125em',
      }
    },
  },
  variants: {
    translate: ['responsive', 'hover', 'focus', 'active', 'group-hover']
  },
  plugins: [],
  important: true
}
