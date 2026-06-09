Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF13F58EB;
	Tue,  9 Jun 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002646; cv=none; b=D+e8KDyXhgwmvrsYzXY+oFUAQpFGQvcNJkvb7BjBjg2V6Pc/Gy+6F6tGNPDS5Q09gOaKlTs6TTWIBLQehTvwM2xOUb/rLcDgAS7IM4a2P9RKkE5el11M2Gr52E0j0N8S+yT7xsWriy6gDmVGMPQz0LnhpUQtpagqfn9XMDCyV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002646; c=relaxed/simple;
	bh=CUYyoKyV+ajjuf7tCF/I88MYnnmBVEA/RgWm86IO5uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tU7kG6ULKEoY3Hl6gid8MlcjhuJIb9NZ5urCtKQPai7jAypLxfZ0VFKWZdoBzDETR8a0dd0g8HgBmmRZZXz+09Z8Xl4ELfx93ts1qWdE2mWu5HQkja0fW7eWErpWa5kyWt9i9z2tu5/DFvoKLT5k4ndb5CM8RZOQwqUOSBpPQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=H35lLF9x; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="H35lLF9x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Gu/Cl4HXUPWLQ14somURAK/E71MHGU9VroHeZQlQXXU=; b=H35lLF9xEPajDqFU4+VwB37xTc
	Xgat1VC7Jj2yqNryAUasB3nFF+z1di3CWKHvTGOCvRP9p7Z/z8+m5bNvALYxKRGq8ZJlTI98R0hi0
	7BHOnkaQlvbxuIWUfDhKhsiwGxonKB+GXFVhfqrjoi57KIAMMH2i+X6IjNNQ5TVcEUJjA5j+lIwvk
	sXT3S8A5Osdkm2p+2fqPT9xFK30mFz2y1mlNJJuMJNDXPnBfIBPIJHenvhj5LsMZ/A8gxVoysxz2W
	hau7FSlh2TC2ce1YP5qpP9dQzuQwWLERtcIkL4wt/0d/aY1RxzL9/cjLmoFkCUZ4UxuiM73+W5/fk
	mn6L/dLw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWu92-008LtC-2T;
	Tue, 09 Jun 2026 10:57:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Jun 2026 03:56:56 -0700
Subject: [PATCH v9 2/6] mm/memory-failure: surface unhandlable kernel pages
 as -ENOTRECOVERABLE
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ecc_panic-v9-2-432a74002e74@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7083; i=leitao@debian.org;
 h=from:subject:message-id; bh=CUYyoKyV+ajjuf7tCF/I88MYnnmBVEA/RgWm86IO5uw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJ/F/MwDyE/qXxp85Rs8ajHfuMkT4dYImzyuTA
 6+g+maicm2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaifxfwAKCRA1o5Of/Hh3
 bc/uD/9tc94sUHlvAtFvm6Cj+R3myfcwXShRskHU2E4luB9pG7qWI88aosNYa4uQLzJ2Wa5RjZb
 sFyLYrmE/QR8Cc2Nhd5wk2l4vN4nhfCdUVYQ5kG6xdMjjG+2Xh3Pojw8efEccTaSGZOEmewpA38
 HzUE4ELNcij+Rc9uLB93CRld2/XIU3SajLSmy3FF4d9rUZ9U41SLIuO3xQfPe1iuMkwCUAeYIsC
 nTdAuPxBTVpJz+ZKHBFs3mwIsXEoooBycl5GPUC8Ss1PSLYd6Yk7cmxvX11Owm9UutRc54Ej1RP
 sn6mXpFu9wbByf54DDlbIqVOVEp7bjpZePGx5IN/b8eDOGHVkXr4SUVPEO/CfzBQdtgmWNtiuZ9
 pgmPilNY0x7rPq7UkstS+lZTMewLq+5UJBUgTkHO3CWT9Mo7zs8JrvyrOPCVwbqCYDKhRwjT68+
 G6SCT7PCeJ97s2n6VZQbWv282+OUz3dGxFZ9EL/BtzxrUvtsFIzPgldaauX/blaqlgJExUQYJlw
 OwD30kUi3j0197fAOrHbHjYveMfLGitHKNkbTdg3D/iYmNUno1VIpnfE7L2t0bhSGhFcv49GBJM
 u1JtvwqsbuR1yhXBmFg7bTrCxQOaA6ubFzeQozM698lmtGQnXq0mQ4YrhgOlDR2JxFUzfjDCzg/
 Poj6q6wL/Pm8mHg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

get_any_page() collapses every HWPoisonHandlable() rejection into a
single -EIO via the __get_hwpoison_page() -> -EBUSY -> shake_page()
-> retry path.  That is correct for the transient case (a userspace
folio briefly off LRU during migration or compaction, which a later
shake can drag back), but wrong for stable kernel-owned pages: slab,
page-table, large-kmalloc and PG_reserved pages will never become
HWPoisonHandlable(), so the retry loop is wasted work and the final
-EIO loses the "this is structurally unrecoverable" information.
memory_failure() then maps -EIO into MF_MSG_GET_HWPOISON, which the
panic-on-unrecoverable sysctl deliberately does not act on.

Introduce HWPoisonKernelOwned(), a small predicate that positively
identifies pages the hwpoison handler cannot recover from:

  HWPoisonKernelOwned(p, flags) :=
      !(MF_SOFT_OFFLINE && page_has_movable_ops(p)) &&
      (PageReserved(p) ||
       PageSlab(head) || PageTable(head) || PageLargeKmalloc(head))

  where head = compound_head(p).

PG_reserved is a per-page flag (PF_NO_COMPOUND) and is tested on the
page directly.  The slab, page-table and large-kmalloc page-type bits
are only stored on the head page, so those tests resolve the compound
head first, then re-read compound_head(page) afterwards: a concurrent
split or compound free that moves head invalidates the just-read flags
and the loop retries.  The lookup still takes no refcount, mirroring
the rest of get_any_page(); the recheck closes the common split race,
and a residual free->alloc->free in the same window can only mis-tag
a genuinely poisoned page, never reclassify a handlable one.

The MF_SOFT_OFFLINE / page_has_movable_ops() opt-out mirrors the
same exception in HWPoisonHandlable(): soft-offline is allowed to
migrate movable_ops pages even though they are not on the LRU, and
we must not pre-empt that with an unrecoverable verdict.

The list is intentionally not exhaustive.  vmalloc and kernel-stack
pages, for example, do not carry a page_type bit and would need a
different oracle; they keep going through the existing retry path
unchanged.  This is the smallest set we can identify with certainty
by page type.

Wire the helper into the top of get_any_page() to short-circuit
those pages before the retry loop runs.  On a hit, drop the caller's
MF_COUNT_INCREASED reference (if any) and return -ENOTRECOVERABLE
straight away.  Pages outside the helper's positive list still take
the existing retry path and return -EIO, leaving operator-visible
behaviour for those cases unchanged.

Extend the unhandlable-page pr_err() to fire for either errno and
update the get_hwpoison_page() kerneldoc to document the new return.

memory_failure() still folds every negative return into
MF_MSG_GET_HWPOISON via its existing "else if (res < 0)" branch, so
this patch on its own only changes the errno that soft_offline_page()
can propagate to its callers.  A follow-up wires -ENOTRECOVERABLE
through memory_failure() and reports MF_MSG_KERNEL for the
unrecoverable cases, which is what the
panic_on_unrecoverable_memory_failure sysctl observes.

Suggested-by: David Hildenbrand <david@kernel.org>
Suggested-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f4d3e6e20e13..eed9de387694 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1325,6 +1325,46 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
 	return PageLRU(page) || is_free_buddy_page(page);
 }
 
+/*
+ * Positive identification of pages the hwpoison handler cannot recover.
+ * These page types are owned by kernel internals (no userspace mapping
+ * to unmap, no file mapping to invalidate, no migration target), so the
+ * shake_page() / retry loop in get_any_page() can never turn them into
+ * something HWPoisonHandlable() will accept.  Short-circuit them to
+ * -ENOTRECOVERABLE so callers can panic on operator request instead of
+ * spinning through retries that exit as a transient-looking -EIO.
+ *
+ * The MF_SOFT_OFFLINE / page_has_movable_ops() opt-out mirrors
+ * HWPoisonHandlable(): soft-offline is allowed to migrate movable_ops
+ * pages even though they are not on the LRU.
+ */
+static inline bool HWPoisonKernelOwned(struct page *page, unsigned long flags)
+{
+	struct page *head;
+
+	if ((flags & MF_SOFT_OFFLINE) && page_has_movable_ops(page))
+		return false;
+
+	/* PG_reserved is a per-page flag, never set on a compound page. */
+	if (PageReserved(page))
+		return true;
+
+	/*
+	 * Page-type bits live only on the head page, so resolve any tail
+	 * first.  The check takes no refcount; recheck the head afterwards
+	 * so a concurrent split or compound free cannot leave us trusting
+	 * a stale view.  A free->alloc->free in the same window is still
+	 * possible but closing it would require taking a reference here.
+	 */
+retry:
+	head = compound_head(page);
+	if (!(PageSlab(head) || PageTable(head) || PageLargeKmalloc(head)))
+		return false;
+	if (head != compound_head(page))
+		goto retry;
+	return true;
+}
+
 static int __get_hwpoison_page(struct page *page, unsigned long flags)
 {
 	struct folio *folio = page_folio(page);
@@ -1371,6 +1411,19 @@ static int get_any_page(struct page *p, unsigned long flags)
 	if (flags & MF_COUNT_INCREASED)
 		count_increased = true;
 
+	/*
+	 * Page types we know are kernel-owned and cannot be recovered.
+	 * Short-circuit before the shake_page() / retry loop, which
+	 * cannot turn any of these into something HWPoisonHandlable().
+	 * Drop the caller's reference if MF_COUNT_INCREASED took one.
+	 */
+	if (HWPoisonKernelOwned(p, flags)) {
+		if (count_increased)
+			put_page(p);
+		ret = -ENOTRECOVERABLE;
+		goto out;
+	}
+
 try_again:
 	if (!count_increased) {
 		ret = __get_hwpoison_page(p, flags);
@@ -1418,7 +1471,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 		ret = -EIO;
 	}
 out:
-	if (ret == -EIO)
+	if (ret == -EIO || ret == -ENOTRECOVERABLE)
 		pr_err("%#lx: unhandlable page.\n", page_to_pfn(p));
 
 	return ret;
@@ -1475,7 +1528,10 @@ static int __get_unpoison_page(struct page *page)
  *         -EIO for pages on which we can not handle memory errors,
  *         -EBUSY when get_hwpoison_page() has raced with page lifecycle
  *         operations like allocation and free,
- *         -EHWPOISON when the page is hwpoisoned and taken off from buddy.
+ *         -EHWPOISON when the page is hwpoisoned and taken off from buddy,
+ *         -ENOTRECOVERABLE for kernel-owned pages identified by
+ *         HWPoisonKernelOwned() (PG_reserved, slab,
+ *         page-table, large-kmalloc) that the handler cannot recover.
  */
 static int get_hwpoison_page(struct page *p, unsigned long flags)
 {

-- 
2.53.0-Meta

