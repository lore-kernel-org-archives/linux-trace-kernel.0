Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F339CEE498F
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 18 Aug 2023 20:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjHRUO4 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243308AbjHRUOW (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:14:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752E11BD4;
        Fri, 18 Aug 2023 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=FKu9hCXJhCudis6NHoImqT88eK3YpaDzx/CiHPdAOeo=; b=LJJAAle+t2QPSw5tbkL9l/pxrd
        7CXcXwaJl5IopehEehAaUOUXXpyaLtRvRR19LciQvHH9d5XYc9V8d0gKwlLsAFA23CNc2t0f+DDQs
        SvAoHhrW3v8ET6ytsKyPW4sYrXB2IOLQJJW9pM29t52lxOIrWGApX6lPs/XrgxRGxEu9d/Nqgpxbm
        ae7sPZtE4Oc9YQ1bxPrfoSYTcaPj2KqCw1PQhKOEw89GOK/iwVSsZQv+Q6URSzN241c/GNyV1pj1j
        AtfeB6N4/pCdm5nO8QlCJ+l1G+dE117AcKdjUYoklnVJgFeHWPstl+C0WdRNFffP02hsBz5NqB0M0
        0ztSR5nQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5rO-00BS8J-A6; Fri, 18 Aug 2023 20:14:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-trace-kernel@vger.kernel.org, linux-docs@vger.kernel.org
Subject: [PATCH] tracefs: Fix kernel-doc warnings
Date:   Fri, 18 Aug 2023 21:14:13 +0100
Message-Id: <20230818201414.2729745-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Move the per-member documentation into the header to fix the complaints
from kernel-doc.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/tracefs/event_inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index da8d2e73cc47..7ca3857ddb89 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -37,6 +37,9 @@ struct eventfs_inode {
  * @ei:		list of files and directories within directory
  * @fop:	file_operations for file or directory
  * @iop:	inode_operations for file or directory
+ * @del_list:	list of eventfs_file to delete
+ * @rcu:	eventfs_file to delete
+ * @is_freed:	Non-zero if @del_list or @rcu is active
  * @data:	something that the caller will want to get to later on
  * @mode:	the permission that the file or directory should have
  */
@@ -49,9 +52,9 @@ struct eventfs_file {
 	const struct file_operations	*fop;
 	const struct inode_operations	*iop;
 	union {
-		struct list_head	del_list; /* list of eventfs_file to delete */
-		struct rcu_head		rcu; /* eventfs_file to delete */
-		unsigned long		is_freed; /* Freed if one of the above is set */
+		struct list_head	del_list;
+		struct rcu_head		rcu;
+		unsigned long		is_freed;
 	};
 	void				*data;
 	umode_t				mode;
-- 
2.40.1

