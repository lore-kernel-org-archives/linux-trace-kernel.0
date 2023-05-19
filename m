Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B176BC77B7F
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 19 May 2023 23:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjESXI2 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 19 May 2023 19:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjESXI0 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:08:26 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB081B0;
        Fri, 19 May 2023 16:08:24 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 69CF220FB611;
        Fri, 19 May 2023 16:08:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69CF220FB611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684537704;
        bh=OvAh3RxmXpSVUBx65Lv/5RIU5rX4bGiaYEjcJRexHGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=io/kAOLFf4UK4zU96lsgT4gbEmhCH7ceePCd+Ojb3H1Tg2OGEKDmwmqngfGech18X
         Jgk+s6ji0vF58grp4NaNtecL4aqvvN3N9sfnDvlkr4sdglmwerLj0XFAQo85Ciwn4T
         LNGkzJhEkJK2onr+1gV460KxFEMbvlAYAEsBNg/Y=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, ast@kernel.org
Subject: [PATCH v3 2/4] tracing/user_events: Remove RCU lock while pinning pages
Date:   Fri, 19 May 2023 16:07:39 -0700
Message-Id: <20230519230741.669-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519230741.669-1-beaub@linux.microsoft.com>
References: <20230519230741.669-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

pin_user_pages_remote() can reschedule which means we cannot hold any
RCU lock while using it. Now that enablers are not exposed out to the
tracing register callbacks during fork(), there is clearly no need to
require the RCU lock as event_mutex is enough to protect changes.

Remove unneeded RCU usages when pinning pages and walking enablers with
event_mutex held. Cleanup a misleading "safe" list walk that is not
needed. During fork() duplication, remove unneeded RCU list add, since
the list is not exposed yet.

Link: https://lore.kernel.org/linux-trace-kernel/CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com/

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ change log written by Beau Belgrave ]
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b2aecbfbbd24..2f70dabb0f71 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -437,9 +437,8 @@ static bool user_event_enabler_exists(struct user_event_mm *mm,
 				      unsigned long uaddr, unsigned char bit)
 {
 	struct user_event_enabler *enabler;
-	struct user_event_enabler *next;
 
-	list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
+	list_for_each_entry(enabler, &mm->enablers, link) {
 		if (enabler->addr == uaddr &&
 		    (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
 			return true;
@@ -455,19 +454,19 @@ static void user_event_enabler_update(struct user_event *user)
 	struct user_event_mm *next;
 	int attempt;
 
+	lockdep_assert_held(&event_mutex);
+
 	while (mm) {
 		next = mm->next;
 		mmap_read_lock(mm->mm);
-		rcu_read_lock();
 
-		list_for_each_entry_rcu(enabler, &mm->enablers, link) {
+		list_for_each_entry(enabler, &mm->enablers, link) {
 			if (enabler->event == user) {
 				attempt = 0;
 				user_event_enabler_write(mm, enabler, true, &attempt);
 			}
 		}
 
-		rcu_read_unlock();
 		mmap_read_unlock(mm->mm);
 		user_event_mm_put(mm);
 		mm = next;
@@ -495,7 +494,9 @@ static bool user_event_enabler_dup(struct user_event_enabler *orig,
 	enabler->values = orig->values & ENABLE_VAL_DUP_MASK;
 
 	refcount_inc(&enabler->event->refcnt);
-	list_add_rcu(&enabler->link, &mm->enablers);
+
+	/* Enablers not exposed yet, RCU not required */
+	list_add(&enabler->link, &mm->enablers);
 
 	return true;
 }
-- 
2.25.1

