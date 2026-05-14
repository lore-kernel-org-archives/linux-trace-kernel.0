Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1BE2459FE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750029; cv=none; b=rFnXlMycH6/GVYqEcZQStopbOGyp3D+9aq6ijp1g+b2YlXJNXJGgF6C7rLWsCWGuG1kwb9iNCI9ctYb7aeawoc7zrgceGZWabqXoG2+2cxWswk/flwz4fSFr3gql+7ScHE6g1E+6N1T8KZiyUmsnDTKLx88GqhsLk/74ZE1EDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750029; c=relaxed/simple;
	bh=Lmwh26GBQBL74u3IyR1CEbT938mNGH+LRyVDqBOFcIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQARw3kJ8PHsSw/rcdsFGszf1zJnDMVkg6Ja7DYLnOTiA9vEa3npppBx1rvlyHmT4XubnpIcidpGswXMSBjSouSz7ppOQog/08hOUctDEd9wH4lmEcbAE4G8wH4c5liDPQhR/NDjYgkt1XRFf2iwV8jmnb84j+VdIYArHqkNNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WLNFRT+s; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WLNFRT+s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778750016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbuPzwpDrGD5qRtFoBY7gLw9d4RHmDm8yrKE2duWsOs=;
	b=WLNFRT+sSjl7HYycGm0Zu9mjheejdUvJL3CBrAbnQL0yawyMdCtbjxl0YOE84PJw4v7Tq1
	Z7K2Zc52ghFu4skhYoyqdP6c7rAJJleSpt/OfaZNk7CxYeBta7GFglsjedV52ZsBXP+afh
	ke8bOWKQjz1N1g93KJMo/VdNfG3fKwA=
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
Subject: Re: [PATCH v7 1/6] mm/memory-failure: drop dead error_states[] entry for reserved pages
Date: Thu, 14 May 2026 17:12:33 +0800
Message-Id: <20260514091233.58243-1-lance.yang@linux.dev>
In-Reply-To: <20260513-ecc_panic-v7-1-be2e578e61da@debian.org>
References: <20260513-ecc_panic-v7-1-be2e578e61da@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Wed, May 13, 2026 at 08:39:32AM -0700, Breno Leitao wrote:
>The first entry of error_states[],
>
>	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },
>
>is unreachable.  identify_page_state() has two callers, and neither
>one can dispatch a PG_reserved page to me_kernel():
>
>  * memory_failure() reaches identify_page_state() only after
>    get_hwpoison_page() returned 1.  get_any_page() reaches that
>    return only via __get_hwpoison_page(), which gates the refcount
>    on HWPoisonHandlable().  HWPoisonHandlable() rejects PG_reserved
>    pages, so they fail with -EBUSY/-EIO long before
>    identify_page_state() runs.

HWPoisonHandlable() does not test PG_reserved directly; it only lets
LRU or free buddy pages through:

return PageLRU(page) || is_free_buddy_page(page);

So this really relies on PG_reserved not being combined with either of
those states. I would not expect that to happen, though.

>
>  * try_memory_failure_hugetlb() reaches identify_page_state() on
>    the MF_HUGETLB_IN_USED branch, but the page is necessarily a
>    hugetlb folio there.  The first table entry that matches a
>    hugetlb folio is { head, head, MF_MSG_HUGE, me_huge_page }, so
>    they dispatch to me_huge_page() before the (now-removed)
>    reserved entry would have matched, regardless of whether
>    PG_reserved happens to be set on the head page.

As David pointed out, hugetlb setup clears PG_reserved before setting
PG_head. See hugetlb_folio_init_vmemmap():

	__folio_clear_reserved(folio);
	__folio_set_head(folio);

>
>me_kernel() never executes and the entry exists only to be matched
>against by code that cannot see it.

identify_page_state() is reached only when get_hwpoison_page()
returns 1, but a PG_reserved page would not get that far, IIUC :)

>
>Drop the entry, the me_kernel() helper, and the now-unused
>"reserved" macro.  Leave the MF_MSG_KERNEL enum value in place: it
>remains part of the tracepoint and pr_err() string tables, and
>follow-on work to classify unrecoverable kernel pages can reuse it
>without churning the user-visible enum.
>
>No functional change.
>
>Suggested-by: David Hildenbrand <david@kernel.org>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---

With David's comments addressed, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
