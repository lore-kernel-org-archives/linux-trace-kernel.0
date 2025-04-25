Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019F22D4E0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569043; cv=none; b=jM2vMUXb4/7vaH6dPraEjKkN7uWJyGD9g8IVY+fxUyVuBzfR9OK3hId9BCxai2CrYw+xhpopwAR1RrgxKP2Gh3PXCIoBxijzhtVZaNFkbqL87/bkaxONNqcVPP1dGeEXJ2FyavfhHJwV/QYBpGrPvwrGOUJO1xoqRE2jLIEeQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569043; c=relaxed/simple;
	bh=lLQNedaVTwlzilKxo6rtKJfffuU3ZH6qm7ADaVT9yyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=aC1xUSl55/yGwXiU+NVrlMy+oAz2M47JyaH+dCRqQFnniZkLYh/23tv+6Q9bErXK+S67+QrU59ZbkSjuKLwapbipFKb+QMFsM31kPoihrbi0s1B0stuMAEo7r87sICsPTAz5mGQyBJ6M76jLFOS/39FC9qRGEwRSGWc8p/rca7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/CSHgby; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/CSHgby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tzxwt+MhqUuWVN/lcqMQkoSkMK2b7PEADKfx26VXtCo=;
	b=V/CSHgbydsTWwPe6T1mUJPphxnJorR2garEeKVmtUmC9lv3Lhe471dabFGjguoXYVR/hAo
	GpFNf88aXbl+hyGB6RTS65unxcZ49wfotj0VueNp1LlwHgTOupgvYaWLHzbka8ByKidqFB
	FaJNmu0/ejpI9+jMIhZ8M7VFEvo5oYY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-mdKUaM8mMoWIwuV-uViKEA-1; Fri, 25 Apr 2025 04:17:19 -0400
X-MC-Unique: mdKUaM8mMoWIwuV-uViKEA-1
X-Mimecast-MFC-AGG-ID: mdKUaM8mMoWIwuV-uViKEA_1745569038
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43efa869b19so10864455e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569038; x=1746173838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzxwt+MhqUuWVN/lcqMQkoSkMK2b7PEADKfx26VXtCo=;
        b=pnAcpPQKOqsPx6bCS5S3i6C08UdDhRmJ8rarRM6yuErUpBb1/MmUNlRNAyWrTcugEP
         tp8NRywbEkSFUG18Y3qykHFbWU/hi4wiUEkfgT9n51PSTukos5/mHk0FnpQZojT7mvn6
         DvVwMpjCnpFpFc+v7Xx8D+SXhMAoAfb7uXiHX92zZAM7B1eMGEIgG/vxvZwdU5ErMvkR
         TNVw7W2pbhZmBhO8VbEaR/yY0VS7KmDJqtMzs67/HjbhortquWu7+aeae5dyQpNr4Gsp
         WzWKhGtJ/NBeH0opw4WNSTPx9v8bV+iCxKxW23lMvs/9KkISquHZwCciAZNyRrAMIGDD
         U5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHcPiKMN8tUj865GJUdczwy5voyzB+eoTbDpT3Nj83bL/RoSJTFVaPBFfvAcR5d2p92tvA/T0wL9e+pTkihzgFbg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywteckh94vX7g80jEX6fi9lVWM55NKQ/N9YEsafkGqdLKGzA98U
	PlmI5LI8TIzJTX8fNX/D2JV6jHmBaWLeQ9Alj/p7bpio850XU+NkbrRP2dQEHTXUZNrsAualeDH
	ELQNmVsgqUflsqcRZNoZYa4f3P8qDERNyjGR49Gsa+wLQu1icZNLqsCA+/IjlYn7snsQQOQ==
X-Gm-Gg: ASbGncusaBVJP5obFU6DjAAxD89isxYrK6cf/oIXiXfnA6WyqQI0wuIlzUOCoIsxXl/
	PN9t8jTV5SX5+bG+r1dyDUSCMzYuEd7tdMhOU0Fr6fxBb2bUT6VtNWG5uRYvzpq+XATIcXUxPlX
	5OsuNQu3PxwT32QY8JCTUyURDY+86I1ixL3mWrL9/xV+55dHghRHvYATcA3oJt1nnuFnkVv/8Y2
	Z5ZbkTmxf6MxIpGGXxqxLlVTcc+vSTn8GilOq5vwo9KuXSjNGG/OSE4YSFErQL4Cp21gIEZm1sX
	X9Es2tMek933AglXLqSqxp2tza/zp1Ttk/uSYirtl96I6GCaOwStAC2MOvLFytf2C5Ua80s=
X-Received: by 2002:a05:600c:190b:b0:440:68db:a013 with SMTP id 5b1f17b1804b1-440a669e6c4mr9418245e9.25.1745569038294;
        Fri, 25 Apr 2025 01:17:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyjFcQvI7K5mz5sl36l2qzWjhPhbqRCrF/SO1EP+wbgtlXIcwScGs89x5MDFtUy4eN+gIvTg==
X-Received: by 2002:a05:600c:190b:b0:440:68db:a013 with SMTP id 5b1f17b1804b1-440a669e6c4mr9417765e9.25.1745569037869;
        Fri, 25 Apr 2025 01:17:17 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-440a0692a22sm35772685e9.2.2025.04.25.01.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:17 -0700 (PDT)
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
Subject: [PATCH v1 00/11] mm: rewrite pfnmap tracking and remove VM_PAT
Date: Fri, 25 Apr 2025 10:17:04 +0200
Message-ID: <20250425081715.1341199-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: znsMc-Ic_na6wuJcqxYrzLbctzXZRdM_l1DY8Jbci4Y_1745569038
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

Briefly tested

There will be some clash with [1], but nothing that cannot be sorted out
easily by moving the functions added to kernel/fork.c to wherever the vma
bits will live.

Briefly tested with some basic /dev/mem test I crafted. I want to convert
them to selftests, but that might or might not require a bit of
more work (e.g., /dev/mem accessibility).

[1] lkml.kernel.org/r/cover.1745528282.git.lorenzo.stoakes@oracle.com

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

David Hildenbrand (11):
  x86/mm/pat: factor out setting cachemode into pgprot_set_cachemode()
  mm: convert track_pfn_insert() to pfnmap_sanitize_pgprot()
  x86/mm/pat: introduce pfnmap_track() and pfnmap_untrack()
  mm/memremap: convert to pfnmap_track() + pfnmap_untrack()
  mm: convert VM_PFNMAP tracking to pfnmap_track() + pfnmap_untrack()
  x86/mm/pat: remove old pfnmap tracking interface
  mm: remove VM_PAT
  x86/mm/pat: remove strict_prot parameter from reserve_pfn_range()
  x86/mm/pat: remove MEMTYPE_*_MATCH
  drm/i915: track_pfn() -> "pfnmap tracking"
  mm/io-mapping: track_pfn() -> "pfnmap tracking"

 arch/x86/mm/pat/memtype.c          | 194 ++++-------------------------
 arch/x86/mm/pat/memtype_interval.c |  44 +------
 drivers/gpu/drm/i915/i915_mm.c     |   4 +-
 include/linux/mm.h                 |   4 +-
 include/linux/mm_inline.h          |   2 +
 include/linux/mm_types.h           |  11 ++
 include/linux/pgtable.h            | 101 ++++++---------
 include/trace/events/mmflags.h     |   4 +-
 kernel/fork.c                      |  54 +++++++-
 mm/huge_memory.c                   |   7 +-
 mm/io-mapping.c                    |   2 +-
 mm/memory.c                        |  85 ++++++++++---
 mm/memremap.c                      |   8 +-
 mm/mremap.c                        |   4 -
 14 files changed, 212 insertions(+), 312 deletions(-)

-- 
2.49.0

