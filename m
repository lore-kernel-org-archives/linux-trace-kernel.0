Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE351256C61;
	Sun, 14 Jun 2026 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781448809; cv=none; b=oOskAQJ6roQwKKEKXHz6x/M4bpn+YE4YlZJ1Bvy83FMRl2bhpBuIWeGpv88uNbiRPBE4Mg4s3WuTnKbL0NzW4eD1cBZ3opSB4ThUj5C0Q3GSuwOrv2YNBnUD+aismR7egutv+GEbviNyYXeEldePV74DfVUn2PKa25EVaEWUb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781448809; c=relaxed/simple;
	bh=QDvrdZJELxyypXAK66pHmqbm8INn3WszC7z5TZ2O4Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ovFX+8hC93D0aW1FxRCbAUHeWlHdKVdYF67UFOsNbTdYj31FRsPvicFTqUyl7mTGwF5vb2uDT2m0gYn7SBzx+FUpPU+DYRITjVuvAA+Mw8yx2gQxq//0YFc2vIuGVhgSDUBGeM2wOAx+Sal7ZqTkB/miUNLEVmefrmO3VytDB7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrGNOi71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrGNOi71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39AE1F000E9;
	Sun, 14 Jun 2026 14:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781448807;
	bh=EqFu6RkWmvsFE5LlNsq/9ImB8IPjZxBq2VFJf/rQTBg=;
	h=From:To:Cc:Subject:Date;
	b=nrGNOi71rT/dDXWHo5g65E/jZsaNdPimjUEcIPgSIDllZ2Om+Rs+dIq4KY7p8iy3n
	 R6113LZ/hWBUNkEUFbAsNCFq2Rc4oLMG4BDOUCUmnpyNDtAocUCAslKkyEljBEr5i3
	 QAaR1MLKiDrnfUQZOUY8PZu1b/T0eueEFX536w9ezW/MiPDJPepD3arPg8ux7sHQyC
	 AHh+ZxiE0rtHJpHYqd9y2wYaO6X+sCK/K5E3Pu5Wd0ZzfWsSbC6HrM/pBW0slXxw6k
	 rLcyMpOM7ljAITl5P0bBbAHQhHlbznm93DhT/qfLrvSwaNRh2b8lRNlg807vffoIqf
	 q4P2ZhbhUebDw==
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
Subject: [PATCH v3 0/7] tracing/probes: Add more typecast features
Date: Sun, 14 Jun 2026 23:53:22 +0900
Message-ID: <178144880282.159464.16882854283219530040.stgit@devnote2>
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

Here is the 3rd version of series to introduce more typecast features
to probe events. The previous version is here:

 https://lore.kernel.org/all/178105268094.21760.13668249930524377840.stgit@devnote2/

In this version, I fixed various problems Sashiko reviewed and add new
test cases.

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


And added a test script to test part of them.

[1] https://lore.kernel.org/all/20260601130746.2139d926@gandalf.local.home/


---

Masami Hiramatsu (Google) (7):
      tracing/events: Fix to check the simple_tsk_fn creation
      tracing/probes: Support typecast for various probe events
      tracing/probes: Support nested typecast
      tracing/probes: Support field specifier option for typecast
      tracing/probes: Add $current variable support
      tracing/probes: Add this_cpu_read() and this_cpu_ptr() dereference method to fetcharg
      tracing/probes: Add a new testcase for BTF typecasts


 Documentation/trace/eprobetrace.rst                |    9 
 Documentation/trace/fprobetrace.rst                |   10 
 Documentation/trace/kprobetrace.rst                |   11 +
 kernel/trace/trace.c                               |    6 
 kernel/trace/trace_probe.c                         |  413 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   19 +
 kernel/trace/trace_probe_tmpl.h                    |   33 +-
 samples/trace_events/trace-events-sample.c         |   45 ++
 samples/trace_events/trace-events-sample.h         |   34 ++
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    9 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    9 
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 
 13 files changed, 540 insertions(+), 114 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
