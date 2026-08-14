Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFBF48AE04;
	Fri, 14 Aug 2026 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723547; cv=none; b=AUF1fW8QwGHYz0RIxFrjCbgd6FILcvlqb+O8iPJ8EimSsYkCxzU5mQ4gy7H4SLQJexeCtQJq+aG5iYSiJVfkEZ1VWcjQIZS2HxN6C9RxyHbWp+AP959BrbdGBZwU9zH1F4jrQb6pSpiSkS7g3GAqyEzM4Gl4LnjKFvtw94XPX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723547; c=relaxed/simple;
	bh=L8GsF73UnKkggtrCxHY/AZeQySCCSFf5WblsqBgisdc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b0OH4HmPldA6PBgXijy1lt6tyaXAUJACdBDMaOJfiu5j4zXP+ZQFz/BTvLXwVOT+epMN0m5T/9efdp6+/T5RJKu5hwS0woXOt2UuW55151p5Owr51dG8WhEvlurtat9eZdykTTPOBFWCTf79ds9PToWq6D7TyZa7OJNwaK+MEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrXPY0s1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrXPY0s1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829ED1F000E9;
	Fri, 14 Aug 2026 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786723528;
	bh=Q5nalS8clh6zVc3SzWMnKZJ3lcpnCa5AuqNQUNumrEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LrXPY0s1PpQURSOt5GR9cvpVCHL1d/OFgWH0ZVda6JjzAv5hlMqFsOoOTMr0QetTa
	 GhQMfrkVrtWh+tdlaYI+fyeUq4qAltEdxKXg1lf3GVUZGqZ0qlYt1kzMlwkADlEAjS
	 FkHq5WcFV/A90mPRrgngDG4V0UiQ3Nw1ytH6bSRbAVa5E4ih3u6FmKw0QFQlq/EsTB
	 WQltN3ZdHANAbwXrMxqMIAHEcoNU/QWLTNnIYsWvap/ltwJqzPdKRs8rD/HHMWzZPL
	 uYQkgj4yQwq5uQhcXk8u11fLJH/viY3QIP3OxtyS2g7QcBH/4NuCXBJqC33Bc/H+i0
	 DiaC43AyYbtJA==
Date: Sat, 15 Aug 2026 01:05:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] selftests/ftrace: Add a boottime tracing test
 framework
Message-Id: <20260815010524.b361dc036dd2e997d23cc421@kernel.org>
In-Reply-To: <178649540853.438282.4271870161169100680.stgit@devnote2>
References: <178649540853.438282.4271870161169100680.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

Would you have any comment on this? I would like to pick this to probes/for-next
for ensuring boottime tracing works correctly.

Thank you,

On Wed, 12 Aug 2026 09:43:28 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> This is the v3 series of the boottime tracing test framework to selftests/ftrace.
> This test builds initramfs from busybox binary and test scripts, and run it on
> QEMU with modified cmdline and bootconfig.
> 
> The previous version is here:
> 
>  https://lore.kernel.org/all/178646245730.428104.4400499381224001727.stgit@devnote2/
> 
> In this version, I fixed some issues pointed by Sashiko[1] and add "# APPLETS:"
> line support for test script. See below changelog for details.
> 
> [1] https://sashiko.dev/#/patchset/178646245730.428104.4400499381224001727.stgit%40devnote2
> 
> Changes in v3:
> [1/4]
>  - Require file command and check kernel binary architecture via file -bL
>    instead of matching kernel path string in run_boottime_test.sh.
>  - Use 'cp -L' when copying BUSYBOX into initramfs to dereference
>    symbolic links.
>  - Use 'ln -sf' when creating BusyBox applet symlinks in initramfs.
>  - Add support for '# APPLETS: <applets>' header in test scripts to
>    dynamically create BusyBox applet symlinks in initramfs.
>  - Update boottime test README to document file command dependency and
>    '# APPLETS:' header syntax.
> [3/4]
>  - Add '# APPLETS: awk' header to cmdline-03-trace-buf-size.sh to request
>    awk applet in initramfs.
> 
> Changes in v2:
> [1/4]
>  - Add top-level boottime-ktap wrapper script and include it in
>    TEST_PROGS in Makefile.
>  - Define BUSYBOX_APPLETS as a global array variable including sleep
>    and sed.
>  - Require timeout tool in run_boottime_test.sh and README, and always
>    invoke QEMU under timeout command to prevent infinite execution loops.
>  - Add fallback sleep loop safeguard (sleep 100 || break) in guest
>    init script.
>  - Support multi-line .qemuopts files using read -r -d '' -a qemu_args.
> [3/4]
>  - Fix buffer_size_kb parsing in cmdline-03-trace-buf-size.sh to handle
>    unexpanded buffer string output '1 (expanded: 2048)'.
>  - Use grep -qw in cmdline-04-trace-options.sh to match word options
>    and avoid matching disabled 'no<option>' entries.
> [4/4]
>  - Increase reserve_mem alignment to 32M (reserve_mem=12M:32M:trace) to
>    ensure stable physical memory placement across KASLR reboots.
> 
> The new run_boottime_test.sh can run tests not only for boottime trace
> but also other kernel cmdline tracing options, including persistent
> ring buffer and its backup.
> 
> Overview
> --------
> The test runner (`run_boottime_test.sh`) constructs a lightweight initramfs
> with busybox and a tracefs checker script from `tests/`, attaches optional
> bootconfigs from `bootconfigs/` using the `bootconfig` tool, applies optional
> command-line parameters from `cmdlines/`, boots the target kernel image under
> QEMU, and reports results according to TAP version 13 format.
> 
> Here is an example usage of the test.
> -----
> $ ./tools/testing/selftests/ftrace/boottime/run_boottime_test.sh -k ${BUILD_PATH}/arch/x86/boot/bzImage
> TAP version 13
> 1..14
> ok 1 01-kprobe
> ok 2 02-synth
> ok 3 03-eprobe
> ok 4 04-fprobe
> ok 5 05-tprobe
> ok 6 06-instance
> ok 7 cmdline-01-ftrace
> ok 8 cmdline-02-trace-event
> ok 9 cmdline-03-trace-buf-size
> ok 10 cmdline-04-trace-options
> ok 11 cmdline-05-trace-clock
> ok 12 cmdline-06-trace-instance
> ok 13 persistent-01-reserve-mem
> ok 14 persistent-02-backup-instance
> # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0
> -----
> 
> Note that this requires QEMU, busybox and some other tools to run, see README
> for more information. If those tools are not installed, this test will be
> skipped.
> 
> Other discussion
> ----------------
> BTW, I found other similar shell scripts under kselftest for other subsystems.
> I think we can make an integrated (standard) QEMU test framework in the
> kselftest common directory and reuse it.
> Also, maybe we can reconsider using ktest.pl to run these tests.
> 
> 
> Thanks,
> 
> ---
> base-commit: 29a86c5e6361caffa7e75e891169e813f82ff688
> 
> Masami Hiramatsu (Google) (4):
>       selftests/ftrace: Add generic boot tracing test framework
>       selftests/ftrace: Add boot-time tracing testcases
>       selftests/ftrace: Add kernel cmdline tracing testcases
>       selftests/ftrace: Add persistent ring buffer testcases
> 
> 
>  tools/testing/selftests/ftrace/Makefile            |    4 
>  tools/testing/selftests/ftrace/boottime-ktap       |    6 
>  tools/testing/selftests/ftrace/boottime/Makefile   |   10 
>  tools/testing/selftests/ftrace/boottime/README     |   74 ++++
>  .../ftrace/boottime/bootconfigs/01-kprobe.bconf    |    4 
>  .../ftrace/boottime/bootconfigs/02-synth.bconf     |    4 
>  .../ftrace/boottime/bootconfigs/03-eprobe.bconf    |    4 
>  .../ftrace/boottime/bootconfigs/04-fprobe.bconf    |    4 
>  .../ftrace/boottime/bootconfigs/05-tprobe.bconf    |    4 
>  .../ftrace/boottime/bootconfigs/06-instance.bconf  |    5 
>  .../boottime/cmdlines/cmdline-01-ftrace.cmdline    |    1 
>  .../cmdlines/cmdline-02-trace-event.cmdline        |    1 
>  .../cmdlines/cmdline-03-trace-buf-size.cmdline     |    1 
>  .../cmdlines/cmdline-04-trace-options.cmdline      |    1 
>  .../cmdlines/cmdline-05-trace-clock.cmdline        |    1 
>  .../cmdlines/cmdline-06-trace-instance.cmdline     |    1 
>  .../cmdlines/persistent-01-reserve-mem.cmdline     |    1 
>  .../cmdlines/persistent-02-backup-instance.cmdline |    1 
>  .../selftests/ftrace/boottime/run_boottime_test.sh |  403 ++++++++++++++++++++
>  .../selftests/ftrace/boottime/tests/01-kprobe.sh   |   25 +
>  .../selftests/ftrace/boottime/tests/02-synth.sh    |   25 +
>  .../selftests/ftrace/boottime/tests/03-eprobe.sh   |   25 +
>  .../selftests/ftrace/boottime/tests/04-fprobe.sh   |   25 +
>  .../selftests/ftrace/boottime/tests/05-tprobe.sh   |   25 +
>  .../selftests/ftrace/boottime/tests/06-instance.sh |   30 +
>  .../ftrace/boottime/tests/cmdline-01-ftrace.sh     |   19 +
>  .../boottime/tests/cmdline-02-trace-event.sh       |   26 +
>  .../boottime/tests/cmdline-03-trace-buf-size.sh    |   29 +
>  .../boottime/tests/cmdline-04-trace-options.sh     |   23 +
>  .../boottime/tests/cmdline-05-trace-clock.sh       |   19 +
>  .../boottime/tests/cmdline-06-trace-instance.sh    |   24 +
>  .../boottime/tests/persistent-01-reserve-mem.sh    |   28 +
>  .../tests/persistent-02-backup-instance.sh         |   40 ++
>  tools/testing/selftests/ftrace/config              |    6 
>  34 files changed, 897 insertions(+), 2 deletions(-)
>  create mode 100755 tools/testing/selftests/ftrace/boottime-ktap
>  create mode 100644 tools/testing/selftests/ftrace/boottime/Makefile
>  create mode 100644 tools/testing/selftests/ftrace/boottime/README
>  create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/01-kprobe.bconf
>  create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/02-synth.bconf
>  create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/03-eprobe.bconf
>  create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/04-fprobe.bconf
>  create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/05-tprobe.bconf
>  create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/06-instance.bconf
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/persistent-01-reserve-mem.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/persistent-02-backup-instance.cmdline
>  create mode 100755 tools/testing/selftests/ftrace/boottime/run_boottime_test.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/01-kprobe.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/02-synth.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/03-eprobe.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/04-fprobe.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/05-tprobe.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/06-instance.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve-mem.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-instance.sh
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
