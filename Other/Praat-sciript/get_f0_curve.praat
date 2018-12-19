
#get the numeber of all sound files
#http://www.hejingzong.cn/blog/viewblog_48.aspx

numberOfSounds = numberOfSelected  ("Sound")

#set up arrays with names and IDs of selected Sounds
#this is necessary because vtchange changes the selections

for ifile from 1 to numberOfSounds
   sound$ = selected$  ("Sound", 'ifile')
   soundID = selected  ("Sound", 'ifile')
   ids'ifile' = soundID
   names'ifile'$ = sound$
endfor

#now get down to business
for ifile from 1 to numberOfSounds
   soundID = ids'ifile'
   sound$ = names'ifile'$
   call fodurnchange
endfor

#sub-function

procedure fodurnchange
select Sound 'sound$'
start = Get start time
end = Get end time
To Manipulation: 0.01, 75, 600
Extract pitch tier
for p from 0 to 9
   currentTime = start + ((end-start)/9)*p
   pitch = Get value at time: currentTime
   print 'pitch:0'
   if p < 9
      printtab
   endif
endfor
#one line one subject
appendInfo: pitch,newline$
endproc


