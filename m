Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED79379C50;
	Fri, 26 Jun 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488037; cv=none; b=XqkgynZ5JyQtgh7Egax6llCFxbJNadmt374nTnfRzq0VJYYttWv1+Fkufv8w3XjmdLW/jGLqD+xAa35IZD9kuEEdQCVj8r9asj+z+l5MMRrXOuOxbEzd1BPdPe1ylqHGZaX+HNKn75fFsPVGhh8ArPeeGjLvBkU91WITAETNXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488037; c=relaxed/simple;
	bh=QiA0KGoCN46shnI5qT5X0mAB2aGO1DAFqEcShnOA/HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o33J8EA85IdYQ0cTvt/PtlSYWMCxDB+XN+ISNzNAn0sMaffp5/hDaC0ub7pk8rSfZZELgToXu5YfRR+8WnJf0n9nh3XTQ6+1kqeKYDzvlNlVLfS6NwY7yVilIYdYxqC4+gBAD3Uqfu5Ara6Y0RiTjd9Z+YISiPtcfogs5ExoZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=TzHmLHBx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="TzHmLHBx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=yKuJcjdWzQFo0sQFTE+S5Gh5L1HH8cwYpvBwkdQvObQ=; b=TzHmLHBxVHiFLct+VoIyFgD9A/
	1QCk5csoAA7sc4DWbl3xJ2Xsob+QW2yVow8yFrJ7RmBYuor4HGhhDc5aa11HWa18ZC452n7Iu9CqF
	hH3z0dA+8IWYjd5pwFn/WlQtOegxxCPNCMwMu9QKwp6jlHnOJ6sYFqFq+gpzj9pryXAdkH2HWhmaF
	YCx/APW/Nabt5/AmVDF7OS2a3VEizOKQmCoXRLkq4SOblwEoQxg6PGbGsokn3i5U9u645qTaZxF4H
	Qn/6SzUrkXrh7+K4/p2Q/p9XCTKHICdO3O87Fy5elpVN6BLocR+L0TgsyzNsLH8YlnANi7dN+XOIU
	j/wBIZzw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd8Yj-004483-0a;
	Fri, 26 Jun 2026 15:33:37 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 08:33:15 -0700
Subject: [PATCH v10 1/6] mm/memory-failure: drop dead error_states[] entry
 for reserved pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-ecc_panic-v10-1-6dacb8ad024d@debian.org>
References: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
In-Reply-To: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3201; i=leitao@debian.org;
 h=from:subject:message-id; bh=QiA0KGoCN46shnI5qT5X0mAB2aGO1DAFqEcShnOA/HE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPpvEdqLaNwFdB3QJkJ0QWv+5rYxWyoSuI/8FI
 uNGnwuyfZSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj6bxAAKCRA1o5Of/Hh3
 be34EACC6biyih5n4XzxL4jAdYPe7LRbOpn+PLp8N0q5SF0Szem1h7Q5xf8ZkPGOXfHPrD8NECb
 aHuPm6bOXyk3hARmfDc5FqympsSykr27EL0gIh9mAapzUkMc7Uvz3vIYgiK29Y45jd7s8iMR5CT
 /+q1U6yRCvmeN7TvH6viLGQCOVNppL75IO7EC56l2YXCZ/ry15N66oIzIGlNkVp0bz+Ft/PPx0v
 QtcZcm7+aZ0tuj8aG6kMkDiRMwo2u7cupmQpYU33zoFyBHIzIuaIEYVvzbvAhElfEhdA9USS7n6
 JC7vX72JSiwuMTE6Ma4jq8JOfW/tzwkp3wS9VKxEk4mcAXhMTKG5hAi16mmkd/UPl9cNdjpRvja
 +JTN5n3+4AZU+35LlN9kuClJch8sjGsubx+9Xw44sCrL8tNrRkVklf4Yuie10RFEz27yi3QJfN+
 lDHv9vTYX6qqKRTRmKNjoFPlaQUEJQL6DppgAdGVRY105aAFmoXIHr64xd0uohzmoV/KQ39I5TL
 /1HckYDK9+AenTlQYwFdU5lsa4i18IX6dd6gOUEoV6sfJ+zqtefVpPGQSMwz1kQZ3yCKqkT8gJ3
 X1dG9WftHKDTwoedpGI4zKa/IhICTtInrIC30C8tENWZ4jguhco996+jgFRdz2koqjUp9gbP9Og
 ct/TtGrW2CxUG9w==
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
index 51508a55c4055..f4d3e6e20e13f 100644
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

