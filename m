Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544D1F8680;
	Tue, 17 Dec 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457528; cv=none; b=aenmFtNTBdXCeNXolA/gI04o3jltgRi5SXBPrOpdxWloA28baOLTSQGna4hd7794YOUOQ8PD83bMlZdtK2J5efld6HgGtkZUgBXfyoYCw91UtnJf8zVSQKOhipGtA8eRA4eq6MzmOklgYyLGpIinopKq5uxET+KE8fn36iSjH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457528; c=relaxed/simple;
	bh=qnQRxzaxQCdy4sbeoonIrpEuwrhmpepXTvIte9AAxn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkOmmu21XD4SRIjLX0Rw0ZavN+lXgXCSqv2ELfrh0ydaFmdJk8hUI6NELuuXdeFo3VLvnuuuesn5aCCuWAiyGsG0dt0CEmWy/PRYUmV2xDFUOciKYnOhCwJEN3Eq0XN4ZoCJNjwl+iFh3da8HfxShL8EJ9vK/1fvkbCDokHsS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517ECC4CED3;
	Tue, 17 Dec 2024 17:45:27 +0000 (UTC)
Date: Tue, 17 Dec 2024 12:46:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ring-buffer: Fix a oob in __rb_map_vma
Message-ID: <20241217124602.2d498c3f@gandalf.local.home>
In-Reply-To: <tencent_E036A29600368E4A2075A7774D67023CFD09@qq.com>
References: <675fe376.050a0220.37aaf.011e.GAE@google.com>
	<tencent_E036A29600368E4A2075A7774D67023CFD09@qq.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 22:07:57 +0800
Edward Adam Davis <eadavis@qq.com> wrote:

> syzbot report a slab-out-of-bounds in __rb_map_vma. [1]
> 
> Overflow occurred when performing the following calculation:
> nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff;
> 
> Add a check before the calculation to avoid this problem.
> 
> [1]
> BUG: KASAN: slab-out-of-bounds in __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
> Read of size 8 at addr ffff8880767dd2b8 by task syz-executor187/5836
> 
> CPU: 0 UID: 0 PID: 5836 Comm: syz-executor187 Not tainted 6.13.0-rc2-syzkaller-00159-gf932fb9b4074 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:489
>  kasan_report+0xd9/0x110 mm/kasan/report.c:602
>  __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
>  ring_buffer_map+0x56e/0x9b0 kernel/trace/ring_buffer.c:7138
>  tracing_buffers_mmap+0xa6/0x120 kernel/trace/trace.c:8482
>  call_mmap include/linux/fs.h:2183 [inline]
>  mmap_file mm/internal.h:124 [inline]
>  __mmap_new_file_vma mm/vma.c:2291 [inline]
>  __mmap_new_vma mm/vma.c:2355 [inline]
>  __mmap_region+0x1786/0x2670 mm/vma.c:2456
>  mmap_region+0x127/0x320 mm/mmap.c:1348
>  do_mmap+0xc00/0xfc0 mm/mmap.c:496
>  vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
>  ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
>  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
>  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
>  __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Reported-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=345e4443a21200874b18
> Tested-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  kernel/trace/ring_buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 7e257e855dd1..15c43d7415d5 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7019,6 +7019,9 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>  	lockdep_assert_held(&cpu_buffer->mapping_lock);
>  
>  	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
> +	if (((nr_subbufs + 1) << subbuf_order) < pgoff)
> +		return -EINVAL;
> +

A proper fix is being discussed here:

https://lore.kernel.org/linux-trace-kernel/20241216164931.57323-1-aha310510@gmail.com/

Thank you,

-- Steve

>  	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
>  
>  	nr_vma_pages = vma_pages(vma);

