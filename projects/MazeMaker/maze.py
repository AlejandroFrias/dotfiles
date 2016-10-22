# coding=utf-8
import random

RIGHT = 0
DOWN = 1
UP = 2
LEFT = 3
DIRECTIONS = (RIGHT, DOWN, UP, LEFT)

cell2repr = {
    tuple(): '   ',
    (LEFT,): '━╸ ',
    (RIGHT,): ' ╺━',
    (UP,): ' ╹ ',
    (DOWN,): ' ╻ ',
    (RIGHT, LEFT): '━━━',
    (DOWN, UP): ' ┃ ',
    (UP, LEFT): '━┛ ',
    (DOWN, LEFT): '━┓ ',
    (RIGHT, UP): ' ┗━',
    (RIGHT, DOWN): ' ┏━',
    (RIGHT, DOWN, LEFT): '━┳━',
    (RIGHT, DOWN, UP): ' ┣━',
    (RIGHT, UP, LEFT): '━┻━',
    (DOWN, UP, LEFT): '━┫ ',
    (RIGHT, DOWN, UP, LEFT): '━╋━',
}


class Maze(object):
    def __init__(self, width, height):
        self.reset(width, height)

    def reset(self, width, height):
        self.width = width
        self.height = height
        self._empties = {
            (row, col) for row in range(height) for col in range(width)
        }
        self._maze = []
        for row in range(height):
            self._maze.append([set() for _ in range(width)])
        for col in range(width):
            self.update_cell(0, col, [LEFT, RIGHT])
            self.update_cell(height - 1, col, [LEFT, RIGHT])
        for row in range(height):
            self.update_cell(row, 0, [DOWN, UP])
            self.update_cell(row, width - 1, [DOWN, UP])
        self.set_cell(0, 0, [DOWN, RIGHT])
        self.set_cell(0, width - 1, [DOWN, LEFT])
        self.set_cell(height - 1, 0, [UP, RIGHT])
        self.set_cell(height - 1, width - 1, [UP, LEFT])

    def fill_maze(self):
        while self.empties():
            self.draw_random_line()

    def redraw(self):
        self.reset(self.width, self.height)
        self.fill_maze()
        print(str(self))

    def draw_random_line(self):
        point = random.choice(list(self.empties()))
        if point:
            row, col = point
            self.draw_line(row, col, random.choice(DIRECTIONS))

    def empties(self):
        return self._empties

    def draw_line(self, row, col, direction):
        opposite_dir = 3 - direction
        row_change = 0
        col_change = 0
        if direction == UP:
            row_change = -1
        elif direction == DOWN:
            row_change = 1
        elif direction == LEFT:
            col_change = -1
        elif direction == RIGHT:
            col_change = 1
        self.update_cell(row, col, [direction])
        row += row_change
        col += col_change
        while True:
            if self._maze[row][col]:
                self.update_cell(row, col, [opposite_dir])
                break
            else:
                self.update_cell(row, col, [direction, opposite_dir])
                row += row_change
                col += col_change

    def set_cell(self, row, col, values):
        assert values
        self._maze[row][col] = set(values)
        if (row, col) in self._empties:
            self._empties.remove((row, col))

    def update_cell(self, row, col, values):
        assert values
        self._maze[row][col].update(values)
        if (row, col) in self._empties:
            self._empties.remove((row, col))

    def get_cell(self, row, col):
        return tuple(sorted(self._maze[row][col]))

    def __str__(self):
        repr_rows = []
        for row in range(self.height):
            repr_row = []
            for col in range(self.width):
                repr_row.append(cell2repr[self.get_cell(row, col)])
            repr_rows.append(''.join(repr_row))
        return '\n'.join(repr_rows)
