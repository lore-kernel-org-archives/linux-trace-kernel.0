Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A82F39C9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209090; cv=none; b=OLs7sjw069QUJnpQf5VwMx18UaMXdlrz9LQFBokyDAsgVJXcDyxW8rqRe0zSwflqEMwCZmSvxALGk1FA8QDvHCz+M9PiRrkySmsLPdyUb5WgF/csniWRhQPoVxS16BxUB38Jxxyb+ulULmqbi57wb/1L0qvLcVF2wa63r9PSkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209090; c=relaxed/simple;
	bh=F3OTy4b16LzApbKeCK9CQdP9sQX2nXedga0zslOc0IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4JaiTs9Ro3eZ2idCt6OQ7UCwF/hnlAq4giPQhyk6NFhEklEsf2rcsvvrwimMktQ3o6TVtfUt5s7Wprd5D2Tf6GExP8+E7ZjF8yD2L6Xblt/rLllbYug0NGY2e3K7fTAwZ3HI4y3Rnq8L8tyNJohMyMChGoEIiHqvUhaCLN7zsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k6mnvdMx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EXhO1lOU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ruW/HzMQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/Z7/KBwY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k6mnvdMx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EXhO1lOU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ruW/HzMQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Z7/KBwY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B9691F750;
	Thu, 23 Oct 2025 08:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761209082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uT++X15nR02aN95TsJbUkl1xeZRDQ6iRqUBMrz4vKM0=;
	b=k6mnvdMxOOpSPNL5d2igOGf95Zo+FrXzFx+SdSmGphG+ZFzpd7WoJd0t7wSiq6uGgzzaib
	2RS6jcTkrBE92rra2+lLDAPXeti6l0f2JC1lX3OWZHpALMR4MvykmNvGU93fcQqeJ7cd76
	vUDd+XLiizeNFG3q0FPqiJqFppDy+a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761209082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uT++X15nR02aN95TsJbUkl1xeZRDQ6iRqUBMrz4vKM0=;
	b=EXhO1lOUUuQqZySuP3Sw8w+L8D1JUVHgTaNZ0BYilxnYXBf107whjOnl85sLulm9H32B2T
	XzhJmc1lXOv0y7Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761209078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uT++X15nR02aN95TsJbUkl1xeZRDQ6iRqUBMrz4vKM0=;
	b=ruW/HzMQZkLDzw9pPT9qqsgQ0l7ce1+1ZbobIqtCys0ORZcwxiPtXlWRt+qmWhfYSA2/ZJ
	zal2xGJmEwKqxFVE5MS/6yG0/txhoZiFetZx8kukJC6lu40r9XguMB67JzdwxUi1nAWJuZ
	EBtVK9GjJCJgcJVauxDyEq6BJ65mROU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761209078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uT++X15nR02aN95TsJbUkl1xeZRDQ6iRqUBMrz4vKM0=;
	b=/Z7/KBwYMiXRHJ6O62WTvJZr2cvlPQQC19KsgBcotqbmmsRxEzzGPTZl1eTKfPtYeZOtH/
	Zs0dyQyvMc5H0ADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9F61136CF;
	Thu, 23 Oct 2025 08:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fiJAJvPq+WhuFQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 23 Oct 2025 08:44:35 +0000
Date: Thu, 23 Oct 2025 09:44:34 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	David Hildenbrand <david@redhat.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
	Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com, 
	raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, 
	jannh@google.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v12 mm-new 15/15] Documentation: mm: update the admin
 guide for mTHP collapse
Message-ID: <c62m3tyr6co7jqdrwhtp7exnewhogxtife7g6yh4gve7gqecz6@b5xpocyvifxp>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-16-npache@redhat.com>
 <bba40f08-1b87-6b57-0e10-6e96e4d7bde6@gentwo.org>
 <ed0887eb-6124-44ab-9d1f-1e87e9640e14@redhat.com>
 <666ee834-396d-4a7c-be89-96c58b5c2ea8@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666ee834-396d-4a7c-be89-96c58b5c2ea8@lucifer.local>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gentwo.org,redhat.com,vger.kernel.org,kvack.org,nvidia.com,linux.alibaba.com,oracle.com,arm.com,lwn.net,goodmis.org,kernel.org,efficios.com,linux-foundation.org,infradead.org,huawei.com,gmail.com,linux.intel.com,os.amperecomputing.com,suse.de,suse.cz,google.com,cmpxchg.org,suse.com,linux.dev];
	R_RATELIMIT(0.00)[to_ip_from(RL9fy6bbe9bsqg6ca1r59pbo74)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Thu, Oct 23, 2025 at 09:00:10AM +0100, Lorenzo Stoakes wrote:
> On Wed, Oct 22, 2025 at 10:22:08PM +0200, David Hildenbrand wrote:
> > On 22.10.25 21:52, Christoph Lameter (Ampere) wrote:
> > > On Wed, 22 Oct 2025, Nico Pache wrote:
> > >
> > > > Currently, madvise_collapse only supports collapsing to PMD-sized THPs +
> > > > and does not attempt mTHP collapses. +
> > >
> > > madvise collapse is frequently used as far as I can tell from the THP
> > > loads being tested. Could we support madvise collapse for mTHP?
> >
> > The big question is still how user space can communicate the desired order,
> > and how we can not break existing users.
>

Do we want to let userspace communicate order? It seems like an extremely
specific thing to do. A more simple&sane semantic could be something like:
"MADV_COLLAPSE collapses a given [addr, addr+len] range into the highest
order THP it can/thinks it should.". The implementation details of PMD or
contpte or <...> are lost by the time we get to userspace.

The man page itself is pretty vaguely written to allow us to do whatever
we want. It sounds to me that allowing userspace to create arbitrary order
mTHPs would be another pandora's box we shouldn't get into.

> Yes, and let's go one step at a time, this series still needs careful scrutiny
> and we need to ensure the _fundamentals_ are in place for khugepaged before we
> get into MADV_COLLAPSE :)
>
> >
> > So I guess there will definitely be some support to trigger collapse to mTHP
> > in the future, the big question is through which interface. So it will
> > happen after this series.
> 
> Yes.
> 
> >
> > Maybe through process_madvise() where we have an additional parameter, I
> > think that was what people discussed in the past.
> 
> I wouldn't absolutely love us doing that, given it is a general parameter so
> would seem applicable to any madvise() option and could lead to confusion, also
> process_madvise() was originally for cross-process madvise vector operations.

For what it's worth, it would probably not be too hard to devise a generic
separation there between "generic flags" and "behavior-specific flags".
And then stuff the desired THP order into MADV_COLLAPSE-specific flags.

> 
> I expanded this to make it applicable to the current process (and introduced
> PIDFD_SELF to make that more sane), and SJ has optimised it across vector
> operations (thanks SJ! :), but in general - it seems very weird to have
> madvise() provide an operation that process_madvise() providse another version
> of that has an extra parameter.
> 
> As usual we've painted ourselves into a corner with an API... :)

But yes, I agree it would feel weird.

> 
> Perhaps we'll to accept the process_madvise() compromise and add
> MADV_COLLAPSE_MHTP that only works with it or something.
> 
> Of course adding a new syscall isn't impossible... madvise2() not very appealing
> however...

It is my impression that process_madvise() is already madvise2(), but
poorly named.

> 
> TL;DR I guess we'll deal with that when we come to it :)

Amen :)

-- 
Pedro
