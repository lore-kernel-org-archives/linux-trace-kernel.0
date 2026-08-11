Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659513B14B5;
	Tue, 11 Aug 2026 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462463; cv=none; b=i+I2BCIG1s/wjgRsf/M1mAE64FCHOdlSfeXbFw8ylkOxRM6VcoQWXVWLelJc87qNgnczWP43CuU0NUsSs6LJRdzduZsXKbI+UwEGC0dO1xa4SieTSHEhP92CL89mbs721Q78cAREZosbFlPLX9G0vcyKpNkaq9HSfbQWzlVOk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462463; c=relaxed/simple;
	bh=dK/7PjrB/Ti1xoT1NZt3kz9ox166YwEeWWZZTn91mhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s35ZjVSXrflcTt3zJmRE241w17hJ/dMYUroXw+f+T7Un9zbzAwuk3lImlNWYOH4+BSSCpyQ7fBVnEyhodbr0GGP66BSfYen2sS/FaJKyYOUVcVavSfqeBR0lxKmm5VyPlvJ3tDepDnK4YKVjlzLHQrnHb+pOWSdEM9RGIilHA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROGdEoGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROGdEoGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213D81F000E9;
	Tue, 11 Aug 2026 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462462;
	bh=i6XIEhaW4zxw9Q4Q6BSb4wq2gbDF+f1U1MJqj2sbru8=;
	h=From:To:Cc:Subject:Date;
	b=ROGdEoGXE3TIdmulMvUKRtS0QZGsV4w/PJVWqwHiRppW1XiBq+KhCbWhca477tj/y
	 7pwzmrMB71da4DdRIb7o+f4QT9VV4u2JaEug1QWe1vYGv/soExXOAa3y18t8oAfYKN
	 ksWdFt6P3R5bpPwuuD4lx8Usv8wHtRHz5SMQSIWUzMvOLR0knNcECijrsd18ClGlLx
	 4Pkip17PIyerVk5Do7x9wjpAJ4BbTEd/T92YPhpd1v3yXPKLyLdi6T1Ag71iKD8yFT
	 LDNMW1EYfQDsVG82gbkrJwTNqDHfDd1QvnIQyjt8Yw2j96nr083y2xH+YaZXIG21Ht
	 OeRDVLno2mEKA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/4] selftests/ftrace: Add a boottime tracing test framework
Date: Wed, 12 Aug 2026 00:34:17 +0900
Message-ID: <178646245730.428104.4400499381224001727.stgit@devnote2>
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

This is the v2 series of the boottime tracing test framework to selftests/ftrace.
Previous version is here:

 https://lore.kernel.org/all/178635442508.380779.3709136256425432083.stgit@devnote2/

In this version, I fixed some issues pointed by Sashiko[1]. See below changelog
for details.
[1] https://sashiko.dev/#/patchset/178635442508.380779.3709136256425432083.stgit%40devnote2

Changes in v2:
[1/4]
 - Add top-level boottime-ktap wrapper script and include it in
   TEST_PROGS in Makefile.
 - Define BUSYBOX_APPLETS as a global array variable including sleep
   and sed.
 - Require timeout tool in run_boottime_test.sh and README, and always
   invoke QEMU under timeout command to prevent infinite execution loops.
 - Add fallback sleep loop safeguard (sleep 100 || break) in guest
   init script.
 - Support multi-line .qemuopts files using read -r -d '' -a qemu_args.
[3/4]
 - Fix buffer_size_kb parsing in cmdline-03-trace-buf-size.sh to handle
   unexpanded buffer string output '1 (expanded: 2048)'.
 - Use grep -qw in cmdline-04-trace-options.sh to match word options
   and avoid matching disabled 'no<option>' entries.
[4/4]
 - Increase reserve_mem alignment to 32M (reserve_mem=12M:32M:trace) to
   ensure stable physical memory placement across KASLR reboots.

The new run_boottime_test.sh can run tests not only for boottime trace
but also other kernel cmdline tracing options, including persistent
ring buffer and its backup.

Overview
--------
The test runner (`run_boottime_test.sh`) constructs a lightweight initramfs
with busybox and a tracefs checker script from `tests/`, attaches optional
bootconfigs from `bootconfigs/` using the `bootconfig` tool, applies optional
command-line parameters from `cmdlines/`, boots the target kernel image under
QEMU, and reports results according to TAP version 13 format.

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

Note that this requires QEMU, busybox and some other tools to run, see README
for more information. If those tools are not installed, this test will be
skipped.

Other discussion
----------------

BTW, I found other similar shell scripts under kselftest for other subsystems.
I think we can make an integrated (standard) QEMU test framework in the
kselftest common directory and reuse it.
Also, maybe we can reconsider using ktest.pl to run these tests.


Thanks,

---
base-commit: 29a86c5e6361caffa7e75e891169e813f82ff688

Masami Hiramatsu (Google) (4):
      selftests/ftrace: Add generic boot tracing test framework
      selftests/ftrace: Add boot-time tracing testcases
      selftests/ftrace: Add kernel cmdline tracing testcases
      selftests/ftrace: Add persistent ring buffer testcases


 tools/testing/selftests/ftrace/Makefile            |    4 
 tools/testing/selftests/ftrace/boottime-ktap       |    6 
 tools/testing/selftests/ftrace/boottime/Makefile   |   10 +
 tools/testing/selftests/ftrace/boottime/README     |   72 ++++
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
 .../selftests/ftrace/boottime/run_boottime_test.sh |  384 ++++++++++++++++++++
 .../selftests/ftrace/boottime/tests/01-kprobe.sh   |   25 +
 .../selftests/ftrace/boottime/tests/02-synth.sh    |   25 +
 .../selftests/ftrace/boottime/tests/03-eprobe.sh   |   25 +
 .../selftests/ftrace/boottime/tests/04-fprobe.sh   |   25 +
 .../selftests/ftrace/boottime/tests/05-tprobe.sh   |   25 +
 .../selftests/ftrace/boottime/tests/06-instance.sh |   30 ++
 .../ftrace/boottime/tests/cmdline-01-ftrace.sh     |   19 +
 .../boottime/tests/cmdline-02-trace-event.sh       |   26 +
 .../boottime/tests/cmdline-03-trace-buf-size.sh    |   28 +
 .../boottime/tests/cmdline-04-trace-options.sh     |   23 +
 .../boottime/tests/cmdline-05-trace-clock.sh       |   19 +
 .../boottime/tests/cmdline-06-trace-instance.sh    |   24 +
 .../boottime/tests/persistent-01-reserve-mem.sh    |   28 +
 .../tests/persistent-02-backup-instance.sh         |   40 ++
 tools/testing/selftests/ftrace/config              |    6 
 34 files changed, 875 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/ftrace/boottime-ktap
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
