Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CAAC38142
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 31 Jan 2023 16:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjAaQPp (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjAaQPo (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:15:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B853E7F;
        Tue, 31 Jan 2023 08:15:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3E4861593;
        Tue, 31 Jan 2023 16:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E4EC433EF;
        Tue, 31 Jan 2023 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675181734;
        bh=uMXIDE3N6tRBHy0qXfA/qokcfkSD+HhNMwAWfevtvoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KtFLR8z6+ix5fyiDnip6/lv75UwxP+ZlQrvlcyrKxb9EX0Xe3XeJTlhFAAEElHE1A
         A2aY54HCUUWFDXRvxE71mdMIFKG5lqf2Z3xFvQwKJ/kjdSQWHS52cVXlVMwJIEvnkx
         j536sTjugBoIsHl8FRwqFZ7yO/sTOK/T1LEXLNbezh60PL2HNFGZZC5K2rh2fZod/S
         uvEontAV7r8VSFBMxC62cp56aN2jmfeDR1J4BqKosfRp2aDUJjs//VheIXlWIRbO8l
         3Ti4T6jWfJ9Oiv3SV9Ma1RuwHiAQ5r64UyG5cG4UwGS/a5opb0GGz52Zsmabh4qPoE
         wijUL1Fs0nslw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 03/10] fprobe: Add nr_maxactive to specify rethook_node pool size
Date:   Wed,  1 Feb 2023 01:15:30 +0900
Message-Id:  <167518173031.336834.3343880383483990761.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
References:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add nr_maxactive to specify rethook_node pool size. This means
the maximum number of actively running target functions concurrently
for probing by exit_handler. Note that if the running function is
preempted or sleep, it is still counted as 'active'.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/fprobe.h |    2 ++
 kernel/trace/fprobe.c  |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index e0d4e6136249..678f741a7b33 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -14,6 +14,7 @@
  * @flags: The status flag.
  * @rethook: The rethook data structure. (internal data)
  * @entry_data_size: The private data storage size.
+ * @nr_maxactive: The max number of active functions.
  * @entry_handler: The callback function for function entry.
  * @exit_handler: The callback function for function exit.
  */
@@ -31,6 +32,7 @@ struct fprobe {
 	unsigned int		flags;
 	struct rethook		*rethook;
 	size_t			entry_data_size;
+	int			nr_maxactive;
 
 	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
 			      struct pt_regs *regs, void *entry_data);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index fa25d09c9d57..f222848571f2 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -143,7 +143,10 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 	}
 
 	/* Initialize rethook if needed */
-	size = num * num_possible_cpus() * 2;
+	if (fp->nr_maxactive)
+		size = fp->nr_maxactive;
+	else
+		size = num * num_possible_cpus() * 2;
 	if (size < 0)
 		return -E2BIG;
 

