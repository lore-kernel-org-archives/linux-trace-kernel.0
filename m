Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD342153FB;
	Tue,  1 Apr 2025 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543657; cv=none; b=Hrkpm3Di1ETr4xj02PpnGy4/GqxFXZb63AtBglha7P+3XPnkXF7UGYD8UYNiPe5zKZNj+SbeTEP6v3ksU4KMij1ZKh2Q6YWbd5BAdWyQMvy8LlktqcD4j+w9NDAzXvYuiThRIdivU0id4eTHvI4cjEhJiVmgBiiM0MH0zJg+BzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543657; c=relaxed/simple;
	bh=Wo2t4WURzFdT8+579o/Bqb3j0d3axCM41klZm2o6hQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3pYxjyUbBGtWDy/1mqxGLRrxG0l+TusBRWVZgqke7sN1rKA+0AFu0iPxDhA2UOV6l/jM9BwJAPq0mxydtJ0r/OnkZtEQiiOSlZtC0mu/XfzK8Sj9jbDTFWcGtNeNMmNVMv+1H3MrIV9tc1Uukwl1o8xbcev+c73j3GEiuYRdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50F0C4CEE8;
	Tue,  1 Apr 2025 21:40:54 +0000 (UTC)
Date: Tue, 1 Apr 2025 17:41:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Jann
 Horn <jannh@google.com>
Subject: Re: [PATCH v3 3/5] tracing: Use vmap_page_range() to map memmap
 ring buffer
Message-ID: <20250401174156.4e9d3b23@gandalf.local.home>
In-Reply-To: <20250401203331.901028151@goodmis.org>
References: <20250401202549.409271454@goodmis.org>
	<20250401203331.901028151@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Apr 2025 16:25:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> -static u64 map_pages(u64 start, u64 size)
> +static u64 map_pages(unsigned long start, unsigned long size)
>  {
> -	struct page **pages;
> -	phys_addr_t page_start;
> -	unsigned int page_count;
> -	unsigned int i;
> -	void *vaddr;
> +        unsigned long vmap_start, vmap_end;

Bah, looks like I have whitespace issues. Will send an update to fix this
and the change log for patch 4.

> +	struct vm_struct *area;
> +	int ret;
>  
