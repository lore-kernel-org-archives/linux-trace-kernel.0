Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC54F0551;
	Thu,  3 Sep 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455704; cv=none; b=uR43r54p8U4lniWCEYfz1fzgCut/KUTOGyFgxiNbeV8O+5TQhEci0EWevzNCIAvugQI0AtmSMeCfWk9YWcx4WnVvImoIwt1GUHnLJd8hLin1ZXZARrAJqrnRMunX3DmM70/kQu6Tss18HySqFmUuULJSO4YdCba4/te3DUKLdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455704; c=relaxed/simple;
	bh=a3738ygz6RB4MyKQnuW2ftvleHfzZqbrsTcw5Ymo/BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSwz/8ocHY6URiHf5tdujR1Fya11vmckYQ4eI1MEaoBASw2ealce/eu3RYpHDOnFT0vKejwPKapXLdeDIBKctCMh6XNWQ0JQgMaNorJYujaZcO+3Jv9te9ZeC6uVmBIwisk5vvCol+yDHi35gHMHd64BWEEliCnAiZrN5RCSAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=0MuYsfb4; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="0MuYsfb4"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 602EE1201BC;
	Thu,  3 Sep 2026 17:15:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 81CC630;
	Thu,  3 Sep 2026 17:14:58 +0000 (UTC)
Date: Thu, 3 Sep 2026 13:16:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/4] ring-buffer: Prevent truncation of nr_pages /
 nr_subbufs
Message-ID: <20260903131601.4e4caa0d@gandalf.local.home>
In-Reply-To: <20260901155445.1475405-5-vdonnefort@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
	<20260901155445.1475405-5-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 81CC630
X-Stat-Signature: da1hmw91c4gsry6ue9ycm9kg5oeaddpg
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18IcofMKkcu31DbAJGvIB0pRIYN1S4spLs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=EQM0VIYmSSZJcx2CTQCUz+pGnyeUaj8iMc9UDxBrZMg=; b=0MuYsfb4RRC34mSamzdeXyelgnxjNrKrClN27u29M8i64A4Z+Lqd3YToXObHwzVi019rKsYKQCZaV8m6967BHKEVYgRvext1yRfkp0ZyGORaGqQwmgGeHDH7Vtfr1pRuaKh2TkZWeKwcN6qYeCyEorRI3XiStvuJzHqzdo6m88Y=
X-HE-Tag: 1788455698-761224
X-HE-Meta: U2FsdGVkX1/AJxdCkMF9L+1ixN7J4/qoeoSfFi2be4yh2tIQr8Y4hsfhVo1zAyZ+vb8+L6tDXzlxPD/WzNflWLUDv0icU1lPTm+llAo9xwoWRPjNBKwKMTOpUDtfYti6u0Agg/g8s1Mm4cM+04k1YPwOEq7eXiwY0uCSi1NdUhOo1h5PEvdmevg+ToArfUtlaOO5lJOC3hmADS66pbKlZYxLWJ8R41U9KpqHw/Z/5Hdppj57KvTk9A3dHx7PtVdVln42hvb+9x+xn5H7h+e56LIxjwqw3uuDL1A/EFdkF59A0YOr5L7CVvjJlREQeB2N51hn1qNTwj5Sw/J+aiZI4nBaj4GuiWxntuKxHDutPdDfH4o38jVKBuZ0hRDkL1lF+GXsaRTCRQOIwba4fwIOePrYol9Rfc1ivXjQjeFhxMQ=

On Tue,  1 Sep 2026 16:54:45 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> -static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
> +static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, unsigned int idx)
>  {
>  	struct ring_buffer_cpu_meta *meta;
> +	unsigned int subbuf_size;
>  	unsigned long ptr;
> -	int subbuf_size;
>  
>  	meta = rb_range_meta(cpu_buffer->buffer, 0, cpu_buffer->cpu);
>  	if (!meta)
> @@ -1777,7 +1776,7 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
>  
>  	ptr = (unsigned long)rb_subbufs_from_meta(meta);
>  
> -	ptr += subbuf_size * idx;
> +	ptr += (unsigned long)subbuf_size * idx;

Really, it looks like the idx should be typecasted, as it is the number of
subbuffers. Maybe even pass it in as unsigned long?

>  	if (ptr + subbuf_size > cpu_buffer->buffer->range_addr_end)
>  		return NULL;
>  
> @@ -1854,13 +1853,13 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
>   * must be the same.
>   */
>  static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> -			      struct trace_buffer *buffer, int nr_pages,
> +			      struct trace_buffer *buffer, unsigned long nr_pages,
>  			      unsigned long *subbuf_mask)
>  {
> -	int subbuf_size = PAGE_SIZE;
> +	unsigned long subbuf_size = PAGE_SIZE;

Why the long? Shouldn't it be unsigned int?

>  	unsigned long buffers_start;
>  	unsigned long buffers_end;
> -	int i;
> +	unsigned long i;
>  
>  	if (!subbuf_mask)
>  		return false;
> @@ -2109,8 +2108,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  	struct buffer_page *head_page, *orig_head, *orig_reader;
>  	struct rb_validation_state state = { 0 };
>  	bool skip = false;
> +	unsigned long i;
>  	int ret;
> -	int i;
>  
>  	if (!meta || !meta->head_buffer)
>  		return;
> @@ -2161,7 +2160,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  		rb_validate_buffer(head_page, cpu_buffer, meta, &state, 0, state.ts);
>  	}
>  	if (i)
> -		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
> +		pr_info("Ring buffer [%d] rewound %lu pages\n", cpu_buffer->cpu, i);
>  
>  	/* The last rewound page must be skipped. */
>  	if (head_page != orig_head)
> @@ -2245,7 +2244,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  	}
>  }
>  
> -static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
> +static void rb_range_meta_init(struct trace_buffer *buffer,
> +			       unsigned long nr_pages, int scratch_size)

static void rb_range_meta_init(struct trace_buffer *buffer, unsigned long nr_pages,
			       int scratch_size)

looks better ;-)

>  {
>  	struct ring_buffer_cpu_meta *meta;
>  	unsigned long *subbuf_mask;
> @@ -2345,8 +2345,8 @@ static int rbm_show(struct seq_file *m, void *v)
>  			   rb_meta_subbuf_idx(meta, (void *)meta->head_buffer));
>  		seq_printf(m, "commit_buffer: %d\n",
>  			   rb_meta_subbuf_idx(meta, (void *)meta->commit_buffer));
> -		seq_printf(m, "subbuf_size:   %d\n", meta->subbuf_size);
> -		seq_printf(m, "nr_subbufs:    %d\n", meta->nr_subbufs);
> +		seq_printf(m, "subbuf_size:   %u\n", meta->subbuf_size);
> +		seq_printf(m, "nr_subbufs:    %u\n", meta->nr_subbufs);
>  		return 0;
>  	}
>  


-- Steve
