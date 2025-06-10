Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F52A1BF;
	Tue, 10 Jun 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749515271; cv=none; b=MCwafwGJpjKCnh7EE4BWzRveEUYvjtd9R23Hk/GHEjOKiUM0pQTt3bbeHdvLY66ehZktxrNSNTEUJj9F62CFSMQ0Fbb/VW4gfwwuGFKIaO0NC87u6ERtLX/RYJz/06SLnNKLLkgAll5X9DZZDK8J2BMAm3Q++iKiPpH26GKUE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749515271; c=relaxed/simple;
	bh=cpHQeBF27zHGQHWG/rVLTKUoz1iYVbYnx7lUbYJioCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqAQQSUlBZIjmnJLaDM/7vmFVqOQwqw3ChtUb5vKuvc2FKC60rdLGiWeGdN0aQOOaqg1SzNs+brq0W444sVVIVSGwQDSCK1W/+HE5mQGn6s856EUG9vWzQKgJ7EMhxeKj2dIet33poyiyRjxt+6Z+z/XAaM139oVeNqK2PohJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 06D418065A;
	Tue, 10 Jun 2025 00:27:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id E711C2F;
	Tue, 10 Jun 2025 00:27:42 +0000 (UTC)
Date: Mon, 9 Jun 2025 20:29:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Masami Hiramatsu <mhiramat@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-ID: <20250609202911.2e25f528@gandalf.local.home>
In-Reply-To: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E711C2F
X-Stat-Signature: n5e6p39xhrcxewrmtf6qgw5timpgabmy
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ZjXJReMgOFSLQfgw0U9IgsFYl/V0RtRo=
X-HE-Tag: 1749515262-39919
X-HE-Meta: U2FsdGVkX18tEsfiPuU5ryucdfb9zRKArBFbJaS75xlyGybrV4Fgy9UPIQOHvt1RrwEgFuyCkj+UsRx0q8DNeT768RgczmwK5S8rkqw86XheE6pIZ4p/f13ZfaXdRoxOxR90JsFiv9i1Ag5VC+sUqcwJzDXXAv8NBXDGF8ShtGld7zWsdrcOA+LcAIG/2AFTvIY6RyVR0NB9N+hTmp1cdHxPrwMWkEC4Nu1+2LNUWi5zUUCaUmM87yfkaJcsmqJLLIFZ0Jp4orobu0torBlmPQtcSSSl1FtA4qlUmsc3Ut1dOKyZRpuslkJByPj84ogNyxxc519ackHnlpwW+Fgcm/PDVQGO2C4AKD2X3V/QgjKbqsArIGbuZecLdNeiwGwK90fEnVkKi6w2w0RwYcRwCEpjRiZ7wgGgJlNk275kRVfljltV52DoHbeK1tesSKjL/YFx8KwFOxcbhR5RkC8eR/FgpNdYiUW2bQ65w0dXv9xFOzFO2w3bmg==


[ Adding x86 and text_poke folks ]

On Thu, 5 Jun 2025 17:12:10 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Regressions found on qemu-x86_64 with compat mode (64-bit kernel
> running on 32-bit userspace) while running LTP tracing test suite
> on Linux next-20250605 tag kernel.
> 
> Regressions found on
>  - LTP tracing
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducible? Intermittent
> 
> Test regression: qemu-x86_64-compat mode ltp tracing Oops int3 kernel panic
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Test log
> ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
> starting test ftrace-stress-test (ftrace_stress_test.sh 90)
> <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI

Did anything change with text_poke? Ftrace just happens to stress text_poke
more than anything else, as it updates tens of thousands of locations at a time.

The ftrace code hasn't changed in a while, but I think there's been updates
to text_poke.

The modifying of code and adding and removing the int3 handler needs to be
synchronized correctly or something like this bug can happen.

-- Steve


> <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
> 6.15.0-next-20250605 #1 PREEMPT(voluntary)
> <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
> <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> 0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> 12 e4 fe
> <4>[   58.998610] RSP: 0018:ffff9494007bbe98 EFLAGS: 00000246
> <4>[   58.998715] RAX: ffff912a042edd00 RBX: 000000000000000b RCX:
> 0000000000000000
> <4>[   58.998727] RDX: 0000000000000000 RSI: 0000000000000006 RDI:
> ffff912a00f2c8c0
> <4>[   58.998737] RBP: ffff9494007bbeb8 R08: 0000000000000000 R09:
> 0000000000000000
> <4>[   58.998748] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff912a00f2c8c0
> <4>[   58.998759] R13: ffff912a00f2c840 R14: 0000000000000006 R15:
> 0000000000000000
> <4>[   58.998804] FS:  0000000000000000(0000)
> GS:ffff912ad7cbf000(0063) knlGS:00000000f7f05580
> <4>[   58.998821] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> <4>[   58.998832] CR2: 00000000f7d8f890 CR3: 000000010124e000 CR4:
> 00000000000006f0
> <4>[   58.998915] Call Trace:
> <4>[   58.999010]  <TASK>
> <4>[   58.999077]  ? file_close_fd+0x32/0x60
> <4>[   58.999147]  __ia32_sys_close+0x18/0x90
> <4>[   58.999172]  ia32_sys_call+0x1c3c/0x27e0
> <4>[   58.999183]  __do_fast_syscall_32+0x79/0x1e0
> <4>[   58.999194]  do_fast_syscall_32+0x37/0x80
> <4>[   58.999203]  do_SYSENTER_32+0x23/0x30
> <4>[   58.999211]  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> <4>[   58.999254] RIP: 0023:0xf7f0c579
> <4>[   58.999459] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10
> 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5
> 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 2e 8d b4 26 00 00 00 00 8d b4 26
> 00 00 00
> <4>[   58.999466] RSP: 002b:00000000fff98500 EFLAGS: 00000206
> ORIG_RAX: 0000000000000006
> <4>[   58.999479] RAX: ffffffffffffffda RBX: 000000000000000b RCX:
> 0000000000000000
> <4>[   58.999484] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> <4>[   58.999488] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000000
> <4>[   58.999492] R10: 0000000000000000 R11: 0000000000000206 R12:
> 0000000000000000
> <4>[   58.999497] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> <4>[   58.999534]  </TASK>
> <4>[   58.999579] Modules linked in:
> <4>[   58.999895] ---[ end trace 0000000000000000 ]---
> <4>[   58.999892] Oops: int3: 0000 [#2] SMP PTI
> <4>[   58.999997] RIP: 0010:_raw_spin_lock+0x5/0x50
> <4>[   59.000008] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> 0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> 12 e4 fe
> <4>[   59.000010] CPU: 1 UID: 0 PID: 339 Comm: sh Tainted: G      D
>          6.15.0-next-20250605 #1 PREEMPT(voluntary)
> <4>[   59.000014] RSP: 0018:ffff9494007bbe98 EFLAGS: 00000246
> <4>[   59.000021] RAX: ffff912a042edd00 RBX: 000000000000000b RCX:
> 0000000000000000
> <4>[   59.000026] RDX: 0000000000000000 RSI: 0000000000000006 RDI:
> ffff912a00f2c8c0
> <4>[   59.000030] RBP: ffff9494007bbeb8 R08: 0000000000000000 R09:
> 0000000000000000
> <4>[   59.000040] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff912a00f2c8c0
> <4>[   59.000044] R13: ffff912a00f2c840 R14: 0000000000000006 R15:
> 0000000000000000
> <4>[   59.000049] FS:  0000000000000000(0000)
> GS:ffff912ad7cbf000(0063) knlGS:00000000f7f05580
> <4>[   59.000054] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> <4>[   59.000059] CR2: 00000000f7d8f890 CR3: 000000010124e000 CR4:
> 00000000000006f0
> <4>[   59.000070] Tainted: [D]=DIE
> <4>[   59.000080] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> <4>[   59.000085] RIP: 0010:_raw_spin_lock+0x5/0x50
> <4>[   59.000101] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> 0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> 12 e4 fe
> <4>[   59.000108] RSP: 0018:ffff9494000e0e88 EFLAGS: 00000097
> <4>[   59.000117] RAX: 0000000000010002 RBX: ffff912a7bd29500 RCX:
> ffff912a7bd2a400
> <0>[   59.000179] Kernel panic - not syncing: Fatal exception in interrupt
> <0>[   60.592321] Shutting down cpus with NMI
> <0>[   60.593242] Kernel Offset: 0x20800000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> <0>[   60.618536] ---[ end Kernel panic - not syncing: Fatal exception
> in interrupt ]---
> 
> ## Source
> * Kernel version: 6.15.0-next-20250605
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: 4f27f06ec12190c7c62c722e99ab6243dea81a94
> 
> ## Build
> * Test log: https://qa-reports.linaro.org/api/testruns/28675335/log_file/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2y4whKazVqJKOUFD08taHC8XHRq/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2y4whKazVqJKOUFD08taHC8XHRq/config
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

