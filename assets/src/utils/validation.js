export const validationRegs = {
  number: /^[0-9]*$/,
  string: /^[\u0400-\u04FF'-]+$/,
  maxLength: /^.{1,10}$/
}

export const validationErrorMessages = {
  lettersOnly: 'Толькі літары, апостраф ці злучок.',
  numbersOnly: 'Толькі лічбы.',
  excludesLength: 'Не больш за 10 літар.'
}

export const formValidationPattern = {
  startsWith: [{ pattern: validationRegs.string, message: validationErrorMessages.lettersOnly }],
  endsWith: [{ pattern: validationRegs.string, message: validationErrorMessages.lettersOnly }],
  contains: [{ pattern: validationRegs.string, message: validationErrorMessages.lettersOnly }],
  length: [{ pattern: validationRegs.number, message: validationErrorMessages.numbersOnly }],
  containsLetters: [{ pattern: validationRegs.string, message: validationErrorMessages.lettersOnly }],
  excludesLetters: [
    { pattern: validationRegs.string, message: validationErrorMessages.lettersOnly },
    { pattern: validationRegs.maxLength, message: validationErrorMessages.excludesLength }
  ],
}

export const searchValidationPattern = {
  allowedSpaces: 3
}
