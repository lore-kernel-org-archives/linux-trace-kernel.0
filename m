Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4AE236428;
	Wed,  2 Apr 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585717; cv=none; b=c+KWtPRNPHYg4fbfDEOapw7fkYKUUOzCZUNyTuxdFBjkWpzF6GnZ1ZgPfrArSU5/67lOG0H1Ud4uiIMjWyx3kJP7u1Rupu7PeRSJ3a7ufYwoaENTuRgWtibObwOkshoFX1ALiC3C2nv8zMVPjBn0zZSMSd3ioxG8Aqx8pnpaV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585717; c=relaxed/simple;
	bh=RNmut04dDUs9Tledr9ogH/SSs6KN3VS7u7Z1NGMHj48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNb2R8ymVyXnbwxYlPgPm/vzKfg2LzaPN10vLG/tEteV6m+0Ll4xLUqGoBSItDtUO9WzxIEOF/OtC/rV2rqL0TTTQhdIkzDz51rcmpHdXlbWA9cGf9L6Rdv3mMJQZCEm0IQPbTpc8dn3JDi5yCOZPWldF4CuNbriYNHei+I9AR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhQ3ZQWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhQ3ZQWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC5CC4CEDD;
	Wed,  2 Apr 2025 09:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743585716;
	bh=RNmut04dDUs9Tledr9ogH/SSs6KN3VS7u7Z1NGMHj48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhQ3ZQWjtsLBoIKIJxXfyQSXNbrBxvdyp/r4KKxfoNjO2LxIup2qGtdfulrH0q8Dm
	 DOxHToyaEXpOrptZJuhV4wGyOPn3KYXTe69TfCAri8nUEIwc2/3gAba6ZdUiIudI4z
	 lbmkElp0nQZJclIrOBGanOa3jYFelhbtCrugiJ/a7vPPrWFvxQHahHPZfYY0d8ftDv
	 /KhPjGD3Uksw+in86osBv+ql78+yENHIhgXsDI5b9dQxAog+clk7eou+Pof7H0wtYn
	 CzPzeePxmNsyVyQHSOCUPnLrQtNdXnDiid2lzG7N9e8YJtWvHoV8tBFReZiz3YmkIL
	 Q+pYMicBape4w==
Date: Wed, 2 Apr 2025 12:21:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 1/4] tracing: Enforce the persistent ring buffer to be
 page aligned
Message-ID: <Z-0BrT-OxGvaWM1H@kernel.org>
References: <20250401225811.008143218@goodmis.org>
 <20250401225842.261475465@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401225842.261475465@goodmis.org>

On Tue, Apr 01, 2025 at 06:58:12PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Enforce that the address and the size of the memory used by the persistent
> ring buffer is page aligned. Also update the documentation to reflect this
> requirement.
> 
> Link: https://lore.kernel.org/all/CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com/
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 ++
>  Documentation/trace/debugging.rst               |  2 ++
>  kernel/trace/trace.c                            | 12 ++++++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3435a062a208..f904fd8481bd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7266,6 +7266,8 @@
>  			This is just one of many ways that can clear memory. Make sure your system
>  			keeps the content of memory across reboots before relying on this option.
>  
> +			NB: Both the mapped address and size must be page aligned for the architecture.
> +
>  			See also Documentation/trace/debugging.rst
>  
>  
> diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
> index 54fb16239d70..d54bc500af80 100644
> --- a/Documentation/trace/debugging.rst
> +++ b/Documentation/trace/debugging.rst
> @@ -136,6 +136,8 @@ kernel, so only the same kernel is guaranteed to work if the mapping is
>  preserved. Switching to a different kernel version may find a different
>  layout and mark the buffer as invalid.
>  
> +NB: Both the mapped address and size must be page aligned for the architecture.
> +
>  Using trace_printk() in the boot instance
>  -----------------------------------------
>  By default, the content of trace_printk() goes into the top level tracing
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index de6d7f0e6206..de9c237e5826 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10788,6 +10788,18 @@ __init static void enable_instances(void)
>  		}
>  
>  		if (start) {
> +			/* Start and size must be page aligned */
> +			if (start & ~PAGE_MASK) {
> +				pr_warn("Tracing: mapping start addr %lx is not page aligned\n",
> +					(unsigned long)start);
> +				continue;
> +			}
> +			if (size & ~PAGE_MASK) {
> +				pr_warn("Tracing: mapping size %lx is not page aligned\n",
> +					(unsigned long)size);
> +				continue;
> +			}

Better use %pa for printing physical address as on 32-bit systems
phys_addr_t may be unsigned long long:

	pr_warn("Tracing: mapping size %pa is not page aligned\n", &size);

> +
>  			addr = map_pages(start, size);
>  			if (addr) {
>  				pr_info("Tracing: mapped boot instance %s at physical memory %pa of size 0x%lx\n",
> -- 
> 2.47.2
> 
> 

-- 
Sincerely yours,
Mike.
