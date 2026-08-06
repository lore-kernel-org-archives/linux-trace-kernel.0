Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3053A1A3B;
	Thu,  6 Aug 2026 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978417; cv=none; b=LRMKPOZ88kCmQmzRNrGxlXfAknC6zCiwkSGMgKT36Yh3C/h2btxRtXeUUd5UFkMLEABk0Gh/S7KiXNnqArsw2Ps9VaPztfAFkMNLNtb0odnUkJlT+1aHpZB/MOm2jcDGYHup3hJ1avwB22n9pqIJJz/kchbjeG3trf/EQAITDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978417; c=relaxed/simple;
	bh=n1b5IPEJmAwc6hKByeexBWZDSkHDUG0n5p9bLv6RTEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V5+X9oLxkv6xCVH19XVMkbKVUAOPAP3bJ2OMH1/9dAOB9gX3GYVcKMsmalEHSiMAJLDRAjP0LRye0AzqdWaEhR40OdkWTvz220pHh4PSf2XczOptS+Y1SzxyhE15A1hG+S4lFuuLPyWVTdRY61EvSBwNli9Eh5ldJZlDazp0xKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXE8tK8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXE8tK8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9D61F000E9;
	Thu,  6 Aug 2026 01:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785978415;
	bh=fl1bXuz8fv2H8f+MlenGdzxtKllBaHVSN2IriBd9AAQ=;
	h=From:To:Cc:Subject:Date;
	b=WXE8tK8MswwfOuvJULMuZdTGXtj2BcQv52yriSmTqeRciReP1gwCdzTAG6s48a8fi
	 dnpACkbCqhQi/Atn/yX1G+n2yBkZ3gxC7KmeBXyosIQ2PP/ZyzwfpESEe8oMV8Kfo1
	 XwUXNHl6H5ra8ux8xbonJruYoB0qh/pFxfVCWA644vXxYbuzxTEehPAjzIfD5zBxDn
	 LrgHLP5pjGpeb+1W3ZsxB+PpXDTRF4qNvCIEbL7vT2uhwDcVBhZzIH18cAwEMUzw4F
	 qbcpMbiXDyfPfn35bTBUzX0/Uelk7TLaoBA+Y3ZZq73WPs1DZtZCQKexNYv2Vdida3
	 vzxOGW4VU4oRw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] tracing/boot: Support eprobe, fprobe, and tprobe events and add test framework
Date: Thu,  6 Aug 2026 10:06:51 +0900
Message-ID: <178597841107.123558.13065821394773752510.stgit@devnote2>
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

This series extends kernel boot-time tracing to support newly added
dynamic event types (eprobes, fprobes, and tracepoint probes) and introduces
an automated QEMU-based test suite under tools/tracing/boottime/.
(Note: this requires busybox binary for making initramfs.)

Patch [1/2] updates boot time tracing to handle eprobe, fprobe and
tracepoint/tprobe events from bootconfig.
Patch [2/2] introduces an automated boot-time tracing test framework in
tools/testing/selftests/ftrace/boottime. It creates a minimal initramfs
with busybox, attaches bootconfig sample files, boots QEMU, and runs
corresponding tracefs verification scripts. This test is currently working
on x86 (it should be easy to support other arch, but I don't have such host
environment.)

Thanks,

---
base-commit: ea694cdd92b6bfa123b3f5c563e47b4cf968046a

Masami Hiramatsu (Google) (2):
      tracing/boot: Add support for eprobe, fprobe, and tprobe events
      selftests/ftrace: Add boot-time tracing test framework


 Documentation/trace/boottime-trace.rst             |   18 +-
 kernel/trace/trace_boot.c                          |  113 ++++++++++
 kernel/trace/trace_dynevent.c                      |    5 
 tools/testing/selftests/ftrace/Makefile            |    2 
 tools/testing/selftests/ftrace/boottime/Makefile   |   10 +
 tools/testing/selftests/ftrace/boottime/README     |   58 +++++
 .../ftrace/boottime/bootconfigs/01-kprobe.bconf    |    5 
 .../ftrace/boottime/bootconfigs/02-synth.bconf     |    4 
 .../ftrace/boottime/bootconfigs/03-eprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/04-fprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/05-tprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/06-instance.bconf  |    5 
 .../selftests/ftrace/boottime/run_boottime_test.sh |  218 ++++++++++++++++++++
 .../selftests/ftrace/boottime/tests/01-kprobe.sh   |   18 ++
 .../selftests/ftrace/boottime/tests/02-synth.sh    |   18 ++
 .../selftests/ftrace/boottime/tests/03-eprobe.sh   |   18 ++
 .../selftests/ftrace/boottime/tests/04-fprobe.sh   |   18 ++
 .../selftests/ftrace/boottime/tests/05-tprobe.sh   |   18 ++
 .../selftests/ftrace/boottime/tests/06-instance.sh |   23 ++
 tools/testing/selftests/ftrace/config              |    4 
 20 files changed, 563 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/boottime/Makefile
 create mode 100644 tools/testing/selftests/ftrace/boottime/README
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/02-synth.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/03-eprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/04-fprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/05-tprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/06-instance.bconf
 create mode 100755 tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/02-synth.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/03-eprobe.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/04-fprobe.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/05-tprobe.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/06-instance.sh

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
