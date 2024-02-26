Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28412B153
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958520; cv=none; b=Gu7nsIfFsLNsvxYBLYca5dWGw2ieqGatvyWuPmwKq5Zv7wt7vfAuNEmKbof4PYBxWHYUyhEhTxuT3QswnHZHTxR3vZZSrbsNmwFvQy3ALtlSWP2hJI7/o6RlspxoBQxoYZOYzl6wa2jqWMghlQXWE6gT9qWSGraw9b0IqUkhTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958520; c=relaxed/simple;
	bh=t6lpAnfj9E5y9YWX/+6w95fmBf82oWK8/NAeqg6LR6Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ATLXH/TnNIFkVRb6+0RobcglaZTkn/fB1fAnoVajviYEHqNhOqpV5P/ZWVEoihHgo66U0fKNSgGYpU4Bxw/8HopizWtuuwzD203pv9vAi30zxLBxhKDe5xC3Kb8NoOWdt3TpswY1Kd5O5aHkFmRS4BeV9h/izldBZro0+1m8cro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oogs/T1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oogs/T1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087CFC433F1;
	Mon, 26 Feb 2024 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708958520;
	bh=t6lpAnfj9E5y9YWX/+6w95fmBf82oWK8/NAeqg6LR6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oogs/T1QYBwMLExsXsKc0GE1mtZNjjtlmNmTo7PSiiVsTIsferx4Kry2Xm0B1lMju
	 GZxklvBjQMUREc3rlYAAhYSQwdzFgk1k99XuDCbfeJU9aAKzSzFtWNnitVv0serq9p
	 T4+GZQaGAqXv72iFUqdF1Xt+1mzdB+Coh2GVm20a5+s5uNbAaNAGb6P3eZ9Y+8dK2v
	 nHgU1/y5Oi/20VAIGltKrI75ara7QEobSt/MPJL6FpFdvX87PwuppvdGzIrbaAMOnS
	 1YClgPw/LNai0R9uioXG67rENdivHZ465kGMacP3EaD7NGKPBLZuVQOPoH81CT2HkQ
	 PWULZIOA1S2Cg==
Date: Mon, 26 Feb 2024 23:41:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgNGB0LrQvtCy?= <xxxa0c@mail.ru>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: tprobe event tracing error
Message-Id: <20240226234156.c6c647f5c005977327fde62c@kernel.org>
In-Reply-To: <1708954589.808811792@f182.i.mail.ru>
References: <1708954589.808811792@f182.i.mail.ru>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
(Cc: linux-kernel-trace ML for sharing this knowledge)

On Mon, 26 Feb 2024 16:36:29 +0300
Максим Морсков <xxxa0c@mail.ru> wrote:

> 
> Hello, dear Masami.
> I am researching Linux event tracing subsystem in part of tprobes,
> and found interesting behavior in kernel version 6.6:
>  
> echo  't:my_fchmodat sys_enter_fchmodat' | sudo tee ‘/sys/kernel/tracing/dynamic_events’
> bash: line 1: echo: write error: Invalid argument

Yeah, I understand that you are confused by this behavior, but it is
actually expected behavior. syscalls:* events looks like trace events
based on tracepoint, but those are software generated trace event.

You can find raw_syscalls:* trace events, that is based on the tracepoint,
and other syscalls:* are based on that raw_syscalls:* trace points.
(IOW, those are a kind of pre-compiled dynamic events)

e.g.

/sys/kernel/tracing # echo "t sys_enter \$arg*" >> dynamic_events 
/sys/kernel/tracing # cat dynamic_events 
t:tracepoints/sys_enter sys_enter regs=regs id=id

/sys/kernel/tracing # echo "t sys_enter_open \$arg*" >> dynamic_events 
sh: write error: Invalid argument
/sys/kernel/tracing # cat error_log 
[  227.981347] trace_fprobe: error: Tracepoint is not found
  Command: t sys_enter_open $arg*
             ^

So, tprobe can not find the hard-coded tracepoints for those dynamically
generated syscall trace events. But raw_syscall sys_enter/sys_exit are OK.

Thank you,

>  
> sudo cat /sys/kernel/tracing/error_log
> trace_fprobe: error: Tracepoint is not found 
>  Command: t:my_fchmodat sys_enter_fchmodat
>                                                     ^
>  
> But such tracepoint ( sys_enter_fchmodat ) exists in system:
> sudo perf list | grep chmod   
>  syscalls:sys_enter_ chmod                           [Tracepoint event] 
>  syscalls:sys_enter_f chmod                          [Tracepoint event] 
>  syscalls:sys_enter_f chmod at                        [Tracepoint event] 
>  syscalls:sys_enter_f chmod at2                       [Tracepoint event] 
>  syscalls:sys_exit_ chmod                            [Tracepoint event] 
>  syscalls:sys_exit_f chmod                           [Tracepoint event] 
>  syscalls:sys_exit_f chmod at                         [Tracepoint event] 
>  syscalls:sys_exit_f chmod at2                        [Tracepoint event]
>  
> sudo ls -lha /sys/kernel/tracing/events/syscalls/ | grep chmod
> drwxr-xr-x 1 root root 0 фев 26 16:07 sys_enter_ chmod
> drwxr-xr-x 1 root root 0 фев 26 16:07 sys_enter_f chmod
> drwxr-xr-x 1 root root 0 фев 26 16:07 sys_enter_f chmod at 
> drwxr-xr-x 1 root root 0 фев 26 16:07 sys_enter_f chmod at2 
> drwxr-xr-x 1 root root 0 фев 26 16:07 sys_exit_ chmod
> drwxr-xr-x 1 root root 0 фев 26 16:07 sys_exit_f chmod
> drwxr-xr-x 1 root root 0 фев 26 16:07 sys_exit_f chmod at 
> drwxr-xr-x 1 root root 0 фев 26 16:07 sys_exit_f chmod at2
>  
> My kernel config in the attachment.
> I noticed that you are developing event tracing tprobe subsystem.
> May be you could explain such behavior?
> Thank you in advance!
>  
> --
> Best regards
> Maksim Morskov

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
