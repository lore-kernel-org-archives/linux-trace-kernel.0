Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649E22ACEB
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429220; cv=none; b=lXp24z5+rQO0Q3f1m0yXueaGwLjEF46b0bSuB81ZXD2iWE2VaVSuMvq2T6audEY9pHmkYAGvimcJNBFqa/1j72fnAgfEv/uWsWZgHq3gxDMArli/bBYtdilmSMgYyNeK/miyv+mdQJHBOdHZ9LWlpwfO8bxuEy1T2YCfMOdoGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429220; c=relaxed/simple;
	bh=bbIuCO06RYRG5+k7n97w09LEogLitBXzNI9yNrxFShE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dif+BzNEvxCGz+/x0VVuBKgdm5yzfyKHh3AVYUcTnsT2trQhzFvcBcYlDtxUI+UzcX1aB6omf/BXRFgBzzPbH/elnmvKogOyly80VJlgHgqBoDfxDEr3+3v6UkquHH3YP1iBoDl8BLDOGy0ksSc6cogwZ7aFKMv9NBtI54c/GSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy+FPBf6; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy+FPBf6"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c888c2c5485so19046a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429219; x=1784034019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAK2ceJ1Zq5e1wppikpMizngj/jwkuXHZE5kwSaxgtw=;
        b=cy+FPBf6lg1SoUpkAw5Uhh3kTtSeZpoJNYBr5W8Rf3aKSIxjizFKQ4hwwmwW4Nie7/
         jTTfEi4nGwcHVyuPQ/k7S7i0CE4XK/sW96ZrZayCoOMlcLUKbh5vVfDuCVVbe5XbyH6t
         7TNi+nkOniTkYjlGNlXSqUFuq0XCDM++Sewn4D7ko4y60xeR6pC2DI2Fjj2AfVtSnPqD
         ZuFRCjqPGlJdi4byE9b05x9CSu3DPccxJau2VuPH0y9Dfr+2Zw30zmQX4zG5J9P3H5XA
         xxG7eO2jq7Ix+oLCDxAYprJ0n8yKedh6+igXoBCnLr3hOa06O2LMjXSrkeJlUFYCQKz0
         uRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429219; x=1784034019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GAK2ceJ1Zq5e1wppikpMizngj/jwkuXHZE5kwSaxgtw=;
        b=Ce1XUmH1fkDF5GEiTEZl41KmcChp5TIgOjF6hwNfmZQhR+OKFqyiBI3AVJfzWcVCn4
         63WBN59fTurDOvVHfPsADshJ5RDuUp2Q8zRCeiIpR4yK/tCAizF7arT/RSVDcxVSHDFc
         Sp3ZHmxYD278oMq3rjQEc9mj3k1uZC74o70T8oNCPILXXGgl8/bb48yx0/htNjNjRPhH
         c/+cTNGERVpVsCLoy8kt4cLaTG+MLK12A2U+Y7SVvjmDkeriW+UFaU1KJ1UF9Xaxo/NF
         zTySLcbneiKRZimP4zqS/In7q8EhvDXwohgWKSHmki8Sy6/Ilj4bb9oC2/NIahgYISyj
         fNlQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDF0JGwtjR5XLdDh8wDrKkA1oVg4+EhciSH5PYtjhFDMs4ZNaNmnAv4y9rrzMKgk4PL/0jr3cEKP1ZEwnYbPbgJjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2JLVYgueG4mBrZ/Mo+6UkpQOGi3sJNIWIyF8kmpiTrr63I+6
	u2YGfByzgL9z5GnwXs+6LBuOlUL8uciQZC9WjGLdUWklWoDeDWy/+1EB
X-Gm-Gg: AfdE7cnRRUKEg1RRUSfq6Wh7oNw3234NprZzGJfLlVUzAbKIFmXBzN3l/Ulk+kd6+La
	f7MEBDANmZwksNN0Qokuy1mCefwV9+51H/9eBEBRiCpLQKlPGlHzgNx0kkd8qcVe8IpYq0v9Xfj
	rpHaEYqGV5Arc2/w2Y21sT4YClmbkCLcpwebpMpCucornW/gZn4gYq4J0LiYT+UMh9itrhzEOYp
	1CI1LynLZqcDWfZE9FTYVrqBhs71+S+InF+0qO6wE5B8nll+TfmKlz8gAKLo6yNlNyRlwrIBcse
	leReUFYspjln1pkHPNQLjWhHXgwhkpv/CVZzOr23wjv+6Q7Nv5sATlx444q2xdAfpnGMHUDD8tn
	6guXNKs1NL/1oO6gku4GOmEkl6yiUIaXdC5uP9zjI6hZ3+x+3L27JvgTi6lHnmJd7LkpckFm48/
	44xXlhW42sbzBHvbADED5TY2vO+Q==
X-Received: by 2002:a05:6a00:22c4:b0:842:50fd:4c13 with SMTP id d2e1a72fcca58-8482f2be242mr2571501b3a.4.1783429218979;
        Tue, 07 Jul 2026 06:00:18 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm5415983b3a.3.2026.07.07.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:00:17 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: vbabka@kernel.org,
	david@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	Alexander.Krabler@kuka.com,
	hughd@google.com,
	fvdl@google.com,
	bigeasy@linutronix.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	pfalcato@suse.de
Subject: [PATCH v2 3/4] mm/migrate: add tracepoint for folios unmapped during migration
Date: Tue,  7 Jul 2026 20:59:24 +0800
Message-ID: <20260707125925.3725177-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707125925.3725177-1-chenwandun1@gmail.com>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add mm_migrate_unmap_folio tracepoint, fired in try_to_migrate_one()
after a folio's mapping has been replaced by a migration entry.
It records the pfn, address, folio flags and vm_flags, making mlocked
folios under migration easy to observe.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 include/trace/events/migrate.h | 29 +++++++++++++++++++++++++++++
 mm/rmap.c                      |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 15ee2ef201b5..1264593ecaee 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -6,6 +6,7 @@
 #define _TRACE_MIGRATE_H
 
 #include <linux/tracepoint.h>
+#include <trace/events/mmflags.h>
 
 #define MIGRATE_MODE						\
 	EM( MIGRATE_ASYNC,	"MIGRATE_ASYNC")		\
@@ -137,6 +138,34 @@ DEFINE_EVENT(migration_pte, set_migration_pte,
 	TP_ARGS(addr, pte, order)
 );
 
+TRACE_EVENT(mm_migrate_unmap_folio,
+
+	TP_PROTO(unsigned long pfn, unsigned long addr,
+		 unsigned long page_flags, unsigned long vm_flags),
+
+	TP_ARGS(pfn, addr, page_flags, vm_flags),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned long, addr)
+		__field(unsigned long, page_flags)
+		__field(unsigned long, vm_flags)
+	),
+
+	TP_fast_assign(
+		__entry->pfn		= pfn;
+		__entry->addr		= addr;
+		__entry->page_flags	= page_flags;
+		__entry->vm_flags	= vm_flags;
+	),
+
+	TP_printk("pfn=0x%lx addr=0x%lx page_flags=%s vm_flags=%s",
+		__entry->pfn,
+		__entry->addr,
+		show_page_flags(__entry->page_flags & PAGEFLAGS_MASK),
+		show_vma_flags(__entry->vm_flags))
+);
+
 DEFINE_EVENT(migration_pte, remove_migration_pte,
 	TP_PROTO(unsigned long addr, unsigned long pte, int order),
 	TP_ARGS(addr, pte, order)
diff --git a/mm/rmap.c b/mm/rmap.c
index 3cb7f6337d38..b110548bebae 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2716,6 +2716,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			hugetlb_remove_rmap(folio);
 		else
 			folio_remove_rmap_pte(folio, subpage, vma);
+
+		trace_mm_migrate_unmap_folio(folio_pfn(folio), address,
+					     folio->flags.f, vma->vm_flags);
+
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
-- 
2.43.0

