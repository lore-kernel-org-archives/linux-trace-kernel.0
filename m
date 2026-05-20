Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FE34F497;
	Wed, 20 May 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305927; cv=none; b=ehLm7qpBOhG/HKwLxZ/tON5XhEdc0mi/G1egsavvDYy1JiqZf3EKdQHVkNjCX4t0ojYFkVDYGUmzIX3b37m0VqRmQHoV/oHckTixNTrTehBfggiPmil1DVcZY+rBD+9R5rGrRRGJuONVoLYQzIiHgH50E5htWvS7Rkzgkl9lmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305927; c=relaxed/simple;
	bh=KOsqa3UzudL5rCGIeeA1Ozh1uNiZJ9IPL2Je2fXHNg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuS7bgFbEJI8/i02PkWj4sqfnQkPPGS4iLgO125wWvsBCWPyWvMrQbQ00D5oLfQ5G8jhxlERhrFD2miNeLWyAJn/2O7bqL+DRCKu9iyhBE4KCjKLlilXpQ+SVP2ZLV13fzhkaVOKvWXtNAKYo84DOv0YurFMBzVbgDTpbzjFGrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01b-stub [10.200.18.250])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8D02B1C030E;
	Wed, 20 May 2026 19:38:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 5F09B62;
	Wed, 20 May 2026 19:38:28 +0000 (UTC)
Date: Wed, 20 May 2026 15:38:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org (open list:TRACING),
 linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: Re: [PATCH] tracing: simplify pages allocation
Message-ID: <20260520153847.2d33e51d@gandalf.local.home>
In-Reply-To: <20260425014403.440786-1-rosenp@gmail.com>
References: <20260425014403.440786-1-rosenp@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5F09B62
X-Stat-Signature: 9obnz4wx4dqjc1d8unseafq4xyui995a
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19CCwFxBDm478vjyjjlC5KSwiqJtDvBQXE=
X-HE-Tag: 1779305908-239698
X-HE-Meta: U2FsdGVkX18WajClPtoQHXdP2JaHKbsRx+u9qNxNFLZuySP3uTTZDzamnZ0yuYAMa5G5ziouOrbPPjBdkE+0sGIJX3GMlIHw+jrD+3BBiYqVbsf6UlQ7KmD4dx7ArMGAe2nK4d707vZ7pmLwf/4KclumI8t7FRDLsjAhBBE7jXfVWS9+gwoKKXyuf9/+N2hsB1clEhzPhwlYTQDPvPZ11AxEtvr0NQv0LVUQ/4x5pk5wHxgWute9Jjf6g1H1QrGm6UPueKS+XeR8GE08Z6/eGlryx+B5CVOEGUuNcts7+7XO7Ws8SaBootLMar2iAmggA7S+PQ1hFojHpx0e3RfRmaiEsZ9Qph5MRnxGyn7cRbqRXUwxlMAlLEozc5B1R7PZ7h98nLEpflABlJPIwGARZw==

On Fri, 24 Apr 2026 18:44:03 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Change to a flexible array member to allocate together with the array
> struct.
> 
> Simplifies code slightly by removing no longer correct null checks for
> pages and removing kfrees.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  kernel/trace/tracing_map.c | 32 +++++++++++---------------------
>  kernel/trace/tracing_map.h |  2 +-
>  2 files changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index bf1a507695b6..627cc3fdf69e 100644
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
> @@ -302,44 +299,37 @@ static void tracing_map_array_free(struct tracing_map_array *a)
>  	if (!a)
>  		return;
>  
> -	if (!a->pages)
> -		goto free;
> -
>  	for (i = 0; i < a->n_pages; i++) {
>  		if (!a->pages[i])
>  			break;
>  		kmemleak_free(a->pages[i]);
>  		free_page((unsigned long)a->pages[i]);
>  	}
> -
> -	kfree(a->pages);
> -
> - free:
> -	kfree(a);
>  }

Sashiko reported:

   https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260425014403.440786-1-rosenp%40gmail.com
  
  Does this code leak the tracing_map_array struct?
  While removing kfree(a->pages) is correct since the array is now inline,
  it looks like we still need kfree(a) to free the container struct itself
  which is allocated by kzalloc_flex() in tracing_map_array_alloc().

It looks to be correct. Please fix.

-- Steve


>  
>  static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
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
> index 99c37eeebc16..18a02959d77b 100644
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

