Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08136C9C5;
	Thu, 25 Jun 2026 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350755; cv=none; b=t4t0VoaJ8fEMjWG/gCQ6p6XG04WUf7i+aGSXnFlMk3q8JL3GKv5OhoYuxL1D5mujPBFo7hnTDWvFv1kISa7Phi0s8q3TOkhM5L1qWlgWpxQL3il+4lfEDhJF5JhlMmma6pHqOpMFEhKd3cOmHSkri/fv1ye6X9GreV6WTuGJWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350755; c=relaxed/simple;
	bh=SY5Euj1qjdj0hfbLzgT53pUkfLUwthg/2yyZlBKd2tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KKCdKHh9k4NLVaAn1SMrZO53YKcyr55Eq6glOZuTrpBdRHc3vDcZCnxI53g1gh4T6/8ncEuSyX5fc+TsLDgf2jSaCMhde3FT732jVyQ8MDN4tN/xzhPvuQbj3GMUKtWP/QAgFAglNUgfa+Yyig0HSq/afInrGuWhADPxE/7BT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6hF8yNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6hF8yNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAE81F000E9;
	Thu, 25 Jun 2026 01:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782350753;
	bh=ErdX3RmX4qYmDR6Moys+BShnnPOkKKCoL22WcV9rF9g=;
	h=From:To:Cc:Subject:Date;
	b=C6hF8yNdc+O8N8OSv4/F4PEee1OV19zK0lJ0kJe5c6dVFubobUc81MpiEyDwk/nzW
	 O22kbahqM/11GKdQ4fzPevoXz9s/wxRlNrKs5n583aM9zcuXpXB8e8MVS1aXvntK0w
	 CoUdefYjIpZaqYl+VKHQObrSH9/afgmeXQwb4nd3yarNfcGcriQqmKEXBELQe0t510
	 kgo0KMAjMGw+373r/dCicEn3KgWQhUKg/X0CZLTksVpM7uCeffaso+aRKEenmPeN4d
	 CEGVdfEGl3C6BxlfqP7kd5y07/2yo9flWXlJEsF5r0Ci6d4AQXN6pWprta/qt4fXi8
	 t5NtDTQKjyLtg==
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
Subject: [PATCH v9 0/9] tracing/probes: Add more typecast features
Date: Thu, 25 Jun 2026 10:25:49 +0900
Message-ID: <178235074943.766912.25308838431649508.stgit@devnote2>
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

Here is the 9th version of series to introduce more typecast features
to probe events. The previous version is here:

 https://lore.kernel.org/all/178231208703.732967.1160700962651040729.stgit@devnote2/

In this version, I removed picked bugfix patch, prohibit percpu
access method on non-kernel probes [8/9], and add a test case
to check the new syntax[9/9].

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

Masami Hiramatsu (Google) (9):
      tracing/probes: Allow eprobe to use variable without $ prefix
      tracing/probes: Support dumping fetcharg program for debugging dynamic events
      tracing/probes: Support typecast for various probe events
      tracing/probes: Support nested typecast
      tracing/probes: Type casting always involves nested calls
      tracing/probes: Support field specifier option for typecast
      tracing/probes: Add $current variable support
      tracing/probes: Add this_cpu_read() and this_cpu_ptr() dereference method to fetcharg
      tracing/probes: Add a new testcase for BTF typecasts


 Documentation/trace/eprobetrace.rst                |    9 
 Documentation/trace/fprobetrace.rst                |   10 
 Documentation/trace/kprobetrace.rst                |   11 
 kernel/trace/Kconfig                               |   12 
 kernel/trace/trace.c                               |    8 
 kernel/trace/trace_eprobe.c                        |    2 
 kernel/trace/trace_fprobe.c                        |    2 
 kernel/trace/trace_kprobe.c                        |    2 
 kernel/trace/trace_probe.c                         |  579 ++++++++++++++++----
 kernel/trace/trace_probe.h                         |  100 ++-
 kernel/trace/trace_probe_tmpl.h                    |   25 +
 kernel/trace/trace_uprobe.c                        |    3 
 samples/trace_events/trace-events-sample.c         |   40 +
 samples/trace_events/trace-events-sample.h         |   34 +
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++
 .../test.d/dynevent/btf_typecast_accepted.tc       |  107 ++++
 .../test.d/dynevent/eprobes_syntax_errors.tc       |    6 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   12 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   12 
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 
 20 files changed, 876 insertions(+), 154 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
