Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F303EC875F
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  8 Sep 2023 02:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjIHCTu (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 7 Sep 2023 22:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbjIHCTt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:19:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3B1BD9;
        Thu,  7 Sep 2023 19:19:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E1EC433CA;
        Fri,  8 Sep 2023 02:19:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qeR6H-000MZ2-2T;
        Thu, 07 Sep 2023 22:20:01 -0400
Message-ID: <20230908022001.580400115@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 07 Sep 2023 22:19:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 2/2] tracing: Remove unused trace_event_file dir field
References: <20230908021910.507739229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that eventfs structure is used to create the events directory via the
eventfs dynamically allocate code, the "dir" field of the trace_event_file
structure is no longer used. Remove it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h |  1 -
 kernel/trace/trace_events.c  | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index eb5c3add939b..12f875e9e69a 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -650,7 +650,6 @@ struct trace_event_file {
 	struct trace_event_call		*event_call;
 	struct event_filter __rcu	*filter;
 	struct eventfs_file             *ef;
-	struct dentry			*dir;
 	struct trace_array		*tr;
 	struct trace_subsystem_dir	*system;
 	struct list_head		triggers;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2af92177b765..065c63991858 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -992,19 +992,6 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 
 static void remove_event_file_dir(struct trace_event_file *file)
 {
-	struct dentry *dir = file->dir;
-	struct dentry *child;
-
-	if (dir) {
-		spin_lock(&dir->d_lock);	/* probably unneeded */
-		list_for_each_entry(child, &dir->d_subdirs, d_child) {
-			if (d_really_is_positive(child))	/* probably unneeded */
-				d_inode(child)->i_private = NULL;
-		}
-		spin_unlock(&dir->d_lock);
-
-		tracefs_remove(dir);
-	}
 	eventfs_remove(file->ef);
 	list_del(&file->list);
 	remove_subsystem(file->system);
-- 
2.40.1
