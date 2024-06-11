Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0C84A21;
	Tue, 11 Jun 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134741; cv=none; b=ukkKTwVYcfUVR+1/QqWfy1xbF+JbaZxaVy7yr/OutacfZDE2jqZnSYhixi77yExUmrZrpZ6t4pYH3KLlS6VJHWjEe9m5RtFHBjStxa3TBB5pDBji8cGWUi+KZ/x+CC5ee/81vqpeO1t1roTSeiyE04hzE6r/ncGmuS8LRW+OZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134741; c=relaxed/simple;
	bh=w2c2G6obsMPgsfkn18lzhEJVlZV+GkjZQ8kXfu4gBA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkoAlpo9ANDI9xZQpOCwI88EZm6X9V9KrqJm7pg9hQJyq6IkW+248wTp9ToFyk2lsipYJgSIFqXWfbS7ZHWhLiYWmHG3u8YKEHLbKUj/0usROwRH9Tcv6VkfCjCTS2nHjz4F2vKaeVvKB9CvZmA5HAErFob1sMKfk5rwew4FA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AE7C4AF48;
	Tue, 11 Jun 2024 19:38:57 +0000 (UTC)
Date: Tue, 11 Jun 2024 15:39:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
 <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Guenter
 Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 wklin@google.com, Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel
 Fernandes <joel@joelfernandes.org>, Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel
 <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240611153913.1568be52@gandalf.local.home>
In-Reply-To: <20240611111218.71e57e0f@gandalf.local.home>
References: <20240606150143.876469296@goodmis.org>
	<20240606150316.751642266@goodmis.org>
	<20240611144029.h7egl4aif5mjlrwf@master>
	<20240611111218.71e57e0f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 11:12:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > >+	p++;
> > >+	err = reserved_mem_add(start, size, p);
> > >+	if (err) {
> > >+		memblock_phys_free(start, size);
> > >+		return err;
> > >+	}
> > >+
> > >+	p += strlen(p);
> > >+
> > >+	return *p == '\0' ? 0: -EINVAL;    
> > 
> > We won't free the memory if return -EINVAL?  

I actually copied this from parse_memmap_one() in arch/x86/kernel/e820.c
and now looking at it, it's a pretty stupid check.

It does: p += strlen(p); which requires p ending with '\0'. So this will
likely bug if there is no '\0'.

I'm going to remove this, but still check to make sure that the name has
some length before the allocation.

-- Steve
