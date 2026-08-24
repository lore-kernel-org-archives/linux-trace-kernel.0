Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D953EC82E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555502; cv=none; b=NJiqcueYj2ibHpECRe1FwESTD5m50rnKFXahRrA3YzZM0yVHzWZY6GVPV58iLrchv6JiJWI50Qr/Nap0yufS/A7bXtKfcwZjeoOgTl0+Zh45J0nRBk3RkiE3mdvDEO55uYIjNDO6BtdR5s0/Q6jX5VZZZ4AAsa2yRJrsOErM1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555502; c=relaxed/simple;
	bh=upHHen4ux8L9irT5wAQCPUOo8cd6TtLi7blsQg4Qp0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ludJL+GqAD4yKUEbcrzzU1KE/k5ic/qjb6FBcQCfI2jAjkNRUKyDLKKxgOB7rel4UtsNGddiP+xxhVLQs6hj0E7L4HdovVOLEv56rplm4OSAHZRmCsc7mbg0M+TTK2Zybwb+Nb3uf31wMK1xfiZELTk/P84JC6iHqmdrCN1sUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BBiXNL4l; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BBiXNL4l"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=upHHen4ux8L9irT5wAQCPUOo8cd6TtLi7blsQg4Qp0c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787555497; v=1; x=1788160297;
 b=BBiXNL4lNREsQ2300oMM+gr2YknnB9p1+MuIdmYBJamkt9iNgJYESP2ang0LIez/h3JLyx5F
 axQqA/FmBM/eA1KsGNvZQkK9FEz9pcH1QOUTMEPpNq5KsU3KKIwRfT/D+oO+iwFLMi+SF/r+w9h
 tt+Q+gJvYFqEsmwROXDciLSo=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost (2602:fce1:44f:115e::)
	by smtp.migadu.com with ESMTPS id bf7ef9951ffd2d20;
	Mon, 24 Aug 2026 07:11:37 +0000
X-Mizu-Trace-ID: bf7ef9951ffd2d20
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: rppt@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	hughd@google.com,
	jannh@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	corbet@lwn.net,
	liam@infradead.org,
	ljs@kernel.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	nico.pache@linux.dev,
	osalvador@suse.de,
	pfalcato@suse.de,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ziy@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 6/6] userfaultfd: collapse VM_UFFD_{MISSING,WP,MINOR,RWP} into single VM_UFFD
Date: Mon, 24 Aug 2026 15:11:26 +0800
Message-Id: <20260824071126.41979-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-6-3086981b33cf@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-6-3086981b33cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Aug 23, 2026 at 03:17:43PM +0300, Mike Rapoport (Microsoft) wrote:
[...]
>diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>index 83587d34b189..193f6e65d875 100644
>--- a/mm/userfaultfd.c
>+++ b/mm/userfaultfd.c
>@@ -50,10 +50,10 @@ struct mfill_state {
> 	pmd_t *pmd;
> };
> 
>-static bool anon_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
>+static bool anon_can_userfault(struct vm_area_struct *vma, unsigned int mode)
> {
> 	/* anonymous memory does not support MINOR mode */
>-	if (vm_flags & VM_UFFD_MINOR)
>+	if (mode & UFFD_MODE_MINOR)
> 		return false;
> 	return true;
> }
>@@ -462,7 +462,7 @@ static int mfill_copy_folio_locked(struct folio *folio, unsigned long src_addr)
> }
> 
> #define MFILL_RETRY_STATE_VMA_FLAGS \
>-	append_vma_flags(__VMA_UFFD_FLAGS, VMA_SHARED_BIT)
>+	append_vma_flags(VMA_UFFD, VMA_SHARED_BIT)

Looks like this drops registration mode from the retry snapshot. Assume a
shared shmem VMA is registered for MISSING and COPY reaches
mfill_copy_folio_retry(). While locks are dropped, the same userfaultfd|
can re-register the range for MINOR. VMA_UFFD, VM_SHARED, ops, file and
pgoff all stay unchanged, so the old COPY can continue instead of
returning -EAGAIN ... no?

The snapshot and comparison bracket the unlocked copy:

static int mfill_copy_folio_retry(struct mfill_state *mfill_state,
				  struct folio *folio)
{
	...
	mfill_retry_state_save(&retry_state, mfill_state->vma);

	/* retry copying with mm_lock dropped */
	mfill_put_vma(mfill_state);
	...
	/* reget VMA and PMD, they could change underneath us */
	err = mfill_get_vma(mfill_state);
	if (err)
		return err;

	if (mfill_retry_state_changed(&retry_state, mfill_state->vma))
		return -EAGAIN;
	...
}

Since mode now lives in vm_uffd_state.mode, could we save it before
mfill_put_vma() and compare it after mfill_get_vma()? The UFFD flags
comment also needs an update, since the mask no longer contains per mode
flags.

Maybe something like this?

---8<---
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 193f6e65d875..5e3c86fe8aee 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -493,7 +493,7 @@ static bool mfill_retry_state_changed(struct mfill_retry_state *state,
 	vma_flags_t flags = vma_flags_and_mask(&vma->flags,
 					       MFILL_RETRY_STATE_VMA_FLAGS);

-	/* Have any UFFD flags (missing, WP, minor) changed? */
+	/* Has UFFD registration or VMA sharing changed? */
 	if (!vma_flags_same_pair(&state->flags, &flags))
 		return true;

@@ -528,6 +528,7 @@ static int mfill_copy_folio_retry(struct mfill_state *mfill_state,
 	struct mfill_retry_state retry_state = { 0 };
 	struct mfill_retry_state *for_free __free(retry_put) = &retry_state;
 	unsigned long src_addr = mfill_state->src_addr;
+	unsigned int saved_mode = uffd_mode(mfill_state->vma);
 	void *kaddr;
 	int err;

@@ -549,7 +550,8 @@ static int mfill_copy_folio_retry(struct mfill_state *mfill_state,
 	if (err)
 		return err;

-	if (mfill_retry_state_changed(&retry_state, mfill_state->vma))
+	if (saved_mode != uffd_mode(mfill_state->vma) ||
+	    mfill_retry_state_changed(&retry_state, mfill_state->vma))
 		return -EAGAIN;

 	err = mfill_establish_pmd(mfill_state);
---

Cheers, Lance
