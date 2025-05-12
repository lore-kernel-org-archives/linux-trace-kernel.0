Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45913635E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053272; cv=none; b=Ubvbnrv5X9eDW+S1tdzwyW8BqfniftUuNIh3XeMngaVNCiwzWxHSojzDK7GRsTaedDq26QPaGgH6j7w7ex064bnY9ix9ivA9rQoFx9e4a4iGRSNrC3OR6sDJe8vju8q8+3IkvksqB+vgzrTo3CUdA+r8Qse3FZP3qCrnBJaw2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053272; c=relaxed/simple;
	bh=NX/Y/HVo0p4VYeB1ou1uSmIImGtgXg7WsYvl1qcXgCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=TkSRc/HMGap373PbkoCK5gEnJ0/qgZaaeXh7qPzjYzoe7ZUHQvNK9eF9Xcvhgx5ka74vNVzGoAiYgkcu//WYyGAMW6d5xoPL6Yrn8EkE06Nt05jpPY9fz8zvzlycscvOo09PHsSXb8z2yqkmKdrYRp6zfKR/EUZV15X2/RdAjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+dKKU9G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+dKKU9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AsNfuXk++hQsXcSMH0/ZpoD/Dq28xwSeg936k+p2z/0=;
	b=T+dKKU9GvuPvNRfRCpSrNJrcmdhXnlof071VH1WTVIb3AKXj14g+PIACg0U0/guE+ahV3u
	aRDAoli13N4Mx+o/LSJeZiNygy8tqUXOkMO7T6jeiQB7d73cAKayDtoFsuq/4AFiGMDk1/
	08sRLuClrc0BpjEZqgHP0kDHAh+UErU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-bP7HMVCgO1yZDPfKjGHRHQ-1; Mon, 12 May 2025 08:34:28 -0400
X-MC-Unique: bP7HMVCgO1yZDPfKjGHRHQ-1
X-Mimecast-MFC-AGG-ID: bP7HMVCgO1yZDPfKjGHRHQ_1747053267
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a0b5d18cb7so1578885f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053267; x=1747658067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsNfuXk++hQsXcSMH0/ZpoD/Dq28xwSeg936k+p2z/0=;
        b=S890vdWLTJJ2pxeJ+0ALdzzy3cO7NMXQA3sSwezL9xPo8XxwHmmy5Qx1rn5LfrETZv
         48cFY+O1sSBt7PzVlX8jfUCSPyn7l6qsxxSnyoNait6RdN65BlyoEx+ujKXGu3x6RPTw
         pNsS8o76PyJAJp3RbugTo+pb45NYseqmmRp1cBQOWE1ALgYbp2SAxvghFm+egrYlVqxu
         Qg1udUzkMv+it6M7mekswHXOGz74sNpueEfeoJxX9XmPqXHELHgsfadXYSqp8bndIAzL
         7lsQYyWbiEfeAicHePZXknx+UC6Kgl5+sg8F0M1uXY7WTuQ95DVUunfOtMCUu3wqBCR/
         rmpg==
X-Forwarded-Encrypted: i=1; AJvYcCWSifAiY9xU4Lg/Y1iFSai85e6ETZx+czd1qcjszrFwxiwHWUcyzK4G6JSA/z5PFxLSGF9HvXYN9oQcck4yklMYCVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXdJDQl50ck14c+LW1FwPDHcAR0ZRBmjEkow6AvaDO90oZEMe
	RynE7MN/2wvTRTDsGjlcTe7XKU2lnmMCn6Eh/bbgnMkjEEAbPNeBqiWjzQejZSPFYx6TiRogxqJ
	iCexEn3QqzTmDr+/Mf+1CRb02TRE5wglpK0RospkKiRaLoWsVDgWZU7F/7pop+R7Rle25HA==
X-Gm-Gg: ASbGncvLw7xCgsqYvOScIUeYS48pJf+ILu4oY+d21QpmMY7sRE2Dvo4bCwBQik68AEt
	QzNtT4CxODyrSLgSzcZdjduSLK4MRifRQVyzUOD06U1SCPWtAfXviyR4rYSzrtNE0LZNeaW9/x8
	zC769fLbJDmAgrmpo9rsfL/R6osW2N2ovzUImx3lVjU5jP7PCqnybcZP+fDIgC7d00c4BQFbN6G
	VD5EStYk4wwgG9I7cJACwRexep8j41isVY9MzN77rJHvRewHVXHmtIOE9pAyvDOkoYkNYKOLvkg
	n0N0DZaBjDbo7s/z4uw1bbgDEh9aR+Xtb/OFlm93tcxMRjt8LgsVYNQA95oBpjvcNKdYKCbu
X-Received: by 2002:a05:6000:1a8a:b0:3a2:6bc:3f25 with SMTP id ffacd0b85a97d-3a206bc6568mr3282298f8f.36.1747053267149;
        Mon, 12 May 2025 05:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbVOvWh8aR7BY5sT0iHvCaoLmEQsNhObrlGdsawBm2VmjmvFE+wMDlxjPW6z9Q2DtavCs6CQ==
X-Received: by 2002:a05:6000:1a8a:b0:3a2:6bc:3f25 with SMTP id ffacd0b85a97d-3a206bc6568mr3282274f8f.36.1747053266780;
        Mon, 12 May 2025 05:34:26 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f5a4c583sm12119696f8f.84.2025.05.12.05.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:26 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 00/11] mm: rewrite pfnmap tracking and remove VM_PAT
Date: Mon, 12 May 2025 14:34:13 +0200
Message-ID: <20250512123424.637989-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HdEiRhXwJ0q3gJr_mFXDzjT1er4y4RKVWm3nV_1MvEU_1747053267
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

On top of mm-unstable.

VM_PAT annoyed me too much and wasted too much of my time, let's clean
PAT handling up and remove VM_PAT.

This should sort out various issues with VM_PAT we discovered recently,
and will hopefully make the whole code more stable and easier to maintain.

In essence: we stop letting PAT mode mess with VMAs and instead lift
what to track/untrack to the MM core. We remember per VMA which pfn range
we tracked in a new struct we attach to a VMA (we have space without
exceeding 192 bytes), use a kref to share it among VMAs during
split/mremap/fork, and automatically untrack once the kref drops to 0.

This implies that we'll keep tracking a full pfn range even after partially
unmapping it, until fully unmapping it; but as that case was mostly broken
before, this at least makes it work in a way that is least intrusive to
VMA handling.

Shrinking with mremap() used to work in a hacky way, now we'll similarly
keep the original pfn range tacked even after this form of partial unmap.
Does anybody care about that? Unlikely. If we run into issues, we could
likely handled that (adjust the tracking) when our kref drops to 1 while
freeing a VMA. But it adds more complexity, so avoid that for now.

Briefly tested with the new pfnmap selftests [1].

[1] https://lkml.kernel.org/r/20250509153033.952746-1-david@redhat.com

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Peter Xu <peterx@redhat.com>

v1 -> v2:
* "mm: convert track_pfn_insert() to pfnmap_setup_cachemode*()"
 -> Call it "pfnmap_setup_cachemode()" and improve the documentation
 -> Add pfnmap_setup_cachemode_pfn()
 -> Keep checking a single PFN for PMD/PUD case and document why it's ok
* Merged memremap conversion patch with pfnmap_track() introduction patch
 -> Improve documentation
* "mm: convert VM_PFNMAP tracking to pfnmap_track() + pfnmap_untrack()"
 -> Adjust to code changes in mm-unstable
* Added "x86/mm/pat: inline memtype_match() into memtype_erase()"
* "mm/io-mapping: track_pfn() -> "pfnmap tracking""
 -> Adjust to code changes in mm-unstable

David Hildenbrand (11):
  x86/mm/pat: factor out setting cachemode into pgprot_set_cachemode()
  mm: convert track_pfn_insert() to pfnmap_setup_cachemode*()
  mm: introduce pfnmap_track() and pfnmap_untrack() and use them for
    memremap
  mm: convert VM_PFNMAP tracking to pfnmap_track() + pfnmap_untrack()
  x86/mm/pat: remove old pfnmap tracking interface
  mm: remove VM_PAT
  x86/mm/pat: remove strict_prot parameter from reserve_pfn_range()
  x86/mm/pat: remove MEMTYPE_*_MATCH
  x86/mm/pat: inline memtype_match() into memtype_erase()
  drm/i915: track_pfn() -> "pfnmap tracking"
  mm/io-mapping: track_pfn() -> "pfnmap tracking"

 arch/x86/mm/pat/memtype.c          | 194 ++++-------------------------
 arch/x86/mm/pat/memtype_interval.c |  63 ++--------
 drivers/gpu/drm/i915/i915_mm.c     |   4 +-
 include/linux/mm.h                 |   4 +-
 include/linux/mm_inline.h          |   2 +
 include/linux/mm_types.h           |  11 ++
 include/linux/pgtable.h            | 127 ++++++++++---------
 include/trace/events/mmflags.h     |   4 +-
 mm/huge_memory.c                   |   5 +-
 mm/io-mapping.c                    |   2 +-
 mm/memory.c                        |  86 ++++++++++---
 mm/memremap.c                      |   8 +-
 mm/mmap.c                          |   5 -
 mm/mremap.c                        |   4 -
 mm/vma_init.c                      |  50 ++++++++
 15 files changed, 242 insertions(+), 327 deletions(-)


base-commit: c68cfbc5048ede4b10a1d3fe16f7f6192fc2c9c8
-- 
2.49.0

