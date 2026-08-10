Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2BF3AFCF3;
	Mon, 10 Aug 2026 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354430; cv=none; b=ZtFwH+IDMui6KHWnQo0NKjj47Y9+KLEZYiiNxZOsFCUNlZ7WwCDgsUYwNlCK812CcTQrfaVMJc0E05nJbiKc1/HAMSCt753MVBNJiIEqiNGwQxe2hOGi//9+GA70/xxfBwOhtlOQMVqywbiuRquiFDGLOVh1MYxRX0RZgqSuWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354430; c=relaxed/simple;
	bh=nuRth1NWMlGonkkWVwij5r+CQGcnCnQhMbGKaFC6OJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cmeyYsPk4fAvOC9oDVgXiojKpskL+FnRb5E2b+p7j0qC99Tr4lMY5g0eYnYmLd59cekJvToAdQFWJWLxTpByrVk+ylSU16CT41oKOlPxJ3WXFbhJ5a40Y5v7No+HJpTiN2Lk9unEfx6o3vGCtp4EeCqE/e7ZI5lKZgF0O7kVBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT5jXQPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT5jXQPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A1F1F000E9;
	Mon, 10 Aug 2026 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786354428;
	bh=khKUbSlK5ktk9+KgsFA7MDUpALx27X0pj/SwoRqFIGU=;
	h=From:To:Cc:Subject:Date;
	b=fT5jXQPnm+f9zadbqeojUt8bLfhSaVtEkgGq21aCfFxQUY1IsFbOkIAY2N95dPWVp
	 hWLIvvoG5Tp3PqmEtE9B0gr98F/971nWoVMSV4OJDEkGLUaXSjuQoB/iISjN3DaFu/
	 qXkD2OZFQEuA/UocAb73XF9ZpIb00lwKtm0XdmXOMP88/9bCOt2517YYR7MpyYWbgV
	 QcMWI5Rb2KrC+LAkNXhSfEFKR4kfGG+qJ71YtnUZSIuWaAs+Ef0O79aXwQWMAPIXBR
	 /bA1cI9zjKebrmcxdh9PW/p5rQO1COR5R/69u4LCJWlgOAfL2vtGeWhw2u5z/9djrB
	 dySdjuZ5yjwjg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 0/4] selftests/ftrace: Add a boottime tracing test framework
Date: Mon, 10 Aug 2026 18:33:45 +0900
Message-ID: <178635442508.380779.3709136256425432083.stgit@devnote2>
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

This series adds a boottime tracing test framework to selftests/ftrace.
This is based on v3 series[1] of the boot-time trace (via bootconfig)
testing script.

[1] https://lore.kernel.org/all/178613904128.259829.16130019979800943264.stgit@devnote2/

The new run_boottime_test.sh can run tests not only for boottime trace
but also other kernel cmdline tracing options, including persistent
ring buffer and its backup.
This makes it possible to easily detect regression bugs in the kernel
boot trace options.

Here is an example of the test output.
-----
TAP version 13
1..14
ok 1 01-kprobe
ok 2 02-synth
ok 3 03-eprobe
ok 4 04-fprobe
ok 5 05-tprobe
ok 6 06-instance
ok 7 cmdline-01-ftrace
ok 8 cmdline-02-trace-event
ok 9 cmdline-03-trace-buf-size
ok 10 cmdline-04-trace-options
ok 11 cmdline-05-trace-clock
ok 12 cmdline-06-trace-instance
ok 13 persistent-01-reserve-mem
ok 14 persistent-02-backup-instance
# Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0
-----

Thanks,

---
base-commit: 29a86c5e6361caffa7e75e891169e813f82ff688

Masami Hiramatsu (Google) (4):
      selftests/ftrace: Add generic boot tracing test framework
      selftests/ftrace: Add boot-time tracing testcases
      selftests/ftrace: Add kernel cmdline tracing testcases
      selftests/ftrace: Add persistent ring buffer testcases


 tools/testing/selftests/ftrace/Makefile            |    2 
 tools/testing/selftests/ftrace/boottime/Makefile   |   10 +
 tools/testing/selftests/ftrace/boottime/README     |   71 ++++
 .../ftrace/boottime/bootconfigs/01-kprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/02-synth.bconf     |    4 
 .../ftrace/boottime/bootconfigs/03-eprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/04-fprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/05-tprobe.bconf    |    4 
 .../ftrace/boottime/bootconfigs/06-instance.bconf  |    5 
 .../boottime/cmdlines/cmdline-01-ftrace.cmdline    |    1 
 .../cmdlines/cmdline-02-trace-event.cmdline        |    1 
 .../cmdlines/cmdline-03-trace-buf-size.cmdline     |    1 
 .../cmdlines/cmdline-04-trace-options.cmdline      |    1 
 .../cmdlines/cmdline-05-trace-clock.cmdline        |    1 
 .../cmdlines/cmdline-06-trace-instance.cmdline     |    1 
 .../cmdlines/persistent-01-reserve-mem.cmdline     |    1 
 .../cmdlines/persistent-02-backup-instance.cmdline |    1 
 .../selftests/ftrace/boottime/run_boottime_test.sh |  373 ++++++++++++++++++++
 .../selftests/ftrace/boottime/tests/01-kprobe.sh   |   25 +
 .../selftests/ftrace/boottime/tests/02-synth.sh    |   25 +
 .../selftests/ftrace/boottime/tests/03-eprobe.sh   |   25 +
 .../selftests/ftrace/boottime/tests/04-fprobe.sh   |   25 +
 .../selftests/ftrace/boottime/tests/05-tprobe.sh   |   25 +
 .../selftests/ftrace/boottime/tests/06-instance.sh |   30 ++
 .../ftrace/boottime/tests/cmdline-01-ftrace.sh     |   19 +
 .../boottime/tests/cmdline-02-trace-event.sh       |   26 +
 .../boottime/tests/cmdline-03-trace-buf-size.sh    |   19 +
 .../boottime/tests/cmdline-04-trace-options.sh     |   23 +
 .../boottime/tests/cmdline-05-trace-clock.sh       |   19 +
 .../boottime/tests/cmdline-06-trace-instance.sh    |   24 +
 .../boottime/tests/persistent-01-reserve-mem.sh    |   28 ++
 .../tests/persistent-02-backup-instance.sh         |   40 ++
 tools/testing/selftests/ftrace/config              |    6 
 33 files changed, 847 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/boottime/Makefile
 create mode 100644 tools/testing/selftests/ftrace/boottime/README
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/02-synth.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/03-eprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/04-fprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/05-tprobe.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/06-instance.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/persistent-01-reserve-mem.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/persistent-02-backup-instance.cmdline
 create mode 100755 tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/02-synth.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/03-eprobe.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/04-fprobe.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/05-tprobe.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/06-instance.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve-mem.sh
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-instance.sh

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
