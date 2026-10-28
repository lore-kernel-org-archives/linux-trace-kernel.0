Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148210;
	b=vFFGQt2t+XL3P+eG248KI7B2O3VJIZr/wsCpJXaiGf3OMPP67CZbg+jLFCN0kEiIgmdc
	 O0C31CIcUgCNhjyXmvwbp+yCs7LgI4uwrE6D29jUGZN9Ymy8xbbRU5uvCRWLApSb+HAFx
	 4rh8mTqJyxHGkpEgFw7CwTxjj2WnNXayxMnwi4bYuAHvCIn5glm/Kv5D3zZQi2unDwFPI
	 tHlWJZJWY/gxF70ldAMHZF8ch43pht6NppWyKW4H8IpLx/d/T/r2owB4j04c+bkqRPUK4
	 3wI65+8Lm8jPk9C+V8oP0Dn6zXIJLp2FEn45lI+VhbkyzEz70o+s7fjmiaJPWvSC4Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148210;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5tVgUGtk9UGck5ve+hDnUjG7SXGj3hc/B0cyug9XWzI=;
	b=OEwC6NDafsjsD75YaoBx158BXzxsbCRHOx+3V627V5o7NBhl10NKvueLMVbNfgcAKlWQ
	 yeGAuE2Y/dbMrTXPkfF8VNcAs2trmAS1w+nIOvkS1hyBv0vFndksvJ3UVavTJ6CP+Hl81
	 8dZRPuJv7mOgaSn9wkXwXveJB2KczDybJAa8r+8qhTXki5WaLtL/IwMXQ0lKzKNp8YFNb
	 G7Eax+qWGShh7XuXeBrHG9BMv1dBeqWqSAwSFLC793pTcVIDN2EaRxOGo/mg9AIhTWek6
	 itklHHU5fuwqArH16QOMxJwryrNv9JHuxbdwS8q14sDTRXF+YUZtbdvjlOvq4ZcgglA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMr+ksoW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1133606A31A;
	Wed, 28 Oct 2026 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMr+ksoW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6E61F01825;
	Wed, 28 Oct 2026 00:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148209;
	bh=5tVgUGtk9UGck5ve+hDnUjG7SXGj3hc/B0cyug9XWzI=;
	h=From:To:Cc:Subject:Date;
	b=RMr+ksoWbh3gnrbBoQaP2uHlWfQm63ilwvzB80kAE/j0tY4lTKobKbfeGLOUuEg9L
	 rRkPC3Fv18wg97sRVM/dNtELJ0milwyLp5/FidOxUF32B1ckTpUtfGA45s2/7eLFbI
	 uijAklCjjLF5nZsk/+niiL5btl7F25NTz6EfaHE+DM11oC/YNaROofTaf+rybPok/l
	 Af3uJ/V40cXasuoJULs12SGp2jOfqgCTbQ8AGoi5dpIdONFUZSXihquAmcirpkTEEI
	 nlXB2LzGHlc6S4UKuz9ixuRRRKjr87XibpCFNV7Sihcp4nT/+qRcvpwv7q4/dgX+oz
	 TI00q4uqGo0pw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 00/16] tracing/filters: Fix event filter parsing and matching bugs
Date: Wed, 28 Oct 2026 09:43:24 +0900
Message-ID: <179314820431.684037.4147763044424284198.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 3rd version of fixes for various bugs in the trace event
filter parser and predicate evaluation in kernel/trace/trace_events_filter.c,
along with a new ftracetest test case covering filter syntax checks.

The previous version is here:
 https://lore.kernel.org/all/179291742944.492959.11659339795290028998.stgit@devnote2

This version splitted some combined patches into dedicated patches, dropped a
wrong patch, and introduced 5 new patches to fix wrong error position reported
in error_log (this is required to fix syntax test failures).

Changes in v3:
[01/16]
 - Split zero-length string underflow and out-of-bounds fix from
   fixed-size string matching.
 - Return 0 immediately if "len <= r->len" in regex_match_end()
   without scanning the string.
[02/16]
 - Split from zero-length string fix into a dedicated patch.
 - Introduce regex_match_end_str() for fixed-size buffers and assign
   it in parse_pred() for FILTER_COMM and FILTER_STATIC_STRING, avoiding
   strnlen() overhead for dynamic and pointer strings in regex_match_end().
[06/16] ([05/09] in v2)
 - Check if str[i] is NUL immediately after skipping whitespace after
   the operator in parse_pred() across all event types, as suggested
   by Steven Rostedt.
[07/16] ([05/09] in v2)
 - Fix quoted operand parsing in function event filter.
 - Allow empty quoted operand ("") as valid syntax per Steven Rostedt.
[08/16] ([05/09] in v2)
 - Reject empty unquoted operands (!q && !len) in function events.
[09/16] ([05/09] in v2)
 - Reject stray quotes and '(' in unquoted function event operands.
([06/09] in v2)
 - Dropped.
[11/16]
 - Introduce filter_check_newline() to convert the first newline to
   NUL and reject any non-whitespace characters after the newline with
   an invalid input error (-EINVAL).
[12/16]
 - Group parser error position fixes targeting commit 80765597bc58 into
   a single patch: pass 'next - str' in predicate_parse(), pass
   'pos + field_pos' for FIELD_NOT_FOUND and IP_FIELD_ONLY, pass
   'pos + op_pos' for string/numeric operator validation and NOP checks,
   and update tracing-error-log.tc to match the corrected error position.
[13/16]
 - Newly added patch to fix error position for function filter
   operations targeting commit e6745a4da964, passing 'pos + fn_pos' for
   ILLEGAL_FIELD_OP and 'pos + op_pos' for INVALID_OP.
[14/16]
 - Group error position fixes for CPUS mask parsing targeting commits
   39f7c41c908b and 3cbec9d7b93d into a single patch: check 'str[i] != '{''
   before incrementing 'i', and pass 'pos + op_pos' for CPUS operator and
   comparison function selection checks.
[15/16]
 - Newly added patch to fix error position for within filter operator
   check targeting commit 7884b0bf098c, passing 'pos + op_pos' for
   GLOB_WITHIN.
[16/16]
 - Replace negated pipelines (! cmd) with explicit
   "if cmd; then exit_fail; fi" checks to properly catch unexpected success
   under POSIX sh with set -e, as pointed out by Sashiko.
 - Update expected error caret positions to reflect corrected 0-based
   indexing from predicate_parse(), FIELD_NOT_FOUND, operator checks,
   and CPUS brace checks.
 - Add test cases for empty strings, out-of-range CPU IDs, missing operands,
   empty operands, type mismatches, brace errors, function event filters
   (including INVALID_OP and ILLEGAL_FIELD_OP caret checks), and multi-line
   newline validation.

Summary of the patches:

- [01/16] Fix regex_match_end() for zero-length strings by returning 0
  immediately when "len <= r->len".
- [02/16] Introduce regex_match_end_str() with strnlen() for fixed-size
  string fields (FILTER_COMM, FILTER_STATIC_STRING) in parse_pred().
- [03/16] Fix process_system_preds() so that "fail" is only cleared when
  at least one event in the subsystem succeeds, and use
  delay_free_filter() when freeing replaced filters on error paths.
- [04/16] Return "pred->op == OP_NE" when "cpu >= nr_cpu_ids" in
  DEFINE_CPUMASK_COMPARISON_PRED so "!=" against a cpumask evaluates to
  true for out-of-range CPU numbers.
- [05/16] Ensure parse_error() is called on all -EINVAL error paths in
  parse_pred(), predicate_parse(), and process_preds() instead of
  leaving lasterr as 0 ("Error: (0)").
- [06/16] Check if str[i] is NUL immediately after operator whitespace
  in parse_pred() to prevent out-of-bounds reads on missing operands.
- [07/16] Fix quoted operand parsing in function event filters, check for
  missing quotes, and advance past closing quotes.
- [08/16] Reject empty unquoted operands in function event filters.
- [09/16] Reject stray quotes and '(' in unquoted function event operands.
- [10/16] Reject unsupported field sizes in parse_pred() when
  select_comparison_fn() or CPUS{} size matching leaves pred->fn_num as
  FILTER_PRED_FN_NOP, avoiding a kernel warning in update_pred_fn().
- [11/16] Convert the first newline to NUL and reject multi-line input
  containing non-whitespace characters after the newline in
  create_filter_start(), apply_event_filter(), and
  apply_subsystem_event_filter().
- [12/16] Fix parser error positions for base filter expressions
  (predicate_parse(), FIELD_NOT_FOUND, IP_FIELD_ONLY, string/numeric
  operators), and update tracing-error-log.tc.
- [13/16] Pass 'pos + fn_pos' for ILLEGAL_FIELD_OP and 'pos + op_pos' for
  INVALID_OP in function filter operations in parse_pred().
- [14/16] Pass 'pos + op_pos' for CPUS operator checks and check
  'str[i] != '{'' before incrementing 'i' for MISSING_BRACE_OPEN.
- [15/16] Pass 'pos + op_pos' for GLOB_WITHIN when '~' is used with a
  'within' filter.
- [16/16] Add filter-syntax-check.tc to ftrace selftests to test valid
  filters, syntax error diagnostics and caret positions, multi-line
  input validation, and subsystem filter error returns.

Notes:

- These bugs were identified and the fixes and cover letter were
prepared with the assistance of an LLM coding assistant.

Thank you,

---
base-commit: 1fdc4164e488916402badddbb1f51e9380dabb91

Masami Hiramatsu (Google) (16):
      tracing/filters: Fix regex_match_end() for zero-length strings
      tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
      tracing/filters: Fix false success return in process_system_preds()
      tracing/filters: Handle out-of-range CPU for OP_NE in cpumask comparison
      tracing/filters: Report parse error on all -EINVAL paths in filter parsing
      tracing/filters: Check for missing operand after operator in parse_pred()
      tracing/filters: Fix quoted operand parsing in function event filter
      tracing/filters: Reject empty unquoted operand in function event filter
      tracing/filters: Reject stray quotes and parentheses in unquoted function event operand
      tracing/filters: Reject unsupported field sizes in parse_pred()
      tracing/filters: Check for trailing characters after newline in filter string
      tracing/filters: Fix error positions in filter parser
      tracing/filters: Fix error position for function filter operations
      tracing/filters: Fix error positions for CPUS mask parsing
      tracing/filters: Fix error position for within filter operator check
      selftests/ftrace: Add event filter syntax check test case


 kernel/trace/trace_events_filter.c                 |  171 ++++++++++++++++----
 .../ftrace/test.d/filter/filter-syntax-check.tc    |  100 ++++++++++++
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |    2 
 3 files changed, 240 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
