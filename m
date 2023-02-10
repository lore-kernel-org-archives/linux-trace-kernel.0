Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE61EC636D4
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 10 Feb 2023 21:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjBJVrS (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 10 Feb 2023 16:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjBJVrR (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:47:17 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1B53E0A1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:47:15 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 2A4CE6BFB4E6; Fri, 10 Feb 2023 13:47:02 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH v1] mm: add tracepoints to ksm
Date:   Fri, 10 Feb 2023 13:46:45 -0800
Message-Id: <20230210214645.2720847-1-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This adds the following tracepoints to ksm:
- start / stop scan
- ksm enter / exit
- merge a page
- merge a page with ksm
- remove a page
- remove a rmap item

This patch has been split off from the RFC patch series "mm:
process/cgroup ksm support".

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS                |   1 +
 include/trace/events/ksm.h | 251 +++++++++++++++++++++++++++++++++++++
 mm/ksm.c                   |  21 +++-
 3 files changed, 271 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/ksm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b92a2a0cb36b..827291f1ba97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13487,6 +13487,7 @@ F:	include/linux/memory_hotplug.h
 F:	include/linux/mm.h
 F:	include/linux/mmzone.h
 F:	include/linux/pagewalk.h
+F:	include/trace/events/ksm.h
 F:	mm/
 F:	tools/mm/
 F:	tools/testing/selftests/mm/
diff --git a/include/trace/events/ksm.h b/include/trace/events/ksm.h
new file mode 100644
index 000000000000..b5ac35c1d0e8
--- /dev/null
+++ b/include/trace/events/ksm.h
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ksm
+
+#if !defined(_TRACE_KSM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KSM_H
+
+#include <linux/tracepoint.h>
+
+/**
+ * ksm_scan_template - called for start / stop scan
+ *
+ * @seq:		sequence number of scan
+ * @rmap_entries:	actual number of rmap entries
+ *
+ * Allows to trace the start / stop of a ksm scan.
+ */
+DECLARE_EVENT_CLASS(ksm_scan_template,
+
+	TP_PROTO(int seq, u32 rmap_entries),
+
+	TP_ARGS(seq, rmap_entries),
+
+	TP_STRUCT__entry(
+		__field(int,	seq)
+		__field(u32,	rmap_entries)
+	),
+
+	TP_fast_assign(
+		__entry->seq		=3D seq;
+		__entry->rmap_entries	=3D rmap_entries;
+	),
+
+	TP_printk("seq %d rmap size %d",
+			__entry->seq, __entry->rmap_entries)
+);
+
+/**
+ * ksm_start_scan - called after a new ksm scan is started
+ *
+ * @seq:		sequence number of scan
+ * @rmap_entries:	actual number of rmap entries
+ *
+ * Allows to trace the start of a ksm scan.
+ */
+DEFINE_EVENT(ksm_scan_template, ksm_start_scan,
+
+	TP_PROTO(int seq, u32 rmap_entries),
+
+	TP_ARGS(seq, rmap_entries)
+);
+
+/**
+ * ksm_stop_scan - called after a new ksm scan has completed
+ *
+ * @seq:		sequence number of scan
+ * @rmap_entries:	actual number of rmap entries
+ *
+ * Allows to trace the completion of a ksm scan.
+ */
+DEFINE_EVENT(ksm_scan_template, ksm_stop_scan,
+
+	TP_PROTO(int seq, u32 rmap_entries),
+
+	TP_ARGS(seq, rmap_entries)
+);
+
+/**
+ * ksm_enter - called after a new process has been added / removed from =
ksm
+ *
+ * @mm:			address of the mm object of the process
+ *
+ * Allows to trace the when a process has been added or removed from ksm=
.
+ */
+DECLARE_EVENT_CLASS(ksm_enter_exit_template,
+
+	TP_PROTO(void *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+		__field(void *,		mm)
+	),
+
+	TP_fast_assign(
+		__entry->mm	=3D mm;
+	),
+
+	TP_printk("mm %p", __entry->mm)
+);
+
+/**
+ * ksm_enter - called after a new process has been added to ksm
+ *
+ * @mm:			address of the mm object of the process
+ *
+ * Allows to trace the when a process has been added to ksm.
+ */
+DEFINE_EVENT(ksm_enter_exit_template, ksm_enter,
+
+	TP_PROTO(void *mm),
+
+	TP_ARGS(mm)
+);
+
+/**
+ * ksm_exit - called after a new process has been removed from ksm
+ *
+ * @mm:			address of the mm object of the process
+ *
+ * Allows to trace the when a process has been removed from ksm.
+ */
+DEFINE_EVENT(ksm_enter_exit_template, ksm_exit,
+
+	TP_PROTO(void *mm),
+
+	TP_ARGS(mm)
+);
+
+/**
+ * ksm_merge_one_page - called after a page has been merged
+ *
+ * @pfn:		page frame number of ksm page
+ * @rmap_item:		address of rmap_item  object
+ * @mm:			address of the process mm struct
+ * @err:		success
+ *
+ * Allows to trace the ksm merging of individual pages.
+ */
+TRACE_EVENT(ksm_merge_one_page,
+
+	TP_PROTO(unsigned long pfn, void *rmap_item, void *mm, int err),
+
+	TP_ARGS(pfn, rmap_item, mm, err),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	pfn)
+		__field(void *,		rmap_item)
+		__field(void *,		mm)
+		__field(int,		err)
+	),
+
+	TP_fast_assign(
+		__entry->pfn		=3D pfn;
+		__entry->rmap_item	=3D rmap_item;
+		__entry->mm		=3D mm;
+		__entry->err		=3D err;
+	),
+
+	TP_printk("ksm pfn %lu rmap_item %p mm %p error %d",
+			__entry->pfn, __entry->rmap_item, __entry->mm, __entry->err)
+);
+
+/**
+ * ksm_merge_with_ksm_page - called after a page has been merged with a =
ksm page
+ *
+ * @ksm_page:		address ksm page
+ * @pfn:		page frame number of ksm page
+ * @rmap_item:		address of rmap_item  object
+ * @mm:			address of the mm object of the process
+ * @err:		success
+ *
+ * Allows to trace the merging of a page with a ksm page.
+ */
+TRACE_EVENT(ksm_merge_with_ksm_page,
+
+	TP_PROTO(void *ksm_page, unsigned long pfn, void *rmap_item, void *mm, =
int err),
+
+	TP_ARGS(ksm_page, pfn, rmap_item, mm, err),
+
+	TP_STRUCT__entry(
+		__field(void *,		ksm_page)
+		__field(unsigned long,	pfn)
+		__field(void *,		rmap_item)
+		__field(void *,		mm)
+		__field(int,		err)
+	),
+
+	TP_fast_assign(
+		__entry->ksm_page	=3D ksm_page;
+		__entry->pfn		=3D pfn;
+		__entry->rmap_item	=3D rmap_item;
+		__entry->mm		=3D mm;
+		__entry->err		=3D err;
+	),
+
+	TP_printk("%spfn %lu rmap_item %p mm %p error %d",
+		  (__entry->ksm_page ? "ksm " : ""),
+		  __entry->pfn, __entry->rmap_item, __entry->mm, __entry->err)
+);
+
+/**
+ * ksm_remove_ksm_page - called after a ksm page has been removed
+ *
+ * @pfn:		page frame number of ksm page
+ *
+ * Allows to trace the removing of stable ksm pages.
+ */
+TRACE_EVENT(ksm_remove_ksm_page,
+
+	TP_PROTO(unsigned long pfn),
+
+	TP_ARGS(pfn),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+	),
+
+	TP_fast_assign(
+		__entry->pfn =3D pfn;
+	),
+
+	TP_printk("pfn %lu", __entry->pfn)
+);
+
+/**
+ * ksm_remove_rmap_item - called after a rmap_item has been removed from=
 the
+ *                        stable tree
+ *
+ * @pfn:		page frame number of ksm page
+ * @rmap_item:		address of rmap_item  object
+ * @mm:			address of the process mm struct
+ *
+ * Allows to trace the removal of pages from the stable tree list.
+ */
+TRACE_EVENT(ksm_remove_rmap_item,
+
+	TP_PROTO(unsigned long pfn, void *rmap_item, void *mm),
+
+	TP_ARGS(pfn, rmap_item, mm),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	pfn)
+		__field(void *,		rmap_item)
+		__field(void *,		mm)
+	),
+
+	TP_fast_assign(
+		__entry->pfn		=3D pfn;
+		__entry->rmap_item	=3D rmap_item;
+		__entry->mm		=3D mm;
+	),
+
+	TP_printk("pfn %lu rmap_item %p mm %p",
+			__entry->pfn, __entry->rmap_item, __entry->mm)
+);
+
+#endif /* _TRACE_KSM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/ksm.c b/mm/ksm.c
index 56808e3bfd19..4356af760735 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -45,6 +45,9 @@
 #include "internal.h"
 #include "mm_slot.h"
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/ksm.h>
+
 #ifdef CONFIG_NUMA
 #define NUMA(x)		(x)
 #define DO_NUMA(x)	do { (x); } while (0)
@@ -655,10 +658,12 @@ static void remove_node_from_stable_tree(struct ksm=
_stable_node *stable_node)
 	BUG_ON(stable_node->rmap_hlist_len < 0);
=20
 	hlist_for_each_entry(rmap_item, &stable_node->hlist, hlist) {
-		if (rmap_item->hlist.next)
+		if (rmap_item->hlist.next) {
 			ksm_pages_sharing--;
-		else
+			trace_ksm_remove_rmap_item(stable_node->kpfn, rmap_item, rmap_item->m=
m);
+		} else {
 			ksm_pages_shared--;
+		}
=20
 		rmap_item->mm->ksm_merging_pages--;
=20
@@ -679,6 +684,7 @@ static void remove_node_from_stable_tree(struct ksm_s=
table_node *stable_node)
 	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD <=3D &migrate_nodes);
 	BUILD_BUG_ON(STABLE_NODE_DUP_HEAD >=3D &migrate_nodes + 1);
=20
+	trace_ksm_remove_ksm_page(stable_node->kpfn);
 	if (stable_node->head =3D=3D &migrate_nodes)
 		list_del(&stable_node->list);
 	else
@@ -1367,6 +1373,8 @@ static int try_to_merge_with_ksm_page(struct ksm_rm=
ap_item *rmap_item,
 	get_anon_vma(vma->anon_vma);
 out:
 	mmap_read_unlock(mm);
+	trace_ksm_merge_with_ksm_page(kpage, page_to_pfn(kpage ? kpage : page),
+				rmap_item, mm, err);
 	return err;
 }
=20
@@ -2114,6 +2122,9 @@ static int try_to_merge_with_kernel_zero_page(struc=
t ksm_rmap_item *rmap_item,
 		if (vma) {
 			err =3D try_to_merge_one_page(vma, page,
 						ZERO_PAGE(rmap_item->address));
+			trace_ksm_merge_one_page(
+				page_to_pfn(ZERO_PAGE(rmap_item->address)),
+				rmap_item, mm, err);
 			if (!err) {
 				rmap_item->address |=3D ZERO_PAGE_FLAG;
 				ksm_zero_pages_sharing++;
@@ -2344,6 +2355,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
=20
 	mm_slot =3D ksm_scan.mm_slot;
 	if (mm_slot =3D=3D &ksm_mm_head) {
+		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
+
 		/*
 		 * A number of pages can hang around indefinitely on per-cpu
 		 * pagevecs, raised page count preventing write_protect_page
@@ -2510,6 +2523,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
 	if (mm_slot !=3D &ksm_mm_head)
 		goto next_mm;
=20
+	trace_ksm_stop_scan(ksm_scan.seqnr, ksm_rmap_items);
 	ksm_scan.seqnr++;
 	return NULL;
 }
@@ -2661,6 +2675,7 @@ int __ksm_enter(struct mm_struct *mm)
 	if (needs_wakeup)
 		wake_up_interruptible(&ksm_thread_wait);
=20
+	trace_ksm_enter(mm);
 	return 0;
 }
=20
@@ -2702,6 +2717,8 @@ void __ksm_exit(struct mm_struct *mm)
 		mmap_write_lock(mm);
 		mmap_write_unlock(mm);
 	}
+
+	trace_ksm_exit(mm);
 }
=20
 struct page *ksm_might_need_to_copy(struct page *page,

base-commit: 234a68e24b120b98875a8b6e17a9dead277be16a
--=20
2.30.2

