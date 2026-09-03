Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42AF4F7995
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457065; cv=none; b=Hhj65LjyQf4KV1Wv9jMHUg8NRf2zUb/xxGZ/gxwcbTPYQfyEy50trMPYKTjehsaKIbwUtiIo2qC4xn4npmd+nipyulKZw2lbfifxfu6IIGsR1osp7fTmbesxn+BYTrVIVLmlsNngfyCNCmxPE0uE7MlzNycACzhJ1tpsHBGPs+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457065; c=relaxed/simple;
	bh=SyrqIQQtXa4YPY2KvQxhEouU+yPJizVLNGPmWqZG/rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4FAjRx6jADRVGxLXVfHS/+1V/BdwxXmOm+uiHE96u4ffexZHeSIyQZKR4MuL3xMZg3ISfx92NgYjtdLX6Tj34MvpNRJUuOCGJP4N4fdGZ6ACw8YkIxoAzm03IqEBNBbjvo8z/a9lawVMS/gptLrZlTV2TCAXAT5vsyHI5yuuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VE537Zba; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VE537Zba"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4843f205a5bso121600f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788457061; x=1789061861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LnCu4sSV0cMjhA1klemm51cjPzIr5wLOT8ikgdkccRI=;
        b=VE537ZbarMZxo9+bcjs3yITDoza4lkLk8HlgANkgSKnGjWeWBhc1rVYOgq43f3foKr
         Jgjlq9BP03tU9EkNaxymabP5tJdnzrQpe3Hl2vA4TPXFzKf2UEqSVtfTbRxyVsYAMZjf
         umZTyda6HsDBWZ+yDBnfzeG8LGT3nhtA6jtZnDfbc7VmoBpWR82doHwmsoqQvD/zwOry
         UePdmczMHeMVM9nEYW8AdVFtX/T/HnyJcqZcnhIaplp5FWM+cS660p6UlB6T3yTg7Whg
         dV1NW9Xyub3Y2QxYUBZaWJX9zLvpEnjpHMvU8moXVqNg3YUygFo9S63jjyeFd4ZTQpxD
         L4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457061; x=1789061861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnCu4sSV0cMjhA1klemm51cjPzIr5wLOT8ikgdkccRI=;
        b=D0nneu+McYuY5jEvp1GTVhgN5kPz/SzHU+/scL2lCEDLUoyyiM1Yi/bYBXE6reKWVm
         5BPBCCviev20hgpfir6WlrF35Y6LB9OlbLvU2BFrbUUXUp7ep3cpVqj64pl8T1p2QyHx
         reHQoYiutcXSd1XLr4Ma54LWi5WnUcT6R5PuEb1cTEhzgOhIut94OTNG3CIJHkQ6OWDS
         TLm9o0Na+TXBJwscLoy2LOWjltWyiTPlW0i7mRu1x9ofrpOo3+9+5FyzreQjf2yBqnHa
         gHYlYTwaBCSv58QmJMiNV7C1a3Om6L8I9nh8A+LtaEvnLFK1e0XGIUKUweR4SDuyYVni
         kwUQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3WBH3nJ0zDQ6wNG5++Gwh6ZpIgZjLBmlQD+94RJkoEsRkS3pEVLtjwBlvhRPWJK6rmsYbjC8vtB8J4XDdx+j4gJU=@vger.kernel.org
X-Gm-Message-State: AFuF++mkGd1BE3yQkCFH6cvuBY3fodO+siSV+brIaHA5eEk2EqNxxTin
	vqmRYU2SwX/sjW4OyktMVoEf1vjBBlOZ3LIYefnXcRWdlYtzVk5eKlVa4f5ZYiPQog==
X-Gm-Gg: AYBFou2s4yjt+4CfrOFFrNCc2X42dsW+qq17y92OGYAS/wrsPbceb5fwiBbZGa8L7/j
	LpMV+Jy0/dX/67eQWD1jzXR2gvcOw6vLXMD6STfY869qgeraD/PEI7MJ9OmeiT6I6hfVmQ/T/D7
	hf68Gnc9QahZYqUbdBgrHS82eM5eTbK0YNHf3ilQRrL1RX91HqFYYdh2almDFt6QlZM02UFuOWI
	e6SwkwiAqpqeciqBXHDvXU/vhTPRkeSz/jIVpzycrDRt3JbOvXzZyoDZSRFNNUmhWO2K6Ng3uAK
	NUOVf5fzIK9eRy0ho1lS+ZMn6/beYRIqLSWByfBZzNp9unui6qbf+m5Up//c7+T4PNMFHPIRgMS
	IpWBUyahb2O+LRCj6DCHnoHkDo1v/3LgF8aQuigrs+UIfs6rRxKa0MM2qvUeIf/0pT29Kx5jq5w
	R6Sq2sJkqxcCodIAqiCF1IaPC+qTrS1OwYggGi+b4BI00Vbpo5BzTEmUsELqAHGjNW/cI6U13Ao
	WzdTzwit0ahRW5q0GX00Xai7GP4S3nz
X-Received: by 2002:a05:600c:354b:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49ce58180bbmr236354195e9.11.1788457060442;
        Thu, 03 Sep 2026 10:37:40 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cc7sm1407865e9.4.2026.09.03.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:37:39 -0700 (PDT)
Date: Thu, 3 Sep 2026 18:37:36 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/4] ring-buffer: Prevent truncation of nr_pages /
 nr_subbufs
Message-ID: <apmwYLVIxX-C21aB@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
 <20260901155445.1475405-5-vdonnefort@google.com>
 <20260903131601.4e4caa0d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903131601.4e4caa0d@gandalf.local.home>

On Thu, Sep 03, 2026 at 01:16:01PM -0400, Steven Rostedt wrote:
> On Tue,  1 Sep 2026 16:54:45 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > -static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
> > +static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, unsigned int idx)
> >  {
> >  	struct ring_buffer_cpu_meta *meta;
> > +	unsigned int subbuf_size;
> >  	unsigned long ptr;
> > -	int subbuf_size;
> >  
> >  	meta = rb_range_meta(cpu_buffer->buffer, 0, cpu_buffer->cpu);
> >  	if (!meta)
> > @@ -1777,7 +1776,7 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
> >  
> >  	ptr = (unsigned long)rb_subbufs_from_meta(meta);
> >  
> > -	ptr += subbuf_size * idx;
> > +	ptr += (unsigned long)subbuf_size * idx;
> 
> Really, it looks like the idx should be typecasted, as it is the number of
> subbuffers. Maybe even pass it in as unsigned long?

__rb_allocate_pages() is passing idx as a number pages, so yeah that'd make
more sense, even though a persistent buffer is capped to a 30-bits nr_pages.

> 
> >  	if (ptr + subbuf_size > cpu_buffer->buffer->range_addr_end)
> >  		return NULL;
> >  
> > @@ -1854,13 +1853,13 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
> >   * must be the same.
> >   */
> >  static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> > -			      struct trace_buffer *buffer, int nr_pages,
> > +			      struct trace_buffer *buffer, unsigned long nr_pages,
> >  			      unsigned long *subbuf_mask)
> >  {
> > -	int subbuf_size = PAGE_SIZE;
> > +	unsigned long subbuf_size = PAGE_SIZE;
> 
> Why the long? Shouldn't it be unsigned int?

That is to cheat to not have to add a cast in

  buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);

> 
> >  	unsigned long buffers_start;
> >  	unsigned long buffers_end;
> > -	int i;
> > +	unsigned long i;
> >  
> >  	if (!subbuf_mask)
> >  		return false;
> > @@ -2109,8 +2108,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> >  	struct buffer_page *head_page, *orig_head, *orig_reader;
> >  	struct rb_validation_state state = { 0 };
> >  	bool skip = false;
> > +	unsigned long i;
> >  	int ret;
> > -	int i;
> >  
> >  	if (!meta || !meta->head_buffer)
> >  		return;
> > @@ -2161,7 +2160,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> >  		rb_validate_buffer(head_page, cpu_buffer, meta, &state, 0, state.ts);
> >  	}
> >  	if (i)
> > -		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
> > +		pr_info("Ring buffer [%d] rewound %lu pages\n", cpu_buffer->cpu, i);
> >  
> >  	/* The last rewound page must be skipped. */
> >  	if (head_page != orig_head)
> > @@ -2245,7 +2244,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> >  	}
> >  }
> >  
> > -static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
> > +static void rb_range_meta_init(struct trace_buffer *buffer,
> > +			       unsigned long nr_pages, int scratch_size)
> 
> static void rb_range_meta_init(struct trace_buffer *buffer, unsigned long nr_pages,
> 			       int scratch_size)
> 
> looks better ;-)

ack

-- 
Vincent

> 
> >  {
> >  	struct ring_buffer_cpu_meta *meta;
> >  	unsigned long *subbuf_mask;
> > @@ -2345,8 +2345,8 @@ static int rbm_show(struct seq_file *m, void *v)
> >  			   rb_meta_subbuf_idx(meta, (void *)meta->head_buffer));
> >  		seq_printf(m, "commit_buffer: %d\n",
> >  			   rb_meta_subbuf_idx(meta, (void *)meta->commit_buffer));
> > -		seq_printf(m, "subbuf_size:   %d\n", meta->subbuf_size);
> > -		seq_printf(m, "nr_subbufs:    %d\n", meta->nr_subbufs);
> > +		seq_printf(m, "subbuf_size:   %u\n", meta->subbuf_size);
> > +		seq_printf(m, "nr_subbufs:    %u\n", meta->nr_subbufs);
> >  		return 0;
> >  	}
> >  
> 
> 
> -- Steve
