Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105E29E110;
	Sun, 21 Jun 2026 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782012393; cv=none; b=OLqNO00ukP18LzLmQI8JvEGWTBiKcDAL4psLCa+R/zsXWQbHLrExDiblO2dEyiSl2OW5p5X3IexFqTAap6o2x4EFVueCHxRDoZbQthlmiWC/13ExN5OgWbhwPsgAfZV9S8Erqi4FxQSDfxES+EB3EQzyj8k2H4CqKj9XMy/oAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782012393; c=relaxed/simple;
	bh=HGaVd+bjUiFouYKEd9jEFtIWAdE5osSUpX4qV4UO/0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TUJgn06Ggurcc3yFLPzKIO8tT67UReEVHti0plflmkhr1sn80I6no0xJJGRu8d8k1bG5tmiLz886Ede3y479tkF9xhfsE2ezMfCN8f5lFujHR5WxPcmPMnxP5lTtOCKuV2RntKPQjy54jzOXzVE77uBkwVqE6ThQtUrfg/38zLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iai5zHbB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iai5zHbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DE91F000E9;
	Sun, 21 Jun 2026 03:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782012392;
	bh=0C/Hcn6afziXnDalLesnUhWmwPyjXTnYpyEbiH0HvzY=;
	h=From:To:Cc:Subject:Date;
	b=iai5zHbBbc4TzcXIaSR94H2uZm11Sesrt6/E73kptffBku0PM7bBJkVjwCbcAalJc
	 w5fMYY+oi+cC+9EDZV0LVFXycKUDqz+ptXKrgdf9Dq2th8a8oQV+bPcMtFlxGif7TY
	 NM/703OB7niDs0m7CbH617Z+gDW6KifmYesu4WWhp6jKR7kN8B+qwg6dnu2uFm4rpg
	 w4bTbJloACYS5KSe8clVk5sO0nJ7JyjkwiZgjv94aYIZUak8LPBuuraiEn8kcwa121
	 rsbi60/E1L4E0EEKLn8CXTcbky49MCAoAUArvDbvjF1eLjV94YdRAMqtG6L4BisXtZ
	 TE3GYhu3vO+5Q==
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
Subject: [RESEND PATCH v6 0/8] tracing/probes: Add more typecast features
Date: Sun, 21 Jun 2026 12:26:28 +0900
Message-ID: <178201238795.570818.15573963115625446598.stgit@devnote2>
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

[Resend for Sashiko review with "base-commit:", also fix a link to previous version.]

Hi,

Here is the 6th version of series to introduce more typecast features
to probe events. The previous version is here:

 https://lore.kernel.org/all/178165816303.269421.7302603996990753309.stgit@devnote2/

In this version, I fixed some issues found by Sashiko reviews (again),
drop the first bugfix which is merged to probes/core, add new fetcharg
dump patch[1/8] and make typecast always nested[3/8]. This version also
allows all probe events to use $current.

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
base-commit: cfae4cb90fc8113d52fea1f0a62cd6a36d9df149

Masami Hiramatsu (Google) (8):
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
 kernel/trace/trace_probe.c                         |  571 ++++++++++++++++----
 kernel/trace/trace_probe.h                         |   95 ++-
 kernel/trace/trace_probe_tmpl.h                    |   25 +
 kernel/trace/trace_uprobe.c                        |    3 
 samples/trace_events/trace-events-sample.c         |   40 +
 samples/trace_events/trace-events-sample.h         |   34 +
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   11 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   11 
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 
 18 files changed, 747 insertions(+), 154 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
