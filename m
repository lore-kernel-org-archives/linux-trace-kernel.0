Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BB3F660F;
	Fri, 26 Jun 2026 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483262; cv=none; b=RoRPUbI+MV184mZcRN0KGu3wqPrld7W1OBxPXnP4nXzThMwyjKSlnv+gigZZFokDbJfXzlJp7R+bMo/x6kiFoX63TdYPaOzwNNzhDHSuaP38vfj6eMyBOnZ7wlgTD6GQqeLW8l+tiAR6cjI0tn7f5KXhzSbIXdaMwRPZkp17gEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483262; c=relaxed/simple;
	bh=6WeEfBZ8rG6m1SW6DnxtfbwfS0Mue6OQjmOfMXiosnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dAmUUwiCuv6eLeE+mk+FoQVvVtxwvXqOU+6RP/2FSsq95gpXplvcAPQwYNnnHvwDKeNdiN8U802zZ9wY/7BHtLGTlIvBl9bm6S5LvEKpsh5jPz4XjWl6aAxu/ZzI5cUB0GPGjJ7RPmgVy3QEN/ePBESLdSfFQLFUxNdOhNkpYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foKHBDQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foKHBDQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BFF1F000E9;
	Fri, 26 Jun 2026 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782483261;
	bh=SkXzb6SusHWpjYbemZl565iVMWbnBwLhnpo+kzrmlw4=;
	h=From:To:Cc:Subject:Date;
	b=foKHBDQmRNlCmzzoAIYLPHl0igRL+acjd1AMpxjLShKlGKCBY1QIyO74CxQVQCZFA
	 gGffgzKTGNwIOZpRL1SZ98FltmHAsF2gbcMZKnwNwLubleIBvH4rAEKxc/R3Xh/4z8
	 WngspWzQfdlHUZZP3CuGTDr8BEGm3EoghL2dxJyugBARLXWXu/bJnmzUa+UYJDDKB/
	 msSQX5bEA7Iz/EfsuOJYC3JJ09Cbh78JjFVyGyKA/hGKRPt3Yig0GcpJ+Fhy8Jawj6
	 dqd3nWR2Yk99Mi4xOOiylR4dS+ErgEgZ5yf3XFOcM3EyvlE5v32zs+4ZqUG6VRlu5n
	 p7X/yh9k4JUmA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v11 00/11] tracing/probes: Add more typecast features
Date: Fri, 26 Jun 2026 23:14:16 +0900
Message-ID: <178248325671.841606.17344906774310339507.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 11th version of series to introduce more typecast features
to probe events. The previous version is here:

 https://lore.kernel.org/all/178243982430.790911.17439694390021542101.stgit@devnote2/

In this version, I fixed minor issues and add 2 patches to fix
in-tree tools to ignore comment lines in dynamic_events[3/11][4/11].

This series extends BTF typecast feature and add more options:

1. Expanding BTF typecast to kprobe and fprobe.
   (currently only function entry/exit)

2. Introduce container_of like typecast. This adds a "assigned
   member" option to the typecast.

   (STRUCT,MEMBER)VAR->ANOTHER_MEMBER

   This casts VAR to STRUCT type but the VAR is as the address
   of STRUCT.MEMBER. In C, it is:

   container_of(VAR, STRUCT, MEMBER)->ANOTHER_MEMBER

3. Support nested typecast, e.g.

   (STRUCT)((STRUCT2)VAR->MEMBER2)->MEMBER

   the nest level must be smaller than 3.

4. Add $current variable to point "current" task_struct.
   This is useful with typecast, e.g.

   (task_struct)$current->pid

5. per-cpu dereference support.

   Intrdouce this_cpu_read(VAR) and this_cpu_ptr(VAR) to
   access per-cpu data on the current CPU (accessing other CPU
   data is not stable, because it can be changed.)

   You can access the member of per-cpu data structure using
   typecast like:

   (STRUCT)this_cpu_ptr(VAR)->MEMBER

6. Support event fields without $ prefix on eprobes.

   Now eprobe events can access its event fields.

And added fetcharg dump feature (for debug) and updated test scripts
to test part of them.

Thanks,

---
base-commit: c69b5f959286395e94c237ce6d7d4970bad7f6e3

Masami Hiramatsu (Google) (11):
      tracing/probes: Allow eprobe to use variable without $ prefix
      tracing/probes: Support dumping fetcharg program for debugging dynamic events
      tools/bootconfig: Ignore comment lines in dynamic_events/kprobe_events file
      perf/probe: Ignore comment lines in dynamic_events/kprobe_events file
      tracing/probes: Support typecast for various probe events
      tracing/probes: Support nested typecast
      tracing/probes: Type casting always involves nested calls
      tracing/probes: Support field specifier option for typecast
      tracing/probes: Add $current variable support
      tracing/probes: Add this_cpu_read() and this_cpu_ptr() dereference method to fetcharg
      tracing/probes: Add a new testcase for BTF typecasts


 Documentation/trace/eprobetrace.rst                |    7 
 Documentation/trace/fprobetrace.rst                |   10 
 Documentation/trace/kprobetrace.rst                |   11 
 kernel/trace/Kconfig                               |   12 
 kernel/trace/trace.c                               |    8 
 kernel/trace/trace_eprobe.c                        |    2 
 kernel/trace/trace_fprobe.c                        |    2 
 kernel/trace/trace_kprobe.c                        |    2 
 kernel/trace/trace_probe.c                         |  585 ++++++++++++++++----
 kernel/trace/trace_probe.h                         |  100 ++-
 kernel/trace/trace_probe_tmpl.h                    |   25 +
 kernel/trace/trace_uprobe.c                        |    3 
 samples/trace_events/trace-events-sample.c         |   40 +
 samples/trace_events/trace-events-sample.h         |   34 +
 tools/bootconfig/scripts/ftrace2bconf.sh           |    2 
 tools/perf/util/probe-file.c                       |    2 
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++
 .../test.d/dynevent/btf_typecast_accepted.tc       |  107 ++++
 .../test.d/dynevent/eprobes_syntax_errors.tc       |   12 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   12 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   12 
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 
 22 files changed, 890 insertions(+), 154 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
