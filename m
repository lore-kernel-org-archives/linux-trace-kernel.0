Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9CB3CA486;
	Wed, 24 Jun 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312093; cv=none; b=kY6oB9rOTpXu4KtkwVMPq5pnIAWFiKnnEL9bF6tD9E0BsdljjrK8gAjjkosfh+Zqm7dlxne+fDXF+/0Zm7eRyOYcLvQ8YeAx7PgJDYOR45bw4/7fDYq/NUUw2pmCoYzVbbsQDza9zONGoBr/09n+JSq30KDzaSwvChRkQYMvDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312093; c=relaxed/simple;
	bh=rVG0zrvhoLLqupHeedRrLHQngjssH75ENT3IpSBjtLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q3LM4mCGG2odz/kIr9BOO3dtjcfyU/Kr/zJuMiOFd2agb/9e2MQcvKqhLHpOqIPgdEe3UzYBhUnJvzNv6Oi+idraBAefm9XRaipNHQQbB39aqLyQWjXIGk83OFAKj+OQOEwsSHrtLHYt+xgKRw2rlUlW/HamL02K6EhxxzE88Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnyFrDSV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnyFrDSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3CA1F000E9;
	Wed, 24 Jun 2026 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782312091;
	bh=LYDX4vbUgsadUQdhH1zwzLpT33O5o/cj28eAKlfuULs=;
	h=From:To:Cc:Subject:Date;
	b=OnyFrDSVJRPo7gRWPKHxPZwrV3tND81cCviSqKHmzwYL3z7OfYrsPXMxlj+OvPdAT
	 kxo0Mc26KOOd4+oUMw8PE2awga6MDhr/2u8t89BEFH6acgtsrj/njOB6rzJoTgN/tI
	 tbB3XYqFnMbfioGfoMvuZgtxL+1khca1BktThPYkImstkRpFqvCG1sXlhKuW1dANOB
	 T52M6R7yAwX7CaPOos6N1qXLh9oOIfZ2JtuPHl/OUzVPYbF5t4NdGvi2Clr/wWGbzW
	 CYwHApHt6BLY1Eq6VDx93qnv6L7X49NbaF0NQpZbo8eqqvROLZ74dHFBrqLKMPvih0
	 sS++4JpG3JZ4g==
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
Subject: [PATCH v8 00/10] tracing/probes: Add more typecast features
Date: Wed, 24 Jun 2026 23:41:27 +0900
Message-ID: <178231208703.732967.1160700962651040729.stgit@devnote2>
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

Here is the 8th version of series to introduce more typecast features
to probe events. The previous version is here:

 https://lore.kernel.org/all/178217904992.643090.15726197350652241270.stgit@devnote2/

In this version, I removed already picked 2 patches and add 2 new
fix and feature patches. The previous BTF typecast patch allows
`(STRUCT)FIELD->MEMBER` without $ prefix for eprobes, but it also
allows user to use COMM/comm instead of FIELD. $COMM/$comm are special
variables, so it should not skip $ prefix[1/10]. However, accessing
event fields without $ prefix itself is acceptable, it is generically
allowed without typecast[2/10].
Other patches have small fixes according to Julian and Sashiko's
comments and are rebased on top of probes/core branch.

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
base-commit: 18dfb4703cd6af27deb30d628dac2e7db2b24e6a

Masami Hiramatsu (Google) (10):
      tracing/probes: Make the $ prefix mandatory for comm access
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
 kernel/trace/trace_probe.c                         |  586 ++++++++++++++++----
 kernel/trace/trace_probe.h                         |   99 ++-
 kernel/trace/trace_probe_tmpl.h                    |   25 +
 kernel/trace/trace_uprobe.c                        |    3 
 samples/trace_events/trace-events-sample.c         |   40 +
 samples/trace_events/trace-events-sample.h         |   34 +
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++
 .../test.d/dynevent/eprobes_syntax_errors.tc       |    6 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   12 
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   12 
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 
 19 files changed, 770 insertions(+), 159 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
