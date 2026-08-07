Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7D4503F5;
	Fri,  7 Aug 2026 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139047; cv=none; b=c0vdnvZBb1CcBXmFiSRZwcQx7J3/rf6bgjkCGmTdhccsFuOY/+axwi+kM15ajwbxs9EpT/5BF9erYR6vTvbGSIaNc26hbMYmhbwY0lrlVJR29K7wEuZwrbquv+njgmg1+2OhvIoXy0tFWtPfUQJCgdh3vVd8eQJuTofu09YgofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139047; c=relaxed/simple;
	bh=JQcWIT+1S/tWgjvXfbDkpTr7gOUS5VS5O+trfb/ofAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SUOJkhbIHJpHXaX0yeIHzZ6lCG7w8blwgb9PxfUvEFvCUKeFUU5wuKeXXurB/Etw6BBVecbU2Bkk1v/6rVDL8F9eLDI5wJaz8+mL3TQYIG0zHL8MGjZKBJdXGU3s7NwXKFDqE/aUTY7iM3xUy7FVriRXZCT+AaV+qk7FjoBbOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYijX0wk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYijX0wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF58C1F000E9;
	Fri,  7 Aug 2026 21:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786139045;
	bh=5/o05a6r7jF5fualbliVrZ++Vos0kZBurmfa59XjZxI=;
	h=From:To:Cc:Subject:Date;
	b=cYijX0wkC2o/BnFl3/7nm3AjIiht3PJoPullB6igA5OibuV5VVZUt2C+ft0jPwHpm
	 Yd7BiT5hLUfn+WTyrpTywzRikOaTjGBol+hUivDEtbE/Hv8NesVuHPQz1i7RRiKxzq
	 hdXHm5W4GHxrAEuSFunES3w3TEjwMdEz4fIEuOqIwZgt3rqcKShZQjoNT3s9DT0/tM
	 aPoik4m08R8qi3f0/n8mWd6pqco+o2umXUmGq9uFX3cETaQBs8IwtIWvEC2h3nM6fs
	 97LuCcbmdpuMqJShvQGpmiKH3VTmUI0WHYX6WTuQxN1PLAaokLCWt2ISiobODqKR+R
	 P7Dht4LrTXKQw==
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
Subject: [PATCH v3 0/2] tracing/boot: Support eprobe, fprobe, and tprobe events and add test framework
Date: Sat,  8 Aug 2026 06:44:01 +0900
Message-ID: <178613904128.259829.16130019979800943264.stgit@devnote2>
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

This is the 3rd version of series to extend kernel boot-time tracing to
support newly added dynamic event types (eprobes, fprobes, and tracepoint
probes) and introduces an automated QEMU-based test suite under
tools/testing/selftests/ftrace/boottime/.
The previous version is here:

 https://lore.kernel.org/all/178602969872.141946.3932041319962687996.stgit@devnote2/

Changes in v3:
 - tracing/boot: Check return values of strscpy() and snprintf() in
   trace_boot_add_probe_event() to prevent silent buffer truncation.
 - selftests/ftrace: Remove boottime/run_boottime_test.sh from
   TEST_PROGS_EXTENDED in Makefile to prevent lib.mk from flattening it
   into top-level ftrace/ on make install.
 - selftests/ftrace: Support executing run_boottime_test.sh both in-tree
   and in installed kselftest environment.
 - selftests/ftrace: Add HUP, INT, and TERM signal handlers to tempdir
   cleanup trap.
 - selftests/ftrace: Validate workdir creation and update
   run_single_test() to return 0 on test failure so set -e is not
   suspended by invocation in an AND-OR list.

Changes in v2:
 - Fix raw command detection logic for eprobes, fprobes, and tprobes
   by requiring ':' or isspace() after type prefix.
 - Consolidate duplicate loop logic into trace_boot_add_probe_event()
   helper function.
 - Copy shared library dependencies using ldd if busybox is dynamically
   linked.
 - Wrap QEMU execution with timeout command and add -T/--timeout CLI
   option.
 - Add pre-flight checks for busybox architecture compatibility and
   cpio tool in run_boottime_test.sh.
 - Fix POSIX syntax compatibility and allow bypassing HOST_ARCH skip
   when custom kernel/QEMU parameters are passed.
 - Add boottime/run_boottime_test.sh to TEST_PROGS_EXTENDED in
   selftests/ftrace/Makefile.

Thanks,

---
base-commit: 54f133c6178d06b169dceae18cc92c4945933b8c

Masami Hiramatsu (Google) (2):
      tracing/boot: Add support for eprobe, fprobe, and tprobe events
      selftests/ftrace: Add boot-time tracing test framework


 Documentation/trace/boottime-trace.rst             |   18 +
 kernel/trace/trace_boot.c                          |   97 +++++++
 kernel/trace/trace_dynevent.c                      |    5 
 tools/testing/selftests/ftrace/Makefile            |    2 
 tools/testing/selftests/ftrace/boottime/Makefile   |   10 +
 tools/testing/selftests/ftrace/boottime/README     |   58 ++++
 .../ftrace/boottime/bootconfigs/01-kprobe.bconf    |    5 
 .../ftrace/boottime/bootconfigs/02-synth.bconf     |    4 
 .../ftrace/boottime/bootconfigs/03-eprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/04-fprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/05-tprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/06-instance.bconf  |    5 
 .../selftests/ftrace/boottime/run_boottime_test.sh |  271 ++++++++++++++++++++
 .../selftests/ftrace/boottime/tests/01-kprobe.sh   |   18 +
 .../selftests/ftrace/boottime/tests/02-synth.sh    |   18 +
 .../selftests/ftrace/boottime/tests/03-eprobe.sh   |   18 +
 .../selftests/ftrace/boottime/tests/04-fprobe.sh   |   18 +
 .../selftests/ftrace/boottime/tests/05-tprobe.sh   |   18 +
 .../selftests/ftrace/boottime/tests/06-instance.sh |   23 ++
 tools/testing/selftests/ftrace/config              |    4 
 20 files changed, 600 insertions(+), 4 deletions(-)
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
