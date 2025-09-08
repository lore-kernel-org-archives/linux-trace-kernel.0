Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E51E8324;
	Mon,  8 Sep 2025 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358142; cv=none; b=AGVBNURe05eJE1fZW9mHCSZ7jzBEsPtStoqW23rTH7mVKtKSVBtAtFDQcpMQzknfKBAuDQze0jNaAwzhOSJutgs+5WYWIuavsNoQajFNULui3ak3RTH7ytZHMWfPBHEuQTstCVyEnUz8gXMlfP0+g1/mj8QsVWWNW/d9wgushWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358142; c=relaxed/simple;
	bh=qoERetJrl9ZYiLDZetUpY4DFOm8TL+eKJyVCXAF76co=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ec7FIrVuFn9PUOVk+lTFQjf4ISHZR2fFqKHjmFUBXbvjfSVPgN28S8MJXcz7jffujACHer/MuSHPMdpU/L/bYPzKOJDvdFDLpQ2XC/PODRipo11leXfJidmjB4mGBRubuKmu3Bn/clEYQ7xKc0oRXxxAon5m/zo8WuwMzRM4u/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3F5A7852D1;
	Mon,  8 Sep 2025 19:02:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 7430732;
	Mon,  8 Sep 2025 19:02:11 +0000 (UTC)
Date: Mon, 8 Sep 2025 15:02:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Silence warning when chunk allocation fails
 in trace_pid_write
Message-ID: <20250908150257.23731d24@gandalf.local.home>
In-Reply-To: <20250908024658.2390398-1-pulehui@huaweicloud.com>
References: <20250908024658.2390398-1-pulehui@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7430732
X-Stat-Signature: 9o6fbypd84tghfzo9oky94emdq8h835p
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19/ajdtOhUTRX7eRkFJLyCJmCS6YjLx718=
X-HE-Tag: 1757358131-741100
X-HE-Meta: U2FsdGVkX18eEM841sijLg+FwXIK0YyLsclUV6i9fU5rvYnlHW2uLAg3OuBlz+dd8GmJXbF0S7QK0gIgHrvFaxifAOHi6mHPD15atXcI5zYRqkATrn+LryfZKXiZlPyROnGdTICFxwlEzFi1Lk6qBYH59tjMskb9pqro78WXjZkkc7bcB/XH1wZISGogfk4a56FwecBbR0BRl00qHZ9ZLVd5vguO8UD9/NfvKiqYHqG1M6cYbPIe9TPJE455l/2MRSnyOPSMm+8I0aTtmgAqrG/fKZc/jmjLELUXG7gJwqWX8tSUsYm7sjcHdV8wj5qUrgou4QvPL/ZuJ+bGnjV4NZ5DK8hhlu66O9TRnjCYt3w0qnBHu9OxdO2oI2KqwKLiWLD6FfY6HVv25gsmYEO7iIJkU66aZPavxfCqAmBItfK96TVTMV0OMURVVjr86dgax2obWN7UTPYcmk8bC68zzj/v1CqCRYDx

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
> ---

FYI, when sending a v2, please state below the three dashes what was
changed since v1. Something like:

Changes since v1: https://lore.kernel.org/all/20250821071721.3609109-1-pulehui@huaweicloud.com/

- Instead of returning -EINVAL before trace_parser_load() have
  trace_pid_write() return error when trace_pid_list_set() returns an error.


I have a Link tag to this email that is added by my scripts, with the idea
that this email will have a link to the previous version and so on. It will
create a chain of the email discussions that lead to what lands in mainline.

-- Steve


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

