Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DCF4A0F;
	Sun, 29 Sep 2024 23:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727653903; cv=none; b=jYy7U5hbTyBoFxM08GxazySrPJWc8FeAsAWpmhx7tEmCzEp4Kmw1fD+O0AUTHuZp8mJHjHItjTHWce1Y4/ZWZB6ZjzOAGKpr0yUOGXp8yaO1I73Zgg88OBmU1uYA01SAmmrXFA0u+gUdjD7/QpOqTGaj2kMwghkbsI8XW8v7rPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727653903; c=relaxed/simple;
	bh=3dIOy/xT3PSITjI7lq+Wrvac7kPT+EMIENbrXsmPCBg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TwafG+IE/iPwjWQCNbPoYUUvncTnImUtAmVG2tipxFMEZo0/sOZYD296wZH4Pk8vlV9VNJJ9kvvOjf6ZNgHXHtd8g4JczUsZKJB3rfTVRwVuqfNjD8j3//R/8sMBsXodAEmab16/hrfbefLtQObOooZntuYQ8wdy1rHIZWEaeq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCS3eZSH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCS3eZSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CBDC4CEC5;
	Sun, 29 Sep 2024 23:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727653903;
	bh=3dIOy/xT3PSITjI7lq+Wrvac7kPT+EMIENbrXsmPCBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RCS3eZSHpKHajfU1KwvOl30XiV07wcOaWPpsgdmlJ2BXQhYsP03lto+oTTMvpRZn6
	 ggfJ40TNMHymfkDMKZH6ng5+xHsvKzgKtIB+03a7PUtpK9A87vJHvlw/iwRwwfici3
	 IK/DhEWngiMH6rtcOA7NdDwy/wduNeoeTxOydXeT2GTpM6OyrsNnBgDYFzsbZZtLfb
	 18n2d9CTjOCH+0F3iGhwxJEDwte8heWHBwFlE8NFZwuhRINDtdRc9u5pPff36w7xKl
	 uafU4AV96PgD9mZSqZC8bZr3tTR4Gy/Tu2sF+Yd34LUB1W6GrIlJyB8Z+rfedLTWaV
	 WR7UiW1ggmkHg==
Date: Mon, 30 Sep 2024 08:51:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Hide a extra entry in stack trace
Message-Id: <20240930085139.5d34f28236a67ef1e9143655@kernel.org>
In-Reply-To: <20240926061311.25625-1-tatsuya.s2862@gmail.com>
References: <20240926061311.25625-1-tatsuya.s2862@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Sep 2024 15:13:07 +0900
Tatsuya S <tatsuya.s2862@gmail.com> wrote:

> A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).
> 
>     [003] .....   110.171589: vfs_write <-__x64_sys_write
>     [003] .....   110.171600: <stack trace>
>  => XXXXXXXXX (Wrong function name)
>  => vfs_write
>  => __x64_sys_write
>  => do_syscall_64
>  => entry_SYSCALL_64_after_hwframe

OK, I confirmed it;

------
echo 1 > options/func_stack_trace 
echo "vfs_write" >> set_ftrace_filter
echo "function" > current_tracer
echo > /dev/null
cat trace
              sh-136     [005] .....   266.884180: vfs_write <-ksys_write
              sh-136     [005] .....   266.884188: <stack trace>
 => 0xffffffffa0004099
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
------

> 
> To resolve this, increment skip in __ftrace_trace_stack().
> The reason why skip is incremented in __ftrace_trace_stack()
> is because __ftrace_trace_stack() in stack trace is the only function
> that wasn't skipped from anywhere.
> 
> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
> ---
>  kernel/trace/trace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c3b2c7dfadef..0f2e255f563c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2916,10 +2916,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  	 * Add one, for this function and the call to save_stack_trace()
>  	 * If regs is set, then these functions will not be in the way.
>  	 */

Hmm, with this change, the above comment should also be updated.


> -#ifndef CONFIG_UNWINDER_ORC
> -	if (!regs)
> +	if (IS_ENABLED(CONFIG_UNWINDER_ORC) || !regs)
>  		skip++;
> -#endif

Also, this solves just one pattern (only enable function tracer) but if
there are fprobes (or kprobes) on the same function, it introduces another issue.
e.g. (with this fix)

------
echo 1 > options/func_stack_trace
echo 1 > options/stacktrace
echo "vfs_write" >> set_ftrace_filter
echo "function" > current_tracer
echo "f:myevent vfs_write" > dynamic_events
echo 1 > events/fprobes/myevent/enable
echo > /dev/null
cat trace
...
              sh-140     [001] ...1.    18.352601: myevent: (vfs_write+0x4/0x560)
              sh-140     [001] ...1.    18.352602: <stack trace>
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
              sh-140     [001] ...1.    18.352602: vfs_write <-ksys_write
              sh-140     [001] ...1.    18.352604: <stack trace>
 => ftrace_regs_call
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
------
As you can see, myevent skips "vfs_write".
(and function tracer still have ftrace_regs_call() )

Thank you,

>  
>  	preempt_disable_notrace();
>  
> -- 
> 2.46.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
