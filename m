Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676624C67F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216339; cv=none; b=m3STD5U9wtqv0otkea8in4y77VEMqtrTgbsR23qk3ZeBECcGYo2gMuGxjJNY10Ue/mOL5Qn8qLgvEPOBqdbdEbHwNx6tGDvjdubijpyya8yEr55eFE4l2/my116AFtJv3w8dMq+Ige6exStJrWWmpV/AI8lHq7/PWa9WldOJsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216339; c=relaxed/simple;
	bh=OGZL6ZsQM7FmXrtZCcJrdgAs8xmw1WSnlW2HAWblnM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JcOiIUOC0fH6VBo35Yl39TQbx1Oj6EpU3XlS2l/xV9oucFNCgh3tiy6eTQRBEvEcv8TKtdZ/9V4O6mxeKrOUybvD+1lW0wMxspmVsCVlqHLAUMvtZMWES4WzeRGyAKtNIxbzd7TZU/RUv0TBFLR1aqKTLnSQ9A693/0SnN3qnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzLQBD1Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzLQBD1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwHnciP+OvnJG9alUSG9/jEypyVF3ZPTXQLV9dVcfyg=;
	b=NzLQBD1YoiGo2u0kAb6fxvb28ijj6H/GOmQSpBziT+sH5GV7wYf7AwEeNxiuLwNjku3WJk
	B7AaYQ1DZCY7RpTkUBgR4X6mHl7gUm0SpsbigSlof2w/lsdAC4Oegf/Cw6TZ9KoVcNQtwC
	m6b57wn0lY3bDqEhLsIONzX3qtQIplA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-cnTFJMGlNTuuESr-xZUhOg-1; Mon, 10 Feb 2025 14:38:55 -0500
X-MC-Unique: cnTFJMGlNTuuESr-xZUhOg-1
X-Mimecast-MFC-AGG-ID: cnTFJMGlNTuuESr-xZUhOg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38dd6edef72so1033065f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 11:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216334; x=1739821134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwHnciP+OvnJG9alUSG9/jEypyVF3ZPTXQLV9dVcfyg=;
        b=nkmIISj10U0JWinN0pAcOAOmcInvvCZ/rveFH4huWc0YwRjDRTBu6BaWyXraWv2ZZI
         xoouoe1xiMufbmlBDXljG/ZMbFgc2Hyn/3s0Lum33reSR5eb3RO6veARaIS5Z24ifrPG
         Ps/FQpQ1vJxGTbiqvEbVHWSD5ZZ0b4MclQHsixyKl2K/owkmlQkf+ebbXEkkYKkEAclL
         3cehBs2UnBNaZvJN3hOlotZmjsYTbXQ9Friy1aJ7d+pMZeztmfBq5+4i9yN2WsM5VHrE
         GxwmfF0/9YbM54HRddQSD45zimrOAHXmdY3bO8xQxLHwozoGLsYDeSuZU6ldlclU6wMd
         h3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVMkE7lsVC/daiw2jh8q/hgbkuY9xOCGel87WV2lmav8TIVeX1qv5XlkkPKC77m0qobLAOBHEvE0ngelLOCrZc+iI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPg0iK3Gj+7CB02kkNL0fqYJpnaVHxOFVFGrcDNTMEcki10iM
	wAMFQyYcUR+vAqE0InFeq4Bt2ORIUv2S5B7yfG3dL1HI3oS/nki2tUFBMHYzW9ol8sEN5LGF2u0
	btWRj3tjIlNsDO4IZIiUWZi2tpp2POEbbQ+27SuYzCA7ZJSZtZCeHWfSr4vKqGCqvGuzhXw==
X-Gm-Gg: ASbGncuQnNt88qA0fKPrOPOHxOffiMjhehPlNKJppRZ6IS0zhYqbnklB0wC7lumOuVN
	9+/uSQk72MHWX7JgKKq2f58X0OGqgtaeBdcmeZjpS889sgBiYPx1WTmM14rxeYrA2LX1ZTj5kg9
	ECCdh8CuD1Q9kdO+9QsYZEOICapXjRvUSm9VdDjyPmB5a7EvUilJXiQQdcj3isw8NSebZ5HSjpQ
	3pFnpJc12HcFHWcolRNHPCjlP06LyIdZL2KZh2vnBXq6hMvteAxZUOBabOO6o1czJA/vlXlXqas
	RzT9OvJETOLf8ue2vkTMMOC6wQgHiCoHuIFS4UsvSUXvg2oaj+m+VBqARqsnOkP/Ag==
X-Received: by 2002:a5d:5f42:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-38de432d90fmr568594f8f.0.1739216333878;
        Mon, 10 Feb 2025 11:38:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ8jI3Pr0PhgIrX5XFi88nBpwoaMc1TLFqexlyUt/iDFsCN9k6Hzlrlovdfu0/+3mYproMTQ==
X-Received: by 2002:a5d:5f42:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-38de432d90fmr568579f8f.0.1739216333460;
        Mon, 10 Feb 2025 11:38:53 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4390db11200sm187831345e9.38.2025.02.10.11.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:52 -0800 (PST)
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
Subject: [PATCH v2 13/17] mm/page_idle: handle device-exclusive entries correctly in page_idle_clear_pte_refs_one()
Date: Mon, 10 Feb 2025 20:37:55 +0100
Message-ID: <20250210193801.781278-14-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: sEdfl9eJ3n47tbl5-Pb-M7KT_eXLkYwg8Wbz5YnS4e0_1739216334
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

page_idle_clear_pte_refs_one() is not prepared for that, so let's
teach it what to do with these PFN swap PTEs. Note that device-private
entries are so far not applicable on that path, as page_idle_get_folio()
filters out non-lru folios.

Should we just skip PFN swap PTEs completely? Possible, but it seems
straight forward to just handle them correctly.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_idle.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 947c7c7a37289..408aaf29a3ea6 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -62,9 +62,14 @@ static bool page_idle_clear_pte_refs_one(struct folio *folio,
 			/*
 			 * For PTE-mapped THP, one sub page is referenced,
 			 * the whole THP is referenced.
+			 *
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
 			 */
-			if (ptep_clear_young_notify(vma, addr, pvmw.pte))
-				referenced = true;
+			if (likely(pte_present(ptep_get(pvmw.pte))))
+				referenced |= ptep_test_and_clear_young(vma, addr, pvmw.pte);
+			referenced |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 			if (pmdp_clear_young_notify(vma, addr, pvmw.pmd))
 				referenced = true;
-- 
2.48.1

