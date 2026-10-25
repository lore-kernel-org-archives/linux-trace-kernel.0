Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917434;
	b=k9MDfJfrjXEt99g3SgTUqUYp1Fip6WgvalEbXn9vlmKCMxpFJ7SUu/Tb0nRbFLvmCLpo
	 nIjKu0pLP29u90XMYL35ijmqbZIc77/m5gxTvbzsg//y2NmfncIwALwy/MXFsCtNR1H/4
	 fdwVUSjBGJjkcVsbK3rsNqzGxVQzKkWh+E/HaLdDhr0sCaaVVotoLLXzdVQg3es7cgxfk
	 +9XpqTP7Oiz5jBka/0Bb7NZFTQ+hgqW34YVdw8gzpISOEGVk7ArD+wlYaqO/mBt0uU0Fo
	 ZTWRQMa1+JnaIfzoXdRtuQuWrOTa0qxLC07tXV38fDH/oHMquPlNL/JZQT6akDr9mzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TUTD02y1snVEKJiu1G5hkhL/dhz7ijXrdWl50l7if3c=;
	b=2loGvMmsODHffvPmg36SH8ZNeIXirSKXmlUMhFQs/HcWCA5Gy4rwZjCgVRRhCMbIw+zN
	 +NB2MesrGIaz9MWTMT133/fsvnYgMkwgpMewPMrIgPPUsoA2d/SEIcpbuQicvKUO1NSTP
	 wUUr6DFV0d0L3g+pBeLZgD2LztyAIMG8TxFINJp3hlUANlT01bmIOK4BLB1kH41/RjI2/
	 cxXWUf4U1UvrOZtAM+qPPJXlye6BFqvezDd8arKEV4NEkwEk47KKTqRsC3Hi9ZmiJDkvQ
	 MWMAFuB8aF2fhmODyXh4pMaHVY6RpyYUTh49yxSXllHrFgQUaypReAQlELMxxhBpTZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jd8/UsZH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C44606A31A;
	Sun, 25 Oct 2026 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jd8/UsZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453FE1F01825;
	Sun, 25 Oct 2026 08:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917434;
	bh=TUTD02y1snVEKJiu1G5hkhL/dhz7ijXrdWl50l7if3c=;
	h=From:To:Cc:Subject:Date;
	b=Jd8/UsZH/s5jmgXiZYu8yk4mpi099K410+p5UEunAOPVfkRvOJzbrO7x0eLwQKKll
	 zBkpBHLKg6lwNzWDe/8JNippdRiTqd08GMpXtYwtc57p2iqqnlXqIuMpQNXFd3yw+B
	 TWZrhX2AqrKjRk8BiIU/y7FizUUwNLPm4JNpARkB7rnc6mRpdW+RHB/wiN8Jl10Dod
	 vTFtk3m4weUkjMwvfPLa41gtAMk//ELs/MH0+Li7hDbxWClQkFGIhsQxrhFoPPabSb
	 UBwPBM6ZznmDienZiom4xpQ3a6HOmKXDA2Ph21F5sJ5Jad34iF4FroVX8ZGkkl/B5O
	 6fFsAr6lJyC6g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/9] tracing/filters: Fix event filter parsing and matching bugs
Date: Sun, 25 Oct 2026 17:37:09 +0900
Message-ID: <179291742944.492959.11659339795290028998.stgit@devnote2>
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

Here is the second version of fixes for various bugs in the trace event
filter parser and predicate evaluation in kernel/trace/trace_events_filter.c,
along with a new ftracetest test case covering filter syntax checks.

The previous version is here:

 https://lore.kernel.org/all/179285912318.466249.7425922682086130057.stgit@devnote2

Changes in v2:
[01/09]
 - Guard against negative length and avoid calling strnlen() when the
   buffer capacity is smaller than the search pattern.
 - Use strnlen(str, len) directly instead of calling strlen(str) when
   len is 0, avoiding an out-of-bounds read on 0-length dynamic arrays.
[03/10] (in v1)
 - Dropped because out-of-range CPU numbers are already rejected at
   filter parse time by cpulist_parse() checking against nr_cpu_ids,
   making the runtime check in do_filter_cpumask_scalar() unreachable.

Summary of the patches:

- [01/09] Compute the actual string length with strnlen() in
  regex_match_end() so suffix matching ("*pattern") works on fixed-size
  string fields (such as comm) and dynamic strings.
- [02/09] Fix process_system_preds() so that "fail" is only cleared when
  at least one event in the subsystem succeeds, and use
  delay_free_filter() when freeing replaced filters on error paths.
- [03/09] Return "pred->op == OP_NE" when "cpu >= nr_cpu_ids" in
  DEFINE_CPUMASK_COMPARISON_PRED so "!=" against a cpumask evaluates to
  true for out-of-range CPU numbers.
- [04/09] Ensure parse_error() is called on all -EINVAL error paths in
  parse_pred(), predicate_parse(), and process_preds() instead of
  leaving lasterr as 0 ("Error: (0)").
- [05/09] Fix function event ("ip") operand parsing in parse_pred() to
  avoid reading past the NUL terminator on empty operands, check for
  missing closing quotes, advance past closing quotes, and reject empty
  operands or stray quotes/'(' in unquoted operands.
- [06/09] Advance past the second character of "&&" and "||" in
  calc_stack() so the second operator character is not miscounted as a
  new predicate.
- [07/09] Reject unsupported field sizes in parse_pred() when
  select_comparison_fn() or CPUS{} size matching leaves pred->fn_num as
  FILTER_PRED_FN_NOP, avoiding a kernel warning in update_pred_fn().
- [08/09] Terminate the input filter string at the first newline ('\n')
  in create_filter_start(), apply_event_filter(), and
  apply_subsystem_event_filter() so multi-line input cannot desynchronize
  cpulist_parse()/parse_pred() from calc_stack() or misalign error_log
  caret placement. (as an improvement)
- [09/09] Add filter-syntax-check.tc to ftrace selftests to test valid
  filters, syntax error diagnostics and caret positions, multi-line
  input truncation, and subsystem filter error returns.

Notes:

- These bugs were identified and the fixes and cover letter were
prepared with the assistance of an LLM coding assistant.

- Also, note that [08/09] may need more discussion because it can break
user space tool which attempts to use line-break characters as a filter
for reasons that are not entirely clear. But as far as I can see, the
error_log does not support such multi-line filter input. So I think
we still need it. (But not sure we should backport it, maybe as an
improvement.)

Thank you,

---
base-commit: 1fdc4164e488916402badddbb1f51e9380dabb91

Masami Hiramatsu (Google) (9):
      tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
      tracing/filters: Fix false success return in process_system_preds()
      tracing/filters: Handle out-of-range CPU for OP_NE in cpumask comparison
      tracing/filters: Report parse error on all -EINVAL paths in filter parsing
      tracing/filters: Fix function event operand parsing in parse_pred()
      tracing/filters: Skip second character of '&&' and '||' in calc_stack()
      tracing/filters: Reject unsupported field sizes in parse_pred()
      tracing/filters: Terminate filter string at first newline
      selftests/ftrace: Add event filter syntax check test case


 kernel/trace/trace_events_filter.c                 |  101 +++++++++++++++-----
 .../ftrace/test.d/filter/filter-syntax-check.tc    |   52 ++++++++++
 2 files changed, 130 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
