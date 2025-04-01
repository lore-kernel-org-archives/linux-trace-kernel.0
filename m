Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9951EF378;
	Tue,  1 Apr 2025 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743547149; cv=none; b=MhAk70dtxrc585QDXtAl17+5IVy48JXuXVmTnzZ+4RGlgzckZeKtIQApfw+qiMqs1BRn8ltxPoT7GjzKxihD7m9ecwd50Y9qn6pdMM7RgQz4Y3EN5uodnYqpqplNSA4Eacujiu6B40TAKlfRF1JDGLFup9C+Nsn6wrZlfXri0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743547149; c=relaxed/simple;
	bh=NqRzgb6JFsUuvJzlcJNDZ1xbbYmmmTtYpnNszF7zWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQzbqEs6/jbGEj7o5IgWCCZLYRhnmK6rerzbp77a/PjZmCR9oOyTQeo3rUOKUD35UZ2+1VmzI1CphEXlKR7qDGBz2ROftu/4M91RNY5KRCYd/2bmu1PNgCjGUTBc6KwnZ80M8qexLEOPtirsUaHtqjox5DrsrZvPiqbgclbDcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC94C4CEE4;
	Tue,  1 Apr 2025 22:39:07 +0000 (UTC)
Date: Tue, 1 Apr 2025 18:40:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort
 <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v4 2/4] tracing: Have reserve_mem use phys_to_virt() and
 separate from memmap buffer
Message-ID: <20250401184008.77ca9599@gandalf.local.home>
In-Reply-To: <20250401181640.09bb0333@gandalf.local.home>
References: <20250401215115.602501043@goodmis.org>
	<20250401215333.427506494@goodmis.org>
	<20250401181640.09bb0333@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 18:16:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> Note, your patch to free the persistent ring buffer wasn't fully
> functional, as it only did the "vunmap()". That doesn't return the buffer
> back to the buddy allocator. What you saw was just the freeing of all the
> other descriptors that make up a trace instance.
> 
> Before this patch:
> 
>   ~# free
>                  total        used        free      shared  buff/cache   available
>   Mem:         8185908      297404     7825896         916      162288     7888504
>   Swap:        7812092           0     7812092
>   ~# rmdir /sys/kernel/tracing/instances/boot_mapped
>   ~# free
>                  total        used        free      shared  buff/cache   available
>   Mem:         8206384      297956     7845904         916      162260     7908428
>   Swap:        7812092           0     7812092
> 
> Amount freed: 7845904 - 7825896 = 20008 (20M)
> 
> After this patch:
> 
>   ~# free
>                  total        used        free      shared  buff/cache   available
>   Mem:         8185912      301808     7820696         920      162860     7884104
>   Swap:        7812092           0     7812092
>   ~# rmdir /sys/kernel/tracing/instances/boot_mapped
>   ~# free
>                  total        used        free      shared  buff/cache   available
>   Mem:         8226868      295968     7867644         920      162836     7930900
>   Swap:        7812092           0     7812092
> 
> Amount freed: 7867644 - 7820696 = 46948 (46M)!

Bah! My patch is buggy. Yeah, your code released the memory properly, as you had:

	reserve_mem_release_by_name()

which does do free_reserve_area() on the memory mapping.

Which means this patch is buggy and freed the same memory twice.

OK, time for v5 to fix that :-p

-- Steve
