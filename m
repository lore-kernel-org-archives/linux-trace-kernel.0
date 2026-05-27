Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E73242BD;
	Wed, 27 May 2026 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890798; cv=none; b=fN907a/ydraGfNj0VmdF566mAdD6u8X6LYwM7RQmqtnZgw3iHasoM6lsX17fTmIHpBqf17/XnTVxi/tJbvI/x1VFgQ0L1+ijSLWY5AGi/nbA6WcM0H+WOZLX3NCD4Q0zvqL5oa1sZPLfNq9Hs4EhuYVDqiXodeOOaKn7qy1BST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890798; c=relaxed/simple;
	bh=dRzYu8tKgN6EjEgu5H7QOpWd9i5LbDMZJK2X6dDuigk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Phvn+nHztQaJ2DOtcb6ip3zOG/1nmfaeluFzAklimmoHH4tayMZMi4wKXmPWuqR4WiXfAiHFkYPOa5WD0JSM302befB1pf2rDKYCWQkyjssrJ0wZqEqhcihUOmBI1bnjBRW3micGKqCIRM79OFhQHDigYWbBnH1P6wXtvaLiCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=t5XLJFW+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="t5XLJFW+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=7Eg1c66LFMSDZiSV4TVxCFeAUFW0duGKcjtTfzIRAmY=; b=t5XLJFW+uun1qucxrWkkyytvAC
	HKxTRIK0pdxK6gln5TMBVKA9j8oKw0A41XdPIb0bG2gARxsyUdy4Np5sACSgpck9Ek8n79JBgraJc
	n77fanFsSs/29HEH9MVJzDahLk1p1vICqVjuO3HtRbpSvExxqg4GYbfvv4h3sYHhf/dAFGAFyUtL3
	3cDuqpj+SbZly5GYogh3UZ2XWATlPaMRPSYFijQ4IfKJnZKOvaoEfZp5f5NCFfwQq/+0aAoN7G3wI
	zSc+GuXpj9nBXeOgMBSOO/98xpgP023IS2gL2aiB2DuS1HUWp8+Elxa/Rjr0Z4dsxELYz4GwKLLM5
	36h+Usqg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSEtz-003DSd-1i;
	Wed, 27 May 2026 14:06:31 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 May 2026 07:06:14 -0700
Subject: [PATCH v8 1/6] mm/memory-failure: drop dead error_states[] entry
 for reserved pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-ecc_panic-v8-1-9ea0cfa16bb0@debian.org>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
In-Reply-To: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
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
 kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3194; i=leitao@debian.org;
 h=from:subject:message-id; bh=dRzYu8tKgN6EjEgu5H7QOpWd9i5LbDMZJK2X6dDuigk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqFvpb1t1yv21tSoXdpd9OeX7lVUqVxBfmBWhRO
 7QMfvqcuUqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahb6WwAKCRA1o5Of/Hh3
 bRLSD/9hra+31QED97u48QP55twrygQyNcmxlYKWygJmoyU4xa7l6enHBboEvlIJi7I/r2D8812
 ZM1O1RL4Rl0bxPeX4dQDLD21S+aNapyrEP/X1Nc+z7O5xECZK1gAiTXa1ZDG/jna6TbAIT8iUKu
 3c5LPqKasQzx6QwGZuf+PfZRicIkAxftwTNEdUB4+M74p8Jic0eGsydOMR23W0dzm75MsjGe39B
 wna0s/IXdcK1m7Qw4lpXQNdmbiWapHcmEUOqMezfMugMkUCiz8bgSfRRG7gLPG4EX1D5o2eNaMu
 itOnCL/dX/AUwCSE2eKiIMNZwf3Aey9zc6Msb3yVwKdRDxu0yLIHvUFQUI9jvIWRMjQu9fjNWOh
 yUUzXaDncvCoJA1LL1oVJzi/mEHe5YrHkLKOC6DMhYYMts7Cgj8s8OiXiGmngwT43XyL64x8VmO
 EHmlfnY9FVJY57gVvOP06yMEq6HJKpcHUD9mjcpdba4L24qncka7JHwbu0x1O7DOQSKi0M0IgDO
 +FZqA2sNAf4etbyVSm9aV6mCYLbt2jO3o0ItIeV3SpI+A40KNmuo1a8DcjrltK9R9NV+p3+dXvT
 WwZtY5lCZVJU/v+gePAT8u/k+VN1IZFPgWbIO4BcMcIw/zU4l1HWhqIFCsikew7x7FiAyA1/QKY
 1Xr7zhi5EBlO9Cg==
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
2.54.0

