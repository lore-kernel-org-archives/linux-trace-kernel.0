Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A13E0C62
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765349; cv=none; b=Zwqc6884yuls6a9TAgpTWGYS8DUNpvKMWz5FjHWbbODVhWBRUS6qIeSItbUl02bjZHsf9aJHsGyGZmRLxs+rygPtE5z8jdSEaQQLBsf+DtIhieepHNuT98b6F9TcJgQoTwzcIWj5z1p/6yyew+LVfwDd2OUB3Q39eoJUuo0jziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765349; c=relaxed/simple;
	bh=/htvruVWym1bQsi8fQdburgDbXqcQpRYNNGCNxuN6Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feHzGHgvkmrB2MYlZq30vsMjZ5Iwvy+FwU7Op7FpUD408aCCWCARBLofhnkdRorr0X6Rnohuje5XtIEYa8uoswPCtZErAMUnpuYSZB1xHzRte6HyF2SE8Nm0fLiFMLjuruU8v3ubY0WSCD4aYniCIaVb8VeF6nSYDGBuDhX6kZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gy4rLQF3; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gy4rLQF3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778765333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHsQvgnGni5VzgHRfyddSYqk4CVVONQEgEqMCt8cdnY=;
	b=Gy4rLQF3LbRi2vNN5nxzWcmxA0rj1izyKV4hVle7D6TZWBOFHaO+fDNE1T6lfPxCtV+ZWm
	C6dXs4GRA6SUMk/uccaOIKQE0nAtepkm5OPEDqz31U98o9qMsRRc0r5+v4EDmY4BHXN5K9
	jXcavJKzAVTla4wEJjC++MsqneecnGs=
From: Lance Yang <lance.yang@linux.dev>
To: leitao@debian.org
Cc: linmiaohe@huawei.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	nao.horiguchi@gmail.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	liam@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v7 2/6] mm/memory-failure: surface unhandlable kernel pages as -ENOTRECOVERABLE
Date: Thu, 14 May 2026 21:28:30 +0800
Message-Id: <20260514132830.25622-1-lance.yang@linux.dev>
In-Reply-To: <20260513-ecc_panic-v7-2-be2e578e61da@debian.org>
References: <20260513-ecc_panic-v7-2-be2e578e61da@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Wed, May 13, 2026 at 08:39:33AM -0700, Breno Leitao wrote:
>get_any_page() collapses three different failure modes into a single
>-EIO return:
>
>  * the put_page race in the !count_increased path;
>  * the HWPoisonHandlable() rejection that bounces out of
>    __get_hwpoison_page() with -EBUSY and exhausts shake_page() retries;
>  * the HWPoisonHandlable() rejection that goes through the
>    count_increased / put_page / shake_page retry loop.
>
>The first is transient (the page is racing with the allocator).  The
>second can be either transient (a userspace folio briefly off LRU
>during migration/compaction) or stable (slab/vmalloc/page-table/
>kernel-stack pages).  The third describes a stable kernel-owned page
>that the count_increased=true caller already held a reference on.
>
>Distinguish them on the return path: keep -EIO for both the put_page
>race and the -EBUSY-after-retries branch (shake_page() cannot drag a
>folio back from active migration, so we cannot prove the page is
>permanently kernel-owned from there), keep -EBUSY for the allocation
>race (unchanged), and return -ENOTRECOVERABLE only from the
>count_increased-true HWPoisonHandlable() rejection that exhausts its
>retries -- the caller's reference is structural evidence that the
>page is owned by the kernel.
>
>Extend the unhandlable-page pr_err() to fire for either errno and
>update the get_hwpoison_page() kerneldoc.
>
>memory_failure() still folds every negative return into
>MF_MSG_GET_HWPOISON via its existing "else if (res < 0)" branch, so
>this patch is a no-op for users of memory_failure() and only changes
>the errno that soft_offline_page() can propagate to its callers.  A
>follow-up wires the new return code through memory_failure() and
>reports MF_MSG_KERNEL for the unrecoverable cases.
>
>Suggested-by: David Hildenbrand <david@kernel.org>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
> mm/memory-failure.c | 18 +++++++++++++++---
> 1 file changed, 15 insertions(+), 3 deletions(-)
>
>diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>index 49bcfbd04d213..bae883df3ccb2 100644
>--- a/mm/memory-failure.c
>+++ b/mm/memory-failure.c
>@@ -1408,6 +1408,15 @@ static int get_any_page(struct page *p, unsigned long flags)
> 				shake_page(p);
> 				goto try_again;
> 			}
>+			/*
>+			 * Return -EIO rather than -ENOTRECOVERABLE: this
>+			 * branch is also reached for pages that are merely
>+			 * off-LRU transiently (e.g. a folio in the middle
>+			 * of migration or compaction), which shake_page()
>+			 * cannot drag back.  The caller cannot prove the
>+			 * page is permanently kernel-owned from here, so
>+			 * keep it on the recoverable errno.
>+			 */
> 			ret = -EIO;
> 			goto out;
> 		}
>@@ -1427,10 +1436,10 @@ static int get_any_page(struct page *p, unsigned long flags)
> 			goto try_again;
> 		}
> 		put_page(p);
>-		ret = -EIO;
>+		ret = -ENOTRECOVERABLE;
> 	}
> out:
>-	if (ret == -EIO)
>+	if (ret == -EIO || ret == -ENOTRECOVERABLE)
> 		pr_err("%#lx: unhandlable page.\n", page_to_pfn(p));
> 
> 	return ret;
>@@ -1487,7 +1496,10 @@ static int __get_unpoison_page(struct page *page)
>  *         -EIO for pages on which we can not handle memory errors,
>  *         -EBUSY when get_hwpoison_page() has raced with page lifecycle
>  *         operations like allocation and free,
>- *         -EHWPOISON when the page is hwpoisoned and taken off from buddy.
>+ *         -EHWPOISON when the page is hwpoisoned and taken off from buddy,
>+ *         -ENOTRECOVERABLE for stable kernel-owned pages the handler
>+ *         cannot recover (PG_reserved, slab, vmalloc, page tables,
>+ *         kernel stacks, and similar non-LRU/non-buddy pages).

Did you test this patch series? I don't see how we ever get to
-ENOTRECOVERABLE there ...

Even with MF_COUNT_INCREASED, the first pass does:

	if (flags & MF_COUNT_INCREASED)
		count_increased = true;

	[...]

	if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
		ret = 1;
	} else {
		if (pass++ < GET_PAGE_MAX_RETRY_NUM) { <-
			put_page(p);
			shake_page(p);
			count_increased = false;
			goto try_again; <-
		}
		put_page(p);
		ret = -ENOTRECOVERABLE;
	}

Then we come back with count_increased=false:

try_again:
	if (!count_increased) {
		ret = __get_hwpoison_page(p, flags); <-
		if (!ret) {
		[...]
		} else if (ret == -EBUSY) { <-
		[...]
			ret = -EIO;
			goto out; <-
		}
	}

For slab/vmalloc/page-table pages, __get_hwpoison_page() returns -EBUSY:

	if (!HWPoisonHandlable(&folio->page, flags))
		return -EBUSY;

so they still seem to end up as -EIO ... Am I missing something?

>  */
> static int get_hwpoison_page(struct page *p, unsigned long flags)
> {
>
>-- 
>2.53.0-Meta
>
>
