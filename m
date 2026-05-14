Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D93B47FA;
	Thu, 14 May 2026 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756168; cv=none; b=DBPAVOubtP9DA0TrG5G46TWyU0PlSWrPI3ukvWiR9dX/NB/qFN4p/dWGnlddFuVZxUfhghWvSwYWvqrjcI/b/mTvIVJU+TnP70FfF+7dE2DitLMKGvyZ5RMNnPhmRCDBNIiBX65nMW2u65OuR+SIZCHaFVMag4ba3xVGKAY08TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756168; c=relaxed/simple;
	bh=P/mECulDMw1L4BtE3Yo7mSSPlh188gZgvg9sCrC/okM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQdFegR0xSvhOVG6xUGthc8E8QibZEmJUno7PzSQs2W4WdafLTnhPrUVikb4F4j3jzMQdTpfrEbCy7TXqTUNnakCCiqpQX0pTgKzdrrA5lPDMYnMGVqHpxc0zAG1UX398PVSSQ7VHL9hZpvoBKDrPBVt4xZmMtnMt8/jYdsDSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=B9HEdahA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="B9HEdahA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1XfFPCmDqRYJH/xx62DhOLsvdI6QVPwH3gKtkBbqlss=; b=B9HEdahAa6wSr6VvT/NOnU7vKE
	Urnc753D8MO9TmdbKrqkwpJyzZBzwLPj7NLh1/k5YceDEq+2+f3VB2mC+QQkIJl6ywdiJ7+SwAUt8
	CKuyoNBgpR4ICsG4PhDjeXRbPFgBf13NT7F32vK2nfR9br27qdep5cB41XZQZJO0nu+BZovNEiWyi
	R55CBMaHeaj1l0FbUQPc6URoeyB5pqN3bQOgJ5bUbvsScamXGVVlnR+b4Nj2vxX/4cI/BJPe45jM/
	KsgUgkPiwvi6OIhnShr1q/BgLyZcdIo2xGEgvou2ZymzZPBr24nR2imkDmXtfCikhlIKEHrZdHDZh
	O1bkZCgQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNTj6-003tA7-3D;
	Thu, 14 May 2026 10:55:37 +0000
Date: Thu, 14 May 2026 03:55:30 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v7 1/6] mm/memory-failure: drop dead error_states[] entry
 for reserved pages
Message-ID: <agWmHFe4QlIfU7LV@gmail.com>
References: <20260513-ecc_panic-v7-0-be2e578e61da@debian.org>
 <20260513-ecc_panic-v7-1-be2e578e61da@debian.org>
 <5712adbc-b2fd-49fd-9827-cace47eff9ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5712adbc-b2fd-49fd-9827-cace47eff9ad@kernel.org>
X-Debian-User: leitao

On Wed, May 13, 2026 at 10:10:27PM +0200, David Hildenbrand (Arm) wrote:
> On 5/13/26 17:39, Breno Leitao wrote:
> >   * memory_failure() reaches identify_page_state() only after
> >     get_hwpoison_page() returned 1.  get_any_page() reaches that
> >     return only via __get_hwpoison_page(), which gates the refcount
> >     on HWPoisonHandlable().  HWPoisonHandlable() rejects PG_reserved
> >     pages, so they fail with -EBUSY/-EIO long before
> >     identify_page_state() runs.
> 
> You should clarify why they are rejected. There is no explicit check for
> PG_reserved in there!

True, I meant that PG_reserved pages do not fit any of the criterias of
HWPoisonHandlable().

I will rewrite it more explictly:

	__get_hwpoison_page() only takes a refcount when the page is
	HWPoisonHandlable()'d, and HWPoisonHandlable() is an allowlist for LRU /
	free-buddy / (soft-offline) movable_ops pages.

is it any better?

> >   * try_memory_failure_hugetlb() reaches identify_page_state() on
> >     the MF_HUGETLB_IN_USED branch, but the page is necessarily a
> >     hugetlb folio there.  The first table entry that matches a
> >     hugetlb folio is { head, head, MF_MSG_HUGE, me_huge_page }, so
> >     they dispatch to me_huge_page() before the (now-removed)
> >     reserved entry would have matched, regardless of whether
> >     PG_reserved happens to be set on the head page.
> 
> See hugetlb_folio_init_vmemmap(): we always clear PG_reserved for hugetlb folios
> allocated from memblock.

Thanks. I clearly see a call to __folio_clear_reserved(folio), so, huge pagetlb folios
are never reserved.

A better summary would be:

	try_memory_failure_hugetlb() reaches identify_page_state() only via the
	MF_HUGETLB_IN_USED branch, as hugetlb folios don't carry PG_reserved at
	that point (hugetlb_folio_init_vmemmap() clears it during init).

> Yes, I think this should work.
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks for the review,
--breno
