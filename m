Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9401D416C;
	Mon, 15 Jun 2026 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486042; cv=none; b=m8A/ldO4olczOQOS2m6+TW1D7eHX3QN2M+oI4HLmRyrjRj/x7Qua5lgVOrc+LZb7XOwvP6GB99hd2m8DcvdNNbSEXGQIDtiBFzPguUeJ4r/jRhr99mLmsrfXHLwy3xHPpSl9qRjsDqabxYkUYBRy338z8aLFddeK+MtqXbukS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486042; c=relaxed/simple;
	bh=srTHieG9QuuExlHEw5TlKCwlwwWNy6V4euxanIlNlkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=maCQ1CCPagyqbtoYRjuPbtxelOrCf+m5E8tPwR7ZGS0coTCxq5SQDS4k82XzDGudxUscIuCwcevJ5CVl1/YjdtgFztxZZeTh/ZoyRr02i0iKXONTOmo3sZZ7y/HzlQBM5jSZ/t+9e5R6YACZGbLOrCrnPrjNPx3McQlyT8qlpgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILZEs0zt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILZEs0zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FEF1F000E9;
	Mon, 15 Jun 2026 01:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781486040;
	bh=IMLryOOflPIA2MeylTVQIkAq8ZoOodmRc9G5qh/vtSo=;
	h=From:To:Cc:Subject:Date;
	b=ILZEs0ztlHZvIev2SkNLzROJupEOQeOpmRE5zgaZhj81x8M6nm8VN6gmNnEf7j5W0
	 dSGRJ/fMvustrl81F3W+mNPPMrV19A7u+3oaQIpRZr14L/0ewWbi4fgKvcjaqfjQ73
	 4pRMnYVoUtyRwRgLDGiaWuqM+Iyg9CQ277pss3bTKRAIr5YnEd+y7EGerb5rw2wWUO
	 5gysc0JgfKesW4e+cL8wReBkJ2+IGojgnKx7TD653lJ51cD+HEwq2qSAJfzfpDyUez
	 rh9I3lC6W4JRntDcoe55KgeKKpw+KzTGb8bMFyVRvQxstv/cuJX8z7tWujbTraQMRz
	 Y1c9zxfjK+h2A==
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
Subject: [PATCH v4 0/7] tracing/probes: Add more typecast features
Date: Mon, 15 Jun 2026 10:13:55 +0900
Message-ID: <178148603548.185520.3389196102475741865.stgit@devnote2>
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

Here is the 4th version of series to introduce more typecast features
to probe events. The previous version is here:

 https://lore.kernel.org/all/178144880282.159464.16882854283219530040.stgit@devnote2/

In this version, I fixed some issues found by Sashiko reviews.

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
 kernel/trace/trace.c                               |    8 
 kernel/trace/trace_probe.c                         |  413 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   19 +
 kernel/trace/trace_probe_tmpl.h                    |   33 +-
 samples/trace_events/trace-events-sample.c         |   44 ++
 samples/trace_events/trace-events-sample.h         |   34 ++
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    9 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    9 
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 
 13 files changed, 540 insertions(+), 115 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
