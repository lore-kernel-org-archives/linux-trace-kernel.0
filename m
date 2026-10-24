Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859128;
	b=sXWhCiUbZVE9BXwY/xbhmUf8O2TkLg2+dAsnPk/fJ++s4aC+W/dmb9QdEIt+jK64G4fu
	 7fndN5ydftGndiRVUWl5iuneClhmmfKo1RMs8D2H43dbyXVMgVJq8fQ3bPVURT/9lZbtH
	 8/BHqdXwz7BScF2nA418E06MCbW627XH+77igsTnfpnutws30cf1cuWpR1ro+gzJRsqwz
	 yzQ+6wKsV+YRnZJYvY/LOGvqZ5qiOpmvgIbOI6v93EPy5ejESMtWu/KwOYwH97n+wJF6C
	 1fXOyFiHfb7bV5f350plhCqXCpvmMBTPIu5zA5ss+0SP5G8ja054SDyo4OcEpZ28SvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G68ur1SMj/NNYuw3zI3yHnD0eHSAvGW7RPf8rjvKBXA=;
	b=Ki4XsCq9xRGEcisl9ohwpBieYye2QHedB8B2cnLYjkUGSkFu4nHspCuaynvtGnfKgq6L
	 iYYQpig5wGIMmYvKER/kbs5HghSer+kbF/5jzvvd/6V8VvBvwLJ38jCzdaKolYvxZ6rck
	 q4rX7Vke5m3axGifAEwbrxdjWLw0SE63NDSif7kTkVYLNf5VctWVoFFo4N+vwDyWP1+Bx
	 XLx/pRJRdystab6rE96867HDcff0rgnZTesbFb29Vco/4Rz/piXVBHM1KGy5izxy5hqvK
	 mcLNHN3zt7gHLZfP7iWQzDFpLP7BFg/4CcmHcuLOTZD1B7a0D5YSJI4rTgT1a3mPl9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ko6qO15Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9AE606A320;
	Sat, 24 Oct 2026 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ko6qO15Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318631F01825;
	Sat, 24 Oct 2026 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859128;
	bh=G68ur1SMj/NNYuw3zI3yHnD0eHSAvGW7RPf8rjvKBXA=;
	h=From:To:Cc:Subject:Date;
	b=Ko6qO15ZhI53ksQ2tGBDI4oWQAk3Tp3FE5c4q5mAolXBAskEJG4qP/BI4q3H0YR1g
	 qW4DMFW4dNFrJi3DD7zlM3jnwYNWcz/eqeHvNVJcSMFr51iDMOU4SX3xoAGaqydtHD
	 D/RoNUDlMn31/la346mRE9d7KUGv0OxiCOIjh8FM5NFcJ9M04zghNQEtNe0R1yrJN6
	 zu39WUOfw0eXF9RENzSrX7ofJN7msR3HJg1XymryS9kQy22iXZ6OJapFL3jUJ94nh1
	 j3pkZcnZao/+Z2XqdKdgao4FwxvzgXLaEeF3M9pQWK1KGmlkIt50Z7iLGCIyv2KnPV
	 1i8hCBH0pkm+g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 00/10] tracing/filters: Fix event filter parsing and matching bugs
Date: Sun, 25 Oct 2026 01:25:23 +0900
Message-ID: <179285912318.466249.7425922682086130057.stgit@devnote2>
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

Here is a series of fixes for various bugs in the trace event filter
parser and predicate evaluation in kernel/trace/trace_events_filter.c,
along with a new ftracetest test case covering filter syntax checks.

Summary of the patches:

- [01/10] Compute the actual string length with strnlen()/strlen() in
  regex_match_end() so suffix matching ("*pattern") works on fixed-size
  string fields (such as comm) and dynamic strings.
- [02/10] Fix process_system_preds() so that "fail" is only cleared when
  at least one event in the subsystem succeeds, and use
  delay_free_filter() when freeing replaced filters on error paths.
- [03/10] Check "cpu >= nr_cpu_ids" before calling cpumask_test_cpu() in
  do_filter_cpumask_scalar() to avoid out-of-bounds bit tests when
  NR_CPUS > nr_cpu_ids.
- [04/10] Return "pred->op == OP_NE" when "cpu >= nr_cpu_ids" in
  DEFINE_CPUMASK_COMPARISON_PRED so "!=" against a cpumask evaluates to
  true for out-of-range CPU numbers.
- [05/10] Ensure parse_error() is called on all -EINVAL error paths in
  parse_pred(), predicate_parse(), and process_preds() instead of
  leaving lasterr as 0 ("Error: (0)").
- [06/10] Fix function event ("ip") operand parsing in parse_pred() to
  avoid reading past the NUL terminator on empty operands, check for
  missing closing quotes, advance past closing quotes, and reject empty
  operands or stray quotes/'(' in unquoted operands.
- [07/10] Advance past the second character of "&&" and "||" in
  calc_stack() so the second operator character is not miscounted as a
  new predicate.
- [08/10] Reject unsupported field sizes in parse_pred() when
  select_comparison_fn() or CPUS{} size matching leaves pred->fn_num as
  FILTER_PRED_FN_NOP, avoiding a kernel warning in update_pred_fn().
- [09/10] Terminate the input filter string at the first newline ('\n')
  in create_filter_start(), apply_event_filter(), and
  apply_subsystem_event_filter() so multi-line input cannot desynchronize
  cpulist_parse()/parse_pred() from calc_stack() or misalign error_log
  caret placement.
- [10/10] Add filter-syntax-check.tc to ftrace selftests to test valid
  filters, syntax error diagnostics and caret positions, multi-line
  input truncation, and subsystem filter error returns.

Note: These bugs were identified and the fixes and cover letter were
prepared with the assistance of an LLM coding assistant.

Also, note that [09/10] may need more discussion because it can break
user space tool which attempts to use line-break characters as a filter
for reasons that are not entirely clear. But as far as I can see, the
error_log does not support such multi-line filter input. So I think
we still need it. (But not sure we should backport it, maybe as an
improvement.)

Thank you,

---
base-commit: 1fdc4164e488916402badddbb1f51e9380dabb91

Masami Hiramatsu (Google) (10):
      tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
      tracing/filters: Fix false success return in process_system_preds()
      tracing/filters: Check CPU bounds before cpumask_test_cpu() in do_filter_cpumask_scalar()
      tracing/filters: Handle out-of-range CPU for OP_NE in cpumask comparison
      tracing/filters: Report parse error on all -EINVAL paths in filter parsing
      tracing/filters: Fix function event operand parsing in parse_pred()
      tracing/filters: Skip second character of '&&' and '||' in calc_stack()
      tracing/filters: Reject unsupported field sizes in parse_pred()
      tracing/filters: Terminate filter string at first newline
      selftests/ftrace: Add event filter syntax check test case


 kernel/trace/trace_events_filter.c                 |  100 +++++++++++++++-----
 .../ftrace/test.d/filter/filter-syntax-check.tc    |   52 ++++++++++
 2 files changed, 129 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
