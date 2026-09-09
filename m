Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96FC489FB0;
	Wed,  9 Sep 2026 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991925; cv=none; b=n3kAgOughI2dBIbJLjqDbmGd9RdUEoTON/Nmc5kjx8Dj58DN7HeGpRwMkGqMHAnBtzpw4YCC3JEID7dSrhU7a8y2GGJkU0ac0qTfvkVnKyvwETX/yv8NmlF55M5PYNdgxbDC7/jMeWNLpBYcTG0qpmK/mM1JdblAGNHSCmXA6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991925; c=relaxed/simple;
	bh=q6BP5kP6oQ5TjB3bb3azGPE1liI5ZOIwuttsZ7zJzzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJht4yMtW8m2SlJhu4bWXaxNhyMCb/Dc/NAIH1cM64bpxdfJzG/uA2eJOy7Ls6qgMqsLG7UdVl56v4NCKdde1oWmMkV9f0UxCLN/G2Z5KX5wX/8bfMkXo1mIS7zATeBDPedbPuNDXMt6GvvMkvPCA+vQ97RFQn1MAGvQkHabv4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=vOFfGjk7; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="vOFfGjk7"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id F10E61C20C9;
	Wed,  9 Sep 2026 22:12:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 2ABF235;
	Wed,  9 Sep 2026 22:11:59 +0000 (UTC)
Date: Wed, 9 Sep 2026 18:13:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] tracing/remotes: Account for ring buffer page
 header in size calculation
Message-ID: <20260909181316.676b8c56@gandalf.local.home>
In-Reply-To: <20260907192643.42513-2-vdonnefort@google.com>
References: <20260907192643.42513-1-vdonnefort@google.com>
	<20260907192643.42513-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2ABF235
X-Stat-Signature: h9nwnykqsmf76yqrew5qupwtypbpudof
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ePOxhzE5KStr96hifsCzIMWLdzhARa50=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=eqXWwhqo/0nztHxRHXstiAZes63YtobY2JN7TKFKusA=; b=vOFfGjk7zCB+iAOupKachDe3ujyORrKRL5IIMngOYGIDwIzia3kexlRdKu2renJqLWVo9EFBqtP+8H34+3AY/Q0KzynrNgSCOPKZ91xasgifPf47yWRBN7niXc83fSYwmaq4R8EQs5n6KzSZJR65T4B7liCf035fm+bLx9lRlH4=
X-HE-Tag: 1788991919-707952
X-HE-Meta: U2FsdGVkX19QsI0T5PDaIBswzPQYJWu+alnRVNcBuTBA567brb/QsxLXdOXN1ZOlWTbFDe8IgwIJVxj1aJD4BCs9Bzhp4Cygnfw9opjN0TUmC7olDuc5P53S+E1eXiMSWGMkMrIMOPF1blnK+UWPcF7S5TBSVhSI9H5CusL/n9pyX0LLLaieynQxC2TDHduDAbeWyeUAa4wuAue7N3McAfuDBHeYimrsq/V01yNshPJXGpk/jOtlO3w+Zfekp6U4WOpU3/zlyD9cqWbxuuHTyR7jYI0BCdlifVUIRgxO1lKBoHnKgQ8040xgsHrglXLEKiEEYZkmZ86YBfJPtdOdGLyOHCwDfL/Y3MVD7HEoKg/gro5ewGFIpK+Th3Nqq151

On Mon,  7 Sep 2026 20:26:42 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> trace_buffer_desc_size() and trace_remote_alloc_buffer undercount the
> required pages because every ring buffer page contains a header
> (BUF_PAGE_HDR_SIZE). Account for that header to ensure allocated remote
> ring buffers aren't smaller than requested by the user.
> 
> While at it, ensure those functions catch nr_pages overflow.

Fixes patches should never have "while at it". That means it belongs as a
separate patch. The only "while at it" that is acceptable is white space
fixes or other formatting changes along with new code that is not a fix.

> 
> Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index afc7daa6ee7d..7a1a92f87650 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -8,6 +8,8 @@
>  
>  #include <uapi/linux/trace_mmap.h>
>  
> +#include <linux/ring_buffer_types.h>

Hmm, why is this after the uapi header? It should be part of the linux/
headers.

> +
>  struct trace_buffer;
>  struct ring_buffer_iter;
>  
> @@ -281,9 +283,14 @@ static inline struct ring_buffer_desc *__first_ring_buffer_desc(struct trace_buf
>  
>  static inline size_t trace_buffer_desc_size(size_t buffer_size, unsigned int nr_cpus)
>  {
> -	unsigned int nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE), 2UL) + 1;
> +	unsigned long nr_pages =
> +		max(DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), 2UL) + 1;

This is getting a little unwieldy. Let's break it up:

	unsigned long pages_req = DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE);
	unsigned long nr_pages = max(pages_req, 2UL) + 1;

Or better yet, let's add a new helper function:

static inline unsigned long calculate_nr_pages(size_t buffer_size)
{
	unsigned long req_pages = DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE);
	return max(pages_req, 2UL) + 1;
}

Then this could be simply:

	unsigned long nr_pages = calculate_nr_pages(buffer_size);

>  	struct ring_buffer_desc *rbdesc;
>  
> +	/* Capped by ring_buffer_desc::nr_page_va */
> +	if (nr_pages > UINT_MAX)
> +		return SIZE_MAX;

Separate patch.

> +
>  	return size_add(offsetof(struct trace_buffer_desc, __data),
>  			size_mul(nr_cpus, struct_size(rbdesc, page_va, nr_pages)));
>  }
> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 75fa1ffc4c96..2e0fdbb730b7 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -980,9 +980,12 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
>  			      const struct cpumask *cpumask)
>  {
>  	size_t min_desc_size = trace_buffer_desc_size(buffer_size, cpumask_weight(cpumask));
> -	unsigned int nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE), 2UL) + 1;
>  	struct ring_buffer_desc *rb_desc;
>  	int cpu, ret = -ENOMEM;
> +	unsigned int nr_pages;
> +


> +	if (min_desc_size == SIZE_MAX)
> +		return -E2BIG;

Looks like this should be a separate patch too.

>  
>  	if (desc_size < min_desc_size)
>  		return -EINVAL;
> @@ -991,6 +994,7 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
>  	desc->struct_len = min_desc_size;
>  
>  	rb_desc = __first_ring_buffer_desc(desc);
> +	nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), 2UL) + 1;

And here we can have;

	nr_pages = calculate_nr_pages(buffer_size);

-- Steve

>  
>  	for_each_cpu(cpu, cpumask) {
>  		unsigned int id;

