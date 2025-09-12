Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22831222596
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690137; cv=none; b=fpjzrwQCP7n75vuzhIQL7vihhnrAmiUjL0jahZWylttfdFZdRipx7UHEOvHq+ooMha1pwXM1+gWKbzqGiliJfnQDsORj7d+2Dibrp/dR1kKatalIVoA5BjU5IiwJ3inOLSxrwqn+qFkC3DnQVOrs4Qyt0GfvPvn/4XqIfUMWAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690137; c=relaxed/simple;
	bh=i0qQXh+7DIrwwhu0DnxHg44sg9lfslYI1FKhuGJhOUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtJ2D2985RIM5iAw2FjLxB4RBPBKduEuMFNByEzzTsNX9PlF+tcrmsgSEuUBJKcX/60GmNsxrexgR1QqdRlh/iF/UQqrm07fo0PpDkx7QGQZZ/BZ8th8bJAf5qFotFVWP1t4MOdGfeKEOysOeKm4EmEE774TSPJB/22NIbiNDkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZQkPnZnU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o9EJkBgC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZQkPnZnU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o9EJkBgC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZQkPnZnU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o9EJkBgC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZQkPnZnU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o9EJkBgC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9819F5F89F;
	Fri, 12 Sep 2025 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757690132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWdXdLhM1N+CqR/OguV/6Acj3qPcJbiUisZav4LkXGY=;
	b=ZQkPnZnUu0qs3kJEusmuAXceM6Cr2U2hTKszSrPMNpY2THiPZeW/Juuus6RPE2J94Y8IQk
	CEkqZwKLD3dlDwefjM+0IUpZo0a0CnkApYDdt1MtFrVgEfmsQn7PctIVYwdPve20guNUI+
	ZRjYiJbsdYTcQ1gs3ZC/4H+K7PDpU2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757690132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWdXdLhM1N+CqR/OguV/6Acj3qPcJbiUisZav4LkXGY=;
	b=o9EJkBgCdfy9n0AMynRlG7cd+7nwcG2V+Rxk2lHxoLENnKZiD+UnslU7EURZvxnDhezG2O
	10PBsEc2Ijyq+cAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZQkPnZnU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o9EJkBgC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757690132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWdXdLhM1N+CqR/OguV/6Acj3qPcJbiUisZav4LkXGY=;
	b=ZQkPnZnUu0qs3kJEusmuAXceM6Cr2U2hTKszSrPMNpY2THiPZeW/Juuus6RPE2J94Y8IQk
	CEkqZwKLD3dlDwefjM+0IUpZo0a0CnkApYDdt1MtFrVgEfmsQn7PctIVYwdPve20guNUI+
	ZRjYiJbsdYTcQ1gs3ZC/4H+K7PDpU2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757690132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWdXdLhM1N+CqR/OguV/6Acj3qPcJbiUisZav4LkXGY=;
	b=o9EJkBgCdfy9n0AMynRlG7cd+7nwcG2V+Rxk2lHxoLENnKZiD+UnslU7EURZvxnDhezG2O
	10PBsEc2Ijyq+cAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C73C713869;
	Fri, 12 Sep 2025 15:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fndjLRE5xGi0MwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 12 Sep 2025 15:15:29 +0000
Date: Fri, 12 Sep 2025 16:15:23 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Kiryl Shutsemau <kas@kernel.org>, 
	Nico Pache <npache@redhat.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, 
	jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com, 
	zokeefe@google.com, rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, 
	hughd@google.com, richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <hcpxpo3xpqcppxlxhmyxkqkqnu4syohhkt5oeyh7qse7kvuwiw@qbhiubf2ubtm>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <20250912133701.GA802874@cmpxchg.org>
 <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,redhat.com,kvack.org,vger.kernel.org,nvidia.com,linux.alibaba.com,oracle.com,arm.com,lwn.net,goodmis.org,efficios.com,linux-foundation.org,infradead.org,huawei.com,gmail.com,linux.intel.com,os.amperecomputing.com,suse.de,suse.cz,gentwo.org,google.com,suse.com,linux.dev];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLp4so9kg11imxa9yzyism77ru)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 9819F5F89F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Fri, Sep 12, 2025 at 03:46:36PM +0200, David Hildenbrand wrote:
> On 12.09.25 15:37, Johannes Weiner wrote:
> > On Fri, Sep 12, 2025 at 02:25:31PM +0200, David Hildenbrand wrote:
> > > On 12.09.25 14:19, Kiryl Shutsemau wrote:
> > > > On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> > > > > The following series provides khugepaged with the capability to collapse
> > > > > anonymous memory regions to mTHPs.
> > > > > 
> > > > > To achieve this we generalize the khugepaged functions to no longer depend
> > > > > on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
> > > > > pages that are occupied (!none/zero). After the PMD scan is done, we do
> > > > > binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
> > > > > range. The restriction on max_ptes_none is removed during the scan, to make
> > > > > sure we account for the whole PMD range. When no mTHP size is enabled, the
> > > > > legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
> > > > > by the attempted collapse order to determine how full a mTHP must be to be
> > > > > eligible for the collapse to occur. If a mTHP collapse is attempted, but
> > > > > contains swapped out, or shared pages, we don't perform the collapse. It is
> > > > > now also possible to collapse to mTHPs without requiring the PMD THP size
> > > > > to be enabled.
> > > > > 
> > > > > When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
> > > > > 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
> > > > > mTHP collapses to prevent collapse "creep" behavior. This prevents
> > > > > constantly promoting mTHPs to the next available size, which would occur
> > > > > because a collapse introduces more non-zero pages that would satisfy the
> > > > > promotion condition on subsequent scans.
> > > > 
> > > > Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> > > > all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> > > > 
> > > 
> > > I am all for not adding any more ugliness on top of all the ugliness we
> > > added in the past.
> > > 
> > > I will soon propose deprecating that parameter in favor of something
> > > that makes a bit more sense.
> > > 
> > > In essence, we'll likely have an "eagerness" parameter that ranges from
> > > 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if
> > > not all is populated".
> > > 
> > > In between we will have more flexibility on how to set these values.
> > > 
> > > Likely 9 will be around 50% to not even motivate the user to set
> > > something that does not make sense (creep).
> > 
> > One observation we've had from production experiments is that the
> > optimal number here isn't static. If you have plenty of memory, then
> > even very sparse THPs are beneficial.
> 
> Exactly.
> 
> And willy suggested something like "eagerness" similar to "swapinness" that
> gives us more flexibility when implementing it, including dynamically
> adjusting the values in the future.
>

Ideally we would be able to also apply this to the page faulting paths.
In many cases, there's no good reason to create a THP on the first fault...

> > 
> > An extreme example: if all your THPs have 2/512 pages populated,
> > that's still cutting TLB pressure in half!
> 
> IIRC, you create more pressure on the huge entries, where you might have
> less TLB entries :) But yes, there can be cases where it is beneficial, if
> there is absolutely no memory pressure.
>

Correct, but it depends on the microarchitecture. For modern x86_64 AMD, it
happens that the L1 TLB entries are shared between 4K/2M/1G. This was not
(is not?) the case for Intel, where e.g back on kabylake, you had separate
entries for 4K/2MB/1GB.

Maybe in the Great Glorious Future (how many of those do we have?!) it would
be a good idea to take this kinds of things into account. Just because we can
map a THP, doesn't mean we should.

Shower thought: it might be in these cases especially where the FreeBSD
reservation system comes in handy - best effort allocating a THP, but not
actually mapping it as such until you really _know_ it is hot - and until
then, memory reclaim can just break your THP down if it really needs to.

-- 
Pedro
