Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791B43169;
	Wed, 14 May 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205543; cv=none; b=br7PCLf/2SnX7PNmqrO+KhjAOMZH0jaQCzkzjpbkD+FqPmmsRljTw5GdrN/+fPoweJssf3/L3FHIA3RTy66QNKy1cuqxgZwPcUJDfmKCjbz7dzXY02eJTtRgmMcehGraSZGPueroksToMHUMQGaoZsI0aZ5/4A/q6G+PNT4WVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205543; c=relaxed/simple;
	bh=oHnLgoHoVliB2FSyG6HXMzMLz6sBG7fjR8CjZ5XHDwM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kbdxPtyuRkaRpDLxspGDk5bsAgi4+PuC/5SGrak40whcQpEjre7Vh/UtW6QygOGNp0NoAKr6ClVRioDyrHkOexo9NZN9C6BtSQtVJE+eViFNZxJFZ8pqQKM7VNJYpX4t7s8O+C7yCLzlUji1OZZWs81UUp4u4fLEcYZsrvL90rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq+rltEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq+rltEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C70C4CEEB;
	Wed, 14 May 2025 06:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747205542;
	bh=oHnLgoHoVliB2FSyG6HXMzMLz6sBG7fjR8CjZ5XHDwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eq+rltEbb/KV5yK697jJJy39sqBC3wWFRdtDrGIPUoh6wThtKmhWmkemcXJupBF1q
	 uVLP11FWvdxyctxI4AHFP826TPNOgukbXO+PyMO8zVocEz5ad2MeTLUBP2W0Mvwsfg
	 HWy2Z7YL5E64rdvlPHAMgap6CRZeDuJAdOC70PceW9Q9fvTh+bwtSYrH8QxCGJngn+
	 6+IpadUvScVPclWfFvE/XeH8mHiqKUuGo2BuLJrvv1qJ9Q5X/JZXWVLcKl2mB60KHR
	 J24r1xYqV2stllsr0WX7Z4R5euIqvvOQoc+OlQtXeA4DqiSkjyz97mnq78MrampPJ6
	 gyR6+bUvemL2g==
Date: Wed, 14 May 2025 15:52:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tasos Sahanidis <tasos@tasossah.com>
Subject: Re: [PATCH] ring-buffer: Fix persistent buffer when commit page is
 the reader page
Message-Id: <20250514155220.54584891585d57c317aa22ac@kernel.org>
In-Reply-To: <20250513115032.3e0b97f7@gandalf.local.home>
References: <20250513115032.3e0b97f7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 11:50:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> \From: Steven Rostedt <rostedt@goodmis.org>
> 
> The ring buffer is made up of sub buffers (sometimes called pages as they
> are by default PAGE_SIZE). It has the following "pages":
> 
>   "tail page" - this is the page that the next write will write to
>   "head page" - this is the page that the reader will swap the reader page with.
>   "reader page" - This belongs to the reader, where it will swap the head
>                   page from the ring buffer so that the reader does not
>                   race with the writer.
> 
> The writer may end up on the "reader page" if the ring buffer hasn't
> written more than one page, where the "tail page" and the "head page" are
> the same.
> 
> The persistent ring buffer has meta data that points to where these pages
> exist so on reboot it can re-create the pointers to the cpu_buffer
> descriptor. But when the commit page is on the reader page, the logic is
> incorrect.
> 
> The check to see if the commit page is on the reader page checked if the
> head page was the reader page, which would never happen, as the head page
> is always in the ring buffer. The correct check would be to test if the
> commit page is on the reader page. If that's the case, then it can exit
> out early as the commit page is only on the reader page when there's only
> one page of data in the buffer. There's no reason to iterate the ring
> buffer pages to find the "commit page" as it is already found.
> 
> To trigger this bug:
> 
>   # echo 1 > /sys/kernel/tracing/instances/boot_mapped/events/syscalls/sys_enter_fchownat/enable
>   # touch /tmp/x
>   # chown sshd /tmp/x
>   # reboot
> 
> On boot up, the dmesg will have:
>  Ring buffer meta [0] is from previous boot!
>  Ring buffer meta [1] is from previous boot!
>  Ring buffer meta [2] is from previous boot!
>  Ring buffer meta [3] is from previous boot!
>  Ring buffer meta [4] commit page not found
>  Ring buffer meta [5] is from previous boot!
>  Ring buffer meta [6] is from previous boot!
>  Ring buffer meta [7] is from previous boot!
> 
> Where the buffer on CPU 4 had a "commit page not found" error and that
> buffer is cleared and reset causing the output to be empty and the data lost.
> 
> When it works correctly, it has:
> 
>   # cat /sys/kernel/tracing/instances/boot_mapped/trace_pipe
>         <...>-1137    [004] .....   998.205323: sys_enter_fchownat: __syscall_nr=0x104 (260) dfd=0xffffff9c (4294967196) filename=(0xffffc90000a0002c) user=0x3e8 (1000) group=0xffffffff (4294967295) flag=0x0 (0
> 
> Cc: stable@vger.kernel.org
> Fixes: 5f3b6e839f3ce ("ring-buffer: Validate boot range memory events")
> Reported-by: Tasos Sahanidis <tasos@tasossah.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/ring_buffer.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1ca482955dae..6859008ca34d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1887,10 +1887,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  
>  	head_page = cpu_buffer->head_page;
>  
> -	/* If both the head and commit are on the reader_page then we are done. */
> -	if (head_page == cpu_buffer->reader_page &&
> -	    head_page == cpu_buffer->commit_page)
> +	/* If the commit_buffer is the reader page, update the commit page */
> +	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
> +		cpu_buffer->commit_page = cpu_buffer->reader_page;
> +		/* Nothing more to do, the only page is the reader page */
>  		goto done;
> +	}
>  
>  	/* Iterate until finding the commit page */
>  	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
