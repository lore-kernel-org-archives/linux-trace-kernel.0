Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC36335BA8;
	Thu, 21 May 2026 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332124; cv=none; b=elPs/MiNFhqhCE726PsTs3c2Pno0x8T4fa8YKm5OfWSdyASKmTAkor+NvGuyejK1ElkUKeQGgIPyWEqOzmaT0l9+sOhAf6APLHM02Un5ahYTJUYf5LChIvOBkCDjGCi/sv7nYR6E1WqnJ+bLWqsV6aOOmpBhW/W+8fViSk5u9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332124; c=relaxed/simple;
	bh=EAb2wauDN5Uk13UBhGSaw/6WwwVNGBTjZ+pm+MbJFys=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=booyGBxA7ydtrPzncz2MqwlWWv1n10Uv22YKTumz777WIE6hpPXiDBPyk4ipWuXmyFH/+AK4/Ml0bkcPYIGVdmsdY3H7u4ljjCw7OvHzAl2EhEvoVAWJVEUU0yxtxgNZc3Olwki0EjJVJEt91LqSVjRUks1KYTLHvKq+n/z7HYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ/p8Puq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ/p8Puq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81001F000E9;
	Thu, 21 May 2026 02:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779332123;
	bh=rlm0Exl5iGU4kQ1kfFL4x6/T2KSgeQbhxz8/3ekD80w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VZ/p8Puqc2Bz/7kRowZrYkL3WqfYmB5uLkTf7WAsIFCGGyfdJElpUcZPwZ3s/6HW2
	 /BKytVIop6ygLJDNXBb2QUXx2vuNMrosFIPk/fK0cFdMmsusfpoxubqWcuEJdX7drp
	 lF3tv7feXc1Q/R9GsIR3NtbVOB7XUSuW6aWwCXWSLI6DiX59aKsStXMo4Ue4n6urdz
	 J4yGbGTjcLwVbl9uYE/Ih0TQyzNNio5Z0/ppYM0iWPOeMre6SYVa4QoLTBBVaE4us0
	 GM+DEJkPNYcdXsZaILa91SkZRFyID1nbqUkRDbaseOjrCpX4U/9kenS1IqHe8wLlFV
	 lvkY7r1dTX3QA==
Date: Thu, 21 May 2026 11:55:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
 (open list:TRACING), linux-hardening@vger.kernel.org (open list:KERNEL
 HARDENING (not covered by other
 areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: Re: [PATCHv2] tracing: simplify pages allocation
Message-Id: <20260521115518.b3b5264ebf6ba2a29b4c5410@kernel.org>
In-Reply-To: <20260520215006.12008-1-rosenp@gmail.com>
References: <20260520215006.12008-1-rosenp@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:50:06 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Change to a flexible array member to allocate together with the array
> struct.
> 
> Simplifies code slightly by removing no longer correct null checks for
> pages and removing kfrees.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: add back kfree(a). Accidentally removed.
>  kernel/trace/tracing_map.c | 30 +++++++++++-------------------
>  kernel/trace/tracing_map.h |  2 +-
>  2 files changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index c59326ad7a84..97f7e3cde262 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -288,9 +288,6 @@ static void tracing_map_array_clear(struct tracing_map_array *a)
>  {
>  	unsigned int i;
> 
> -	if (!a->pages)
> -		return;
> -
>  	for (i = 0; i < a->n_pages; i++)
>  		memset(a->pages[i], 0, PAGE_SIZE);
>  }
> @@ -302,9 +299,6 @@ static void tracing_map_array_free(struct tracing_map_array *a)
>  	if (!a)
>  		return;
> 
> -	if (!a->pages)
> -		goto free;
> -
>  	for (i = 0; i < a->n_pages; i++) {
>  		if (!a->pages[i])
>  			break;
> @@ -312,9 +306,6 @@ static void tracing_map_array_free(struct tracing_map_array *a)
>  		free_page((unsigned long)a->pages[i]);
>  	}
> 
> -	kfree(a->pages);
> -
> - free:
>  	kfree(a);
>  }
> 
> @@ -322,24 +313,25 @@ static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
>  						  unsigned int entry_size)
>  {
>  	struct tracing_map_array *a;
> +	unsigned int entry_size_shift;
> +	unsigned int entries_per_page;
> +	unsigned int n_pages;
>  	unsigned int i;
> 
> -	a = kzalloc_obj(*a);
> +	entry_size_shift = fls(roundup_pow_of_two(entry_size) - 1);
> +	entries_per_page = PAGE_SIZE / (1 << entry_size_shift);
> +	n_pages = max(1, n_elts / entries_per_page);
> +
> +	a = kzalloc_flex(*a, pages, n_pages);
>  	if (!a)
>  		return NULL;
> 
> -	a->entry_size_shift = fls(roundup_pow_of_two(entry_size) - 1);
> -	a->entries_per_page = PAGE_SIZE / (1 << a->entry_size_shift);
> -	a->n_pages = n_elts / a->entries_per_page;
> -	if (!a->n_pages)
> -		a->n_pages = 1;
> +	a->entry_size_shift = entry_size_shift;
> +	a->entries_per_page = entries_per_page;
> +	a->n_pages = n_pages;
>  	a->entry_shift = fls(a->entries_per_page) - 1;
>  	a->entry_mask = (1 << a->entry_shift) - 1;
> 
> -	a->pages = kcalloc(a->n_pages, sizeof(void *), GFP_KERNEL);
> -	if (!a->pages)
> -		goto free;
> -
>  	for (i = 0; i < a->n_pages; i++) {
>  		a->pages[i] = (void *)get_zeroed_page(GFP_KERNEL);
>  		if (!a->pages[i])
> diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
> index ed64136782d8..90a7fde5dd02 100644
> --- a/kernel/trace/tracing_map.h
> +++ b/kernel/trace/tracing_map.h
> @@ -167,7 +167,7 @@ struct tracing_map_array {
>  	unsigned int entry_shift;
>  	unsigned int entry_mask;
>  	unsigned int n_pages;
> -	void **pages;
> +	void *pages[] __counted_by(n_pages);
>  };
> 
>  #define TRACING_MAP_ARRAY_ELT(array, idx)				\
> --
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
