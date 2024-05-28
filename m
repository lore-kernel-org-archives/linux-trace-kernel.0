Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AD4D5AA;
	Tue, 28 May 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882484; cv=none; b=eHFbQn77Bxn8nXkl8zAz4a3oNP12lvoTqGIr9YrDReJ1Iz+NdSr+XF2wyvWEOgUl+pki4N0z7MJ45UUW3attQnBUVW5qYLBGm4kiISo5R73huDM1VrhucWobYFci+tGgQRmGSih/DCBNOgY2KU/dsFc5jYD0+33ZVkKGJitbsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882484; c=relaxed/simple;
	bh=MEXmGizH5ZPIfk9tFrmN/a5NTYRN1I0vHNXxtvfSSvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMNc84/DQTO3nIGSwuk2EK/y/DXpeSTER/tfNGlPQA1RfXFIMwxRALgGHjoIKQsVyWj4zLCa36NRnz9Z68vyHaShcpBctdpsIt57OYEaHOES2AUtk1ndhJxVaGe8cUu1U61oie+z0+VqxjjUVSNANQBoS2ALh36BNXS679a45z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wMfBjZJ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EH6ODv5T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wMfBjZJ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EH6ODv5T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wMfBjZJ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EH6ODv5T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wMfBjZJ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EH6ODv5T"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 724F7201A5;
	Tue, 28 May 2024 07:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716882477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkpiOXLGdR9OPIRy+yzo5vTOBWDcbMdJNyfMfwqVvLA=;
	b=wMfBjZJ76T1L4fBEk/Xuw2HtJYZsAR5tKO0jgzvF3OiH8srVRktv/uQWOa2dWdTZuH5mXb
	fnEj9rskHg+2/dsTb0KBYPmfzZ5AbHCXaWXQtpUafdZ+8K5HDpOCrrBkxU3eN2lHGG2FJZ
	S6o4gG9m6N+yKX33Jz5CmZ/2/1PMZZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716882477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkpiOXLGdR9OPIRy+yzo5vTOBWDcbMdJNyfMfwqVvLA=;
	b=EH6ODv5T3YkeG6oxT6qxs3sXGbDMHk6+WvvQwmcMX8+KSeYlzcq3QEPTNpwUt7ZIBbs0+F
	YNtigKl372CNejCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716882477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkpiOXLGdR9OPIRy+yzo5vTOBWDcbMdJNyfMfwqVvLA=;
	b=wMfBjZJ76T1L4fBEk/Xuw2HtJYZsAR5tKO0jgzvF3OiH8srVRktv/uQWOa2dWdTZuH5mXb
	fnEj9rskHg+2/dsTb0KBYPmfzZ5AbHCXaWXQtpUafdZ+8K5HDpOCrrBkxU3eN2lHGG2FJZ
	S6o4gG9m6N+yKX33Jz5CmZ/2/1PMZZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716882477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkpiOXLGdR9OPIRy+yzo5vTOBWDcbMdJNyfMfwqVvLA=;
	b=EH6ODv5T3YkeG6oxT6qxs3sXGbDMHk6+WvvQwmcMX8+KSeYlzcq3QEPTNpwUt7ZIBbs0+F
	YNtigKl372CNejCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFB1513A5D;
	Tue, 28 May 2024 07:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fVzvKyyMVWZgQQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 28 May 2024 07:47:56 +0000
Date: Tue, 28 May 2024 09:47:47 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [mm] d99e3140a4:
 BUG:KCSAN:data-race_in_folio_remove_rmap_ptes/print_report
Message-ID: <ZlWMIwDcEI5edfnJ@localhost.localdomain>
References: <202405281431.c46a3be9-lkp@intel.com>
 <8aba80ed-7b3e-4c8c-99e8-d8a2e0b112fc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aba80ed-7b3e-4c8c-99e8-d8a2e0b112fc@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, May 28, 2024 at 09:43:39AM +0200, David Hildenbrand wrote:
> Likely that's just a page_type check racing against concurrent
> mapcount changes.
> 
> In __folio_rmap_sanity_checks() we check
> 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);

Yeah, and that "collides" with

last = atomic_add_negative(-1, &page->_mapcount)

from __folio_remove_rmap.

> To make sure we don't get hugetlb folios in the wrong rmap code path. That
> can easily race with concurrent mapcount changes, just like any other
> page_type checks that end up in folio_test_type/page_has_type e.g., from
> PFN walkers.
> 
> Load tearing in these functions shouldn't really result in false positives
> (what we care about), but READ_ONCE shouldn't hurt or make a difference.
> 
> 
> From b03dc9bf27571442d886d8da624a4e4f737433f2 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 28 May 2024 09:37:20 +0200
> Subject: [PATCH] mm: read page_type using READ_ONCE
> 
> KCSAN complains about possible data races: while we check for a
> page_type -- for example for sanity checks -- we might concurrently
> modify the mapcount that overlays page_type.
> 
> Let's use READ_ONCE to avoid laod tearing (shouldn't make a difference)
> and to make KCSAN happy.
> 
> Note: nothing should really be broken besides wrong KCSAN complaints.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202405281431.c46a3be9-lkp@intel.com
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

-- 
Oscar Salvador
SUSE Labs
