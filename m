Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7967381BD;
	Wed, 22 May 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364367; cv=none; b=I/+cZ6MjFCMjee85JERUk9lEoLvBHHh6mvD6tGUtxMVFbfbZEtjXqOfWNLwOuyp1T/wERgForblrz83x/31nEpN+NkU6vh1YTWNUsE2INA/qhaj8prMsdqWuFPHj7hjfo3S9XL87lMWIlay0rGTHqeTcPp/aGEgKp9VDK5DHyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364367; c=relaxed/simple;
	bh=BlUYc18xxTSYW8D3eEZVvpXbvyLOVNxxS2l+k+VIBB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRfEP9Q9TjxKalsMWtNWmzJyuBk1lp9wgKxSKEFC6Ifv+wTe7ZupLPh824aaS0WlUBlHfNzcS7VpXVXabdvVw80JbD6lu64vwnL4i0+Rc9VVDn7fmDK6We/SicJk/7MJoj7b/UlPMtVTgDLJC75sYke6eN0UtmiFdAL+lWtsz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=EYnRLAHA; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="EYnRLAHA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1716364365; x=1747900365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p1PR+bMgri8CFj5w/WqKj5UXpiMUEtn0gsOYoXkuyv4=;
  b=EYnRLAHA8Q8yrukXXqxhP+LF/bQKchi8obzQ8U/1qX2YKn9545pWOK/3
   LVnSETqOnT9URNPGIRPsqCaUDbBNtb/5dubolZ3SPcnkmcsEzB5EfUwG9
   lQaebYZFVRwfdv7xlJi8cGFzr4T1J2shfKw+BjypWWbS55CH6KpDJnkR6
   Mn5n0KqE/zgK/MQXuIQLdvbVwPV1GApUC29hnCqEJoceuAhZ4BRTGTKLh
   ApEc8akkxU0GThtmGNC+Ngs/q9CNt+P/iX1UIq917LsJS+vzObksYqScl
   1g7/boxwxwY0mpcBlPYSJhruxfK/u0MrDL7NaVOIExTmxKUIgqEewv0ll
   g==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:42:34 +0900
X-IronPort-AV: E=Sophos;i="6.08,179,1712588400"; 
   d="scan'208";a="390840544"
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
Subject: [PATCH 0/2] Improve dump_page() output for slab pages
Date: Wed, 22 May 2024 16:46:27 +0900
Message-Id: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While using dump_page() on a range of pages, I noticed that there were some
PG_slab pages that were also showing as PG_anon pages, according to the
function output.

[    7.071985] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102768
[    7.072602] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    7.073085] anon flags: 0x8000000000000840(slab|head|zone=2)
[    7.073777] raw: 8000000000000840 ffff8881000419c0 0000000000000000 dead000000000001

It was also printing the "page_type" field for slab pages, but that was fixed in
a very recent commit:
    8f790d0c7cfe (mm: improve dumping of mapcount and page_type)

Given that the slab pages cannot be mapped to userspace, this output seems
misleading.

In dump_page(), folio_test_anon() is used, which checks the "mapping" field.
But the struct slab was separated from struct page.
So accessing the mapping field through a struct page pointer, which actually
points to a struct slab, will result in garbage memory access and the PG_anon
test can return true.

It seems that other parts of the kernel MM make the check for slab before
checking for anon, but dump_page() is not doing that.

On the other hand, the struct slab has kmem_cache which maintains another set
of flags. It would be nice to have these flags added as a part of the debug
output, and to have a convenient way to print them.

(The long chain of pointer dereferences for cache flags looks messy, but I
assume it should be fine for a debug function.)

Sukrit Bhatnagar (2):
  mm: printk: introduce new format %pGs for slab flags
  mm: debug: print correct information for slab folios

 Documentation/core-api/printk-formats.rst |  2 +
 include/linux/slab.h                      |  5 ++
 include/trace/events/mmflags.h            | 67 +++++++++++++++++++++++
 lib/test_printf.c                         | 13 +++++
 lib/vsprintf.c                            | 22 ++++++++
 mm/debug.c                                | 12 +++-
 mm/internal.h                             |  1 +
 7 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.34.1

