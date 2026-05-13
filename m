Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0B496910;
	Wed, 13 May 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686800; cv=none; b=V8yM3S4KwS/eVL3zbo+cZSVJg1FtjBTOPZTO1LzF/kLIweAbR7DanE2TCWYNat6Y+Rg3dFhJQHGxHzi9RiziMsoyCM0t7uAIGBaLJnr2fbt835IAIUh+PgYsC6B+LLK77mxbApXO7bKuJZ80FC/nYiiCEsfEy7PnXdcnVF36wqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686800; c=relaxed/simple;
	bh=3P+pE8uCw6JuISeQtNGrLkc7kUF6mG0rlNthqhsuxWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X8WRly+lhUiFaRKr88Az0dwj7w9njwG2Tvq1zCL86iX9ssFnA4dRC3WN08KH+k3whzK0VKxJYhxqkWJtQXXAs4xlvx1LEGSHanEmOR08dIoSpggAkvSCDtZT9ewHgdV9OaYJRNlyYL17UZx947B3+pFr1lufE8TVcJFf8oJju34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OPx+DcsU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OPx+DcsU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=StiN5p0Brhv25pUjIdeBXehIgHFb5wfCLHnn/Bhsiis=; b=OPx+DcsUN8QXuh9kSsho836vJu
	PJ0OQRzequxyIGQGLvHtPxj8AzF84nGA4PfixPMKdrKO71q8GouHLPgnF1N4i4gjNWkLzlZ7oi+Nn
	gljKFypHreeHz1Rc1af6WWIpsTXQZuyW4kTszpuPEBqafZ/WvKvp/ykishxR4pqobjbZZXAEVvi2v
	oopwBZxISQCsBlAzGu2sidpPf/PT+AiZxa34q+/v27M5sSAQlbf3V7oiiD+j+YJWIKJu/wlBHq1yt
	4TqbC1RT/paQAVxqJBIbDVhj3TZ0sF9+WAJmexDJbgJ0aD7EZ1n0H106AQQW0DD1jWyL8AgNVxgOa
	kTQuLgDA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNBgj-003GTo-00;
	Wed, 13 May 2026 15:39:57 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 08:39:33 -0700
Subject: [PATCH v7 2/6] mm/memory-failure: surface unhandlable kernel pages
 as -ENOTRECOVERABLE
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-ecc_panic-v7-2-be2e578e61da@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3720; i=leitao@debian.org;
 h=from:subject:message-id; bh=3P+pE8uCw6JuISeQtNGrLkc7kUF6mG0rlNthqhsuxWU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBJs7FZyPHKtHBgrc6Kh7qjDO22e9jyTS0C1Oo
 fxzWFGsNwuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagSbOwAKCRA1o5Of/Hh3
 bUQ4EACL88FtBnv/N9NnyVYqO3xg8YkV51eu3EAQKYU2lox77uiixwNBehQ6MzuVHphMsNUOGKB
 qq/qMYY0K/Vhp5mjOjJQw0N+0PeIW+rwnDasJNDr9uvEJJb4S7r0gzdaYJgQ0Hs0DY3MvlQPozN
 6FQvQFsbyZWqNqneq0o3bi05fc99tzM5YnVseLw6IANqXdPkhhTYOhnZKDvFPho8wVIUk7C0tT0
 lxyZD8UvCHQjE4441G1m33+FiJvyPCX/bdBeS6Bm5C7q0JN+es5iIbYrCKLGTVV+wbIy67hRvBB
 TCFw0cDspBJchhLujcQfPnR0a/8CKM3xFDmr6wAgxxB1IMZ1iT1ShsR5X3MaX1hp1rR28JJlgjy
 om6YT1dMmkaekVkKnFOtKACEbQfTjryndH1Spxc9fi3Wn5VfJAncFT8W44r9BQoLW9I8JoMvpDf
 ZPyMEuNn6yHFF1vla5ViykB98hR4rVCFUnu3uBUBRj+4d02R6w6pUQVukUKXEGpXviov/htT8sd
 Gk4KcUn2yVeDU3gDnq23qXGosaroL7sjVE12IJll4ZdM+mSgHVQdk8nX3TKdAbcn6c6WMsja2Hd
 enRfz/XtyBj4KmS+J/dw/wWtksFZtEF56BpdYWcB6f3DktbvbE7ApVA5YGIO9BK9+GMpsqcMgIA
 3ta1D3r9PRzJdMg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

get_any_page() collapses three different failure modes into a single
-EIO return:

  * the put_page race in the !count_increased path;
  * the HWPoisonHandlable() rejection that bounces out of
    __get_hwpoison_page() with -EBUSY and exhausts shake_page() retries;
  * the HWPoisonHandlable() rejection that goes through the
    count_increased / put_page / shake_page retry loop.

The first is transient (the page is racing with the allocator).  The
second can be either transient (a userspace folio briefly off LRU
during migration/compaction) or stable (slab/vmalloc/page-table/
kernel-stack pages).  The third describes a stable kernel-owned page
that the count_increased=true caller already held a reference on.

Distinguish them on the return path: keep -EIO for both the put_page
race and the -EBUSY-after-retries branch (shake_page() cannot drag a
folio back from active migration, so we cannot prove the page is
permanently kernel-owned from there), keep -EBUSY for the allocation
race (unchanged), and return -ENOTRECOVERABLE only from the
count_increased-true HWPoisonHandlable() rejection that exhausts its
retries -- the caller's reference is structural evidence that the
page is owned by the kernel.

Extend the unhandlable-page pr_err() to fire for either errno and
update the get_hwpoison_page() kerneldoc.

memory_failure() still folds every negative return into
MF_MSG_GET_HWPOISON via its existing "else if (res < 0)" branch, so
this patch is a no-op for users of memory_failure() and only changes
the errno that soft_offline_page() can propagate to its callers.  A
follow-up wires the new return code through memory_failure() and
reports MF_MSG_KERNEL for the unrecoverable cases.

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 49bcfbd04d213..bae883df3ccb2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1408,6 +1408,15 @@ static int get_any_page(struct page *p, unsigned long flags)
 				shake_page(p);
 				goto try_again;
 			}
+			/*
+			 * Return -EIO rather than -ENOTRECOVERABLE: this
+			 * branch is also reached for pages that are merely
+			 * off-LRU transiently (e.g. a folio in the middle
+			 * of migration or compaction), which shake_page()
+			 * cannot drag back.  The caller cannot prove the
+			 * page is permanently kernel-owned from here, so
+			 * keep it on the recoverable errno.
+			 */
 			ret = -EIO;
 			goto out;
 		}
@@ -1427,10 +1436,10 @@ static int get_any_page(struct page *p, unsigned long flags)
 			goto try_again;
 		}
 		put_page(p);
-		ret = -EIO;
+		ret = -ENOTRECOVERABLE;
 	}
 out:
-	if (ret == -EIO)
+	if (ret == -EIO || ret == -ENOTRECOVERABLE)
 		pr_err("%#lx: unhandlable page.\n", page_to_pfn(p));
 
 	return ret;
@@ -1487,7 +1496,10 @@ static int __get_unpoison_page(struct page *page)
  *         -EIO for pages on which we can not handle memory errors,
  *         -EBUSY when get_hwpoison_page() has raced with page lifecycle
  *         operations like allocation and free,
- *         -EHWPOISON when the page is hwpoisoned and taken off from buddy.
+ *         -EHWPOISON when the page is hwpoisoned and taken off from buddy,
+ *         -ENOTRECOVERABLE for stable kernel-owned pages the handler
+ *         cannot recover (PG_reserved, slab, vmalloc, page tables,
+ *         kernel stacks, and similar non-LRU/non-buddy pages).
  */
 static int get_hwpoison_page(struct page *p, unsigned long flags)
 {

-- 
2.53.0-Meta

