Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235A2D7B8;
	Fri, 23 Aug 2024 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439098; cv=none; b=XMlDuyDtRXzaiU/wpxtiGqqyTHsXAvPlxpMx7prwYIpKurdDIkyD6mLAXLF7wYebcG98gO/I8nZQGAgPMyxj+D7FG4pRqjeR0PzN2j6A3RZmj+b38Lsy/cDzBimKhGKDmY4h2iminzV/9wGqORuxAZ0lZZ0JYOmZx9Vsl2fxgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439098; c=relaxed/simple;
	bh=tzwfU5CRs0mRc5d9uBF7Wp4I5zlF5Wa0yJyNBA3R83g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nkh6prLYqDWjWpXZepKz/j6B5sYPycKDON3VzTKKz/0hiY4lrKM2qqcrsijn2rJJ8VGfjmaepeTQWYB7czfroOcqm9VanZ+Bx1AKHSNHSgUrBHVZlHIT62Z9JsW4I4iVmwTPYJyf64Zdhe7reUoYlSXJq4oGKTtupogqidRtHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6A3C32786;
	Fri, 23 Aug 2024 18:51:37 +0000 (UTC)
Date: Fri, 23 Aug 2024 14:52:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: tglozar@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240823145211.34ccda61@gandalf.local.home>
In-Reply-To: <20240823125426.404f2705@gandalf.local.home>
References: <20240820130001.124768-1-tglozar@redhat.com>
	<20240823125426.404f2705@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 12:54:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > $ while true; do rtla timerlat top -u -q & PID=$!; sleep 5; \
> >  kill -INT $PID; sleep 0.001; kill -TERM $PID; wait $PID; done  
> 
> The "kill -INT $PID" caused the write to osnoise_workload_start(), and the
> after 1ms you do the "kill -TERM $PID" that kill the process which closes
> the file descriptor right after the reset.
> 
> The real fix here looks to be:
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 66a871553d4a..400a72cd6ab5 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -265,6 +265,8 @@ static inline void tlat_var_reset(void)
>  	 */
>  	for_each_cpu(cpu, cpu_online_mask) {
>  		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
> +		if (tlat_var->kthread)
> +			hrtimer_cancel(&tlat_var->timer);
>  		memset(tlat_var, 0, sizeof(*tlat_var));
>  	}
>  }
> @@ -2579,7 +2581,8 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
>  	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
>  	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
>  
> -	hrtimer_cancel(&tlat_var->timer);
> +	if (tlat_var->kthread)
> +		hrtimer_cancel(&tlat_var->timer);
>  	memset(tlat_var, 0, sizeof(*tlat_var));
>  
>  	osn_var->sampling = 0;
> 
> I'll make this into a real patch and send it out.

Egad, I don't think this is even good enough. I noticed this in the trace
(adding kthread to the memset trace_printk):

           <...>-916     [003] .....   134.227044: osnoise_workload_start: memset ffff88823c435b28 for 0000000000000000
           <...>-916     [003] .....   134.227046: osnoise_workload_start: memset ffff88823c4b5b28 for 0000000000000000
           <...>-916     [003] .....   134.227048: osnoise_workload_start: memset ffff88823c535b28 for 0000000000000000
           <...>-916     [003] .....   134.227049: osnoise_workload_start: memset ffff88823c5b5b28 for 0000000000000000
           <...>-916     [003] .....   134.227051: osnoise_workload_start: memset ffff88823c635b28 for 0000000000000000
           <...>-916     [003] .....   134.227052: osnoise_workload_start: memset ffff88823c6b5b28 for 0000000000000000
           <...>-916     [003] .....   134.227054: osnoise_workload_start: memset ffff88823c735b28 for ffff888108205640
           <...>-916     [003] .....   134.227055: osnoise_workload_start: memset ffff88823c7b5b28 for 0000000000000000

Before the reset, all but one of the tlat->kthread is NULL. Then it dawned
on me that this is a global per CPU variable. It gets initialized when the
tracer starts. If another program is has the timerlat fd open when the
tracer ends, the tracer starts again, and you close the fd, it will cancel
the hrtimer for the new task.

I think there needs to be some ref counting here, that keeps the tracer
from starting again if there's still files opened.

This looks to be a bigger problem than I have time to work on it for now.
I'll just apply the mutex patch for the kthreads, but this bug is going to
take a bit more work in solving.

-- Steve


