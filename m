Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE813F58EB;
	Tue,  9 Jun 2026 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002641; cv=none; b=BuJFSlyeWkZ61vgrkd5MgdDtkdsRKUThYgKp3R5Nkaq4ijB4qNKbGxm+G+XDZc6KlEDyoKul3m1gURGfTygjPIGYZKKvUzMljzCJ6ZDlZQZxT321msQZ289IXWL0NYl4MAKcayhrjOXd0BsY4PRYgaXGqhrMm8EyQAr+0H/bO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002641; c=relaxed/simple;
	bh=S/LBPsjK30OHelXFeIEq2OoL51toNBeqnKCcHXf3YZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCxn8MepUMx0v7znuTsjZYlCnFgyXjnS0RH6+nPaW94PjEV6c9MNvQA349VvZh8t+0zdz7y4NTn2iMZiC4K8Nytn+jtnqyP4LlfxLoRkEtXP4X5LADBU2O58uySeXUbZJi+VhjG6Ds0UtWV0uH0D4gVIe42fVPTA/I/7EqTsVEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=R2Ebasz7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="R2Ebasz7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=fa8zz6R4p8oQR9YfNRRWZX08Hmu4ZhsxlCE5B6JMwdY=; b=R2Ebasz7sqx+PQI4Hl+rYq/Yah
	KTpeniLLengUedpR0JZxa5kHQkS/sXBigQJVRtOblpTfnfdBT7PlkvhZL2VTR5zqvINsMgKVKrZ46
	qzxqWewlD80vhGHWzUC+QnReOX533BW5H8jSGhy+0WZfadKWzi0vZNbJNPhCY2GVozO5KpZNAQa+4
	DTSWN/XhKQe06Y5LHdmR14pTdR5qTILMr5lEHJ0HJk/FdI+Z2sj866hO11kM7Dp7GbfK1Y9mD0CnH
	f1piZ1PerfnSuwVedlK4tkEItLxaeSBwIi/QUS+x5E3XjsOtDokiuWKgkeQx9RG//0zC3fU5qqxSL
	wTS/Cw1w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWu8w-008LtA-2j;
	Tue, 09 Jun 2026 10:57:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Jun 2026 03:56:55 -0700
Subject: [PATCH v9 1/6] mm/memory-failure: drop dead error_states[] entry
 for reserved pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ecc_panic-v9-1-432a74002e74@debian.org>
References: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
In-Reply-To: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=leitao@debian.org;
 h=from:subject:message-id; bh=S/LBPsjK30OHelXFeIEq2OoL51toNBeqnKCcHXf3YZ8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJ/F+RwM7FNvMEmtMWZ1Zg7fCTG+bxJiZsvZCe
 jH49HaDs1+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaifxfgAKCRA1o5Of/Hh3
 bfWQD/99pUoutynRjvnbUr1KG39G7HbZBPVQotVsVqujJ9kMtd9WYO/9Mq3ApucmJ6rxrDOdobr
 yPsAWi5L8Wm73ds8YU2RpvtWBfvLX/YKGlouKI4VCMFSfMXgSpIVfvqToBnSnXnle1Pm6uN4aHG
 Su/eUPNTnkRnSCNIQZ3NoOJqX9xlrjiw87zP9aNgGsevb8IL5aye9meJZT6lwaJEa4WGQTryZVK
 1EWkgs3iLPgAy8Nf5jktGpIypnon4nRmgrDPra9MiuftTp02o5z9W7InLcCTU8iHtkWuwiUGyw6
 8+z+8GWgLrWP7kOSwnAsTpCKXoBjWaK0KMEEjgJm5q9GAMX3oI71isW9u6MfmWF5aOGBBpWAmw6
 Fwj3o7IdL5b8hVzrjX9Yr+p+YmZ6bqBm7RPZu/JCnD5v2xHTCaL5LlSq9sfXGbcb5hl0y8zOyCN
 VfgEju0mpzTSYmG1UVCfqTfEoyYpaA3Yayl/HpNQYWnRS31qopEgKxfK8bUxEoA2V7QUBJLs9kb
 9jeKdSDWaKGK11XjAbCoFgOXq4D3kBZY19n9Yw9Y8+XCFaazzzLLgWLIHKZUvhhKduqc1nzU9yX
 yfXU1OZKQWCSVA1cl/ULE1LKeZX7FwWiNh+J68MQDCHCvREc08UbvgpdecFdOpdsOyllqWBpmZL
 xRzlYtE7rZewwOw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The first entry of error_states[],

	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },

is unreachable.  identify_page_state() has two callers, and neither
one can dispatch a PG_reserved page to me_kernel():

  * memory_failure() reaches identify_page_state() only after
    get_hwpoison_page() returned 1.  get_any_page() reaches that
    return only via __get_hwpoison_page(), which only takes a
    refcount when the page is HWPoisonHandlable().
    HWPoisonHandlable() is an allowlist for LRU, free-buddy, and
    (for soft-offline) movable_ops pages -- PG_reserved pages do
    not satisfy any of these, so they fail with -EBUSY/-EIO long
    before identify_page_state() runs.

  * try_memory_failure_hugetlb() reaches identify_page_state() only
    via the MF_HUGETLB_IN_USED branch, where the page is necessarily
    a hugetlb folio.  hugetlb folios don't carry PG_reserved at that
    point: hugetlb_folio_init_vmemmap() calls __folio_clear_reserved()
    during init, so the reserved entry would not match even if it
    were still present.

me_kernel() never executes and the entry exists only to be matched
against by code that cannot see it.

Drop the entry, the me_kernel() helper, and the now-unused
"reserved" macro.  Leave the MF_MSG_KERNEL enum value in place: it
remains part of the tracepoint and pr_err() string tables, and
follow-on work to classify unrecoverable kernel pages can reuse it
without churning the user-visible enum.

No functional change.

Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51508a55c405..f4d3e6e20e13 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -980,17 +980,6 @@ static bool has_extra_refcount(struct page_state *ps, struct page *p,
 	return false;
 }
 
-/*
- * Error hit kernel page.
- * Do nothing, try to be lucky and not touch this instead. For a few cases we
- * could be more sophisticated.
- */
-static int me_kernel(struct page_state *ps, struct page *p)
-{
-	unlock_page(p);
-	return MF_IGNORED;
-}
-
 /*
  * Page in unknown state. Do nothing.
  * This is a catch-all in case we fail to make sense of the page state.
@@ -1199,10 +1188,8 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 #define mlock		(1UL << PG_mlocked)
 #define lru		(1UL << PG_lru)
 #define head		(1UL << PG_head)
-#define reserved	(1UL << PG_reserved)
 
 static struct page_state error_states[] = {
-	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },
 	/*
 	 * free pages are specially detected outside this table:
 	 * PG_buddy pages only make a small fraction of all free pages.
@@ -1234,7 +1221,6 @@ static struct page_state error_states[] = {
 #undef mlock
 #undef lru
 #undef head
-#undef reserved
 
 static void update_per_node_mf_stats(unsigned long pfn,
 				     enum mf_result result)

-- 
2.53.0-Meta

