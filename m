Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C29D1EB196;
	Tue,  1 Apr 2025 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545741; cv=none; b=TwNx8hifKlFcBIUjxki7OsPF+3wfufE+Yqf2BH+tEo5+0apYxLeHdGTrgOTZF28+AvuJxgNZ6K55fmoFOVo+Gua//PKhn3poZFRG5v+padYhrKjJwGFIKxOBjSFMCHMT0bnuAXsYufdzZKCK72Sc69lbH2SATlAphGJvGIqbgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545741; c=relaxed/simple;
	bh=pOoI5K03fFatVj0NubhzsEhDG1rIDb3ydkPNk4fejUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBdJO+p6aQseDulIBpDyg/ooopENMExnBrmbDsl7ItGlV1svROsT4yJE7J/ed2epMt6ZtptON5XTHCTmwtyYnQYhzX71kM+8XFuC3vUv1087mp60dLGvte9ig/TO4YVLLXe5aHxw+hBIJad+gh3AaVtqW9CVIUncAPdWrSQcilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCD9C4CEE4;
	Tue,  1 Apr 2025 22:15:39 +0000 (UTC)
Date: Tue, 1 Apr 2025 18:16:40 -0400
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
Message-ID: <20250401181640.09bb0333@gandalf.local.home>
In-Reply-To: <20250401215333.427506494@goodmis.org>
References: <20250401215115.602501043@goodmis.org>
	<20250401215333.427506494@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Apr 2025 17:51:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -9615,8 +9619,12 @@ static void free_trace_buffers(struct trace_array *tr)
>  	free_trace_buffer(&tr->max_buffer);
>  #endif
>  
> -	if (tr->range_addr_start)
> -		vunmap((void *)tr->range_addr_start);
> +	if (tr->range_addr_start) {
> +		void *start = (void *)tr->range_addr_start;
> +		void *end = start + tr->range_addr_size;
> +
> +		free_reserved_area(start, end, 0, tr->range_name);
> +	}
>  }
>  
>  static void init_trace_flags_index(struct trace_array *tr)

Masami,

Note, your patch to free the persistent ring buffer wasn't fully
functional, as it only did the "vunmap()". That doesn't return the buffer
back to the buddy allocator. What you saw was just the freeing of all the
other descriptors that make up a trace instance.

Before this patch:

  ~# free
                 total        used        free      shared  buff/cache   available
  Mem:         8185908      297404     7825896         916      162288     7888504
  Swap:        7812092           0     7812092
  ~# rmdir /sys/kernel/tracing/instances/boot_mapped
  ~# free
                 total        used        free      shared  buff/cache   available
  Mem:         8206384      297956     7845904         916      162260     7908428
  Swap:        7812092           0     7812092

Amount freed: 7845904 - 7825896 = 20008 (20M)

After this patch:

  ~# free
                 total        used        free      shared  buff/cache   available
  Mem:         8185912      301808     7820696         920      162860     7884104
  Swap:        7812092           0     7812092
  ~# rmdir /sys/kernel/tracing/instances/boot_mapped
  ~# free
                 total        used        free      shared  buff/cache   available
  Mem:         8226868      295968     7867644         920      162836     7930900
  Swap:        7812092           0     7812092

Amount freed: 7867644 - 7820696 = 46948 (46M)!

-- Steve
