Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA77EEE14D3
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  7 Sep 2023 02:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjIGCry (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 6 Sep 2023 22:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbjIGCry (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:47:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2940619AF;
        Wed,  6 Sep 2023 19:47:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C51C433A9;
        Thu,  7 Sep 2023 02:47:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qe53s-000BK3-0s;
        Wed, 06 Sep 2023 22:48:04 -0400
Message-ID: <20230907024804.086679464@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Sep 2023 22:47:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 5/6] tracing: Have option files inc the trace array ref count
References: <20230907024710.866917011@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The option files update the options for a given trace array. For an
instance, if the file is opened and the instance is deleted, reading or
writing to the file will cause a use after free.

Up the ref count of the trace_array when an option file is opened.

Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/

Cc: stable@vger.kernel.org
Fixes: 8530dec63e7b4 ("tracing: Add tracing_check_open_get_tr()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b82df33d20ff..0608ad20cf30 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8988,12 +8988,33 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
+static int tracing_open_options(struct inode *inode, struct file *filp)
+{
+	struct trace_option_dentry *topt = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(topt->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+	return 0;
+}
+
+static int tracing_release_options(struct inode *inode, struct file *file)
+{
+	struct trace_option_dentry *topt = file->private_data;
+
+	trace_array_put(topt->tr);
+	return 0;
+}
 
 static const struct file_operations trace_options_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_options,
 	.read = trace_options_read,
 	.write = trace_options_write,
 	.llseek	= generic_file_llseek,
+	.release = tracing_release_options,
 };
 
 /*
-- 
2.40.1
