Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8DA238C07;
	Tue,  9 Sep 2025 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403783; cv=none; b=Gacql+3Tj59geMmsRm28qxcLY5FMhJgvTRizHAXcmxTgWsTP5lpfquJ5JjA0JCyQE7Z5Z5gVwE4jkYeKWtwBloHqugfhEUX0fQ7KZBnAiFkt6JV1wKGExapq7ses+gzJK/5Bc56/TwtK17Nr6jc5XnUMmuA1btowgidDMtrZGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403783; c=relaxed/simple;
	bh=urd/4rmKjr2mQ/VCO7nQ8YDst0DtM+tpJ0FsUi3+hb4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QJcXVq6mSMNLX6qY8QV2zLoqKIh5RW1HOZ5C9AZpzQIXuvaUl4C1PEGmnHG8xF1jTyB5TTntceQBvyQdtLOMEiNzkrwMIE5kVjlsaCIcMoyyVT25uTGaD/JlB7QgVya3hCT0v4gFR7We7I3s/2t6skOCLkH8ZzyeFwSlSslKf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMY4/Q7W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMY4/Q7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A14BC4CEF4;
	Tue,  9 Sep 2025 07:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757403783;
	bh=urd/4rmKjr2mQ/VCO7nQ8YDst0DtM+tpJ0FsUi3+hb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMY4/Q7WwX+gc4TAGcFOQUQS61sree24OoA9iWdFPX0bBQ13pRAuXQzR2sss6XOH5
	 uEjjx3FpDS6zcsOi/hySfXDXeNFzPg6XGc1cGfpBI27hY0zSSb7wwxk9RR04MjWya1
	 7/x1ONQbXyXEu3R/L5Bmm7PlVrMYjDjA+FoD3rjobSSXZrrV5VsoFtq3qVE4bqmoPt
	 B8zi8fbFqaj/EapirWunlejeF+ERuUML4so98QsMjZJwRqT8MxCE0PlHEyFNI/IH9i
	 r5rPWrfK10x+UkWAKd09J/N0vzJChM3MBAIAagmnMhCwlgMaxWLDG7QuaMAItjh5OP
	 7TtKl9bDPN+Jg==
Date: Tue, 9 Sep 2025 16:43:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Silence warning when chunk allocation fails
 in trace_pid_write
Message-Id: <20250909164300.72ebc2c27921251d33de48af@kernel.org>
In-Reply-To: <20250908024658.2390398-1-pulehui@huaweicloud.com>
References: <20250908024658.2390398-1-pulehui@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 02:46:58 +0000
Pu Lehui <pulehui@huaweicloud.com> wrote:

> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller trigger a fault injection warning:
> 
> WARNING: CPU: 1 PID: 12326 at tracepoint_add_func+0xbfc/0xeb0
> Modules linked in:
> CPU: 1 UID: 0 PID: 12326 Comm: syz.6.10325 Tainted: G U 6.14.0-rc5-syzkaller #0
> Tainted: [U]=USER
> Hardware name: Google Compute Engine/Google Compute Engine
> RIP: 0010:tracepoint_add_func+0xbfc/0xeb0 kernel/tracepoint.c:294
> Code: 09 fe ff 90 0f 0b 90 0f b6 74 24 43 31 ff 41 bc ea ff ff ff
> RSP: 0018:ffffc9000414fb48 EFLAGS: 00010283
> RAX: 00000000000012a1 RBX: ffffffff8e240ae0 RCX: ffffc90014b78000
> RDX: 0000000000080000 RSI: ffffffff81bbd78b RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffffffffef
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff81c264f0
> FS:  00007f27217f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2e80dff8 CR3: 00000000268f8000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  tracepoint_probe_register_prio+0xc0/0x110 kernel/tracepoint.c:464
>  register_trace_prio_sched_switch include/trace/events/sched.h:222 [inline]
>  register_pid_events kernel/trace/trace_events.c:2354 [inline]
>  event_pid_write.isra.0+0x439/0x7a0 kernel/trace/trace_events.c:2425
>  vfs_write+0x24c/0x1150 fs/read_write.c:677
>  ksys_write+0x12b/0x250 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> We can reproduce the warning by following the steps below:
> 1. echo 8 >> set_event_notrace_pid. Let tr->filtered_pids owns one pid
>    and register sched_switch tracepoint.
> 2. echo ' ' >> set_event_pid, and perform fault injection during chunk
>    allocation of trace_pid_list_alloc. Let pid_list with no pid and
> assign to tr->filtered_pids.
> 3. echo ' ' >> set_event_pid. Let pid_list is NULL and assign to
>    tr->filtered_pids.
> 4. echo 9 >> set_event_pid, will trigger the double register
>    sched_switch tracepoint warning.
> 
> The reason is that syzkaller injects a fault into the chunk allocation
> in trace_pid_list_alloc, causing a failure in trace_pid_list_set, which
> may trigger double register of the same tracepoint. This only occurs
> when the system is about to crash, but to suppress this warning, let's
> add failure handling logic to trace_pid_list_set.
> 
> Fixes: 8d6e90983ade ("tracing: Create a sparse bitmask for pid filtering")
> Reported-by: syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67cb890e.050a0220.d8275.022e.GAE@google.com
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,


> ---
>  kernel/trace/trace.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1b7db732c0b1..f2a84d1ce4b7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -834,7 +834,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
>  		/* copy the current bits to the new max */
>  		ret = trace_pid_list_first(filtered_pids, &pid);
>  		while (!ret) {
> -			trace_pid_list_set(pid_list, pid);
> +			ret = trace_pid_list_set(pid_list, pid);
> +			if (ret < 0)
> +				goto out;
> +
>  			ret = trace_pid_list_next(filtered_pids, pid + 1, &pid);
>  			nr_pids++;
>  		}
> @@ -871,6 +874,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
>  		trace_parser_clear(&parser);
>  		ret = 0;
>  	}
> + out:
>  	trace_parser_put(&parser);
>  
>  	if (ret < 0) {
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
