Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F282E62A6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898220; cv=none; b=MjpN8IWaQkCS+6Giw2+LjkuAGKsRnMZeQIly2QHcl3ObhigCSjYo2S1TrkzoskkFOBdvv/Ppke4fUiPFPH4OkrTPaC0PtO0Y/6+ATSQq9Rz10MdCppTrHoeNRcV5XlGpwzyyNm8MwpxdoR5kh5vHAygS3v3R3EBOXmHaAAJDZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898220; c=relaxed/simple;
	bh=+AQYffAyBYiUuZgWMQbD//Qwua3uzgLuSDzQ0WqjdoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcPojTpJPriPiNXY9sGrl1brSwz7i/jBI0dih69ffDVxCW9V0OPs2yAxf855K5641PDugc5AjcefjyM3dLkBli7TIHPrtVIm1DDW6ZlSwlHAzyP7QOn+VO9p2fCD06txYHtiCyJq8N7vVzWKNglxfp+tf5oq+YrXitEkN8A4+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3NtgvRm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3NtgvRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762898217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJQdUI+LXX11RLLs0Qx52DufVkzJbNjuRnkX8eB0oEo=;
	b=b3NtgvRmIFdYVus70s8maNqZwFKPn82pfIJquuZn1KB+hxFqGB3/WCM7wLrMVAKpqEsxvp
	Ff4quYITve8EOS8q8CqqsDci0Yu67TIMpcMsRLkRuNGArND59K6xU7EI61a/EalnoUXOLf
	n8oqSAaGkJ/wSmrvv2+SWwv3HSnd6s8=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-CA_fuXEwNuSdQ16skb9OIw-1; Tue, 11 Nov 2025 16:56:54 -0500
X-MC-Unique: CA_fuXEwNuSdQ16skb9OIw-1
X-Mimecast-MFC-AGG-ID: CA_fuXEwNuSdQ16skb9OIw_1762898213
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-640fd3541b3so385546d50.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762898213; x=1763503013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fJQdUI+LXX11RLLs0Qx52DufVkzJbNjuRnkX8eB0oEo=;
        b=LaUiMh5UNls1T3JU1Ierz/5/8U9P+ZNl/AzEcsy/e4flkMkMEySbylDggG4OT6qIZB
         Xhfnah4RIUCgUFoiiIquCMNfVY2NDdTl8hLnvTXjIuc/NFOL8aL55HoQrsGS9QG0Rs78
         6f6BOdpaY0YWU6mtRQEfWLvys2XVpQcj1Jxo4bBISVbno8bzz2R5Ee/BlLpa55KRQEhi
         FMtGM/+KbIyiDZbCAQGmEFusCiFEYO2SDye4dBqMrTnE/iY4+knBC0kTJy/qGpbyucIj
         O1NzKI60nNnONKLU37ldE3AOEACkBukHpZpthMaCPE3VMzSvmIkZbJGomdl8AiaOZH13
         4k6g==
X-Forwarded-Encrypted: i=1; AJvYcCXEmuIcBA6p7IwTrpD1SQ7CEioK1/xh6KI+jGyvK1DJLQA3z7/c63HlnO4EoZQlkvbXKh1e1GQKb+4qY8mzjWXSRI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPGqAObWk6TrFb01vHoF6pXVoSAUUgyTQzXQHLu7QbSc6IxfJ
	JgswJdx0D7AUhZxk8feIe/PVkTlWNoBHI2WYtY5e0vrPYWZmBKFB9icNhOtDzhUHI5EGAhiNRFG
	aeFjuSwIL3sNp/ajKGNkagmuBbukT20Mhg/3cofCuZTedUy03mSKByf9e0SqxCrZVw2LW9YFU7P
	vK3m9Xr3llF4+h2NdQOVCohwcZhRab+zzDXToYPG10M8EaSqEy
X-Gm-Gg: ASbGncvv7ujXbimcQn9wMrkUew1sR1XK+LumbGk3PxEhDkWFVJ4BqeIMQ8nTBtW+3v5
	wE1WwVhh5rJ8ri0hu0focIDSJk2oE9tauUu4f+6+yCRfj/qcw+VtyPWnRb38WHcptFpaewi8l6I
	CFawxy5PKaZxmXWLx2anCvZmTzQiaTTkIWCr5ea2yG09jlrHzLl+8d8WORd+v5qG+Om+XF1A==
X-Received: by 2002:a05:690c:c341:b0:787:e9bc:f9d8 with SMTP id 00721157ae682-788136a7be5mr8843777b3.52.1762898213565;
        Tue, 11 Nov 2025 13:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+b3xAzqqRUNr4xdfJt+6yqZ+2HXxhopK8ftc8r8sTeifMmau05ZwVAtlGjfvcUgQM5qWXlqEnQddMG63Dwo0=
X-Received: by 2002:a05:690c:c341:b0:787:e9bc:f9d8 with SMTP id
 00721157ae682-788136a7be5mr8843467b3.52.1762898213134; Tue, 11 Nov 2025
 13:56:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-13-npache@redhat.com>
 <20251109020802.g6dytbixd4aygdgh@master>
In-Reply-To: <20251109020802.g6dytbixd4aygdgh@master>
From: Nico Pache <npache@redhat.com>
Date: Tue, 11 Nov 2025 14:56:27 -0700
X-Gm-Features: AWmQ_bn3fKyzIDCH5FNeUuK4AtOvAXqhYr80QM2Hqo2H858Qfygt1YN2wMe4pp8
Message-ID: <CAA1CXcA5pKaAOxw45YQ90ygNcGc73MY8o1X9MqR7GBih9AA1HA@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 12/15] khugepaged: Introduce mTHP collapse support
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com, 
	pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A1pL9Tnhv_2nF-yDYJTuLmKDLRGYPKf418KEEOR0wZ8_1762898213
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 7:08=E2=80=AFPM Wei Yang <richard.weiyang@gmail.com>=
 wrote:
>
> On Wed, Oct 22, 2025 at 12:37:14PM -0600, Nico Pache wrote:
> >During PMD range scanning, track occupied pages in a bitmap. If mTHPs ar=
e
> >enabled we remove the restriction of max_ptes_none during the scan phase
> >to avoid missing potential mTHP candidates.
> >
> >Implement collapse_scan_bitmap() to perform binary recursion on the bitm=
ap
> >and determine the best eligible order for the collapse. A stack struct i=
s
> >used instead of traditional recursion. The algorithm splits the bitmap
> >into smaller chunks to find the best fit mTHP.  max_ptes_none is scaled =
by
> >the attempted collapse order to determine how "full" an order must be
> >before being considered for collapse.
> >
> >Once we determine what mTHP sizes fits best in that PMD range a collapse
> >is attempted. A minimum collapse order of 2 is used as this is the lowes=
t
> >order supported by anon memory.
> >
> >mTHP collapses reject regions containing swapped out or shared pages.
> >This is because adding new entries can lead to new none pages, and these
> >may lead to constant promotion into a higher order (m)THP. A similar
> >issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
> >introducing at least 2x the number of pages, and on a future scan will
> >satisfy the promotion condition once again. This issue is prevented via
> >the collapse_allowable_orders() function.
> >
> >Currently madv_collapse is not supported and will only attempt PMD
> >collapse.
> >
> >We can also remove the check for is_khugepaged inside the PMD scan as
> >the collapse_max_ptes_none() function handles this logic now.
> >
> >Signed-off-by: Nico Pache <npache@redhat.com>
>
> Generally LGTM.
>
> Some nit below.
>
> >---
> > include/linux/khugepaged.h |   2 +
> > mm/khugepaged.c            | 128 ++++++++++++++++++++++++++++++++++---
> > 2 files changed, 122 insertions(+), 8 deletions(-)
> >
> >diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> >index eb1946a70cff..179ce716e769 100644
> >--- a/include/linux/khugepaged.h
> >+++ b/include/linux/khugepaged.h
> >@@ -1,6 +1,8 @@
> > /* SPDX-License-Identifier: GPL-2.0 */
> > #ifndef _LINUX_KHUGEPAGED_H
> > #define _LINUX_KHUGEPAGED_H
> >+#define KHUGEPAGED_MIN_MTHP_ORDER     2
> >+#define MAX_MTHP_BITMAP_STACK (1UL << (ilog2(MAX_PTRS_PER_PTE) - KHUGEP=
AGED_MIN_MTHP_ORDER))
> >
> > #include <linux/mm.h>
> >
> >diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >index 89a105124790..e2319bfd0065 100644
> >--- a/mm/khugepaged.c
> >+++ b/mm/khugepaged.c
> >@@ -93,6 +93,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM=
_SLOTS_HASH_BITS);
> >
> > static struct kmem_cache *mm_slot_cache __ro_after_init;
> >
> >+struct scan_bit_state {
> >+      u8 order;
> >+      u16 offset;
> >+};
> >+
> > struct collapse_control {
> >       bool is_khugepaged;
> >
> >@@ -101,6 +106,13 @@ struct collapse_control {
> >
> >       /* nodemask for allocation fallback */
> >       nodemask_t alloc_nmask;
> >+
> >+      /*
> >+       * bitmap used to collapse mTHP sizes.
> >+       */
> >+       DECLARE_BITMAP(mthp_bitmap, HPAGE_PMD_NR);
> >+       DECLARE_BITMAP(mthp_bitmap_mask, HPAGE_PMD_NR);
> >+      struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_STACK];
>
> Looks like an indent issue.

Thanks!
>
> > };
> >
> > /**
> >@@ -1357,6 +1369,85 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long pmd_address,
> >       return result;
> > }
> >
> >+static void push_mthp_bitmap_stack(struct collapse_control *cc, int *to=
p,
> >+                                 u8 order, u16 offset)
> >+{
> >+      cc->mthp_bitmap_stack[++*top] =3D (struct scan_bit_state)
> >+              { order, offset };
> >+}
> >+
>
> For me, I may introduce pop_mth_bitmap_stack() .
>
> And use it ...
>
> >+/*
> >+ * collapse_scan_bitmap() consumes the bitmap that is generated during
> >+ * collapse_scan_pmd() to determine what regions and mTHP orders fit be=
st.
> >+ *
> >+ * Each bit in the bitmap represents a single occupied (!none/zero) pag=
e.
> >+ * A stack structure cc->mthp_bitmap_stack is used to check different r=
egions
> >+ * of the bitmap for collapse eligibility. We start at the PMD order an=
d
> >+ * check if it is eligible for collapse; if not, we add two entries to =
the
> >+ * stack at a lower order to represent the left and right halves of the=
 region.
> >+ *
> >+ * For each region, we calculate the number of set bits and compare it
> >+ * against a threshold derived from collapse_max_ptes_none(). A region =
is
> >+ * eligible if the number of set bits exceeds this threshold.
> >+ */
> >+static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long add=
ress,
> >+              int referenced, int unmapped, struct collapse_control *cc=
,
> >+              bool *mmap_locked, unsigned long enabled_orders)
> >+{
> >+      u8 order, next_order;
> >+      u16 offset, mid_offset;
> >+      int num_chunks;
> >+      int bits_set, threshold_bits;
> >+      int top =3D -1;
> >+      int collapsed =3D 0;
> >+      int ret;
> >+      struct scan_bit_state state;
> >+      unsigned int max_none_ptes;
> >+
> >+      push_mthp_bitmap_stack(cc, &top, HPAGE_PMD_ORDER - KHUGEPAGED_MIN=
_MTHP_ORDER, 0);
> >+
> >+      while (top >=3D 0) {
> >+              state =3D cc->mthp_bitmap_stack[top--];
>
> ... here.

Ack!

>
> >+              order =3D state.order + KHUGEPAGED_MIN_MTHP_ORDER;
>
> We push real_order - KHUGEPAGED_MIN_MTHP_ORDER, and get it by add
> KHUGEPAGED_MIN_MTHP_ORDER.
>
> Maybe we can push real_order ...
>
> >+              offset =3D state.offset;
> >+              num_chunks =3D 1UL << order;
> >+
> >+              /* Skip mTHP orders that are not enabled */
> >+              if (!test_bit(order, &enabled_orders))
> >+                      goto next_order;
> >+
> >+              max_none_ptes =3D collapse_max_ptes_none(order, !cc->is_k=
hugepaged);
> >+
> >+              /* Calculate weight of the range */
> >+              bitmap_zero(cc->mthp_bitmap_mask, HPAGE_PMD_NR);
> >+              bitmap_set(cc->mthp_bitmap_mask, offset, num_chunks);
> >+              bits_set =3D bitmap_weight_and(cc->mthp_bitmap,
> >+                                           cc->mthp_bitmap_mask, HPAGE_=
PMD_NR);
> >+
> >+              threshold_bits =3D (1UL << order) - max_none_ptes - 1;
> >+
> >+              /* Check if the region is eligible based on the threshold=
 */
> >+              if (bits_set > threshold_bits) {
> >+                      ret =3D collapse_huge_page(mm, address, reference=
d,
> >+                                               unmapped, cc, mmap_locke=
d,
> >+                                               order, offset);
> >+                      if (ret =3D=3D SCAN_SUCCEED) {
> >+                              collapsed +=3D 1UL << order;
> >+                              continue;
> >+                      }
> >+              }
> >+
> >+next_order:
> >+              if (state.order > 0) {
>
> ...and if (order > KHUGEPAGED_MIN_MTHP_ORDER) here?
>
> Not sure you would like it.

I went ahead and implemented this based on real order. Thanks for the
suggestion, it's much cleaner now. It made more sense like this when I
had the bitmap compressed into 128 bits.

>
> >+                      next_order =3D state.order - 1;
> >+                      mid_offset =3D offset + (num_chunks / 2);
> >+                      push_mthp_bitmap_stack(cc, &top, next_order, mid_=
offset);
> >+                      push_mthp_bitmap_stack(cc, &top, next_order, offs=
et);
> >+              }
> >+      }
> >+      return collapsed;
> >+}
> >+
> > static int collapse_scan_pmd(struct mm_struct *mm,
> >                            struct vm_area_struct *vma,
> >                            unsigned long start_addr, bool *mmap_locked,
> >@@ -1364,11 +1455,15 @@ static int collapse_scan_pmd(struct mm_struct *m=
m,
> > {
> >       pmd_t *pmd;
> >       pte_t *pte, *_pte;
> >+      int i;
> >       int result =3D SCAN_FAIL, referenced =3D 0;
> >-      int none_or_zero =3D 0, shared =3D 0;
> >+      int none_or_zero =3D 0, shared =3D 0, nr_collapsed =3D 0;
> >       struct page *page =3D NULL;
> >+      unsigned int max_ptes_none;
> >       struct folio *folio =3D NULL;
> >       unsigned long addr;
> >+      unsigned long enabled_orders;
> >+      bool full_scan =3D true;
> >       spinlock_t *ptl;
> >       int node =3D NUMA_NO_NODE, unmapped =3D 0;
> >
> >@@ -1378,16 +1473,29 @@ static int collapse_scan_pmd(struct mm_struct *m=
m,
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out;
> >
> >+      bitmap_zero(cc->mthp_bitmap, HPAGE_PMD_NR);
> >       memset(cc->node_load, 0, sizeof(cc->node_load));
> >       nodes_clear(cc->alloc_nmask);
> >+
> >+      enabled_orders =3D collapse_allowable_orders(vma, vma->vm_flags, =
cc->is_khugepaged);
> >+
> >+      /*
> >+       * If PMD is the only enabled order, enforce max_ptes_none, other=
wise
> >+       * scan all pages to populate the bitmap for mTHP collapse.
> >+       */
> >+      if (cc->is_khugepaged && enabled_orders =3D=3D _BITUL(HPAGE_PMD_O=
RDER))
>
> We sometimes use BIT(), e.g. in collapse_allowable_orders().
> And sometimes use _BITUL().
>
> Suggest to use the same form.

Yeah I caught this after posting, I missed this one!

>
> Nothing else, great job!

Thank you :) I appreciate the reviews!

>
> >+              full_scan =3D false;
> >+      max_ptes_none =3D collapse_max_ptes_none(HPAGE_PMD_ORDER, full_sc=
an);
> >+
> >       pte =3D pte_offset_map_lock(mm, pmd, start_addr, &ptl);
> >       if (!pte) {
> >               result =3D SCAN_PMD_NULL;
> >               goto out;
> >       }
> >
> >-      for (addr =3D start_addr, _pte =3D pte; _pte < pte + HPAGE_PMD_NR=
;
> >-           _pte++, addr +=3D PAGE_SIZE) {
> >+      for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> >+              _pte =3D pte + i;
> >+              addr =3D start_addr + i * PAGE_SIZE;
> >               pte_t pteval =3D ptep_get(_pte);
> >               if (is_swap_pte(pteval)) {
> >                       ++unmapped;
> >@@ -1412,8 +1520,7 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> >               if (pte_none_or_zero(pteval)) {
> >                       ++none_or_zero;
> >                       if (!userfaultfd_armed(vma) &&
> >-                          (!cc->is_khugepaged ||
> >-                           none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> >+                          none_or_zero <=3D max_ptes_none) {
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> >@@ -1461,6 +1568,8 @@ static int collapse_scan_pmd(struct mm_struct *mm,
> >                       }
> >               }
> >
> >+              /* Set bit for occupied pages */
> >+              bitmap_set(cc->mthp_bitmap, i, 1);
> >               /*
> >                * Record which node the original page is from and save t=
his
> >                * information to cc->node_load[].
> >@@ -1517,9 +1626,12 @@ static int collapse_scan_pmd(struct mm_struct *mm=
,
> > out_unmap:
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> >-              result =3D collapse_huge_page(mm, start_addr, referenced,
> >-                                          unmapped, cc, mmap_locked,
> >-                                          HPAGE_PMD_ORDER, 0);
> >+              nr_collapsed =3D collapse_scan_bitmap(mm, start_addr, ref=
erenced, unmapped,
> >+                                            cc, mmap_locked, enabled_or=
ders);
> >+              if (nr_collapsed > 0)
> >+                      result =3D SCAN_SUCCEED;
> >+              else
> >+                      result =3D SCAN_FAIL;
> >       }
> > out:
> >       trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> >--
> >2.51.0
>
> --
> Wei Yang
> Help you, Help me
>

