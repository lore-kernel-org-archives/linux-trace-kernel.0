Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF638A72B;
	Mon,  8 Jun 2026 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928662; cv=none; b=MryxTjjiIaFZclZHBTgw3OxNYl3jUq9tcPo0GLhDLEnp0ZvyEYLVftKLuvupeEyE/QtJWAGJ5WmLl3ot2rZFG/0vMD+HVD1yos0FlZNiXqyVzvU+vgq/7tU3fb0tbEZVuaBH1h7N43wV6+wZeivlVnZHjXtT5diWGq+lVr0Ommg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928662; c=relaxed/simple;
	bh=QRE7yBxmt6dZDSBRemCh6llijh3yzWyacNI7zuU+HTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i8j22oY+twjH9+eeDn9wgUPFI9d1ebBh437zmmP5eJx+ycO6aC6rkwdr7qr0giXI7S3xEcFk8VoUs4CNoSLChZ0zdzsRz+Sr75elrMmS+kPtObdFok2nOQX80AWK+ELypyUfXiylc98w8+imNZ568sxTboNsQcykUWEhFPgDtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f77AGlaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f77AGlaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C0F1F00893;
	Mon,  8 Jun 2026 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780928661;
	bh=cjX8+061TbVjwdZkrMpGGF5UrC/j9HGWiAY7267pDNU=;
	h=From:To:Cc:Subject:Date;
	b=f77AGlaS6HBVxqhZkkJaK6b99hh1j5WLUqwlOcQ4XHW6uh23v4gv3Axcvhfndj9rA
	 fm623nHWTCJHysS1H1cXErOtZ6ooF6tjKuANecAJVYPssg25xjy6XY7/B7Q2YKzwMA
	 eya8VzYYnbDujPfFUHYWWn++cY4jOZUCzfOQEbYJKW6WI5UZA0Nh5nQQ3+WlnYnBaU
	 5QasU3GPek1KhPSyQJ3KkQsg24UACh4cDz6F5Tuldh7J10Tpl5TSziNCrENGJeI4dS
	 vxRklYAiC8owVwkeDW4pkiENIsSKAPZcty9tPgFnnro/M54q5zUoDfPJLJi7egOwZp
	 Xoor4wX2gLUyg==
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
Subject: [RFC PATCH 0/7] tracing/probes: Add more typecast features
Date: Mon,  8 Jun 2026 23:24:16 +0900
Message-ID: <178092865666.163648.10457567771536160909.stgit@devnote2>
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

Here is a series of patches to introduce more typecast features
to probe events, which includes 1. expanding BTF typecast to
fprobe and kprobe events, 2. introducing container_of like typecst
option, 3. supporting nested typecast, 4. adding $current special
variable support, 5. adding per-cpu dereference support, 6. adding
a testcase to check typecasts.

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

   +CPU(VAR) is the same as this_cpu_read(VAR), and
   +PCPU(VAR) is the same as this_cpu_ptr(VAR).
   Also, "this_cpu_ptr(VAR)" is available. This is good
   with nesting expression.

   (STRUCT)(this_cpu_ptr(VAR))->MEMBER

   (However, it might be better to allow a special way to omit
    parentheses for thi_cpu_ptr())

And added a test script to test part of them.

[1] https://lore.kernel.org/all/20260601130746.2139d926@gandalf.local.home/


---

Masami Hiramatsu (Google) (7):
      tracing/probes: Support typecast for various probe events
      tracing/probes: Support nested typecast
      tracing/probes: Support field specifier option for typecast
      tracing/probes: Add $current variable support
      tracing/probes: Add +CPU() and +PCPU() dereference method to fetcharg
      tracing/probes: Support reserved this_cpu_ptr() method
      tracing/probes: Add a new testcase for BTF typecasts


 Documentation/trace/eprobetrace.rst                |   11 +
 Documentation/trace/fprobetrace.rst                |   11 +
 Documentation/trace/kprobetrace.rst                |   12 +
 kernel/trace/trace.c                               |    6 
 kernel/trace/trace_probe.c                         |  312 +++++++++++++++-----
 kernel/trace/trace_probe.h                         |   12 +
 kernel/trace/trace_probe_tmpl.h                    |   33 ++
 samples/trace_events/trace-events-sample.c         |   38 ++
 samples/trace_events/trace-events-sample.h         |   34 ++
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   52 +++
 10 files changed, 422 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

--
Signature
