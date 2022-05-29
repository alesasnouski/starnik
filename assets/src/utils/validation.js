export const validationRegs = {
  number: /^[0-9]*$/,
  string: /^[A-Za-z '-]+$/
}

export const formValidationPattern = {
  startsWith: validationRegs.string,
  endsWith: validationRegs.string,
  contains: validationRegs.string,
  length: validationRegs.number,
  containsLetters: validationRegs.string,
  excludesLetters: validationRegs.string,
}
