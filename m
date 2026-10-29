Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237850;
	b=F0jltZEyIUEnsmem0jbsHwTPGSAgPuTj/2LUwu1EVgWG77A48eV8PjOWJ2ou9ql0if9C
	 zLnzJjj2YB9xcHE3Kf+v/2BUyfbLYSRgEEeog9HzW7jOaI/XnaZ+fxzVYzrg66RDDHYFI
	 LC+aODIXVodQp32B1gMxlalP3DNxcjc9DnVYMkxOrYoJfQbQd5YShgbA/joej0S5nHeQW
	 MLjvMWqJzXELgQ6OJtjM9s2m2X6+/atQYeTxwXnjym/0LnQ6OtT/iDNdXEkaZblG9Bier
	 fuB5S61ZXSXcm/wjb2fjenYW7F2+HpQPRK1noGxWFZ3IGJxegW7vvYY8V+FbQhLr+qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xvU3H0FSV6/NrrW+yhwNygjcSR4mNQwktBgxwlF2Pr8=;
	b=WAr5geuoe9v/3ALdWTaj7oTzRdLaEIygfhHof+CU2ILXofNNoa2pNuIaRdF/aAbzLYPo
	 lDRlrwEVHV+LlWjMJ2KTUcuMlT4ZBcySdhRANJK/HFVWcKubRma6jFp2nEX2t3z2V4vo/
	 NmsRPEJRq/D+wgFJ18BJsoxaGxz8MNsKGXMKYd1mJ1EJedZX+zFGOg62DG4EflsmRQndL
	 1+aW6NfoSj3hFOSBOpvP6CVVGInkpZyQjptyr2ygJYjTAYPNbGAWam8dH9rZwBHkBc0rx
	 TvY+e5HVzxtRdEu+EaHHbW9P7q/U0UGIjPzhuKJK7W9nnAfAV/8SN5wJo+K6cPkjfeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ji34zmTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28E606A31A;
	Thu, 29 Oct 2026 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ji34zmTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E841F01825;
	Thu, 29 Oct 2026 01:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237849;
	bh=xvU3H0FSV6/NrrW+yhwNygjcSR4mNQwktBgxwlF2Pr8=;
	h=From:To:Cc:Subject:Date;
	b=ji34zmTS+n30tri4UBu5EvGb3ObnjHCuwWwVD8Y75cCmo7Wfb1+fQPdYZQ0nNIl8z
	 BesVJuH4Lp9jTS7fcdPXh7IuoFspAXQGDhx0ajiCbwuyMOYsNgsgMXLxD2fBevPfZM
	 pPvdQn7MZ3atECHL+2jPQSST++pbP4CBRAj56EAvctVwZAX/F9Ns1V1bjRpZgSfJ8I
	 zssDDeU98x98bQHZhhRc7UxjVoasUOKl+oKHGHjw3p0ZUTU5qyNRzdb2IWuP0U+4EQ
	 PgNXLiialab5tJpL/r2trGMiSas+ijgDPxiFNzvK8tINHMhh7WcM8niEO5ygKoPDYD
	 PeJZVUHkErllQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 00/15] tracing/filters: Fix event filter parsing and matching bugs
Date: Thu, 29 Oct 2026 10:37:25 +0900
Message-ID: <179323784538.740114.15323117974242744566.stgit@devnote2>
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

Here is the 4th version of fixes for various bugs in the trace event
filter parser and predicate evaluation in kernel/trace/trace_events_filter.c,
along with a new ftracetest test case covering filter syntax checks.

The previous version is here:
 https://lore.kernel.org/all/179314820431.684037.4147763044424284198.stgit@devnote2

In this version, according to the comment from Sashiko and Steve, dropped
a redundant patch and reorder the patches for separating real bug fixes
(1-8) and cleanups & test (9-15). Steve and I agreed that the patches which
just fixes the error message will be a cleanup or improvement, so I removed
Fixes/Cc:stable tags from those.

Changes in v4:
- Dropped the separate regex_match_end() zero-length string fix patch
  ([01/16] in v3) as redundant per review from Sashiko.
- In [01/15], introduce regex_match_end_dynstr() for FILTER_STATIC_STRING
  fields defined with size 0 (such as the 'buf' field of ftrace/print
  events / trace_marker), so that suffix filtering on unbounded NUL-terminated
  strings works as expected without penalizing fixed-size buffer matching.
- In [02/15], clean up process_system_preds() by replacing the 'fail'
  boolean with 'ret' and consolidating the cleanup logic between fail
  and fail_mem, as suggested by Steven Rostedt.
- In [09/15] (was [10/16]), verify that all characters following the
  newline are whitespace before writing '\0' in filter_check_newline(),
  preventing in-place truncation of the filter string on error, as
  pointed out by Sashiko.
- In [10/15] (was [08/16]), drop Fixes and Cc: stable tags, as this is an
  error log improvement cleanup rather than a bug fix.
  Also move it after other Cc: stable patches.
- In [11/15] to [14/15], drop Fixes and Cc: stable tags from error
  position fixes as these are cleanups.


Summary of the patches:

~~~~~~(fixes)~~~~~~
- [01/15] Introduce regex_match_end_str() for fixed-size string fields
  (FILTER_COMM, FILTER_STATIC_STRING with field->size > 0), and
  regex_match_end_dynstr() for unbounded strings (field->size == 0)
  in parse_pred().
- [02/15] Fix process_system_preds() so that "fail" is only cleared when
  at least one event in the subsystem succeeds, and use
  delay_free_filter() when freeing replaced filters on error paths.
- [03/15] Return "pred->op == OP_NE" when "cpu >= nr_cpu_ids" in
  DEFINE_CPUMASK_COMPARISON_PRED so "!=" against a cpumask evaluates to
  true for out-of-range CPU numbers.
- [04/15] Ensure parse_error() is called on all -EINVAL error paths in
  parse_pred(), predicate_parse(), and process_preds() instead of
  leaving lasterr as 0 ("Error: (0)").
- [05/15] Check if str[i] is NUL immediately after operator whitespace
  in parse_pred() to prevent out-of-bounds reads on missing operands.
- [06/15] Fix quoted operand parsing in function event filters, check for
  missing quotes, and advance past closing quotes.
- [07/15] Reject empty unquoted operands in function event filters.
- [08/15] Reject unsupported field sizes in parse_pred() when
  select_comparison_fn() or CPUS{} size matching leaves pred->fn_num as
  FILTER_PRED_FN_NOP, avoiding a kernel warning in update_pred_fn().

~~~~~~(improvement/cleanups)~~~~~~
- [09/15] Convert the first newline to NUL and reject multi-line input
  containing non-whitespace characters after the newline in
  create_filter_start(), apply_event_filter(), and
  apply_subsystem_event_filter().
- [10/15] Reject stray quotes and '(' in unquoted function event operands.
- [11/15] Fix parser error positions for base filter expressions
  (predicate_parse(), FIELD_NOT_FOUND, IP_FIELD_ONLY, string/numeric
  operators), and update tracing-error-log.tc.
- [12/15] Pass 'pos + fn_pos' for ILLEGAL_FIELD_OP and 'pos + op_pos' for
  INVALID_OP in function filter operations in parse_pred().
- [13/15] Pass 'pos + op_pos' for CPUS operator checks and check
  'str[i] != '{'' before incrementing 'i' for MISSING_BRACE_OPEN.
- [14/15] Pass 'pos + op_pos' for GLOB_WITHIN when '~' is used with a
  'within' filter.
- [15/15] Add filter-syntax-check.tc to ftrace selftests to test valid
  filters, syntax error diagnostics and caret positions, multi-line
  input validation, and subsystem filter error returns.

Notes:

- These bugs were identified and the fixes and cover letter were
prepared with the assistance of an LLM coding assistant.

Thank you,

---
base-commit: 1fdc4164e488916402badddbb1f51e9380dabb91

Masami Hiramatsu (Google) (15):
      tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
      tracing/filters: Fix false success return in process_system_preds()
      tracing/filters: Handle out-of-range CPU for OP_NE in cpumask comparison
      tracing/filters: Report parse error on all -EINVAL paths in filter parsing
      tracing/filters: Check for missing operand after operator in parse_pred()
      tracing/filters: Fix quoted operand parsing in function event filter
      tracing/filters: Reject empty unquoted operand in function event filter
      tracing/filters: Reject unsupported field sizes in parse_pred()
      tracing/filters: Check for trailing characters after newline in filter string
      tracing/filters: Reject stray quotes and parentheses in unquoted function event operand
      tracing/filters: Fix error positions in filter parser
      tracing/filters: Fix error position for function filter operations
      tracing/filters: Fix error positions for CPUS mask parsing
      tracing/filters: Fix error position for within filter operator check
      selftests/ftrace: Add event filter syntax check test case


 kernel/trace/trace_events_filter.c                 |  182 ++++++++++++++++----
 .../ftrace/test.d/filter/filter-syntax-check.tc    |  100 +++++++++++
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |    2 
 3 files changed, 248 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
