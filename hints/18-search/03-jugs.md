# Hint — 03-jugs

Pouring moves as much water as fits, so each direction splits into two cases.

For **A into B** (B holds 3): the room in B is `Room is 3 - B`.
- If `A =< Room`, everything in A pours across: the result is `s(0, B + A)`.
- If `A > Room`, only the room pours in: the result is `s(A - Room, 3)`.

Both cases need the preconditions that make the pour meaningful: `A > 0` (the
source has water) and `B < 3` (the target has room).

**B into A** is the mirror, but A holds **4**, so the room is `Room is 4 - A`
and the full target is `s(4, _)`.
