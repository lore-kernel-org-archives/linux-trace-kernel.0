Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE037E567;
	Wed, 22 May 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364371; cv=none; b=llzY2KBcVxdh1tS7FW2ATxGXIk8i98gNA722929zHsUfYmvVfo4l3QEC5/3RMjHPvBaGPMK4Voj5N/7krpx9+UZNJNjP4sE1dPt938UO3AM7M3Gxv62zY3diusNLN6hXTHruPOhRfLSqXy+rofM2cA9p9WoXf/zVRkho+PxPS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364371; c=relaxed/simple;
	bh=H4JHdiWPqWyKWVKoR695WAUUBmxgnpWpYE2Ply1KevE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MonhiwQRx+IcLQynPNuU8TlfwMjqKlRM2iDSiYFUZnS7+fW24TTq59cWXNL1jxWqbWHJoTG2elIxBN5BN78NqP8bpaDw2npieoyLSzp+rpoWzjAdhm4O4xzknj3ip2ypDWypUPbbdY4QpFbU8E0E7h2T90CD/TSeVkcMBTa3o+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=m88YQUPI; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="m88YQUPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1716364369; x=1747900369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qt8VQF9vI4lN2kpWCMHn3LoxytDoJRuZtWxRqLzoavA=;
  b=m88YQUPIyYoHSzVMNM4T5hFC8BuIOdB/WPuoqvaHhoPaqQh+CvQr9Evy
   +FGbvO4pyt5PXy6I83FCBBStVSaXjRb6XMrHV6dJ21b/2saInOPCZ1360
   5YABTRVl0yc/xlg+etWYfM3mP5GS6RB4S+fklGoeKWWpyRKcwsOwBSDr6
   4YMzkY0kvigWScO5al2oxF8mai3WRMYS1tN98FXv7f2EM0Xz2NSlYHQeF
   2/FU6dq0NWMRXhvjY5UNixLkHjQslzmitu9orcaJRnEiVy+1Qoo5rfTqp
   nfbm4dpV6UXqF3jopFNRGVmH4/tSVIyIw3PPVV0k3xwuXw28HSZ/+QR7s
   A==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:42:34 +0900
X-IronPort-AV: E=Sophos;i="6.08,179,1712588400"; 
   d="scan'208";a="390840548"
Received: from unknown (HELO OptiPlex-7080..) ([IPv6:2001:cf8:1:5f1:0:dddd:6fe5:f4d0])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 22 May 2024 16:42:34 +0900
From: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Sukrit.Bhatnagar@sony.com
Subject: [PATCH 2/2] mm: debug: print correct information for slab folios
Date: Wed, 22 May 2024 16:46:29 +0900
Message-Id: <20240522074629.2420423-3-Sukrit.Bhatnagar@sony.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>
References: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function dump_page() prints "anon" even for slab pages.
This is not correct, especially now that struct slab is separated from
struct page, and that the slab pages cannot be mapped to userspace.

[    7.071985] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102768
[    7.072602] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    7.073085] anon flags: 0x8000000000000840(slab|head|zone=2)
[    7.073777] raw: 8000000000000840 ffff8881000419c0 0000000000000000 dead000000000001

This debugging output may be misleading, and it is not easy to understand
unless we read the source code.

If the folio tests true for slab, do not print information that does not
apply to it. Instead, print the slab flags stored in the kmem_cache field.

[    7.248722] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888103e6aa87>
[    7.249135] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    7.249429] slab flags: 0x8000000000000840(slab|head|zone=2)
[    7.249664] cache flags: 0x10310(HWCACHE_ALIGN|PANIC|TYPESAFE_BY_RCU|CMPXCHG_DOUBLE)
[    7.249999] raw: 8000000000000000 ffffea00040f9a01 ffffea00040f9bc8 dead000000000400

Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
---
 mm/debug.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index 2ef516f310e8..b6892dd279cb 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -16,6 +16,7 @@
 #include <linux/ctype.h>
 
 #include "internal.h"
+#include "slab.h"
 #include <trace/events/migrate.h>
 
 /*
@@ -80,7 +81,9 @@ static void __dump_folio(struct folio *folio, struct page *page,
 	if (folio->memcg_data)
 		pr_warn("memcg:%lx\n", folio->memcg_data);
 #endif
-	if (folio_test_ksm(folio))
+	if (folio_test_slab(folio))
+		type = "slab ";
+	else if (folio_test_ksm(folio))
 		type = "ksm ";
 	else if (folio_test_anon(folio))
 		type = "anon ";
@@ -98,6 +101,8 @@ static void __dump_folio(struct folio *folio, struct page *page,
 		is_migrate_cma_folio(folio, pfn) ? " CMA" : "");
 	if (page_has_type(&folio->page))
 		pr_warn("page_type: %pGt\n", &folio->page.page_type);
+	else if (folio_test_slab(folio))
+		pr_warn("cache flags: %pGs\n", &((struct slab *)&folio->page)->slab_cache->flags);
 
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
-- 
2.34.1

