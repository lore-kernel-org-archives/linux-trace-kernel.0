Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA83D9556
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735929; cv=none; b=gdZ3th+mJOfsTMyn8f/H/RIhtIQVJQxtWciPXdaZpGIVo50hYVHN8RuqCxRsgD/Q2u1BwnCJm/8xeTVNSoFF5SWC6YgF+PW1z9Obzo9xFANE6BTvUrEOxTf+IwFMWQHITtfiV8xBzuDxmDGJo3zc21ALb6I3ttEVp2ufR0RquSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735929; c=relaxed/simple;
	bh=ZTwn4UyMShrGZfEU90otJVup2JEojFMgiToKCnnSVVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QDlF5Zv3lMoj/BSTaA8T0Es7caurAebFPkUYmH6irMlbFvppbSc/+FmgptaYR4uYy4hQCbshF9KyJI28dW4mK5XJ+5dHvpV6w2Domc1k1t9iGFeDf1ws7swdDuHLTz9nKAznUuDjN4VNnEckuh33/Zk6eqhS4JaFCagJXaNNyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdcfcOy6; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdcfcOy6"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso589937a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735919; x=1788340719; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/nf3e4536rn08VcIwbRdla3FrzM9D86FJQTH62XB18=;
        b=fdcfcOy6HRtOZ73daoZ5zvlxhHTJKMPmTvGcbBfkxdVGLpx3kgm6YEpnNEh81jifWj
         CidD8pxMoBESJ7UJeWnsesrZF/vzaLA54i2t/Xqfpz2dDw4Kf9vX+RtnCjmeoT8+klXg
         XshsxVoedZMoxvIP2qqi68MuIUINPr5nkAKdG++Iqq7QH2GGKgbhF7RTE23u8NrjklBp
         4r55oCaQsEjXKwfMDQmdwEjkuyv9wCe9C8u0yRAcxKAWGLPmz6/AOcz42cyaLv07vgEj
         pdd779s8A3cF3YCBTuKdRDUyvEw7KS13FAwHSzmqFa+QCIF45BaJo3JDL0cyEERLHrTJ
         qu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735919; x=1788340719;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S/nf3e4536rn08VcIwbRdla3FrzM9D86FJQTH62XB18=;
        b=HUwDi9+aCVGmQAx+tDII/G6tKw7rsTbFKSX8txy2cNi5Jnm8fjz0/Z2OjgtxL8Iq+r
         kl4x3rDfRhcKoMqm9szdCX+j+2kTXv9LXXcCb9ZalUH37xzfenhYmTiYneM5ufX0gRIs
         V7JJaOPWWMaFVRTDtq/EE+Ti0q8Pa04OFkUdFunhWT3YwQo+Mrt2LhYSm1I5X70djqWr
         2v/msK25xQFWJYy+YCoMs1kdUpRzeL2WmvS6ajdqcKUI8t0Cs9iOjvMfWXRpq/EypnBj
         aFY+HWfBWu7niVPpttrHiF0HHhUB4lNrbyJxGsvGTD0afVCC70/7JCA20cvAkxcMWsxb
         4cnA==
X-Forwarded-Encrypted: i=1; AHgh+Rpwulx6Wb3CFsmGfBcpVQlvIcP079bmHQwAS16QbWYgJrcqH/BeP3Qy2cSX73otZQqbyrGXqlqBToftQEibkvw+BjA=@vger.kernel.org
X-Gm-Message-State: AFuF++lXYdDYF9mKcUjyZ5NxE745nfZXpZTn8PUR1BtQdDX8Oaa+ns9B
	yvkfThPqbPKjMEwdXYdsPZcaloQGIuZvnuRNl9OW+I5G0qGRl5OsGI/tBDn4EIAvqqU0P7A2vHg
	EVheIxJPHQ4G5mlU2jG+UeYdXUA==
X-Received: from pgig7.prod.google.com ([2002:a63:f407:0:b0:cc1:c7d3:7c7b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a383:b0:3cd:8d15:895e with SMTP id adf61e73a8af0-3cf84b53689mr11572460637.12.1787735918168;
 Wed, 26 Aug 2026 02:18:38 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:16 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=4708;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ZTwn4UyMShrGZfEU90otJVup2JEojFMgiToKCnnSVVE=; b=dDBRMblwUg6UwX2I1hz2Tpxt+EI3WovENt6hqBknKpraB0X285GZYRtS86E6IMk5svSgepv73
 EfxqI68rjF/CyC9ce+QdXDFmPsPxg8E1UYpFu6gAUyL8f5QVEBtho9j
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-18-0a15d8a799aa@google.com>
Subject: [PATCH v11 18/46] KVM: guest_memfd: Handle lru_add fbatch refcounts
 during conversion safety check
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="utf-8"

A guest_memfd folio has no outstanding references if guest_memfd holds the
only references on it. Any other references on the folio may indicate
another user, and guest_memfd cannot convert it to private if there may be
an existing host user.

A folio will have outstanding references if it is present in a per-CPU
lru_add fbatch. guest_memfd does not actually participate in LRU, but
freshly-allocated folios are still added to the lru_add fbatch for batch
LRU statistics processing.

A folio may also have extra refcounts if it is on the mlock fbatch.

These two known "usages" of the folio are handled by calling
lru_cache_drain_for_folio, which drains both the lru_add and mlock
fbatches. After draining, if the refcount is still elevated, then there are
truly outstanding references.

If the page may be dma pinned, DMA is using it and hence there are
outstanding references. folio_maybe_dma_pinned() can have false positives,
but that's only with a significant number of refcounts, at which point
draining LRU is not going to move the needle - it can still be concluded
that the folio has outstanding references.

If the page is still mapped after guest_memfd tried to unmap it earlier in
the conversion process, it also has outstanding references.

Return true and exit early to avoid unnecessary draining in these 2 cases.

Provide a drain status to only drain once ever while processing a batch of
folios.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Suggested-by: David Hildenbrand <david@kernel.org>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/swap.c              |  2 ++
 virt/kvm/guest_memfd.c | 30 ++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 8e965c8ce9aa9..9f511b97ab110 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/kvm_types.h>
 
 #include "internal.h"
 
@@ -995,6 +996,7 @@ void lru_cache_drain_for_folio(const struct folio *folio,
 			*drained = LRU_CACHE_DRAINED_ALL;
 	}
 }
+EXPORT_SYMBOL_FOR_KVM(lru_cache_drain_for_folio);
 
 atomic_t lru_disable_count = ATOMIC_INIT(0);
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 6dc199be0eb87..4912f90567fe8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -8,6 +8,7 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 
 #include "kvm_mm.h"
 #include "guest_memfd.h"
@@ -556,10 +557,28 @@ static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
 	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
 }
 
+static bool __folio_has_outstanding_references(struct folio *folio,
+					       enum lru_cache_drained *drained)
+{
+	if (folio_maybe_dma_pinned(folio) || folio_mapped(folio))
+		return true;
+
+	/* 1 reference held by filemap_get_folios() in the folio batch. */
+	lru_cache_drain_for_folio(folio, 1, drained);
+
+	/*
+	 * Outstanding references are anything other than those from the page
+	 * cache, plus 1 temporary reference held by filemap_get_folios() in the
+	 * folio batch.
+	 */
+	return folio_ref_count(folio) != folio_nr_pages(folio) + 1;
+}
+
 static bool kvm_gmem_has_outstanding_references(struct inode *inode,
 						pgoff_t start, size_t nr_pages,
 						pgoff_t *err_index)
 {
+	enum lru_cache_drained drained = LRU_CACHE_NOT_DRAINED;
 	struct address_space *mapping = inode->i_mapping;
 	pgoff_t last = start + nr_pages - 1;
 	bool has_outstanding = false;
@@ -570,17 +589,12 @@ static bool kvm_gmem_has_outstanding_references(struct inode *inode,
 	folio_batch_init(&fbatch);
 
 	next = start;
-	while (has_outstanding && filemap_get_folios(mapping, &next, last, &fbatch)) {
+	while (!has_outstanding && filemap_get_folios(mapping, &next, last, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
 
-			/*
-			 * Outstanding references are anything other than those
-			 * from the page cache, plus 1 temporary reference held
-			 * by filemap_get_folios() in the folio batch.
-			 */
-			if (folio_ref_count(folio) != folio_nr_pages(folio) + 1) {
-				has_outstanding = true;
+			has_outstanding = __folio_has_outstanding_references(folio, &drained);
+			if (has_outstanding) {
 				*err_index = max(start, folio->index);
 				break;
 			}

-- 
2.55.0.887.g758fc8c411-goog

