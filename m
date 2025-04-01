Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EAE205AAC;
	Tue,  1 Apr 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520260; cv=none; b=qNIKW9KTOjytcwqC/VKCthyhIPL/s8eliWt1i5Bw+4BaG1EuBL+rzsXJrNa9Ruwm/K9mH1ZmIPK7BvONXr01wqOlrrErqpqo3cHPJu+Ax28qAyJtEgS4QUEFci3JwAmHFbXiNJE62KEY1oSZ0I5DMOKyQH9OB0ZgiWiSmifFSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520260; c=relaxed/simple;
	bh=34OZHjbPlcRSynqDPInO1OJu6ZWjltPskko05vek160=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r69pn7eVdP+hMuKP/TzDg7T/NBlnAprDF5kfG8r3u8WMTmXjXCTsW+Hibz+4y+VObvp5zYcLhKV5cIfVIeyJ5Qu+HrR0t8wL+chCv4Qp3hU3IqBMxQNShiT2YUrHvAJABHDKqZtlST/jxaJh8/WKuwnwRvY2Kln43Cg4nBKefPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF0BC4CEE4;
	Tue,  1 Apr 2025 15:10:58 +0000 (UTC)
Date: Tue, 1 Apr 2025 11:11:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250401111159.7632a0fa@gandalf.local.home>
In-Reply-To: <Z-u4Tzz9J8hSk6G7@kernel.org>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
	<20250331133906.48e115f5@gandalf.local.home>
	<CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
	<20250331165801.715aba48@gandalf.local.home>
	<CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
	<Z-u4Tzz9J8hSk6G7@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 12:56:31 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> > For example, using "mem=" on the kernel command line will literally
> > limit the amount of RAM the kernel will use, and in doing so will
> > limit the page allocations too.  
> 
> And using memmap=m$n on x86 creates a hole in System RAM that does not have
> neither struct page nor kernel mappings and it is never considered RAM
> anywhere in mm.

Hmm, when that is used, then we had better not "free" the buffer.

>  
> > IOW, all of these kernel command line things are *subtle*.
> > 
> > Don't mis-use them by then making assumptions about how they work
> > today (or how they will work tomorrow).  
> 
> I'd say it's better not to use them at all. They cause weirdness in memory
> layout and also they are inconsistent in how architectures implement them.
>  
> > > Mike can correct me if I'm wrong, but the memory that was stolen was actual
> > > memory returned by the system (E820 in x86). It reserves the memory before
> > > the memory allocation reserves this memory. So what reserve_mem returns is
> > > valid memory that can be used by memory allocator, but is currently just
> > > "reserved" which means it wants to prevent the allocator from using it.  
> > 
> > That may indeed be true of reserve_mem.  
> 
> The reserve_mem behaves like any other early allocation, it has proper
> struct pages (PG_Reserved) and it is mapped in the direct map so
> phys_to_virt() will work on it.
> 
> As for mapping it to userspace, vm_iomap_memory() seems the best API to
> use. It has all the alignment checks and will refuse to map ranges that are
> not properly aligned and it will use vma information to create the right
> mappings.
>  

When using vmap() to get the virtual addresses (via the kmalloc_array() of
struct pages), the vunmap() gives the memory back to the memory allocator:

~# free
               total        used        free      shared  buff/cache   available
Mem:         8185928      296676     7840576         920      148280     7889252
Swap:        7812092           0     7812092
~# rmdir /sys/kernel/tracing/instances/boot_mapped/
~# free
               total        used        free      shared  buff/cache   available
Mem:         8206404      290868     7866772         920      148384     7915536
Swap:        7812092           0     7812092

With no issues.

But if I use vmap_page_range(), how do I give that back to the memory allocator?

Calling vunmap() on that memory gives me:

 1779.832484] ------------[ cut here ]------------
[ 1779.834076] Trying to vunmap() nonexistent vm area (000000027c000000)
[ 1779.835941] WARNING: CPU: 6 PID: 956 at mm/vmalloc.c:3413 vunmap+0x5a/0x60
[ 1779.837587] Modules linked in:
[ 1779.838455] CPU: 6 UID: 0 PID: 956 Comm: rmdir Not tainted 6.14.0-rc4-test-00019-ga9c509c0c8e7-dirty #379
[ 1779.840597] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 1779.842576] RIP: 0010:vunmap+0x5a/0x60
[ 1779.843553] Code: 89 c7 48 85 c0 74 12 e8 94 e1 01 00 48 8b 5d f8 c9 c3 cc cc cc cc 90 0f 0b 90 48 c7 c7 78 b6 c4 9d 48 89 de e8 57 b4 cd ff 90 <0f> 0b 90 90 eb dc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[ 1779.847159] RSP: 0018:ffffbfdb7ec93da0 EFLAGS: 00010282
[ 1779.848256] RAX: 0000000000000000 RBX: 000000027c000000 RCX: 0000000000000000
[ 1779.849623] RDX: ffff9f0efdfab108 RSI: ffff9f0efdf9cbc0 RDI: 0000000000000001
[ 1779.851079] RBP: ffffbfdb7ec93da8 R08: 00000000ffffdfff R09: ffffffff9e7652c8
[ 1779.852447] R10: ffffffff9e6b5320 R11: 0000000000000000 R12: ffff9f0d80226e00
[ 1779.853746] R13: 0000000000000001 R14: ffff9f0d806294c0 R15: ffff9f0d80629190
[ 1779.855121] FS:  00007f414dea6740(0000) GS:ffff9f0efdf80000(0000) knlGS:0000000000000000
[ 1779.856524] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1779.857548] CR2: 00007f28a0a4d350 CR3: 000000010f950002 CR4: 0000000000172ef0
[ 1779.858916] Call Trace:
[ 1779.859467]  <TASK>
[ 1779.859986]  ? show_regs.cold+0x19/0x24
[ 1779.860708]  ? vunmap+0x5a/0x60
[ 1779.861387]  ? __warn.cold+0xc2/0x157
[ 1779.862141]  ? vunmap+0x5a/0x60
[ 1779.862752]  ? report_bug+0x10a/0x150
[ 1779.865787]  ? handle_bug+0x5c/0xa0
[ 1779.866684]  ? exc_invalid_op+0x1c/0x80
[ 1779.867455]  ? asm_exc_invalid_op+0x1f/0x30
[ 1779.868256]  ? vunmap+0x5a/0x60
[ 1779.868908]  ring_buffer_free+0xac/0xc0
[ 1779.869595]  __remove_instance.part.0.constprop.0+0xeb/0x1f0
[ 1779.870590]  instance_rmdir+0xe1/0xf0
[ 1779.871342]  tracefs_syscall_rmdir+0x5c/0xa0
[ 1779.872198]  vfs_rmdir+0xa0/0x220
[ 1779.872806]  do_rmdir+0x146/0x190
[ 1779.873477]  __x64_sys_rmdir+0x43/0x70
[ 1779.874188]  x64_sys_call+0x114f/0x1d70
[ 1779.874944]  do_syscall_64+0xbb/0x1d0
[ 1779.875605]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

What's the proper way to say: "I no longer need this physical memory I
reserved, the kernel can now use it"?

-- Steve
