Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E012B169
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954233; cv=none; b=GfwYEch8kUgBoi5bg27OYw+OMZIPSiV/iK0wUcOYe6ejv1eBTBNe9z6nBXWZeGzcXv81D+J9rkLgkTH31A3jHVINQ3UhgHFaiX55tEzwIaAUY+TzwSb5NIym6ckoYqfLSd4hdBbIDHBw6+z8AFBEsWi7iYaMsXRLknx1dqb+lLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954233; c=relaxed/simple;
	bh=9votbjZYGnsoOfXCKKEgAXV4fJLfUAG+L0lY3CPcsJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBwnuTpjbeX5VJ40OqwIKsgz4bmoLvzDl3H5KaLC7xfvsdjG9cKVMKl9QGh8hsMaVJLqCIz/nmLFmbHdURNX0lrGCcXRDfCwfnaKL+NtN6Z7NVIZOcztQSzpnzDdQDQKWcqJ8ajkySQkyxKr3p1TB4ULlRd+onTWLR9Y9hDLaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C119C4CEE4;
	Wed, 15 Jan 2025 15:17:12 +0000 (UTC)
Date: Wed, 15 Jan 2025 10:17:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: kprobe not always triggering
Message-ID: <20250115101715.12c6cce3@gandalf.local.home>
In-Reply-To: <f91a64bf-c5cb-4d36-b50b-67cdcdccdccc@flourine.local>
References: <f91a64bf-c5cb-4d36-b50b-67cdcdccdccc@flourine.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[ Adding Masami ]

On Wed, 15 Jan 2025 09:26:36 +0100
Daniel Wagner <dwagner@suse.de> wrote:

> Hi,
> 
> it's likely a layer 8 problem but I can't figure out what I am doing
> wrong.
> 
> I am debugging the nvme state machine with a nvme-tcp setup. I attached
> a kprobe to nvme_change_ctrl_state to trace all the state changes, but
> not all of them are logged. It's consistent behavior and I tried
> different things with the same result.

Is it consistently the same locations being dropped?

There's been cases of a compiler inlining some functions for the code
called in the same file. If that happened, then those will likely be
dropped. That can be tested by adding:

bool noinline nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
                enum nvme_ctrl_state new_state) 

You would think it shouldn't inline it, but there's nothing in the spec
that says it can't do so.

> 
> The state transition I'd like to see is
> 
>   LIVE (1) -> RESETTING (2) -> CONNECTING (3) -> LIVE (1)
> 
> Though the 1 -> 2 transition is always missing, though a printk says it
> is happening.
> 
> cd /sys/kernel/debug/tracing
> echo "r:nvme_change_ctrl_state nvme_change_ctrl_state new_state=\$arg2:x32" > kprobe_events
> echo 1 > events/kprobes/enable
> echo 1 > tracing_on
> cat trace_pipe
> 
>             nvme-570     [004] .....    97.559620: nvme_change_ctrl_state: (nvme_tcp_setup_ctrl+0x324/0x720 [nvme_tcp] <- nvme_change_ctrl_state) new_state=0x1
>            <...>-65      [000] .....   143.540287: nvme_change_ctrl_state: (nvme_reset_ctrl_work+0x76/0xc0 [nvme_tcp] <- nvme_change_ctrl_state) new_state=0x3
>    kworker/u34:3-76      [001] .....   170.236138: nvme_change_ctrl_state: (nvme_tcp_setup_ctrl+0x324/0x720 [nvme_tcp] <- nvme_change_ctrl_state) new_state=0x1
> 
> 
> [   97.548827] nvme_change_ctrl_state:566 3 -> 1
> [   97.550547] nvme nvme1: new ctrl: NQN "nqn.io-1", addr 192.168.154.25:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36
> [  133.273552] nvme nvme1: I/O tag 1 (e001) type 4 opcode 0x18 (Keep Alive) QID 0 timeout
> [  133.274359] nvme nvme1: long keepalive RTT (5056 ms)
> [  133.274684] nvme nvme1: failed nvme_keep_alive_end_io error=10
> [  143.514090] nvme_change_ctrl_state:566 1 -> 2
> [  143.529185] nvme_change_ctrl_state:566 2 -> 3
> [  146.584904] nvme nvme1: failed to connect socket: -110
> [  146.585553] nvme nvme1: Reconnecting in 10 seconds...
> [  159.897184] nvme nvme1: failed to connect socket: -110
> [  159.897633] nvme nvme1: Failed reconnect attempt 2/60
> [  159.898006] nvme nvme1: Reconnecting in 10 seconds...
> [  170.153915] nvme nvme1: creating 8 I/O queues.
> 
> The system is idle, so I hope it's not just a dropped event. Any ideas
> what I am doing wrong?

I don't think it's a dropped event. It's not busy enough. But the compiler
making a copy of the function (by inlining or what not) can cause something
like this to happen.

-- Steve

> 
> Linux 6.13.0-rc3+, clang compiler.
> 
> Thanks,
> Daniel

