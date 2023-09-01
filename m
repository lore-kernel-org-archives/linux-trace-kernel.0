Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B0CCA0FE5
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  1 Sep 2023 15:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350139AbjIAPMp (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350136AbjIAPMp (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D946710F3
        for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693581067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDuTMVC2fItyk8TQyqI4vfFk/aqpQbO6zoYrXybc/Ys=;
        b=Z6wSq4tuLzm76WWiCdo4SGF9RKHiqwUTax3FlLIt4emXpAO6o78AlX+9RyR8rEZ7VJHYVx
        czHcyeEx/6aWlavNg5MrYBclAQB9+P4Rg45b1j3rbWfpaRMNfltLclYXpN4/khG8wWJxCh
        dR4o2YAEJb7OkIu3Qq/7az4M9Ao2Rug=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-GMysWmSFMWOrbG21E5dJXg-1; Fri, 01 Sep 2023 11:11:02 -0400
X-MC-Unique: GMysWmSFMWOrbG21E5dJXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1C76923000;
        Fri,  1 Sep 2023 15:11:01 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.39.193.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D960205B0BE;
        Fri,  1 Sep 2023 15:11:00 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/4] tracing/filters: Fix error-handling of cpulist parsing buffer
Date:   Fri,  1 Sep 2023 17:10:36 +0200
Message-Id: <20230901151039.125186-2-vschneid@redhat.com>
In-Reply-To: <20230901151039.125186-1-vschneid@redhat.com>
References: <20230901151039.125186-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

parse_pred() allocates a string buffer to parse the user-provided cpulist,
but doesn't check the allocation result nor does it free the buffer once it
is no longer needed.

Add an allocation check, and free the buffer as soon as it is no longer
needed.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3a529214a21b7..c06e1d596f4b9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1744,17 +1744,23 @@ static int parse_pred(const char *str, void *data,
 
 		/* Copy the cpulist between { and } */
 		tmp = kmalloc((i - maskstart) + 1, GFP_KERNEL);
-		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
+		if (!tmp)
+			goto err_mem;
 
+		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
 		pred->mask = kzalloc(cpumask_size(), GFP_KERNEL);
-		if (!pred->mask)
+		if (!pred->mask) {
+			kfree(tmp);
 			goto err_mem;
+		}
 
 		/* Now parse it */
 		if (cpulist_parse(tmp, pred->mask)) {
+			kfree(tmp);
 			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
 			goto err_free;
 		}
+		kfree(tmp);
 
 		/* Move along */
 		i++;
-- 
2.31.1

