Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF4126BEE;
	Fri, 14 Feb 2025 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498846; cv=none; b=CboAdhrCmY/6tPuEvYYMjVVNDlSQsppTGWCQo1OSBN25msPXRBJKjSv5HGO4CejriPzHTAqR+7R6WV9x6oUUE1lZTK23DsQif3p1S2zsL97wDY0vU5waMWVu7ojAWi45jIM5wGsO7edwtGCMxNrqFmHGG3Bx9tcV3WNQo5ZjYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498846; c=relaxed/simple;
	bh=NJFgRj4wAHsadBYYWTQwGEVqMdRcUIMDmqN9w7KIeGY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KBKKCLl84Xch8Hq7/EEJ7KRSgGDYGnKzGtYGnbZ6RCOaC8SrrYphKEV2nJb0Q29ADoiQ4x6oHtxEGW1qb26v5RlZuKdXSFw3MXGrUUHOr4mPbPVOUCoPgYq7SgkHN6rhVP+eSF4lPiXn8zDRcjmps/s6bJeAjNQG73PvwxdEk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYZ0yP/b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYZ0yP/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88055C4CED1;
	Fri, 14 Feb 2025 02:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498846;
	bh=NJFgRj4wAHsadBYYWTQwGEVqMdRcUIMDmqN9w7KIeGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GYZ0yP/bC35bgTlbZCbbUF3MTv3UhmsaC7XVnIOGHtjDUJG4j8L2QGQKo7LHG9d7U
	 EfEkn9T3WsXxT/xFhEJN6VKJ7rhckmA42YOmu7ZhimfidlEQEM35Fx9daa/WmYEMGw
	 uoQZc8WlOQPSdLWb6UyN8AKb//fMEBtlTf/NJvMjQdYjoYAXRvOTwkfN5Fku9CDFE6
	 FTMrxgBbae2P1LshJrEJg8yMfIGs2JbQI0dgayO4YFMzpHJ8tE5bvJ+ojFlV6S0QyV
	 xrHEWTiVgJchfIQ6tJ4S/5tP/lSRnwACql2sP1R/wysQr6aJzfk8yzj3blICr7zib0
	 XDvTtUXHB7X4g==
Date: Fri, 14 Feb 2025 11:07:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-Id: <20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
In-Reply-To: <20250213180737.061871ae@gandalf.local.home>
References: <20250213180737.061871ae@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 18:07:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When trying to mmap a trace instance buffer that is attached to
> reserve_mem, it would crash:
> 
>  BUG: unable to handle page fault for address: ffffe97bd00025c8
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 2862f3067 P4D 2862f3067 PUD 0
>  Oops: Oops: 0000 [#1] PREEMPT_RT SMP PTI
>  CPU: 4 UID: 0 PID: 981 Comm: mmap-rb Not tainted 6.14.0-rc2-test-00003-g7f1a5e3fbf9e-dirty #233
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>  RIP: 0010:validate_page_before_insert+0x5/0xb0
>  Code: e2 01 89 d0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 <48> 8b 46 08 a8 01 75 67 66 90 48 89 f0 8b 50 34 85 d2 74 76 48 89
>  RSP: 0018:ffffb148c2f3f968 EFLAGS: 00010246
>  RAX: ffff9fa5d3322000 RBX: ffff9fa5ccff9c08 RCX: 00000000b879ed29
>  RDX: ffffe97bd00025c0 RSI: ffffe97bd00025c0 RDI: ffff9fa5ccff9c08
>  RBP: ffffb148c2f3f9f0 R08: 0000000000000004 R09: 0000000000000004
>  R10: 0000000000000000 R11: 0000000000000200 R12: 0000000000000000
>  R13: 00007f16a18d5000 R14: ffff9fa5c48db6a8 R15: 0000000000000000
>  FS:  00007f16a1b54740(0000) GS:ffff9fa73df00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffffe97bd00025c8 CR3: 00000001048c6006 CR4: 0000000000172ef0
>  Call Trace:
>   <TASK>
>   ? __die_body.cold+0x19/0x1f
>   ? __die+0x2e/0x40
>   ? page_fault_oops+0x157/0x2b0
>   ? search_module_extables+0x53/0x80
>   ? validate_page_before_insert+0x5/0xb0
>   ? kernelmode_fixup_or_oops.isra.0+0x5f/0x70
>   ? __bad_area_nosemaphore+0x16e/0x1b0
>   ? bad_area_nosemaphore+0x16/0x20
>   ? do_kern_addr_fault+0x77/0x90
>   ? exc_page_fault+0x22b/0x230
>   ? asm_exc_page_fault+0x2b/0x30
>   ? validate_page_before_insert+0x5/0xb0
>   ? vm_insert_pages+0x151/0x400
>   __rb_map_vma+0x21f/0x3f0
>   ring_buffer_map+0x21b/0x2f0
>   tracing_buffers_mmap+0x70/0xd0
>   __mmap_region+0x6f0/0xbd0
>   mmap_region+0x7f/0x130
>   do_mmap+0x475/0x610
>   vm_mmap_pgoff+0xf2/0x1d0
>   ksys_mmap_pgoff+0x166/0x200
>   __x64_sys_mmap+0x37/0x50
>   x64_sys_call+0x1670/0x1d70
>   do_syscall_64+0xbb/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The reason was that the code that maps the ring buffer pages to user space
> has:
> 
> 	page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> 
> And uses that in:
> 
> 	vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
> 
> But virt_to_page() does not work with vmap()'d memory which is what the
> persistent ring buffer has. It is rather trivial to allow this, but for
> now just disable mmap() of instances that have their ring buffer from the
> reserve_mem option.

This may be good for fixing crash short term but may not allow us to read the
subbufs which is read right before crash. Can we also add an option to reset
the read pointer in the previous boot for the persistent ring buffer?

Thank you,

> 
> Cc: stable@vger.kernel.org
> Fixes: e645535a954ad ("tracing: Add option to use memmapped memory for trace boot instance")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 25ff37aab00f..72895500155d 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8279,6 +8279,10 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
>  	struct trace_iterator *iter = &info->iter;
>  	int ret = 0;
>  
> +	/* Currently the boot mapped buffer is not supported for mmap */
> +	if (iter->tr->flags & TRACE_ARRAY_FL_BOOT)
> +		return -EINVAL;
> +
>  	ret = get_snapshot_map(iter->tr);
>  	if (ret)
>  		return ret;
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
