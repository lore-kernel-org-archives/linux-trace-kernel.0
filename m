Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D1190664;
	Wed, 21 Jan 2026 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957671; cv=none; b=HxBZhMstDGcpyvfFrE8WhCkEPP3Bh6flceslrmiwdHAdLkN6BCGBvWrV3Ypo9vxVLRnSl16XtvYmaXEY2+WjRBXH1+XeXllAqOGzo9FaOx2EauD4mQrBdEATWNHdbAd61BenPc+xa/9uQNuZm6oz9Gx4FPknf1JZ8AI9NTELf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957671; c=relaxed/simple;
	bh=5idTwFNzS2Q+TB3Lx9INhPxb7Ar05bCuaPgK9mFvHNA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SepckVuR3UZUhXbdkDv81TiRqWvj5BYYlZsKcJ+y/9DTjCrdoxpFmOf7yNMkHDFT5hAohJhcw8gCXGKHtQyMH+wPKhkSRjGAHNfzKx+F3nPUxvwz7SoBqiuaeGTQ/Sep7e8ANJSJlxayeVpgF73yBfYPmckbXKx4Rsf1aMKw8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOExnnPj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOExnnPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A08CC16AAE;
	Wed, 21 Jan 2026 01:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957671;
	bh=5idTwFNzS2Q+TB3Lx9INhPxb7Ar05bCuaPgK9mFvHNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOExnnPjHgBezBYF7WZeggvUHHXa4XOrJ7ckHvyrXVllE7dDFo12IF8t12F2A/Zoh
	 TUn53mTb2MiZES9kxEtAs6UuQzYMRliNeEKPDXEQQ7hpOwIIBlb8joIO5VdLPBUeKS
	 F9DwWY/AJUjoAdrFTIuzTQ4tbp7jganB2OqG2e2ejCLmplbAy72cCCB8Yt9pArX0CP
	 aPeZK/kkzNqiiftSJiCR+63IHNO2/Y990jdq6Ug29CahtrRUm9W1n2xeXX3Ake6PG2
	 jRdKHYTX3Q35drWhhe5UZsB8Yt+ZsWDgwY38XU7CLgpqaPQpFwdqNcxnwlvuMuSd0n
	 oDh3Y/8DXjoSg==
Date: Wed, 21 Jan 2026 10:07:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steven Rostedt
 <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, Naveen N Rao <naveen@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] kprobes: Use dedicated kthread for kprobe optimizer
Message-Id: <20260121100746.e8c7d0da85f8b68620489c5e@kernel.org>
In-Reply-To: <202601191507.74fccd0c-lkp@intel.com>
References: <176826884613.429923.16578111751623731056.stgit@devnote2>
	<202601191507.74fccd0c-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 15:29:58 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> Hello,
> 
> kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:

OOps, yes. It should be wait in interruptible.

Thanks,

> 
> commit: 62f65c2531ad66e84c1a5ef91389322357ef6db4 ("[PATCH v2] kprobes: Use dedicated kthread for kprobe optimizer")
> url: https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/kprobes-Use-dedicated-kthread-for-kprobe-optimizer/20260113-094928
> base: https://git.kernel.org/cgit/linux/kernel/git/trace/linux-trace for-next
> patch link: https://lore.kernel.org/all/176826884613.429923.16578111751623731056.stgit@devnote2/
> patch subject: [PATCH v2] kprobes: Use dedicated kthread for kprobe optimizer
> 
> in testcase: trinity
> version: trinity-x86_64-294c4652-1_20251011
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-03
> 	nr_groups: 5
> 
> 
> 
> config: x86_64-kexec
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-----------------------------------------+------------+------------+
> |                                         | 78a419b44e | 62f65c2531 |
> +-----------------------------------------+------------+------------+
> | INFO:task_blocked_for_more_than#seconds | 0          | 6          |
> +-----------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202601191507.74fccd0c-lkp@intel.com
> 
> 
> 
> [  972.359932][   T32] INFO: task kprobe-optimize:18 blocked for more than 491 seconds.
> [  972.361221][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [  972.362516][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  972.364322][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [  972.366628][   T32] Call Trace:
> [  972.367378][   T32]  <TASK>
> [  972.368066][   T32]  __schedule (kernel/sched/core.c:5259)
> [  972.370837][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [  972.371679][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [  972.373219][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [  972.374017][   T32]  kthread (kernel/kthread.c:465)
> [  972.374573][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [  972.375364][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [  972.376005][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [  972.376679][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [  972.377305][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [  972.377958][   T32]  </TASK>
> [ 1463.879952][   T32] INFO: task kprobe-optimize:18 blocked for more than 983 seconds.
> [ 1463.882239][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [ 1463.884371][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1463.887443][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [ 1463.891867][   T32] Call Trace:
> [ 1463.893396][   T32]  <TASK>
> [ 1463.894468][   T32]  __schedule (kernel/sched/core.c:5259)
> [ 1463.903984][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [ 1463.904926][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [ 1463.905949][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [ 1463.907111][   T32]  kthread (kernel/kthread.c:465)
> [ 1463.907954][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [ 1463.909157][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 1463.910045][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [ 1463.910939][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 1463.911933][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 1463.912947][   T32]  </TASK>
> [ 1955.399991][   T32] INFO: task kprobe-optimize:18 blocked for more than 1474 seconds.
> [ 1955.404266][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [ 1955.407452][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1955.414557][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [ 1955.416961][   T32] Call Trace:
> [ 1955.417705][   T32]  <TASK>
> [ 1955.418382][   T32]  __schedule (kernel/sched/core.c:5259)
> [ 1955.419274][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [ 1955.419929][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [ 1955.421071][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [ 1955.422303][   T32]  kthread (kernel/kthread.c:465)
> [ 1955.423217][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [ 1955.424452][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 1955.425189][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [ 1955.425913][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 1955.426645][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 1955.427357][   T32]  </TASK>
> [ 2446.919964][   T32] INFO: task kprobe-optimize:18 blocked for more than 1966 seconds.
> [ 2446.922105][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [ 2446.925697][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 2446.926569][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [ 2446.927775][   T32] Call Trace:
> [ 2446.928242][   T32]  <TASK>
> [ 2446.928609][   T32]  __schedule (kernel/sched/core.c:5259)
> [ 2446.929827][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [ 2446.930256][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [ 2446.930789][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [ 2446.931434][   T32]  kthread (kernel/kthread.c:465)
> [ 2446.931926][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [ 2446.932624][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 2446.933079][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [ 2446.933534][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 2446.933983][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 2446.934450][   T32]  </TASK>
> [ 2938.439916][   T32] INFO: task kprobe-optimize:18 blocked for more than 2457 seconds.
> [ 2938.441278][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [ 2938.442281][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 2938.444599][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [ 2938.446316][   T32] Call Trace:
> [ 2938.446892][   T32]  <TASK>
> [ 2938.447449][   T32]  __schedule (kernel/sched/core.c:5259)
> [ 2938.449286][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [ 2938.450230][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [ 2938.451347][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [ 2938.452611][   T32]  kthread (kernel/kthread.c:465)
> [ 2938.453462][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [ 2938.454622][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 2938.455583][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [ 2938.456604][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 2938.457614][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 2938.458645][   T32]  </TASK>
> [ 3429.960057][   T32] INFO: task kprobe-optimize:18 blocked for more than 2949 seconds.
> [ 3429.962853][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [ 3429.965133][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 3429.967986][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [ 3429.971731][   T32] Call Trace:
> [ 3429.973021][   T32]  <TASK>
> [ 3429.974169][   T32]  __schedule (kernel/sched/core.c:5259)
> [ 3429.975713][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [ 3429.977206][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [ 3429.978375][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [ 3429.979623][   T32]  kthread (kernel/kthread.c:465)
> [ 3429.980602][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [ 3429.981810][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 3429.982797][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [ 3429.983793][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 3429.984838][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 3429.985864][   T32]  </TASK>
> [ 3921.480064][   T32] INFO: task kprobe-optimize:18 blocked for more than 3440 seconds.
> [ 3921.482942][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [ 3921.485260][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 3921.488269][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [ 3921.491811][   T32] Call Trace:
> [ 3921.493488][   T32]  <TASK>
> [ 3921.494960][   T32]  __schedule (kernel/sched/core.c:5259)
> [ 3921.508616][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [ 3921.509430][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [ 3921.510413][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [ 3921.511467][   T32]  kthread (kernel/kthread.c:465)
> [ 3921.512331][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [ 3921.513388][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 3921.514202][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [ 3921.514976][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 3921.515773][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 3921.516817][   T32]  </TASK>
> [ 4413.000017][   T32] INFO: task kprobe-optimize:18 blocked for more than 3932 seconds.
> [ 4413.004653][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [ 4413.007745][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 4413.010446][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [ 4413.013906][   T32] Call Trace:
> [ 4413.015027][   T32]  <TASK>
> [ 4413.016134][   T32]  __schedule (kernel/sched/core.c:5259)
> [ 4413.017465][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [ 4413.018294][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [ 4413.019366][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [ 4413.020594][   T32]  kthread (kernel/kthread.c:465)
> [ 4413.021350][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [ 4413.022331][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 4413.023124][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [ 4413.023925][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 4413.025015][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 4413.026074][   T32]  </TASK>
> [ 4904.520028][   T32] INFO: task kprobe-optimize:18 blocked for more than 4423 seconds.
> [ 4904.521949][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [ 4904.528612][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 4904.529924][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [ 4904.531461][   T32] Call Trace:
> [ 4904.531896][   T32]  <TASK>
> [ 4904.532406][   T32]  __schedule (kernel/sched/core.c:5259)
> [ 4904.532947][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [ 4904.533381][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [ 4904.533944][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [ 4904.534547][   T32]  kthread (kernel/kthread.c:465)
> [ 4904.534985][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [ 4904.535670][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 4904.536359][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [ 4904.536831][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 4904.537310][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 4904.537788][   T32]  </TASK>
> [ 5396.039936][   T32] INFO: task kprobe-optimize:18 blocked for more than 4915 seconds.
> [ 5396.040939][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
> [ 5396.041631][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 5396.042742][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
> [ 5396.045182][   T32] Call Trace:
> [ 5396.045723][   T32]  <TASK>
> [ 5396.046266][   T32]  __schedule (kernel/sched/core.c:5259)
> [ 5396.046928][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
> [ 5396.047542][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
> [ 5396.048329][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
> [ 5396.049182][   T32]  kthread (kernel/kthread.c:465)
> [ 5396.049803][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
> [ 5396.050654][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 5396.051353][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
> [ 5396.052048][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
> [ 5396.052723][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
> [ 5396.053187][   T32]  </TASK>
> [ 5396.053524][   T32] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> BUG: kernel hang in test stage
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260119/202601191507.74fccd0c-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
