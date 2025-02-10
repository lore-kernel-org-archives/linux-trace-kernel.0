Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64325A2CA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216312; cv=none; b=G4KoNFJ5T7xgLL8uXHag+tAqI+a9qWTaWEYwLorS8g6weEQ69vWil8xC33LRo+3ivz3wTaHA1Ub7yn5L7lj9zh7z4gaDDzovClt4n5bARtXYyAbndQ5e2rEVC50aPrRJwLFQh7q8wEKeF277LkSUk0MS9+cviFuxhjmyYVdJ3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216312; c=relaxed/simple;
	bh=aAO5U4rIUSmSiW9HiZeU+4RaV76aniUNOw4ep9QcM3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=g1VIXIH9ewbvQRjK4GsL2QcHcivaBdrUynufFW1/t5Ai7S1+3CG0uCzVPr6RP/qs0aZ031wePi1URTqoi+/uYVcCgcZeahoaeMnLWwynJsjN9lrk2i9D5u8SnEBazyeikLdLho/21yO3nIIpPZ8+5sWqFEWx52XKJeEs4982nzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUsKcbG8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUsKcbG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLiFHA5Aiy4k7pcGr1QPi7NyoGcLfJYJaAk0JBe4xM8=;
	b=dUsKcbG86Ghp0O/cbBA+Hr3g6NI9LYCR2GL77poGUOAJEkBiNDRuQD8VcIItPET1iaMC9Z
	drCz+Xi/4z46FmfEp5xWVjCcFLdyjI2gimBAg9v85WmiOQ4HJqBlwXVTBWscu7nDLBbRgS
	UTjkK96iHi7Dy+v7bZdgc/dZRJK5zLg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-H52CM2KTOEKADLRpyiDWRA-1; Mon, 10 Feb 2025 14:38:28 -0500
X-MC-Unique: H52CM2KTOEKADLRpyiDWRA-1
X-Mimecast-MFC-AGG-ID: H52CM2KTOEKADLRpyiDWRA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38ddee833e0so763663f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 11:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216307; x=1739821107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLiFHA5Aiy4k7pcGr1QPi7NyoGcLfJYJaAk0JBe4xM8=;
        b=kHbVSHbE1xxQOu4sOaCaQrNfbDnddZqA05TPbJW58uzgOAjUiPOadRDlz3o/elDhUu
         3zVpeCtEhzYel7JB2y+8Je/OsoTItNhkE0rcug5d2Gls8OIv3Rpe4kqtRveyf6VRCwNG
         Px9DHvJmAKij33O5E+T/w3SmyH/Y/ZcIq3EWf4g4LkcibyHW9TakFhEqOH6qHZraci5B
         wJYc2o0sjyzkg+PaYdHBmtSItjangYN1bRD96DwcqQO7/FVCZ1gI/xOsszGMduo+N5jk
         thkt/vd6jwHEhQywxyD21oqNGpZptewEwT4D6YMmas2urOuf8UFfSYfQKuySFO0bxd2a
         j58w==
X-Forwarded-Encrypted: i=1; AJvYcCUxQgPy0eKq7EeonTcSUDhx94Ap4maUBnD52SHv5DJVnqlPf3Ju5ekAKXET94I0YxaZmO/+yrRkcj0p1o3dTzg2dj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/7t9DM7vKhXx2P/hsjbnzqSGkA8MjI+7OqZnxyeQYrTLp9Ap
	xRKzoUc5f+iqGwvJC/roP76qbc8NE41IFEJflWqEyX2kSh+EMGP5pdBdrctslQct0w4FDCPSn5g
	jmEhy5pnwPvsczw8uMSnUUxhOkbPY9bNQsEIQlnkKM22bTeyMYqxwgvf+tGsqA1S/F0PsRQ==
X-Gm-Gg: ASbGncuhD+nYcorf5WNeR6D0vm/ZkWiYCoggH2n16/FstNIdIF4a1G91ukdzAVAV8uL
	iGRa6v2RZ828weqVdh2suphM98ZSynmjMt6PSUmGTauzjAIdxJLtD3U/M6vkRUqUyP5eJBbQh00
	KfuX4vuU6XTjIdQvSxmT2U/7kQ4DOHF2w7Q4CORjunt6a0pzUTsxNL/EfuVFGa55E41e2MaCN/i
	OWOi3OR5u7cjCffhz89ggWpMFzk+JwXJ1+kOlGBXAVLy66ZMK12InQTopR3/dqwFug4ABcLTycH
	WetEtD03ygP2v9EwTFVhAWEMiral4M+ExGk/jCn79/v/Prmis80qTIjmfG9Ig2je4w==
X-Received: by 2002:a05:6000:2ab:b0:38d:e3fd:1a1c with SMTP id ffacd0b85a97d-38de43b38d8mr568321f8f.23.1739216307214;
        Mon, 10 Feb 2025 11:38:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsdgSvAB5qD8mlN6AGjEYvBbSJNfBUob/X5TfyCrhv/WAdQoby+DEB/v6QRZcPR+eQm0f2lQ==
X-Received: by 2002:a05:6000:2ab:b0:38d:e3fd:1a1c with SMTP id ffacd0b85a97d-38de43b38d8mr568308f8f.23.1739216306759;
        Mon, 10 Feb 2025 11:38:26 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dc2f6aeafsm11911098f8f.20.2025.02.10.11.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:25 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v2 06/17] mm: use single SWP_DEVICE_EXCLUSIVE entry type
Date: Mon, 10 Feb 2025 20:37:48 +0100
Message-ID: <20250210193801.781278-7-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210193801.781278-1-david@redhat.com>
References: <20250210193801.781278-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zjbfXrks_tqT3RYbApysR2GqOupu154f4xBViYNpgnQ_1739216307
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

There is no need for the distinction anymore; let's merge the readable
and writable device-exclusive entries into a single device-exclusive
entry type.

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swap.h    |  7 +++----
 include/linux/swapops.h | 27 ++++-----------------------
 mm/mprotect.c           |  8 --------
 mm/page_table_check.c   |  5 ++---
 mm/rmap.c               |  2 +-
 5 files changed, 10 insertions(+), 39 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b13b72645db33..26b1d8cc5b0e7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -74,14 +74,13 @@ static inline int current_is_kswapd(void)
  * to a special SWP_DEVICE_{READ|WRITE} entry.
  *
  * When a page is mapped by the device for exclusive access we set the CPU page
- * table entries to special SWP_DEVICE_EXCLUSIVE_* entries.
+ * table entries to a special SWP_DEVICE_EXCLUSIVE entry.
  */
 #ifdef CONFIG_DEVICE_PRIVATE
-#define SWP_DEVICE_NUM 4
+#define SWP_DEVICE_NUM 3
 #define SWP_DEVICE_WRITE (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM)
 #define SWP_DEVICE_READ (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM+1)
-#define SWP_DEVICE_EXCLUSIVE_WRITE (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM+2)
-#define SWP_DEVICE_EXCLUSIVE_READ (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM+3)
+#define SWP_DEVICE_EXCLUSIVE (MAX_SWAPFILES+SWP_HWPOISON_NUM+SWP_MIGRATION_NUM+2)
 #else
 #define SWP_DEVICE_NUM 0
 #endif
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 96f26e29fefed..64ea151a7ae39 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -186,26 +186,16 @@ static inline bool is_writable_device_private_entry(swp_entry_t entry)
 	return unlikely(swp_type(entry) == SWP_DEVICE_WRITE);
 }
 
-static inline swp_entry_t make_readable_device_exclusive_entry(pgoff_t offset)
+static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
-	return swp_entry(SWP_DEVICE_EXCLUSIVE_READ, offset);
-}
-
-static inline swp_entry_t make_writable_device_exclusive_entry(pgoff_t offset)
-{
-	return swp_entry(SWP_DEVICE_EXCLUSIVE_WRITE, offset);
+	return swp_entry(SWP_DEVICE_EXCLUSIVE, offset);
 }
 
 static inline bool is_device_exclusive_entry(swp_entry_t entry)
 {
-	return swp_type(entry) == SWP_DEVICE_EXCLUSIVE_READ ||
-		swp_type(entry) == SWP_DEVICE_EXCLUSIVE_WRITE;
+	return swp_type(entry) == SWP_DEVICE_EXCLUSIVE;
 }
 
-static inline bool is_writable_device_exclusive_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_DEVICE_EXCLUSIVE_WRITE);
-}
 #else /* CONFIG_DEVICE_PRIVATE */
 static inline swp_entry_t make_readable_device_private_entry(pgoff_t offset)
 {
@@ -227,12 +217,7 @@ static inline bool is_writable_device_private_entry(swp_entry_t entry)
 	return false;
 }
 
-static inline swp_entry_t make_readable_device_exclusive_entry(pgoff_t offset)
-{
-	return swp_entry(0, 0);
-}
-
-static inline swp_entry_t make_writable_device_exclusive_entry(pgoff_t offset)
+static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
 	return swp_entry(0, 0);
 }
@@ -242,10 +227,6 @@ static inline bool is_device_exclusive_entry(swp_entry_t entry)
 	return false;
 }
 
-static inline bool is_writable_device_exclusive_entry(swp_entry_t entry)
-{
-	return false;
-}
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 #ifdef CONFIG_MIGRATION
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 516b1d847e2cd..9cb6ab7c40480 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -225,14 +225,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_uffd_wp(oldpte))
 					newpte = pte_swp_mkuffd_wp(newpte);
-			} else if (is_writable_device_exclusive_entry(entry)) {
-				entry = make_readable_device_exclusive_entry(
-							swp_offset(entry));
-				newpte = swp_entry_to_pte(entry);
-				if (pte_swp_soft_dirty(oldpte))
-					newpte = pte_swp_mksoft_dirty(newpte);
-				if (pte_swp_uffd_wp(oldpte))
-					newpte = pte_swp_mkuffd_wp(newpte);
 			} else if (is_pte_marker_entry(entry)) {
 				/*
 				 * Ignore error swap entries unconditionally,
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 509c6ef8de400..c2b3600429a0c 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -196,9 +196,8 @@ EXPORT_SYMBOL(__page_table_check_pud_clear);
 /* Whether the swap entry cached writable information */
 static inline bool swap_cached_writable(swp_entry_t entry)
 {
-	return is_writable_device_exclusive_entry(entry) ||
-	    is_writable_device_private_entry(entry) ||
-	    is_writable_migration_entry(entry);
+	return is_writable_device_private_entry(entry) ||
+	       is_writable_migration_entry(entry);
 }
 
 static inline void page_table_check_pte_flags(pte_t pte)
diff --git a/mm/rmap.c b/mm/rmap.c
index 0cd2a2d3de00d..1129ed132af94 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2492,7 +2492,7 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 	 * do_swap_page() will trigger the conversion back while holding the
 	 * folio lock.
 	 */
-	entry = make_writable_device_exclusive_entry(page_to_pfn(page));
+	entry = make_device_exclusive_entry(page_to_pfn(page));
 	swp_pte = swp_entry_to_pte(entry);
 	if (pte_soft_dirty(fw.pte))
 		swp_pte = pte_swp_mksoft_dirty(swp_pte);
-- 
2.48.1

