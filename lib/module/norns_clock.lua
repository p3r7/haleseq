-- haleseq. module/norns clock

local In = include("haleseq/lib/submodule/in")
local Out = include("haleseq/lib/submodule/out")

local paperface = include("haleseq/lib/paperface")
include("haleseq/lib/consts")


-- ------------------------------------------------------------------------

local NornsClock = {}
NornsClock.__index = NornsClock


-- ------------------------------------------------------------------------
-- constructors

function NornsClock.new()
  local p = setmetatable({}, NornsClock)

  p.kind = "norns_clock"
  p.id = "norns_clock"
  p.fqid = "norns_clock"

  p.ins = {}
  p.outs = {}
  p.i = In.new(p.fqid, p)
  p.o = Out.new(p.fqid, p)

  return p
end

function NornsClock.init(ins_map, outs_map)
  local c = NornsClock.new()

  if ins_map ~= nil then
    ins_map[c.i.id] = c.i
  end
  if outs_map ~= nil then
    outs_map[c.o.id] = c.o
  end

  return c
end

-- ------------------------------------------------------------------------
-- screen

function NornsClock.redraw(x, y, acum)
    -- local trig = (math.abs(os.clock() - last_mclock_tick_t) < PULSE_T)
  local trig = acum % (MCLOCK_DIVS / 4) == 0
  paperface.trig_out(x, y, trig)
  screen.move(x + SCREEN_STAGE_W + 2, y + SCREEN_STAGE_W - 2)
  screen.text(params:get("clock_tempo") .. " BPM ")
end

-- ------------------------------------------------------------------------

return NornsClock
