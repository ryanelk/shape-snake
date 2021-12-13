pico-8 cartridge // http://www.pico-8.com
version 0
__lua__
-- shape snake
-- by ampersands

game = {}
p    = {}
os   = {}

function _init()
 game_init()
 player_init()
end

function game_init()
 game.state="title"
 game.frm=0
 game.speed=1
 game.col=init_col()
 game.frm_rate=60
 game.limit=100
 map(0,0)
 palt(8,true)
 palt(0,true)
end

function level_init()
 game.state="level"
 game.frm=0
 game.speed=1
 game.col=init_col()
 game.frm_rate=60
 game.limit=100
 map(0,0)
 palt(8,true)
 palt(0,true)
end

function _update60()
 game.frm+=1
 if (game.state=="title") then
  title_update()
  player_update()
  env_update()
 elseif (game.state=="init") then
  player_update()
  enemy_update()
  env_update()
 elseif (game.state=="play") then
  player_update()
  enemy_update()
  env_update()
 elseif (game.state=="end") then
  env_update()
  enemy_update()
  end_update()
 end
end

function _draw()
 cls()
 if (game.state=="title") then
  title_draw()
  env_draw()
  player_draw()
 elseif (game.state=="init") then
  env_draw()
  enemy_draw()
  player_draw()
 elseif (game.state=="play") then
  env_draw()
  enemy_draw()
  player_draw()
 elseif (game.state=="end") then
  env_draw()
  enemy_draw()
  end_draw()
 end
end
-->8
-- title, init, end

function title_update()

end

function title_draw()

end

function init_update()

end

function init_draw()

end

function end_update()
 if (btnp(⬆️)) then
  reset()
 end

end

function end_draw()

end

function reset()
 game_init()
 player_init()
 es={}
 
 game.state="init"
end
-->8
-- draw library

-- player draw
function player_draw()
 pal()
 pal(7,p.col[7])
 spr(1,p.x,p.y)
 pal()
 pal(8,p.col[6])
 spr(3,p.x,p.y)
 pal()
 pal(8,p.col[4])
 spr(4,p.x,p.y)
 pal()
 pal(8,p.col[2])
 spr(5,p.x,p.y)
 
 -- fill corrupted sprites
 if (p.corrupted) then
  -- calculate spr
  cor_frm=corrupt_frame()
  if (cor_frm>0) then
   pal()
   pal(8,p.col[5])
   spr3=p.spr_lrg[cor_frm]
   spr(spr3,p.x,p.y)
   pal()
   pal(8,p.col[3])
   spr2=p.spr_med[cor_frm]
   spr(spr2,p.x,p.y)
   pal()
   pal(8,p.col[1])
   spr1=p.spr_sml[cor_frm]
   spr(spr1,p.x,p.y)
   
  end
 end
end
-->8
-- misc functions

function calc_dist2(x1,y1,x2,y2)
 local x_sqr=x2-x1
 local y_sqr=y2-y1
 return x_sqr*x_sqr+y_sqr*y_sqr
end

function calc_side(r, n)
 return 2 * r * sin(0.5/n)
end

function calc_rotation(n)
 return 0.5 * (1 + 1/n)
end

function calc_direction(x, n)
 return (x + calc_rotation(n)) % 2
end

function init_col()
 col_tbl = {}
 for i=1,12 do add(col_tbl,i)
 end
 del(col_tbl,7)
 del(col_tbl,8)
 return shuffle(col_tbl)
end

function shuffle(tbl)
 for i=#tbl, 2, -1 do
  local j = flr(rnd(i))+1
  tbl[i],tbl[j]=tbl[j],tbl[i]
 end
 return tbl
end

function bound_collide(p)
 return p.xy[0]>121 or p.xy[0]<-1 or p.xy[1]>121 or p.xy[1]<-1
end

-- memoize against seen array
function self_collide(p)
 if (p.seen[p.xy[0]][p.xy[1]]) then
  return true
 else
  p.seen[p.xy[0]][p.xy[1]]] = true
  return false
end

function collide(p)
 return bound_collide(p) and self_collide(p)
end

function set_quadrant(o,p)
 if (p.x<60) then o.x=60
 else o.x=30 
 end
 if (p.y<60) then o.y=60
 else o.y=30
 end 
end

function check_corrupt(obj,o_col)
 for x=1,#obj.col-1 do
  if (obj.col[x]!=o_col) then
   return false
  end
 end
 return true
end

function corrupt_frame()
 count=game.frm%game.frm_rate*2 
 if (count<game.frm_rate/2) then
  return 1
 else
  return 2
 end
end
-->8
-- player

-- dir true = clockwise, false = counter-cw
-- shape 0 = circle, 1 = ellipse, 2 = polygon (num points generated)
function player_init()
 p.turns=0
 p.dist=0
 p.dir=true
 p.shape=0
 p.xy=calc_spawn()
 p.nxy=p.xy
 p.col={0}
 p.spd=32
 p.w=6
 p.h=6
 p.acc=1
 p.drg=0.01
 p.spr={6,7}
 p.seen={}
end

function calc_spawn()
 return {60, 60}
end

function player_move()
 -- get remaining side length
 -- if no more side
  -- get new direction
 -- calculate step size
 -- move in that direction 
end

function player_update()
 if (btn(⬅️)) then
    p.turn+=1
    p.dir = not p.dir
 end

 local player_hit=collide()
 if (player_hit or p.turn > limit) then
  game.state="end"
 else
  player_move()
  check_win()
 end
end



-->8

function env_update()
 // increase rad of circle
 foreach(os,o_update)
 // remove 2big circles & spwn
 foreach(os,o_chk)
 
 if (#os<1) init_oasis()
end

function env_draw()
 foreach(os, o_draw)
end

function init_oasis()
 local o = {}
 set_quadrant(o,p)
 o.x=flr(rnd(30))+o.x
 o.y=flr(rnd(30))+o.y
 o.rad=1
 o.grow=.3
 o.col=game.col[1]
 o.s_anim=100
 o.s_anim_spd=6
 o.s_rad=0
 o.active=true
 add(os,o)
end

function o_draw(o)
 if (o.s_anim > 0) then
  circfill(o.x,o.y,o.s_rad,o.col)
 else
  circfill(o.x,o.y,o.rad,o.col)
 end
end

function o_update(o)
 if (o.s_anim > 0) then
  o.s_anim-=1
  if (o.s_anim%o.s_anim_spd==1) then
   o.s_rad=o.s_anim%5
  end
 else
  o.rad+=o.grow*game.speed
 end
end

function o_chk(o)
 if (o.rad>140 and o.active) then
  game.speed+=.05
  del(game.col,o.col)
  o.active=false
  init_oasis()
  add(game.col,o.col)
 end
 if (o.rad>400 and not o.active) then
  del(os,o)
 end
 
end
__gfx__
00000000007777007700007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070000707000000700888800000000000000000000000000000000000000000000000000000808000080800000000000000000000000000000000000
00700700700000070000000008888880008888000000000000000000000000000008080000808000008888800888880000000000000000000000000000000000
00077000700000070000000008888880008888000008800000008000000800000088800000088800088888000088888000000000000000000000000000000000
00077000700000070000000008888880008888000008800000080000000080000008880000888000008888800888880000000000000000000000000000000000
00700700700000070000000008888880008888000000000000000000000000000080800000080800088888000088888000000000000000000000000000000000
00000000070000707000000700888800000000000000000000000000000000000000000000000000008080000008080000000000000000000000000000000000
00000000007777007700007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
