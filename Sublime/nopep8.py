import sublime, sublime_plugin

class Nopep8Command(sublime_plugin.TextCommand):
    def run(self, edit):
        nopep8_comment = "  # nopep8"
        max_line_length = 79
        lines_with_text = []
        add_comment = False
        sels = self.view.sel()
        for sel in reversed(sels):
            regions = self.view.split_by_newlines(sel)
            lines = [self.view.line(region) for region in regions]
            for line in reversed(lines):
                text = self.view.substr(line)
                lines_with_text.append((line, text))

                if len(text) > max_line_length and text[-len(nopep8_comment):] != nopep8_comment:
                    add_comment = True


        for line, text in lines_with_text:
            if add_comment and len(text) > max_line_length and text[-len(nopep8_comment):] != nopep8_comment:
                self.view.insert(edit, line.end(), nopep8_comment)
            elif len(text) < max_line_length + len(nopep8_comment) and text[-len(nopep8_comment):] == nopep8_comment:
                self.view.erase(edit, sublime.Region(line.end() - len(nopep8_comment), line.end()))
            elif not add_comment and len(text) > max_line_length and text[-len(nopep8_comment):] == nopep8_comment:
                self.view.erase(edit, sublime.Region(line.end() - len(nopep8_comment), line.end()))
