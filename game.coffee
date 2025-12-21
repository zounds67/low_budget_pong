# ============================================
# PONG GAME
# A simple Pong game for learning to code!
# Fill in the ??? and YOUR CODE HERE sections!
# ============================================

# ============================================
# CONSTANTS - Fill in the values!
# ============================================

# Canvas size (how big is the game screen?)
CANVAS_WIDTH = ???   # HINT: Try 600-900
CANVAS_HEIGHT = ???  # HINT: Try 300-500

# Paddle settings (the things players move up and down)
PADDLE_WIDTH = ???   # HINT: Try 8-15
PADDLE_HEIGHT = ???  # HINT: Try 60-100
PADDLE_SPEED = ???   # HINT: Try 4-8 (how fast paddles move)

# Ball settings
BALL_SIZE = ???      # HINT: Try 8-15
BALL_SPEED = ???     # HINT: Try 3-7 (how fast ball moves)

# How many points to win the game
WINNING_SCORE = ???  # HINT: Try 3-10

# ============================================
# GAME VARIABLES - These values change during the game
# (Don't change this section!)
# ============================================

# The canvas and drawing context
canvas = null
ctx = null

# The ball's position and speed
ball =
  x: 0
  y: 0
  speedX: 0
  speedY: 0

# The left paddle's position (x is always 20)
leftPaddle =
  y: 0

# The right paddle's position (x is always CANVAS_WIDTH - 30)
rightPaddle =
  y: 0

# The scores for each player
leftScore = 0
rightScore = 0

# Track which keys are currently pressed
keysPressed = {}

# Is the game currently running?
gameRunning = false

# Audio context for sounds
audioContext = null

# ============================================
# SETUP FUNCTIONS (Don't change this section!)
# ============================================

# Set up the game - get the canvas and start listening for keys
setupGame = ->
  canvas = document.getElementById('gameCanvas')
  ctx = canvas.getContext('2d')

  # Set up audio for sound effects
  audioContext = new (window.AudioContext || window.webkitAudioContext)()

  # Listen for keyboard input
  document.addEventListener('keydown', handleKeyDown)
  document.addEventListener('keyup', handleKeyUp)

  # Put paddles in the middle
  leftPaddle.y = CANVAS_HEIGHT / 2 - PADDLE_HEIGHT / 2
  rightPaddle.y = CANVAS_HEIGHT / 2 - PADDLE_HEIGHT / 2

  # Reset the ball to the center
  resetBall()

  # Start the game loop
  gameLoop()

# ============================================
# DRAWING FUNCTIONS - Fill these in!
# ============================================

# Fill the whole screen with black
# HINT: Set ctx.fillStyle to 'black'
# HINT: Use ctx.fillRect(x, y, width, height) to fill the whole canvas
drawBackground = ->
  # YOUR CODE HERE

# Draw the ball as a white square at (ball.x, ball.y)
# HINT: Set ctx.fillStyle to 'white'
# HINT: Use ctx.fillRect(ball.x, ball.y, width, height)
drawBall = ->
  # YOUR CODE HERE

# Draw a paddle at position (x, y)
# HINT: Same pattern as drawBall
# HINT: Use PADDLE_WIDTH and PADDLE_HEIGHT for the size
drawPaddle = (x, y) ->
  # YOUR CODE HERE

# Draw both paddles on the screen
# HINT: Call drawPaddle twice - once for each paddle
# HINT: Left paddle is at x = 20, right paddle is at x = CANVAS_WIDTH - 30
drawPaddles = ->
  # YOUR CODE HERE

# Draw both players' scores at the top of the screen
# HINT: Set ctx.fillStyle, ctx.font = '48px Arial', ctx.textAlign = 'center'
# HINT: Use ctx.fillText(text, x, y) to draw text
# HINT: Left score at x = CANVAS_WIDTH / 4, right at x = CANVAS_WIDTH * 3 / 4
drawScore = ->
  # YOUR CODE HERE

# Draw a dashed line down the center (Don't change this!)
drawCenterLine = ->
  ctx.strokeStyle = 'white'
  ctx.lineWidth = 2
  ctx.setLineDash([10, 10])
  ctx.beginPath()
  ctx.moveTo(CANVAS_WIDTH / 2, 0)
  ctx.lineTo(CANVAS_WIDTH / 2, CANVAS_HEIGHT)
  ctx.stroke()
  ctx.setLineDash([])

# Draw a message in the center (Don't change this!)
drawMessage = (text) ->
  ctx.fillStyle = 'white'
  ctx.font = '32px Arial'
  ctx.textAlign = 'center'
  ctx.fillText(text, CANVAS_WIDTH / 2, CANVAS_HEIGHT / 2)

# ============================================
# SOUND FUNCTIONS (Don't change this section!)
# ============================================

playSound = (frequency, duration) ->
  if audioContext
    oscillator = audioContext.createOscillator()
    gainNode = audioContext.createGain()
    oscillator.connect(gainNode)
    gainNode.connect(audioContext.destination)
    oscillator.frequency.value = frequency
    oscillator.type = 'square'
    gainNode.gain.value = 0.1
    oscillator.start()
    oscillator.stop(audioContext.currentTime + duration)

playPaddleHitSound = ->
  playSound(440, 0.1)

playWallBounceSound = ->
  playSound(220, 0.1)

playScoreSound = ->
  playSound(330, 0.3)

# ============================================
# MOVEMENT FUNCTIONS - Fill these in!
# ============================================

# Move the ball by adding its speed to its position
# HINT: ball.x = ball.x + ball.speedX
# HINT: Do the same for y
moveBall = ->
  # YOUR CODE HERE

# Move left paddle when W or S is pressed
# HINT: Check if keysPressed['w'] or keysPressed['W'] is true
# HINT: If W pressed, subtract PADDLE_SPEED from leftPaddle.y (up)
# HINT: If S pressed, add PADDLE_SPEED to leftPaddle.y (down)
# HINT: Call keepPaddleOnScreen(leftPaddle) at the end
moveLeftPaddle = ->
  # YOUR CODE HERE

# Move right paddle when Arrow keys are pressed
# HINT: Check keysPressed['ArrowUp'] and keysPressed['ArrowDown']
# HINT: Same pattern as moveLeftPaddle but for rightPaddle
moveRightPaddle = ->
  # YOUR CODE HERE

# Don't let the paddle go off the screen
# HINT: If paddle.y < 0, set paddle.y = 0 (top edge)
# HINT: If paddle.y > CANVAS_HEIGHT - PADDLE_HEIGHT, fix it (bottom edge)
keepPaddleOnScreen = (paddle) ->
  # YOUR CODE HERE

# ============================================
# COLLISION FUNCTIONS - Fill these in!
# ============================================

# Bounce the ball off the top and bottom walls
# HINT: If ball.y <= 0, the ball hit the top wall
# HINT: If ball.y >= CANVAS_HEIGHT - BALL_SIZE, hit the bottom
# HINT: To bounce, reverse the direction: ball.speedY = -ball.speedY
# HINT: Call playWallBounceSound() when it bounces
checkWallCollision = ->
  # YOUR CODE HERE

# Bounce the ball off the paddles (this one is tricky!)
# HINT: Left paddle is at x = 20, right paddle is at x = CANVAS_WIDTH - 30
# HINT: Check if ball's x position is near the paddle
# HINT: Check if ball's y position overlaps with the paddle's y
# HINT: If both are true, reverse ball.speedX and call playPaddleHitSound()
checkPaddleCollision = ->
  # YOUR CODE HERE

# Check if ball went off left or right side (someone scored!)
# HINT: If ball.x < 0, the ball went off the left - right player scores!
# HINT: If ball.x > CANVAS_WIDTH, left player scores!
# HINT: Add 1 to the winner's score
# HINT: Call playScoreSound(), resetBall(), and checkWinner()
checkScoring = ->
  # YOUR CODE HERE

# Check if someone won the game
# HINT: If leftScore >= WINNING_SCORE, set gameRunning = false
# HINT: Same check for rightScore
checkWinner = ->
  # YOUR CODE HERE

# ============================================
# RESET FUNCTIONS - Fill these in!
# ============================================

# Put the ball back in the center with a random direction
# HINT: Set ball.x to center: CANVAS_WIDTH / 2 - BALL_SIZE / 2
# HINT: Set ball.y to center: CANVAS_HEIGHT / 2 - BALL_SIZE / 2
# HINT: Use Math.random() < 0.5 to randomly pick left or right
# HINT: Set ball.speedX to BALL_SPEED or -BALL_SPEED
# HINT: Set ball.speedY to a random value for angle
resetBall = ->
  # YOUR CODE HERE

# Start a fresh game
# HINT: Set leftScore = 0 and rightScore = 0
# HINT: Call resetBall() to center the ball
# HINT: Put both paddles in the middle (CANVAS_HEIGHT / 2 - PADDLE_HEIGHT / 2)
# HINT: Set gameRunning = true
startNewGame = ->
  # YOUR CODE HERE

# ============================================
# INPUT HANDLING (Don't change this section!)
# ============================================

handleKeyDown = (event) ->
  keysPressed[event.key] = true
  if event.key == ' '
    if not gameRunning
      startNewGame()

handleKeyUp = (event) ->
  keysPressed[event.key] = false

# ============================================
# MAIN GAME LOOP (Don't change this section!)
# ============================================

update = ->
  if gameRunning
    moveBall()
    moveLeftPaddle()
    moveRightPaddle()
    checkWallCollision()
    checkPaddleCollision()
    checkScoring()

draw = ->
  drawBackground()
  drawCenterLine()
  drawScore()
  drawPaddles()
  drawBall()

  if not gameRunning
    if leftScore >= WINNING_SCORE
      drawMessage('Left Player Wins! Press SPACE to play again')
    else if rightScore >= WINNING_SCORE
      drawMessage('Right Player Wins! Press SPACE to play again')
    else
      drawMessage('Press SPACE to start')

gameLoop = ->
  update()
  draw()
  requestAnimationFrame(gameLoop)

# ============================================
# START THE GAME!
# ============================================

setupGame()
