Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11106481FCE;
	Wed, 13 May 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686796; cv=none; b=dl2oGNnrb5tRZ+EuF+KGgvFTySKGOTg9f7oTS7rf0BRh5TyfvfpLvj0r/0B8AyCClqPR90oWjZnL/2haE8N6ky+LzmtxW4WE9/ht8l1mn0ZgQGes3nl5grN1dqkjl/NSYS4QVSC8/XxowhFTuN0/NP6nUnW6OsVhABSxnAG1TPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686796; c=relaxed/simple;
	bh=YmqAu0MKBmjqTPY6Xp2AGwlYrj86HgU7CFNy45dVm1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLXct5jWlKx79hhzjxnaad49M2bnbFHKWHT5TlXjOb1LAoZRPX3LihgClkr9sTxcTfnUeNP+RBOisyCTBIn+kN8a4Z+dJJephgU8K/WdCMbznbF2XRgAHp3D7zasw9dAWmZvhoAQEUZPL8MVIdNGnvHMMJUTvCl4UuWc3OyuYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=C5kavAJm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="C5kavAJm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=0VwvF1KgbgTaLhH80dAvDE3biS5CMTVSVvUy9k323TY=; b=C5kavAJmTRWLHmHzyxTmOyzeRl
	Mu52fHbNn/G+fEXkrw3hiKPilsD8htg2JoySqpmLBduOs+nocpw2b8LkpalYG2anjI3cGaXaYdwzx
	tQcYX6WrYqFNwAuoMdljS9acv+yYKCTCu27Puir849T2C/oQfodj+LSptbrnZKY1hcPLCXZL7pYsf
	AHU1jap2iBoBmh/oj5zvK89b2UKq5Yhs/H6+9gH0CU5bOzEIcrvtQ+mi73gH4DZizL9pRG7bjQJSR
	8VMIzjrPgevFU6uqK50LI+TNyOHULSr9MLIO6CsoaAAdMNCflUgci5IaC5i+e7B6UH3/8PhTS1ZAO
	2xgZOGOw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNBgd-003GTl-1Y;
	Wed, 13 May 2026 15:39:51 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 08:39:32 -0700
Subject: [PATCH v7 1/6] mm/memory-failure: drop dead error_states[] entry
 for reserved pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-ecc_panic-v7-1-be2e578e61da@debian.org>
References: <20260513-ecc_panic-v7-0-be2e578e61da@debian.org>
In-Reply-To: <20260513-ecc_panic-v7-0-be2e578e61da@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996; i=leitao@debian.org;
 h=from:subject:message-id; bh=YmqAu0MKBmjqTPY6Xp2AGwlYrj86HgU7CFNy45dVm1c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBJs6ke4HsS3R5O/j/KZISqMDE5tmdj17JHj2r
 gYZdMUqt5WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagSbOgAKCRA1o5Of/Hh3
 bTghD/90CfcSo04fggOfDUaE1JFJXqEA/MFDTRoBPWRGgXosrYL07rW5qF0YPnv7+VS6Lw8SL3W
 eDc6QdNVpIThXaZ7mkA90LioCvk3FpsSg4mSv29bAockiYO4UnvicP499yMUKbvwD8MuXoqnCBo
 UA7E04FJKDmbVxhjI9sEwpXKRSlGiasqyFEODsK3aHf9a37apm1kpVO0cihxy9AKbeVHMbFDjhl
 kk04DtPsPGQ+yxNQFLGskcYdrsAiSFyWMCautYu6QVWGeVxpSnz/I0Zj/a2n7tEAQuGMW3iNKKo
 XXiaqDfiOQCnlRK9JFzIFmlGMbHNsrBjX42q1MCtdKMzWhAsFow7LpA9U69iMDmGjSTvAhUswHK
 1H4gCFCrXmEt+nJYLYLdx5dtzXGbiI9eTyO0iL08veDqgwg7mY5u8XBEdeQS4bgRmI4+y2+DCpi
 06m0BYrhJJZu9cC0fPJXeWdyMRIZat9lXQYpc1x0o6NzJMHN1QeDDErQaoYgVw3N4qT4Q1d4512
 KqFTdWrUhunznnlJy3E8l7+jP1RoI6YIZweDcmOc7QSSl03QeLohU4wJQVirWnUCTwgx+YTgsLJ
 UG8McwNHWspfdKqqaCBdoaKorLST1bFrvc96W1YQhqtmD52sRVbi1ZpyeMDH0bByuyTvLgpQgdL
 YwRIMi2HHPGHISQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The first entry of error_states[],

	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },

is unreachable.  identify_page_state() has two callers, and neither
one can dispatch a PG_reserved page to me_kernel():

  * memory_failure() reaches identify_page_state() only after
    get_hwpoison_page() returned 1.  get_any_page() reaches that
    return only via __get_hwpoison_page(), which gates the refcount
    on HWPoisonHandlable().  HWPoisonHandlable() rejects PG_reserved
    pages, so they fail with -EBUSY/-EIO long before
    identify_page_state() runs.

  * try_memory_failure_hugetlb() reaches identify_page_state() on
    the MF_HUGETLB_IN_USED branch, but the page is necessarily a
    hugetlb folio there.  The first table entry that matches a
    hugetlb folio is { head, head, MF_MSG_HUGE, me_huge_page }, so
    they dispatch to me_huge_page() before the (now-removed)
    reserved entry would have matched, regardless of whether
    PG_reserved happens to be set on the head page.

me_kernel() never executes and the entry exists only to be matched
against by code that cannot see it.

Drop the entry, the me_kernel() helper, and the now-unused
"reserved" macro.  Leave the MF_MSG_KERNEL enum value in place: it
remains part of the tracepoint and pr_err() string tables, and
follow-on work to classify unrecoverable kernel pages can reuse it
without churning the user-visible enum.

No functional change.

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 866c4428ac7ef..49bcfbd04d213 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -992,17 +992,6 @@ static bool has_extra_refcount(struct page_state *ps, struct page *p,
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
@@ -1211,10 +1200,8 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 #define mlock		(1UL << PG_mlocked)
 #define lru		(1UL << PG_lru)
 #define head		(1UL << PG_head)
-#define reserved	(1UL << PG_reserved)
 
 static struct page_state error_states[] = {
-	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },
 	/*
 	 * free pages are specially detected outside this table:
 	 * PG_buddy pages only make a small fraction of all free pages.
@@ -1246,7 +1233,6 @@ static struct page_state error_states[] = {
 #undef mlock
 #undef lru
 #undef head
-#undef reserved
 
 static void update_per_node_mf_stats(unsigned long pfn,
 				     enum mf_result result)

-- 
2.53.0-Meta

