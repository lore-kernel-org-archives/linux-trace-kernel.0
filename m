Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73C2512EA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216355; cv=none; b=PeGIcZjKcrJY45iDZorxwjB0cw7AZb2+7pKLgc17ks7FlN+4DWH0HAKamSOd9dvQnhiqwnOBlu/okzXYcTrIYnMoRyK70SQDdVAsadZUo229oYP4KH99c4y/8xMME4HkRHPs2QLTpim1SP9Es0aBkeFfk4xnnH03b095+lSVEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216355; c=relaxed/simple;
	bh=PA01cEf2/9mIQZ9O32CRa6PGoRajWbPJGABkde9iNzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HqFJTv3Ydn0lWay1Y7yIvyCk274NiQTIPzy7ku4AwsgRNHkvEa3WTbVgMjzhQE9rlYzhqR1QTQcI3t9L8qVxkgiAZHR/7UVi652/q+w8G9OrH/1j6+ea6P2v5ILf2MRi8dmbgh9h3YVW3qWBwZhj13KgGPKRw1i6X7Xz97UVZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeIgX9EE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeIgX9EE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxIo4/a9ZeK4nnisZvQU6AU2gxtpzJDN86Rrv62j7Tk=;
	b=OeIgX9EETrS1A6kA4ePwSvSgkM4zenbWyeU0W6YjUu9nulZgfEU6+PSVZfZRZ1hA0hywpI
	cXYdzRFPPGaRT9rrMDdYwHpydp9QQoDKEOVH9xaBMouefWFt6ShGyTHzrmn5fhnkNVMH1r
	bAWPMHZhTOxnBFqEu/mkH/9zRawwL+I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-42hDAaPFPGyGailSjtle1A-1; Mon, 10 Feb 2025 14:39:10 -0500
X-MC-Unique: 42hDAaPFPGyGailSjtle1A-1
X-Mimecast-MFC-AGG-ID: 42hDAaPFPGyGailSjtle1A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38ddba9814bso733056f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 11:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216349; x=1739821149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxIo4/a9ZeK4nnisZvQU6AU2gxtpzJDN86Rrv62j7Tk=;
        b=WtREMvIQEz6alI4YMqpQcvUFqMRW0mqM3HQgVNwe6YssZnUaoxP1+6WMYwwW+M/fVH
         dtEZdPFUvXBRmLrSMa+Ex/1Gd11mzh6HzGEFI5PQTRkqYdWsf1qTBNZTLMiGGdPanffU
         lMCfQz7QmEbNrrLDYhYni0WbrlNpfBiLOtv0fcyQjNznEZ+G4pR0fDG+qcmkIDI6jNgW
         gn3zshJaPvgPTiyieSLrTzes/LoBvCnxMfXB/wEPeK8OwSrT1z//sHnbsTmS6h+O9X3g
         Re/8MUZv35H4XU5/td0Szr5QV6Btba9oRRQMcWscarjUKHeumgSf0mQLjyVLlrQPltiN
         tPzw==
X-Forwarded-Encrypted: i=1; AJvYcCUs/EUldD/WHMGSmNQ11HgPI5vXFnWvgs/z4bNSkKPrHGvNsSbM4BF2zAqeon+lHCCjtRzgzmMHRoyt9LPmSN+VJmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmJLEM4I+VI+tZdBBJX8DLH/Y8nJlAZHriJL9BE9xRYlcMci7
	fHbc/v+rnspHp7/vJRaV4OB6I6GSqJuUtxVeJGXDV73U86T/VFc0TyuUfEqfxKuFHYUKPib0/Of
	sDigF3SvgKN+2POeMpVww4E4oZbCa/o60MAmYVKeF4wmRf2VJ0VuN3kKxAolRThZDEjvQUg==
X-Gm-Gg: ASbGncsfjQIUYMlkUCggNj4b7fVE5l7oge4tw+KDrgsye4k6vvYK+2WHDb7XPxnuCmH
	nzJsa5Rv1Kc2h0dh/TZZJ9rzK6V6gYhN9oh03DbrTL4fOy/E4VM+kALnFla1mjcVsRxM9mEpkVf
	pRPA6ZFUHJGFZ1IRGL3ivSQ+PpPmWCkhk/1xMHpYZMfBhfBaRjhtY71gORBXdDP8oB9OcisBOMe
	XuzK3oAfXu+LKNM00zi2vGHnD7bLY42vGCAagkL6+KxWNfxSm+7X+wXO5WRy2Q1IapJVHVl8O87
	zcNfdCs6hhvTRZmk0b4ZWKyF4MhARrMD8P4bNiOc5ih43Cf3++YY4/VFTTSCLWvFmw==
X-Received: by 2002:a05:6000:1448:b0:38d:a879:4778 with SMTP id ffacd0b85a97d-38dc9343f89mr13325606f8f.33.1739216349523;
        Mon, 10 Feb 2025 11:39:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOm3YA+KmUhyhlND1SLmjpOJWvwKHSp1MsMH3YdrdBRb69cVHv165Q1M/eFn8bTRexW9yPlw==
X-Received: by 2002:a05:6000:1448:b0:38d:a879:4778 with SMTP id ffacd0b85a97d-38dc9343f89mr13325571f8f.33.1739216349113;
        Mon, 10 Feb 2025 11:39:09 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dca0b4237sm10326047f8f.85.2025.02.10.11.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:39:07 -0800 (PST)
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 17/17] mm/rmap: avoid -EBUSY from make_device_exclusive()
Date: Mon, 10 Feb 2025 20:37:59 +0100
Message-ID: <20250210193801.781278-18-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: PkQ3SKXCfjrpPeDHrIT_D3gJIt_dGG1i55QJwjoUGiQ_1739216349
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Failing to obtain the folio lock, for example because the folio is
concurrently getting migrated or swapped out, can easily make the callers
fail: for example, the hmm selftest can sometimes be observed to fail
because of this. Instead of forcing the caller to retry, let's simply
retry in this to-be-expected case.

Similarly, avoid spurious failures simply because we raced with someone
(e.g., swapout) modifying the page table such that our folio_walk fails.

Simply unconditionally lock the folio, and retry GUP if our folio_walk
fails. Note that the folio_walk repeatedly failing is not something we
expect.

Note that we might want to avoid grabbing the folio lock at some point;
for now, keep that as is and only unconditionally lock the folio.

With this change, the hmm selftests don't fail simply because the folio
is already locked. While this fixes the selftests in some cases, it's
likely not something that deserves a "Fixes:".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index e2a543f639ce3..0f760b93fc0a2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2435,6 +2435,7 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 	struct page *page;
 	swp_entry_t entry;
 	pte_t swp_pte;
+	int ret;
 
 	mmap_assert_locked(mm);
 	addr = PAGE_ALIGN_DOWN(addr);
@@ -2448,6 +2449,7 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 	 * fault will trigger a conversion to an ordinary
 	 * (non-device-exclusive) PTE and issue a MMU_NOTIFY_EXCLUSIVE.
 	 */
+retry:
 	page = get_user_page_vma_remote(mm, addr,
 					FOLL_GET | FOLL_WRITE | FOLL_SPLIT_PMD,
 					&vma);
@@ -2460,9 +2462,10 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-	if (!folio_trylock(folio)) {
+	ret = folio_lock_killable(folio);
+	if (ret) {
 		folio_put(folio);
-		return ERR_PTR(-EBUSY);
+		return ERR_PTR(ret);
 	}
 
 	/*
@@ -2488,7 +2491,7 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 		mmu_notifier_invalidate_range_end(&range);
 		folio_unlock(folio);
 		folio_put(folio);
-		return ERR_PTR(-EBUSY);
+		goto retry;
 	}
 
 	/* Nuke the page table entry so we get the uptodate dirty bit. */
-- 
2.48.1

