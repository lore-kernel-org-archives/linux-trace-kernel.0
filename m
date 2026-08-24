Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4435E1D5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586576; cv=none; b=CLjJgZFJegpTYUqQEgmRrMps6f4c68OSdhnNEXl5H+ztcZbrN7yH1dgaVOiAIDIq70zgiJQrGLvQD8G+W4r7MQ8w12DO+RNfgWg9tXFhNnQWfr3hGIZvETjAYnrBh8N9zhioxRbl7b4oz04KvdRFnU63GuQPeJlxpwP+VnThGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586576; c=relaxed/simple;
	bh=WM3MVN1PRqwYY42ec9gLBm7NmwB8V1GCbU6/PFNW214=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHMHTk/o1eA7BLE35VlZzaQRQ+EtemP3yoI4+Jaq0Ops/m0WtMVecqPx4DfnZetNBgusSqq/x8WyplLwesmg6hM92re+VMlpeNY3k5JJRrOG78xrBmABIEeU82ranZUyrrDGOnJ3Bz6Cbo1S/OVoO3Y8rzvGfCODnq5Zq1geuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Ok1TNobG; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Ok1TNobG"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so41799136d6.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1787586572; x=1788191372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3bUpuIKeVP88lgTSCxGsoiU0GQ4MnqPzmUq2XXBctZw=;
        b=Ok1TNobG+C/axL4qamOjO0I2V5DnYRwsRmMfrb/qe9uFtyp6eWmlrlzAJRAyn1AUuY
         8fB/DIiulsNe860x2qsNpyRiuu89ggyW7WmY36d3UUD+C8DyiWijNIvVGaXsX0xISe/v
         64ws313wyzHlMT1DAgqu8KYHPlF+HvAvR9zH04yCOm1KVGVT54T957x55z7f8DSP0Gre
         3cR0UnQFGM6cwgeUdZyyBXEhfDYA2oxinoNp2qFNpglhT9W0GC0WRjGvNLjR8hsjdZeW
         JXlutdAiHkZ15E7pZj8axsU8ZRMpTxwhc0O/1EG+crbjrcN37TH+LGY/l9/RxflVFgD+
         mPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586572; x=1788191372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3bUpuIKeVP88lgTSCxGsoiU0GQ4MnqPzmUq2XXBctZw=;
        b=nnqRDcGx7aS+xtj1YqaJSuURlhpIa4rP6/lHIXUC1/c0HUZgAYkRioiGcMYi9cRKg3
         xCgq+meCjWNmZo1Usq7iGm7176YY/yGL95S+La72chr2moqMSEx8hHzJ6AhOQ9lhLNYP
         TVUvSrxVNod0kC+b+wBduY0F2qub3/miQycxKQfjNqBbdQR7JhTrEcVjlTXzmCYO7sIz
         imz5h7tnS4S6PPbZsxnYk4pXK0OXLsskEtdP54pWwWO6sgAVQguBO2fOnxSP50oQ8as8
         EiI7UgN739Vj7IjBS8UZWQXhhzRsHo0Sg3B2jbPi7igo5wnWyWR6aI4bAENq41Dv+9oZ
         NfGA==
X-Forwarded-Encrypted: i=1; AHgh+RogUa/mDy4xtNhg1hH9/pvCqqLNE+pfTEStd/gSJ16klHJdzwgvxGCZ09fyOShujUTe/bA1nS8lU4MGCb09XvfYYJU=@vger.kernel.org
X-Gm-Message-State: AFuF++lL4u3RcMcxYXCuUZpkTozQACxwngcsXdMnqLDaRsNwlykUdCHJ
	5nNC+y1pkobq3sUUxKArx6CLMHUGHb+g+CVmySGMG6qmMuFCitE9WS+jUp23pPRregc=
X-Gm-Gg: AR+sD107AlusA4HRNYtuNFvlsOV/IC5MAHUfczCWud9V/K5NKpOcJry7wZEYi8l0sKF
	j3hXQw/bwqIp4rpT7icefJ84WMQZWdta4ucnNRYD/0u6pkTQwEJl5VUQ5dwtSWN6aevqWUH72R9
	lF+1S8TgQn+yVeJBlZ8HdzzqzC6/kEzpoI/ozIOwb6wxHNSs9ENUuRYAe0bhi8x+AzGlBl2p0QQ
	YW3/OWIoH3Gs0rPTVTdudDiYKpLLccKk/7YQXFxcaufbM5vgukcyQHcErH+FvECllUVskwogQ3n
	WxdGaKAajEX76/9x5n3DNLF58qosHUNnYTtO6LlzcM5KEiP41FmUuqCvz6pJ+T68CF8ui4Irz1U
	Q3hvy4cNGNx8BryTqS2hMVvWSXhjBxRvfqt7EB45viCUIaMwAqXt4xcy+tXlrsbOmw3itkLkl+T
	Fwj9zwQSbFUWm1Rvjqg8IkpVyvUSMogGwal4gC07hS4uQ6QAt/A4DoWFtDeXc=
X-Received: by 2002:a05:6214:f2f:b0:908:a916:4727 with SMTP id 6a1803df08f44-90c8fa2cb39mr194848236d6.25.1787586572331;
        Mon, 24 Aug 2026 08:49:32 -0700 (PDT)
Received: from localhost ([2600:382:8b2b:357c:c834:fad7:4274:2299])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a7af21sm64308866d6.41.2026.08.24.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:49:30 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:49:21 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, nico.pache@linux.dev,
	baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
	hughd@google.com, liam@infradead.org, mhocko@suse.com,
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org,
	surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org,
	ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, jannh@google.com, willy@infradead.org,
	pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 16/57] mm/collapse: freeze the sources behind
 migration entries
Message-ID: <20260824154921.GA863036@cmpxchg.org>
References: <20260816224609.308019-17-kirill@shutemov.name>
 <20260824131224.73344-1-lance.yang@linux.dev>
 <aoxQnuEacGpzp2I7@thinkstation>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoxQnuEacGpzp2I7@thinkstation>

On Mon, Aug 24, 2026 at 03:13:10PM +0100, Kiryl Shutsemau wrote:
> On Mon, Aug 24, 2026 at 09:12:24PM +0800, Lance Yang wrote:
> > 
> > On Sun, Aug 16, 2026 at 11:45:28PM +0100, Kiryl Shutsemau wrote:
> > >+		if (!folio_ref_freeze(folio,
> > >+				      folio_expected_ref_count(folio) + 1)) {
> > >+			result = SCAN_PAGE_COUNT;
> > >+			goto unfreeze;
> > >+		}
> > >+		nr_frozen = nr_saved;
> > 
> > Just one thing I was wondering about ... can deferred_split_isolate()
> > remove a source folio from deferred_split_lru while its refcount is
> > frozen by collapse_freeze_candidate()?
> > 
> > Assume an earlier span belongs to an anonymous large folio on the
> > deferred split queue, then a later span fails folio_trylock().
> > collapse_freeze_candidate() continues after freezing each source folio
> > and calls collapse_unfreeze_candidate() on a later failure:
> > 
> > static noinline enum scan_result collapse_freeze_candidate(struct mm_struct *mm,
> > 		struct collapse_candidate *cand, pte_t *pte)
> > {
> > ...
> > 	for (i = 0, addr = cand->addr; i < nr_pages;) {
> > ...
> > 		if (!folio_trylock(folio)) {
> > 			folio_put(folio);
> > 			result = SCAN_PAGE_LOCK;
> > 			goto unfreeze;
> > 		}
> > ...
> > 		nr_saved = i + nr;
> > 
> > 		if (!folio_ref_freeze(folio,
> > 				      folio_expected_ref_count(folio) + 1)) {
> > 			result = SCAN_PAGE_COUNT;
> > 			goto unfreeze;
> > 		}
> > 		nr_frozen = nr_saved;
> > 
> > 		i += nr;
> > 		addr += nr * PAGE_SIZE;
> > 	}
> > 
> > ...
> > unfreeze:
> > 	collapse_unfreeze_candidate(mm, cand, pte, nr_saved, nr_frozen);
> > 	return result;
> > }
> > 
> > folio_ref_freeze() takes the source folio's refcount to zero:
> > 
> > static inline int folio_ref_freeze(struct folio *folio, int count)
> > {
> > 	return page_ref_freeze(&folio->page, count);
> > }
> > 
> > static inline int page_ref_freeze(struct page *page, int count)
> > {
> > 	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);
> > 
> > ...
> > 	return ret;
> > }
> > 
> > While collapse_freeze_candidate() still holds the source folio lock,
> > deferred_split_scan() can call deferred_split_isolate():
> > 
> > static unsigned long deferred_split_scan(struct shrinker *shrink,
> > 		struct shrink_control *sc)
> > {
> > 	LIST_HEAD(dispose);
> > 	struct folio *folio, *next;
> > 	int split = 0;
> > 	unsigned long isolated;
> > 
> > 	isolated = list_lru_shrink_walk_irq(&deferred_split_lru, sc,
> > 					    deferred_split_isolate, &dispose);
> > }
> > 
> > static enum lru_status deferred_split_isolate(struct list_head *item,
> > 					      struct list_lru_one *lru,
> > 					      void *cb_arg)
> > {
> > 	struct folio *folio = container_of(item, struct folio, _deferred_list);
> > 	struct list_head *freeable = cb_arg;
> > 
> > 	if (folio_try_get(folio)) {
> > 		list_lru_isolate_move(lru, item, freeable);
> > 		return LRU_REMOVED;
> > 	}
> > 
> > 	/*
> > 	 * We lost race with folio_put(). Read folio state before the
> > 	 * isolate: folio_unqueue_deferred_split() checks list_empty()
> > 	 * locklessly, so once removed the folio can be freed any time.
> > 	 */
> > 	if (folio_test_partially_mapped(folio)) {
> > 		folio_clear_partially_mapped(folio);
> > 		mod_mthp_stat(folio_order(folio),
> > 			      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> > 	}
> > 	list_lru_isolate(lru, item);
> > 	return LRU_REMOVED;
> > }
> > 
> > And folio_try_get() fails because the source folio has a frozen refcount.
> > deferred_split_isolate() treats the failure as a race with folio_put(),
> > clears PG_partially_mapped and its MTHP_STAT_NR_ANON_PARTIALLY_MAPPED
> > accounting when set, then removes the folio from deferred_split_lru ...
> 
> Hm. So, the premise in deferred_split_isolate() is false:
> !folio_try_get() doesn't mean lost race with folio_put().

I suppose you mean, not exclusively. But it can also mean that. And
then the question is, who cleans up the partially_mapped state.

> I think deferred_split_isolate() should do something like:
> 
>       if (!folio_try_get(folio))
>               return LRU_SKIP;
> 
>       list_lru_isolate_move(lru, item, freeable);
>       return LRU_REMOVED;
> 
> Johannes, do I miss something?

Ah. The idea being: leave the item on the LRU when there is a race
with the refcount going zero; and then it's up to that other side to
deal with/clean up the partially_mapped state as appropriate. Thus:

folio_put()
  __folio_put()
    folio_unqueue_deferred_split()
      if __list_lru_del():
        // clear partially_mapped state & stats

will always succeed, even if it races with the shrinker. And you are
also guaranteed on the collapse side that the state won't vanish from
underneath you.

I think that should work. Usama?
