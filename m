Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21C1A6817
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Jul 2026 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784487386; cv=pass; b=TqWW1cSb+3Z8lXbjsv2mZ8qiY6fHIowm+5scG63HdNGODQMusPKmyGe5uWtOq0GBpksrfTk1FRo1wybpltffem0iY2Mis0nGBP/uNa+kcatxlR8NNnzSJqU10clDEkKw6dxP4dsX5GVVpx+c/1uAW4wB/F8HEU/eHpAx80+dPPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784487386; c=relaxed/simple;
	bh=DWqpV7HV35H5sSmmuvc8SHajZmC2s/uaGRbQuy3Z+NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mhaEUTqd/4gjBmkBzHfl3j9qQ3fPd0/T4p10Ky+ZhkNMXnCDfvXwRArrWHDdEvicq08XDuQJfTdoGBOraEiHVMXvUY/MHc0kepWKoJKdypODeXSKN+zgqdPCv1q8nZf6s+8yeEFtYRNcv561nfb768Q7cSqudpYYLb/smQMw+6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=KxhcUFcb; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="KxhcUFcb"
ARC-Seal: i=1; a=rsa-sha256; t=1784487280; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=XEiIyIz5mE0Bp26X0wV6jXA/VaVEDP0Vsd8y+wtWApSpa0QnNb1QflaNTLWFhUnGhhhtxzfJCuzo0fiHM9keOIa6/HZdzmITOPROxQGgPC+KqksvGbqDzNUa3EBFq+euvnUukms+YSB2J5UPUhW16rYMvfndG0EowDoBNKl6VhE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1784487280; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2WFeeZ7KFA8P2LraO+LyQSTzhNZOCYdC5G9o/v637Mc=; 
	b=N/saLD1un8BAWR2AyHmL00UBCNQGgS9/mzsoMKFPls2nqPvcQd+TE66HlrKt8RGiL89qVR9M5f6W4l12uUOC2nvBrukr1+OWVMMtyIRcFb7CXatipTkE8sSZF+7gU4erUjorKMdKAeU6W7rF8Y7xqAnl9zXd6GUjmF2aCGtfdpU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784487280;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=2WFeeZ7KFA8P2LraO+LyQSTzhNZOCYdC5G9o/v637Mc=;
	b=KxhcUFcbC6fZlSEYws8W0Ligew3B89Dy34756H9Y+FnvLbM3HTHSHcq86uuSw8oE
	n0Ztxv6GW1uqGFGw83uoBxi03Di1KvQYhCIeLO3m80kIr5Uz1H/Sh6dVKWRaGyqsAVD
	lbsjcFg5UpRN2pbF/Is6Fg7wpUjH+nwu2Tyjw80g=
Received: by mx.zoho.in with SMTPS id 1784487278994775.8847779555358;
	Mon, 20 Jul 2026 00:24:38 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imbrenda@linux.ibm.com,
	Aditya Sharma <adi.sharma@zohomail.in>
Subject: [RFC PATCH 1/7] mm: add CONFIG_ASYNC_MM_TEARDOWN scaffolding for off-CPU exit teardown
Date: Mon, 20 Jul 2026 00:24:03 +0530
Message-Id: <20260719185409.409685-2-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260719185409.409685-1-adi.sharma@zohomail.in>
References: <20260719185409.409685-1-adi.sharma@zohomail.in>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Address-space teardown on process exit runs synchronously in the dying
task's context: exit_mm() -> mmput() -> __mmput() -> exit_mmap() walks
page tables, updates rmap, frees the RSS and drops file refs, all on the
exiting CPU.

Add the scaffolding to later move __mmput() off-CPU for large exiting
address spaces, with no functional change in this patch:
  - new config ASYNC_MM_TEARDOWN (bool, depends on MMU, default n)
  - struct mm_struct::async_reap_node (llist_node), CONFIG-gated, with
    an explicit <linux/llist.h> include (it was only ever available
    transitively via spinlock.h)
  - mmput_exit() declaration, with a static inline fallback that is a
    plain mmput

When the config is disabled mmput_exit() compiles to mmput() with zero
delta, so nothing changes until the kthread and dispatch land.

Signed-off-by: Aditya Sharma <adi.sharma@zohomail.in>
---
 include/linux/mm_types.h |  4 ++++
 include/linux/sched/mm.h |  6 ++++++
 mm/Kconfig               | 11 +++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 939b5ea8c..fffa285ef 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -7,6 +7,7 @@
 #include <linux/auxvec.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/llist.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
 #include <linux/maple_tree.h>
@@ -1367,6 +1368,9 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+#ifdef CONFIG_ASYNC_MM_TEARDOWN
+		struct llist_node async_reap_node;
+#endif /* CONFIG_ASYNC_MM_TEARDOWN */
 
 #ifdef CONFIG_IOMMU_MM_DATA
 		struct iommu_mm_data *iommu_mm;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 10be8a54b..20aeb1d7e 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -147,6 +147,12 @@ extern void mmput(struct mm_struct *);
 void mmput_async(struct mm_struct *);
 #endif
 
+#ifdef CONFIG_ASYNC_MM_TEARDOWN
+void mmput_exit(struct mm_struct *);
+#else
+static inline void mmput_exit(struct mm_struct *mm) { mmput(mm); }
+#endif
+
 /* Grab a reference to a task's mm, if it is not already going away */
 extern struct mm_struct *get_task_mm(struct task_struct *task);
 /*
diff --git a/mm/Kconfig b/mm/Kconfig
index c52ab6afc..296b16ad4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1500,6 +1500,17 @@ config LAZY_MMU_MODE_KUNIT_TEST
 
 	  If unsure, say N.
 
+config ASYNC_MM_TEARDOWN
+	bool "Async off-CPU address space teardown on exit"
+	depends on MMU
+	default n
+	help
+	  Defer the address space teardown (exit_mmap()) of large exiting processes
+	  to a kernel thread instead of running it on the exiting CPU. The feature
+	  is off by default.
+
+	  If unsure, say N.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.34.1

