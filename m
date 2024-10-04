Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB761BC23;
	Fri,  4 Oct 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051456; cv=none; b=RlREb2f2eAS662A5vmjxpmiZa0e8CTS/6EAE6hTHXt1WCQl45r4GnyKZs6xt5T/quzdtQiIJ2EAbvtTdMfECX8/XODkraL4CWMmJPaGFx4P/PCv9RO44J9QncpckhTip/l4BQ4VZHrbR9fbXyVY7MeHiOWBj9+fXvyfmJ3fLxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051456; c=relaxed/simple;
	bh=X4xq/NbuSXO7BJmTN7sQjUOwsklgqQwxSaneSZECvQ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k4uVaZToPmNade46WoothUNqjEUTxl2NcW1IOIyRSuMhl7o1Ong/Sdx55Ih6U8YLyaBVZFwGX+PWJ+N3HEbvSkGMXsTpqYhunviW3ginix6guEtV8Boib37mk3C9k8LtCV1pbG1y5Nie0zIpvj1XFTpGDdDwH/UXwMuJ9XY6zyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf+rHoSQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf+rHoSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC7FC4CEC6;
	Fri,  4 Oct 2024 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728051455;
	bh=X4xq/NbuSXO7BJmTN7sQjUOwsklgqQwxSaneSZECvQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tf+rHoSQ/tklcnMEZ3dJWLvQDwN4ADFiH2kLIMj1u8snJ4o8acLBlkjRuu+e1qna1
	 wkarJWHxyfmVtbjasS0QpsTjFgU3yxRot/a4gNbZuDAwt+MDMWqIW08Q3FVd+59yD0
	 t4lcXsXhaMCpQZI6QfKU/konm786J8y0qH/sB5S88zcaaGYqyLE9wXHQG/tmMksuMJ
	 NYack17GuzKBSifVhXIQq0YsivHJJDm6yqZ9aYBSSYU2vguYc5B3i3CzCHWWxKU85X
	 NSXF/OTniQ5vf0RnTj9uv6rcoMRykxVbqah6QFi8GWnMwaiwk2aC0JNxs1apS85zPU
	 NCI626j645Asw==
Date: Fri, 4 Oct 2024 23:17:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ftrace: Hide a extra entry in stack trace
Message-Id: <20241004231732.247301975e1e8f1511b50c6a@kernel.org>
In-Reply-To: <20241002051347.4239-3-tatsuya.s2862@gmail.com>
References: <20241002051347.4239-3-tatsuya.s2862@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 14:13:48 +0900
Tatsuya S <tatsuya.s2862@gmail.com> wrote:

> A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).
> 
> [003] .....   110.171589: vfs_write <-__x64_sys_write
> [003] .....   110.171600: <stack trace>
> => XXXXXXXXX (Wrong function name)
> => vfs_write
> => ksys_write
> => do_syscall_64
> => entry_SYSCALL_64_after_hwframe
> 
> To resolve this, increment skip for __ftrace_trace_stack() in
> function_stack_trace_call().
> The reason why skip is incremented for __ftrace_trace_stack()
> is because __ftrace_trace_stack() in stack trace is the only function
> that wasn't skipped from anywhere.

Hi Tatsuya,

Can you focus on making test cases which checks what combinations caused
this wrong values and what does not? Also it should be checked with
various kconfigs. That is more valuable than making add-hoc fixes.

Thank you,

> 
> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
> ---
> V2 -> V3: Changed the place to increment skip number
> V1 -> V2: Fixed redundant code
> 
>  kernel/trace/trace_functions.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 3b0cea37e029..27089d8e65d4 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -203,23 +203,21 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  	ftrace_test_recursion_unlock(bit);
>  }
>  
> -#ifdef CONFIG_UNWINDER_ORC
> -/*
> - * Skip 2:
> - *
> - *   function_stack_trace_call()
> - *   ftrace_call()
> - */
> -#define STACK_SKIP 2
> -#else
>  /*
>   * Skip 3:
> - *   __trace_stack()
> - *   function_stack_trace_call()
> - *   ftrace_call()
> + *   Skipped functions if CONFIG_UNWINDER_ORC is defined
> + *
> + *     __ftrace_trace_stack()
> + *     function_stack_trace_call()
> + *     ftrace_call()
> + *
> + *   Otherwise
> + *
> + *     __trace_stack()
> + *     function_stack_trace_call()
> + *     ftrace_call()
>   */
>  #define STACK_SKIP 3
> -#endif
>  
>  static void
>  function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
> -- 
> 2.46.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
