Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453521;
	b=IeeJCjgo6z0yeM5UAQxiGYFakm7ts4f7gFL79MznSatxYqbevHnJI6jk79zM3kaIYokF
	 5HDZgILFAv/dOmY5h23r/xtZksnr8EFRkHV8TCCIKG/oEpRhIOm3zaXzxNbccjh+a3bOo
	 HB2MkjeMdsS8Qlx1u4i9VUuRmvweiCsznH+s4092fKg5Tu1xPILedkhHQPobPJax9hs9z
	 G/0IP0vFTvoB21E6LuklAdkENf+P6pBpC+PiV7xctjSPH5BfduvpiaXWJzfZqjrMtiEW5
	 1D11U5urbu0l0YAQtBoowSYbZNKSLXx3y2aiybxU445u7A15y3XoWsZroRjuZD3NZ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453521;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=dcW5cGcK21Y3UH7CNytXeKsD8qoNAseQRFgVTZx89HQ=;
	b=yUNqEh13tnRn5kGTxr9ik2GFXbioM4eO3ksMW2L62XAjegMxiiijn4v9nNyG+6npoCA/
	 5JEfY0O2WpSPk805S+uDbp/TYhZsVVBgNdVb7VmhH3kn3X7Z5+EhqE5tLiOmvXTShtKI2
	 C4Rn/b910dhCQCacmRb42swbovU7zyxlEIH2NCBoPMALRLusVeXw10XpWufgLIlgLv6yM
	 ZWEl2mrYHmkvle36pqqF2FB21jf8zBCKZ/zPF5XIa8owYNfXcr0vra8chAzOuQKrcRWr6
	 s4l+Vk8clLVRSLrO7LxmBevfLcfiyPODdPlK4Oz4f052EAJ0k7bDN3ZHWLPg4Ui0gsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=imRsXZpQ;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5C606A321;
	Mon, 23 Nov 2026 17:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1C5C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=imRsXZpQ
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 9540AA821F;
	Mon, 23 Nov 2026 17:05:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 4CCBC2002E;
	Mon, 23 Nov 2026 17:05:11 +0000 (UTC)
Date: Mon, 23 Nov 2026 12:05:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Vincent Donnefort <vdonnefort@google.com>, Xiang Gao
 <gxxa03070307@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Donggeun
 Yoo <donggeunyoo.kernel@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lorenzo Stoakes <ljs@kernel.org>, gao xu
 <gaoxu2@honor.com>, =?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [PATCH v5 1/4] ring-buffer: add
 ring_buffer_memory_size()
Message-ID: <20261123120509.3e59bdad@gandalf.local.home>
In-Reply-To: <9d178b02ddd9464982757b0f23b86011@xiaomi.com>
References: <20261105140221.44614-1-gaoxiang17@xiaomi.com>
	<20261105140221.44614-2-gaoxiang17@xiaomi.com>
	<avhteUQSrWPFuQ3a@google.com>
	<aac878d9f74e49d7b3bccd0f352b700c@xiaomi.com>
	<avxg8M4dcs7Gphc0@google.com>
	<9d178b02ddd9464982757b0f23b86011@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: eso6s38mnxyoj6enn47tjubdn1xqehg6
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4CCBC2002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Aa3NnRv+ETU+ZQkJN6EcsK4iqPfC+w9g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=dcW5cGcK21Y3UH7CNytXeKsD8qoNAseQRFgVTZx89HQ=; b=imRsXZpQDYiFYcb39U6LSM6TVnQiwg9vMANZy3EQW8l2/1eoHcAP7YQb/iKBhvS7bgrCoro/Ai+5FGvs5Dop+iTgUC24V1dOl6eOimQz7fmDf1lLeRpIQpAh1nrscZBQYOZi4xkbUPHERlOEsCPtoxJaQwpckPjM8+nP9O1XfkE=
X-HE-Tag: 1795453511-28984
X-HE-Meta: U2FsdGVkX1+VX/FmN0Z7S3lYNTElvSiXXEuL0rHm0CZLh5vUxm8JNbDml7q61afmgce4IpMekEWM17cmr3KGqJ0fvp+WA7clijLfiSOp4hOT9zoYryEvcDuRLNjSrBS6RA9M62b3CVyvQBFhg7/YPOsY3zSCQzBncj8EwClOTB1Woa/++zhz7L/33Sv3IEMwOJWmYj6WcYXtQaduJuk87OqSA7lcn5bKec2jfDSQas+qtlbQdvcNbKLoPebt3EKIiJOIGTq4JI2yGTjzdAOQQiYaxBT59T5MVaenP3v8oKsG8barGMtCHh1CPU1wVmjCl9r2hrKtAZxUhOtHSmh+S67m7pi6hDqC

On Mon, 23 Nov 2026 11:13:06 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:
>=20
> > Actually I am more and more convinced a more generic helper is better.
> > This could be ring_buffer_nr_subbufs() which only reads
> > cpu_buffer->nr_pages. =20
>=20
>=20
> Agreed. One thing I want to confirm: the reader page is one page per CPU
> for every buffer type. normal, range, and remote all allocate it in
> rb_allocate_cpu_buffer(), so trace_stat would add one sub-buffer page
> per CPU unconditionally. Your earlier "if the caller knows if a
> cpu_buffer is a remote or persistent" comment made it sound like the +1
> is conditional, but I think it always applies.

It should still get the information directly from the ring buffer and not
make any assumptions.

>=20
>=20
> > Regarding the "meta" pages, we can have a separate accessor. e.g.
> > ring_buffer_nr_meta_pages(). The caller could easily "guess" this
> > value, but as they are ring buffer internals, I suppose an accessor is
> > alright. =20
>=20
>=20
> Agreed. To confirm the semantics: meta_page is one page per CPU and is
> only allocated when the buffer is user-mapped (rb_alloc_meta_page()), so
> ring_buffer_nr_meta_pages() would return 0 or 1 per CPU.

It can also be allocated at boot up for the persistent ring buffer. Again,
something the ring buffer needs to supply information about.

>=20
>=20
> > And actually writing the paragraph above made me realise it would be
> > worth splitting the commit between ring buffer data allocations and
> > meta-page allocations (and perhaps showing the difference in
> > trace_stat). The sync for data and meta-page is slightly different. =20
>=20
>=20
> That makes sense. I was thinking of splitting trace_stat as well: the
> buffer categories report data pages only, and the meta pages are summed
> into a separate line, for example:
>=20
>=20
>   global:          XXX     (data pages)
>   instances:       XXX     (data pages)
>   snapshots:       XXX     (data pages)
>   persistents:     XXX     (data pages)
>   remotes:         0
>   meta_pages:      XXX     (sum over global and all instances)
>   total_system:    XXX     (=3D global + instances + snapshots + remotes
>                              + meta_pages)
>   total_carveout:  XXX     (=3D persistents)
>=20
>=20
> Do you have a preference between a single meta_pages line and a
> per-category data/meta split?

Not sure what you mean by the above. The meta pages should include all
allocations that contain meta data only.

>=20
>=20
> > If being off by at most one page is acceptable... (well, one subbuf
> > per trace_pipe_raw reader) then why accounting for it at all? :-) =20
>=20
>=20
> Fair enough. To make sure I understand: free_page is not just the single
> cached page in cpu_buffer->free_page, but also one page held by each
> trace_pipe_raw reader while it consumes the buffer. That makes the count
> depend on the number of readers, so it cannot be accounted without a
> racy read. I will drop it.

Yes, the free page is simply a cache that is stored for reuse and is not
created per-se. It is simply reserved when a previous free happens.

>=20
>=20
> > ring_buffer_memory_size() still hit a race with
> > ring_buffer_set_subbuf_order(). and existing accessors like
> > ring_buffer_capacity() do too. It is down to the caller to resolve
> > this race, if necessary. =20
>=20
>=20
> Understood. trace_stat already holds trace_types_lock while walking
> ftrace_trace_arrays, but it does not hold buffer->mutex, so subbuf_order
> and nr_pages are read without the resize lock. The reported value can
> therefore be momentarily stale while a resize is in flight. I think that
> is acceptable for a memory-usage statistic; please tell me if you would
> rather have trace_stat serialize against resize.

Yes that is acceptable as even if we had locking, the information could
become stale as soon as it reaches user space. No need to protect against r=
aces that can happen when user space is reading it anyway.

-- Steve
