Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DAE7DA93;
	Tue,  1 Apr 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522805; cv=none; b=azbt/aIXaU+/2vCk27Sykx1E8BdGXAFNseaDjSx0W++XBnedweX7qruBImQYV/Ej7IgYXHNv3VO61Chnq/JTv6LDYR2UkBp5G3GVAjXuD2tERANXPxiPugc7XO2IZThCCTWC414NF4/WOFtucIIh9ZvIpIoMYghdyn7plTVwy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522805; c=relaxed/simple;
	bh=SnSvkRvuPF4aWZD2Jf9iPtCXK2S+lgRXlydT322YmEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zuzc8qcQo/di028Qtyyb9yAyRPlw2jM9M+lkI4APYHN6RPpF5ev5GGHUvAaCEyOsJgyoAkdw0rdm8Q439/QBqjxhldFDp68F0LJeyc/iLMD0o9PV8VscOuYFM479N8vWwxoR0EyMevCP5FpcbrK+9xkR3S7E5uQ/x53tuYGNao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C98C4CEE5;
	Tue,  1 Apr 2025 15:53:23 +0000 (UTC)
Date: Tue, 1 Apr 2025 11:54:23 -0400
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
Message-ID: <20250401115423.3b6a926d@gandalf.local.home>
In-Reply-To: <Z-wFszhJ_9o4dc8O@kernel.org>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
	<20250331133906.48e115f5@gandalf.local.home>
	<CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
	<20250331165801.715aba48@gandalf.local.home>
	<CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
	<Z-u4Tzz9J8hSk6G7@kernel.org>
	<20250401111159.7632a0fa@gandalf.local.home>
	<Z-wFszhJ_9o4dc8O@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 18:26:43 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> > But if I use vmap_page_range(), how do I give that back to the memory allocator?  
> 
> But you don't need neither vmap() nor vmap_page_range() to have kernel page
> tables for memory that you get from reserve_mem. It's already mapped and
> plain phys_to_virt() gives you the virtual address you can use.

Oh! That makes things so much easier! Especially since that means it should
work like the normal buffer where virt_to_page() should also work. Right?

Now I do support mapping the persistent ring buffer via memmap, but I can
just give up on allowing that to be memory mapped to user space, or even
freed.

>  
> > Calling vunmap() on that memory gives me:
> > 
> >  1779.832484] ------------[ cut here ]------------
> > [ 1779.834076] Trying to vunmap() nonexistent vm area (000000027c000000)
> > [ 1779.835941] WARNING: CPU: 6 PID: 956 at mm/vmalloc.c:3413 vunmap+0x5a/0x60
> > 
> > What's the proper way to say: "I no longer need this physical memory I
> > reserved, the kernel can now use it"?  
>  
> free_reserved_area()

Awesome!

Thanks,

-- Steve
