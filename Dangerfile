
if github.pr_body.length < 5
  fail "Please provide a summary in the Pull Request description"
end

warn("Big PR") if git.lines_of_code > 500
fail("Big PR") if git.lines_of_code > 1000

fail("fdescribe left in tests") if `grep -r fdescribe specs/ `.length > 1
fail("fit left in tests") if `grep -r fit specs/ `.length > 1

swiftlint.lint_files
swiftlint.lint_files inline_mode: true
