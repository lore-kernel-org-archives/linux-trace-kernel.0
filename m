Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2C45DF6B;
	Fri,  7 Aug 2026 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141034; cv=none; b=poTa0WZnf+8hEjZBeOhDQdgwASuYwQ30nOxI+BnGOULUaypTOplQ3hodgktK8SUuzO7VUJJxaghNNO1zo2Foj8Ae6/CD/Nc09dTV4Mq9UFBZw/rjdHJKFeei/sj+F3BNB1uOhqQk4/+u7uGGT8j/XQGsHV9iCKrNdAipjfVUrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141034; c=relaxed/simple;
	bh=3ARzX+XpBlfGQj3hEMHI8qeJiUjDkqFuFKZt1QU065U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Pvqm/6kKBvfaV0CQwPwCStrsHlwpuhWgQ6AxUEAXX/igfe/smpcjipUcUR3PJ8bAWLx8IVuHrgz5p9/w1QgHVJncwVA/5ZyyawSbNxF5P8RAOqWe1zRAGLWbNfM5lHTahxKBCIyp2t5vni5605FrRDPxTVDDbDjGhosFIzoatMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8IUx32c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8IUx32c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D4E1F000E9;
	Fri,  7 Aug 2026 22:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786141032;
	bh=xxrPQ3n/bRUMadST9eYFb+N+ZW6gaQSsn/Y02AdyFf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e8IUx32ckAliPJvX3zMfqn4f/MS/q6TDFnMuEQeL7czl+DY2+KOCkX69LJDhjLEK+
	 fLnrVBfgnScLkjOAnO1SDWOTJoOgbVihiphMhh0TmXGZXKAVi6MDv+vml8h2EzQe/I
	 X2QpifqoBRKk8VkRcaPex9ZgSo48zrhCn5puYYuGfXJYwQbc+w23+LJYYiwRyDuSqS
	 DoKVd9XXosngCcmYnPzc5kf6dgIB36Z2rVbfao2OVX8m5NFPUCUNI8aQJ92WLM1p/l
	 VzlM8WwH/4YCknIXzNsmeU2BndUPvJGazK3CpBVriNRk8k2a8WmiEgYmXjmfB2ZZPW
	 eerj6YbTug+7A==
Date: Sat, 8 Aug 2026 07:17:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Hui Su <sh_def@163.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Fix crash passing ERR_PTR to
 kthread_stop()
Message-Id: <20260808071708.6bcbac3a30c5a58fa1a4c2b0@kernel.org>
In-Reply-To: <20260807154145.2846521-2-sh_def@163.com>
References: <20260807154145.2846521-2-sh_def@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 23:41:46 +0800
Hui Su <sh_def@163.com> wrote:

> In test_ringbuffer()'s out_free cleanup loop, the check
> `!rb_threads[cpu]` only catches NULL entries and misses entries that
> hold an ERR_PTR.
> 
> rb_threads[] is static, so unassigned slots are NULL. But when
> kthread_run_on_cpu() fails for a cpu, it stores ERR_PTR(-ENOMEM) (or
> -EINTR) in rb_threads[cpu] before the creation loop jumps to out_free.
> That entry is non-NULL, so the old `!ptr` check does not break, and the
> cleanup proceeds to call kthread_stop() on the ERR_PTR. kthread_stop()
> then dereferences the bogus pointer, crashing the kernel during the
> late_initcall self-test.
> 
> crash logs:
>   BUG: kernel NULL pointer dereference, address: 000000000000001c
>   Oops: 0002 [#1] SMP NOPTI
>   CPU: 1 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc6-dirty #7 PREEMPT(lazy)
>   RIP: 0010:kthread_stop+0x2e/0x220
>   RBX: fffffffffffffff4
>   CR2: 000000000000001c
>   Call Trace:
>    <TASK>
>    test_ringbuffer+0x1ec/0x650
>    do_one_initcall+0x6c/0x2c0
>    kernel_init_freeable+0x21d/0x420
>    kernel_init+0x15/0x1c0
>    ret_from_fork+0x21b/0x320
>    </TASK>
>   Kernel panic - not syncing: Fatal exception
> 
> Fixes: 64ed3a049e3e ("ring-buffer: make use of the helper function kthread_run_on_cpu()")
> Signed-off-by: Hui Su <sh_def@163.com>

Look good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 8e2485bb3aa8..6af7e36ca526 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -8214,7 +8214,7 @@ static __init int test_ringbuffer(void)
>  
>   out_free:
>  	for_each_online_cpu(cpu) {
> -		if (!rb_threads[cpu])
> +		if (IS_ERR_OR_NULL(rb_threads[cpu]))
>  			break;
>  		kthread_stop(rb_threads[cpu]);
>  	}
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
