Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613421581EE;
	Wed, 16 Jul 2025 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752708631; cv=none; b=tqMZ1VWAR4uUWb+ZamDMTFyCdmd3DZPTxFSxYkSff9LMArO3tPmmVdOmG4WGiHH0L0n/sxeVEQ00vypfmF/zVGO6zZMaeHdfrzNpeqStiH10Dc+FZcLxdhdLYYHfdplz1aN6je+iDWduieEFrX56QPLR3NJQLO2hU1NXa30uekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752708631; c=relaxed/simple;
	bh=vpdb/FFt82flKJIlBIGoF5aG80XhB46NBHmh2lM03uc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n0LuBSKY51+zLTjuU20ZygYYn/o/QRAW95/AMT07IAQE2tDE02Lpxk7gRqAig1zrjiSmxojctFYgxPLrImsgo3gvcq9Z/G/zidIPbCV3rhheK8YGyC8Ls1czZz0k36kE8xgzyO54RZOLlwM3qVAlduWPJmL8ri+hlJLI0LeCb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrjYBFfa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrjYBFfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36B7C4CEE7;
	Wed, 16 Jul 2025 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752708631;
	bh=vpdb/FFt82flKJIlBIGoF5aG80XhB46NBHmh2lM03uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nrjYBFfaal/qo7FKu/29xl0g9B/XGO7Gq34qJoAGs0EMXUva0GMOpTHaiwRA6fq76
	 tsnAuh0w+s4wbMuSKous34uLGzbRbz3w527XdjGQeGYLaHVXj32bp7v24Ha8Jp0JDC
	 rBCzLLjK9VazlF2l6s+mSXNPKgt4yKWQQbAo50VjXJBQnnIovXwNAhniCjXrWLqome
	 mtt5+kmRpOSJRrkczlLGac32nLYwoB7hERm/kyMi87YfIZ9gH+gBy++TKf6WUdyexy
	 WkVYsQGKDLsh73crE27V/T0+H9JSCyiluZInNMhvxbDYk84VTdX5AqbjFsYfl5Xk39
	 gv1CSGaNzAHzg==
Date: Thu, 17 Jul 2025 08:30:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>,
 Attila Fazekas <afazekas@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Fix crash in timerlat_dump_stack()
Message-Id: <20250717083028.823c06845d60927b6773322f@kernel.org>
In-Reply-To: <20250716143601.7313-1-tglozar@redhat.com>
References: <20250716143601.7313-1-tglozar@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 16:36:01 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> We have observed kernel panics when using timerlat with stack saving,
> with the following dmesg output:
> 
> memcpy: detected buffer overflow: 88 byte write of buffer size 0
> WARNING: CPU: 2 PID: 8153 at lib/string_helpers.c:1032 __fortify_report+0x55/0xa0
> CPU: 2 UID: 0 PID: 8153 Comm: timerlatu/2 Kdump: loaded Not tainted 6.15.3-200.fc42.x86_64 #1 PREEMPT(lazy)
> Call Trace:
>  <TASK>
>  ? trace_buffer_lock_reserve+0x2a/0x60
>  __fortify_panic+0xd/0xf
>  __timerlat_dump_stack.cold+0xd/0xd
>  timerlat_dump_stack.part.0+0x47/0x80
>  timerlat_fd_read+0x36d/0x390
>  vfs_read+0xe2/0x390
>  ? syscall_exit_to_user_mode+0x1d5/0x210
>  ksys_read+0x73/0xe0
>  do_syscall_64+0x7b/0x160
>  ? exc_page_fault+0x7e/0x1a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> __timerlat_dump_stack() constructs the ftrace stack entry like this:
> 
> struct stack_entry *entry;
> ...
> memcpy(&entry->caller, fstack->calls, size);
> entry->size = fstack->nr_entries;
> 
> Since commit e7186af7fb26 ("tracing: Add back FORTIFY_SOURCE logic to
> kernel_stack event structure"), struct stack_entry marks its caller
> field with __counted_by(size). At the time of the memcpy, entry->size
> contains garbage from the ringbuffer, which under some circumstances is
> zero, triggering a kernel panic by buffer overflow.
> 
> Populate the size field before the memcpy so that the out-of-bounds
> check knows the correct size. This is analogous to
> __ftrace_trace_stack().
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Cc: stable@vger.kernel.org
> Fixes: e7186af7fb26 ("tracing: Add back FORTIFY_SOURCE logic to kernel_stack event structure")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  kernel/trace/trace_osnoise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Note: This has been so far only reproduced on laptops (three different
> machines). Not sure what the reason for that is, but it is clearly
> a bug.
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 6819b93309ce..fd259da0aa64 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -637,8 +637,8 @@ __timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, u
>  
>  	entry = ring_buffer_event_data(event);
>  
> -	memcpy(&entry->caller, fstack->calls, size);
>  	entry->size = fstack->nr_entries;
> +	memcpy(&entry->caller, fstack->calls, size);
>  
>  	trace_buffer_unlock_commit_nostack(buffer, event);
>  }
> -- 
> 2.47.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
