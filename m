Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E646377019;
	Tue, 23 Jun 2026 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179055; cv=none; b=J7+ULdMxo7u02bYZCr/uRxI5Jv3Uxe1idfrqoWZp5drRe6JYeopGRJtj/+QI9WgGkeif0+xwC4J3mdQWh5n3Lmz1SlgA/l4bSUPtO7CLVuW2LZII+hxXrsH42fqNFdaY2jiBc+kNDrFVyGxAADjp0LDKja1FnF5uifZ7mnqzk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179055; c=relaxed/simple;
	bh=ty118v/GEIKgPHRF7FkPEb1YYTctfSyI9LDfVCc8uBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnSrwMAR9M6GST8HTwJZa1YmHM/HP9vBALjheGdOgo/rZ7dw/pLS0LrOnxzJcRaD8Uwalvy/ucZ5RmY1Ewc70N/x9fm412hl26HOUsTbW1ofwYlIVwlX/bp+kU2e5EnBYRuzpNgCC/0afQEwEnyxha5fGOnwBBHDcnHSx365WcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZeo4cWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZeo4cWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386DD1F000E9;
	Tue, 23 Jun 2026 01:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179054;
	bh=vni5Lyip3mgwniFnSgkoIOM9DFuNAQmCprTMRCiORoU=;
	h=From:To:Cc:Subject:Date;
	b=jZeo4cWTbOi4j3PW944Wwi8m+/QXtToDpe7N3uOJzT60jex6ZikMn6LvXCqG7GHMv
	 q9k0q1V+TgggdtJkR+aCiufi5rt/fgZrSmjZg2yMz5DbjelHq7a5ZGdG8F4hYM63kL
	 zNOOn/gqW/fGF5KI216G5d0HNxPyz76ViI59nGSkKEq/JswvFhwQYkfA4EnL86hQDW
	 dqetFDoeTneXCXBYOZy7LNfbWFsWbeZ0cEUFIgQF2DGUyo/KZZ0zkS4p3WnSoSU3eM
	 yigvj8RMw3O1xC/N3il+KbSvokgRHsjUB+rirELEAYWl0f4sY9a/D75/ZVC8hxiY4X
	 h7y2iyWUnWD3A==
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
Subject: [PATCH v7 00/10] tracing/probes: Add more typecast features
Date: Tue, 23 Jun 2026 10:44:10 +0900
Message-ID: <178217904992.643090.15726197350652241270.stgit@devnote2>
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

Here is the 7th version of series to introduce more typecast features
to probe events. The previous version is here:

 https://lore.kernel.org/all/178201238795.570818.15573963115625446598.stgit@devnote2/

In this version, I added 2 new fix and cleanup patches and update
according to Sashiko's review. [1/10] is a long-lived issue about
@+FOFFS, which was wrongly adding offset twice. [2/10] is a clean
up patch for renaming fetch_op name (good to dump it). 
This is applicable against probes/core branch on linux-trace tree.

Steve introduced BTF typecast feature for eprobe[1].
This series extends it and add more options:

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

And added fetcharg dump feature (for debug) and updated test scripts
to test part of them.

Thanks,

---
base-commit: 3ec75d0067f30eb5e0730f033766d6ab2feca7ae

Masami Hiramatsu (Google) (10):
      tracing/probes: Fix double addition of offset for @+FOFFSET
      tracing/probes: Rename FETCH_OP_DATA to FETCH_OP_IMMSTR
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
 kernel/trace/Kconfig                               |   11 
 kernel/trace/trace.c                               |    8 
 kernel/trace/trace_eprobe.c                        |    2 
 kernel/trace/trace_fprobe.c                        |    2 
 kernel/trace/trace_kprobe.c                        |    2 
 kernel/trace/trace_probe.c                         |  582 ++++++++++++++++----
 kernel/trace/trace_probe.h                         |   98 ++-
 kernel/trace/trace_probe_tmpl.h                    |   27 +
 kernel/trace/trace_uprobe.c                        |    3 
 samples/trace_events/trace-events-sample.c         |   40 +
 samples/trace_events/trace-events-sample.h         |   34 +
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   11 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   11 
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 
 18 files changed, 756 insertions(+), 161 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
