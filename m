Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED05C001DB
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  4 Aug 2023 20:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHDUyb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 4 Aug 2023 16:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHDUya (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1E14C31
        for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691182424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4OBEiq9HKlDq3EnC9rDgOXCYD/GG5hag+Y80zX9mZwQ=;
        b=XgjU8sddNZz8OWAbNGzkc4QtU2FHF7depgiA6GGFwUMFHcZp5SJzgZaT0IB2nJF08utCQ1
        3Sxm5+06h9Uk+giPHR9Gwesmy1p8vejTJixqaiZ3HzT9L8raoD1UkEStpqltStLi7FKChf
        HiCwyvBJXfP8NEp8m8u7r91vCqupJXE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-NP8VM07NNVSUK8P9-OwVqw-1; Fri, 04 Aug 2023 16:53:41 -0400
X-MC-Unique: NP8VM07NNVSUK8P9-OwVqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAED729AA386;
        Fri,  4 Aug 2023 20:53:40 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.32.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 647BBC5796B;
        Fri,  4 Aug 2023 20:53:40 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, rostedt@goodmis.org
Subject: [PATCH] tracing: vmscan: add file/anon identifier to lru_shrink_[in]active tracepoints
Date:   Fri,  4 Aug 2023 14:53:26 -0600
Message-ID: <20230804205326.33952-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Add the file variable to the tracepoint data for both the active and
inactive lru shrink functions. This should help increase observability
in the LRU reclaim algorithm.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/trace/events/vmscan.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index d2123dd960d5..055d50c10842 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -372,6 +372,7 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__field(unsigned long, nr_unmap_fail)
 		__field(int, priority)
 		__field(int, reclaim_flags)
+		__field(int, file)
 	),
 
 	TP_fast_assign(
@@ -388,10 +389,11 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_unmap_fail = stat->nr_unmap_fail;
 		__entry->priority = priority;
 		__entry->reclaim_flags = trace_reclaim_flags(file);
+		__entry->file = file;
 	),
 
-	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
-		__entry->nid,
+	TP_printk("nid=%d is_file=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
+		__entry->nid, __entry->file,
 		__entry->nr_scanned, __entry->nr_reclaimed,
 		__entry->nr_dirty, __entry->nr_writeback,
 		__entry->nr_congested, __entry->nr_immediate,
@@ -417,6 +419,7 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
 		__field(unsigned long, nr_referenced)
 		__field(int, priority)
 		__field(int, reclaim_flags)
+		__field(int, file)
 	),
 
 	TP_fast_assign(
@@ -427,10 +430,11 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
 		__entry->nr_referenced = nr_referenced;
 		__entry->priority = priority;
 		__entry->reclaim_flags = trace_reclaim_flags(file);
+		__entry->file = file;
 	),
 
-	TP_printk("nid=%d nr_taken=%ld nr_active=%ld nr_deactivated=%ld nr_referenced=%ld priority=%d flags=%s",
-		__entry->nid,
+	TP_printk("nid=%d is_file=%d nr_taken=%ld nr_active=%ld nr_deactivated=%ld nr_referenced=%ld priority=%d flags=%s",
+		__entry->nid, __entry->file,
 		__entry->nr_taken,
 		__entry->nr_active, __entry->nr_deactivated, __entry->nr_referenced,
 		__entry->priority,
-- 
2.41.0

