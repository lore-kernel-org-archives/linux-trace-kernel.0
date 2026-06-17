Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5228F9D9;
	Wed, 17 Jun 2026 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658170; cv=none; b=PqYQf8IseAuhIjG2XvqYxryfQYiWGOx9AZg4ESZgD465TMYRJqIgCzbT0cvrHcVDpwB+3AmWywQMA/arrwlYuzXBP1BSs5mh4AMHMZBLyE+8Rzl8KYHNW1OotwF0VPcZCAqJxt5/Tk0OqZQnf949Vsaz5rva6vGbNDS+kzAEzxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658170; c=relaxed/simple;
	bh=MwAUITCY71TvqKgK+d2+dZhrF6BF5u4Yt119pa5Offg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QqdVTyo5ci2By50RWE8SfADDc5muP5bOLB1JcIxknvVQXYpMP+lRwkzL1ja9FWViq+t6sXBVIS/0+PzdWvjxyapK8HzMcgzCVG82xcxDNtRbF78wjyyvAR76CpMR7UwLnvJOC76PyLsS/9NDmoeboVtw6ocs8/HYKLEs0TiQQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dq/W2mlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq/W2mlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE90D1F000E9;
	Wed, 17 Jun 2026 01:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658167;
	bh=xFpQIWYAE0rXBuCc5y3yoBzamTGA5qheLbZTB7avkOc=;
	h=From:To:Cc:Subject:Date;
	b=dq/W2mlD6+v+60BKUj1QWQSd5QI/F19ECvF95Y1jgUMI89uIIYrxJbHYhXD/moCTv
	 0fzRqpb4cZAbd/W4K8Vg6NinxekpOGj12oY8+fuS0nArd+PrQR5IUzNmuErWR32V1B
	 6po5ZiWkoKLDi2GHPfezwFXKQTST/Ce0XwLssGK8pYrNXxUC7Qa9f15BbtejUoo0gW
	 xjU4Hs8+/z6g9S+c7ZZ90hhaEyHFSBOersmDw6PfbXbZcbc+4Zn/Z/56AH+ybp6a0U
	 OJVSSaF6WECtyFO5yUp2x1gvm70fZRppi+sD5V9wkaU7VJCT+rSVcWkrhm2c+GLwA2
	 teeAGf//l1N0A==
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
Subject: [PATCH v5 0/7] tracing/probes: Add more typecast features
Date: Wed, 17 Jun 2026 10:02:43 +0900
Message-ID: <178165816303.269421.7302603996990753309.stgit@devnote2>
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

Here is the 5th version of series to introduce more typecast features
to probe events. The previous version is here:

 https://lore.kernel.org/all/178148603548.185520.3389196102475741865.stgit@devnote2/

In this version, I fixed some issues found by Sashiko reviews,
convert this_cpu_read() into this_cpu_ptr() + dereference[6/7],
and add some syntax testcases. 

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

Thanks,

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
 kernel/trace/trace_probe.c                         |  439 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   17 +
 kernel/trace/trace_probe_tmpl.h                    |   25 +
 samples/trace_events/trace-events-sample.c         |   44 ++
 samples/trace_events/trace-events-sample.h         |   34 +-
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   11 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   11 +
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 
 13 files changed, 559 insertions(+), 116 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
