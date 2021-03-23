<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fomantic-ui/2.8.7/semantic.min.css" />
    <title>Document</title>
</head>
<body>
<div class="ui container">
<p>
Sockets on /sock <a href="/sock">Socket Page</a><br>
Queue on /view-queue
</p>
<div class="ui two column grid">

    <div class="column">
        <form class="ui form", action="/audiofile" method="POST">
            <div class="ui segment very padded">
                <div class="field">
                    <label>Text</label>
                    <input type="text" name="text"  placeholder="Stuff to say">
                  </div>

            
                  <div>
                    <button class="ui primary fluid button" type="submit">GO</button>
                  </div>
            </form>
            <div class="ui hidden divider"></div>
            <img class="ui centered large image" src="https://i.imgur.com/yXUaqz2.png" alt="" srcset="">
            <a href="/view-queue">View audio files</a>
    </div>
    

</div>
</div>
      
</div>
</body>
</html>
