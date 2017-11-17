RA = Retronator.Accounts
RS = Retronator.Store

RS.Pages.Admin.Patreon.updateCurrentPledges.method ->
  RA.authorizeAdmin()
  RA.Patreon.updateCurrentPledges()

RS.Pages.Admin.Patreon.importPledges.method (date, csvData) ->
  check date, Date
  check csvData, String

  RA.authorizeAdmin()

  lines = csvData.match /[^\r\n]+/g
  console.log "Importing", lines.length - 1, "pledges …"

  # Create a regex that matches commas, but not inside quoted strings.
  commaRegex = /,(?=(?:(?:[^\"]*\"){2})*[^\"]*$)/

  # Create a map of data columns to indices. Possible parts are:
  #   FirstName,LastName,Email,Pledge,Lifetime,Status,Twitter,Street,City,State,Zip,Country,Start,MaxAmount,Complete
  parts = lines[0].split commaRegex

  columnIndices = {}

  for index in [0...parts.length]
    columnIndices[parts[index]] = index

  # Now create a pledge for each remaining line using the column mapping.
  pledgesCreated = 0
  pledgesUpdated = 0

  for line in lines[1..]
    parts = line.split commaRegex

    # Strip double quotes from strings.
    parts = _.map parts, (part) -> part.replace(/^"(.*)"$/, '$1')

    # Convert parts to payments.
    email = parts[columnIndices['Email']]
    amount = parseFloat parts[columnIndices['Pledge']]
    return unless email and not _.isNaN amount

    existingPledgeTransaction = RS.Transaction.documents.findOne
      time: date
      email: email
      payments:
        $elemMatch:
          type: RS.Payment.Types.PatreonPledge
          authorizedOnly:
            $ne: true

    if existingPledgeTransaction
      pledgesUpdated++
      paymentId = existingPledgeTransaction.payments[0]._id

    else
      pledgesCreated++

      # Create transaction and payment for this patron.
      paymentId = RS.Payment.documents.insert
        type: RS.Payment.Types.PatreonPledge
        patronEmail: email

      RS.Transaction.documents.insert
        time: date
        email: email
        payments: [{_id: paymentId}]

    # Update payment.
    RS.Payment.documents.update paymentId,
      $set:
        amount: amount

  console.log "Successfully created", pledgesCreated, "and updated", pledgesUpdated , "pledges."