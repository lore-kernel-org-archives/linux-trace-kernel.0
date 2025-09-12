Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7156212F89
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691360; cv=none; b=gnrj94T6HXpEeAHwFZDjNax1CG0XvT2Ih6duVYoiGeWuYQ1mEfFKCsrcjL8ZEgf4gW3r7lxiVNHaAw4q18PC+/VjSdw80HMSby+drs+jr5fPhnm3NZyXwVw+RT51eI8vNFUQef/Ukk3fsGsgcwtWHJaaHZGz+mlgr08D+FrHoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691360; c=relaxed/simple;
	bh=W7RJif43AU1EBHHDVzTvRah1OjEmezhSgBT6vNT8kjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/fLaQtYGWQqd1GhttkOEo4HluEjzgs/zbj4P7I+iOd4OyQyrs8sNPbnR33fBybiUpmTl1XD7YfrbOt30Rb3jOlu5YtP2tHC9iwxueMfDbmiC5er7YQMmL1Z/bN0PTDCogkfeGlFygar6tIqCIdr8o3QiuJZcws0r/+BZRs6zqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OBpA4FMu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kAockfyw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OBpA4FMu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kAockfyw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OBpA4FMu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kAockfyw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OBpA4FMu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kAockfyw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEA3920CAB;
	Fri, 12 Sep 2025 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757691357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBiocSUn73h91SztgA47KjxTQZuFNez33YFYDrxjsUg=;
	b=OBpA4FMudjq2OYs5e/zWXlxyHxdj4X6xE5RK4DMMA5bEGrPppUbMnm0YNkCpx8dE26VLra
	Y1iOy+TI3nJcNDUe61syTO77ppu3K/VXb0ahWHKzuQxxDo6zZcJnRzU95Kzy1Cf9tUgEa6
	8rfhzKENsesY0kzhPnIe37oanrOzfXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757691357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBiocSUn73h91SztgA47KjxTQZuFNez33YFYDrxjsUg=;
	b=kAockfywONAG9VoHlV/w63sA0RrFbI31pywIuhkQYtAHEM2l0KLiWHuHxAMzy+7F+jVkSZ
	7+iid89z8TqVABDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757691357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBiocSUn73h91SztgA47KjxTQZuFNez33YFYDrxjsUg=;
	b=OBpA4FMudjq2OYs5e/zWXlxyHxdj4X6xE5RK4DMMA5bEGrPppUbMnm0YNkCpx8dE26VLra
	Y1iOy+TI3nJcNDUe61syTO77ppu3K/VXb0ahWHKzuQxxDo6zZcJnRzU95Kzy1Cf9tUgEa6
	8rfhzKENsesY0kzhPnIe37oanrOzfXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757691357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBiocSUn73h91SztgA47KjxTQZuFNez33YFYDrxjsUg=;
	b=kAockfywONAG9VoHlV/w63sA0RrFbI31pywIuhkQYtAHEM2l0KLiWHuHxAMzy+7F+jVkSZ
	7+iid89z8TqVABDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FE3F13869;
	Fri, 12 Sep 2025 15:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GH1IBNo9xGgkOgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 12 Sep 2025 15:35:54 +0000
Date: Fri, 12 Sep 2025 16:35:44 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, peterx@redhat.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, 
	jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com, 
	zokeefe@google.com, rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, 
	hughd@google.com, richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <cip5baipge3u2tb2ysds6qeoq7qjqmtkk2x7uefamcwpgh42be@24bwdor4jskq>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <20250912133701.GA802874@cmpxchg.org>
 <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
 <bd206c0e-3d99-4656-ad2f-f57316232498@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd206c0e-3d99-4656-ad2f-f57316232498@lucifer.local>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL9fy6bbe9bsqg6ca1r59pbo74)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,cmpxchg.org,kernel.org,kvack.org,vger.kernel.org,nvidia.com,linux.alibaba.com,oracle.com,arm.com,lwn.net,goodmis.org,efficios.com,linux-foundation.org,infradead.org,huawei.com,gmail.com,linux.intel.com,os.amperecomputing.com,suse.de,suse.cz,gentwo.org,google.com,suse.com,linux.dev];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Fri, Sep 12, 2025 at 03:01:02PM +0100, Lorenzo Stoakes wrote:
> On Fri, Sep 12, 2025 at 03:46:36PM +0200, David Hildenbrand wrote:
> > <snip>
> > Exactly.
> >
> > And willy suggested something like "eagerness" similar to "swapinness" that
> > gives us more flexibility when implementing it, including dynamically
> > adjusting the values in the future.
> 
> I like the idea of abstracting it like this, and - in a rare case of kernel
> developer agreement (esp. around naming :) - both Matthew, David and I rather
> loved referring to this as 'eagerness' here :)
> 
> The great benefit in relation to dynamic state is that we can simply treat this
> as an _abstract_ thing. I.e. 'how eager are we to establish THPs, trading off
> against memory pressure and higher order folio resource consumption'.
> 
> And then we can decide how precisely that is implemented in practice - and a
> sensible approach would indeed be to differentiate between scenarios where we
> might be more willing to chomp up memory vs. those we are not.
> 
> This also aligns nicely with the 'grand glorious future' we all dream off (don't
> we??) in THP where things are automated as much as possible and the _kernel
> decides_ what's best as far as is possible.
> 
> As with swappiness, it is essentially a 'hint' to us in abstract terms rather
> than simply exposing an internal kernel parameter.
> 
> (Credit to Matthew for making this abstraction suggestion in the THP cabal
> meeting by the way!)
> 
> >
> > >
> > > An extreme example: if all your THPs have 2/512 pages populated,
> > > that's still cutting TLB pressure in half!
> >
> > IIRC, you create more pressure on the huge entries, where you might have
> > less TLB entries :) But yes, there can be cases where it is beneficial, if
> > there is absolutely no memory pressure.
> >
> > >
> > > So in the absence of memory pressure, allocating and collapsing should
> > > optimally be aggressive even on very sparse regions.
> >
> > Yes, we discussed that as well in the THP cabal.
> >
> > It's very similar to the max_ptes_swapped: that parameter should not exist.
> > If there is no memory pressure we can just swap it in. If there is memory
> > pressure we probably would not want to swap in much.
> 
> Yes, but at least an eagerness parameter gets us closer to this ideal.
> 
> Of course, I agree that max_ptes_none should simply never have been exposed like
> this. It is emblematic of a 'just shove a parameter into a tunable/sysfs and let
> the user decide' approach you see in the kernel sometimes.
> 
> This is problmeatic as users have no earthly idea how to set the parameter (most
> likely never touch it), and only start fiddling should issues arise and it looks
> like a viable solution of some kind.
> 
> The problem is users usually lack a great deal of context the kernel has, and
> may make incorrect decisions that work in one situation but not another.

Note that in this case we really don't have much for context. We can trivially do
"check what number of ptes are mapped", but not anything much fancier. You can
also attempt to look at A bits (and/or check PG_referenced or PG_active). But
currently there's really nothing setup to collect this information in a timely
basis, and for anon memory (AFAIK) you only gauge this on reclaim, _if_ you
find the page itself.

The good news is that there are 3 or 4 separate movements for getting page
"temperature" information with their own special infra and daemons, for their
own special little features.

> 
> TL;DR - this kind of interface is just lazy and we have to assess these kinds of
> tunables based on the actual RoI + understanding from the user's perspective.

Fully agreed.

-- 
Pedro
