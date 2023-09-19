Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D5CD342E
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 19 Sep 2023 01:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjISB3H (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 18 Sep 2023 21:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISB3H (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:29:07 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 00CEA106;
        Mon, 18 Sep 2023 18:29:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id C859660284275;
        Tue, 19 Sep 2023 09:28:40 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] kprobes: Remove unnecessary initial values of variables
Date:   Tue, 19 Sep 2023 09:28:23 +0800
Message-Id: <20230919012823.7815-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

ri and sym is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ca385b61d546..82b2a366d496 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1990,7 +1990,7 @@ NOKPROBE_SYMBOL(__kretprobe_find_ret_addr);
 unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
 				      struct llist_node **cur)
 {
-	struct kretprobe_instance *ri = NULL;
+	struct kretprobe_instance *ri;
 	kprobe_opcode_t *ret;
 
 	if (WARN_ON_ONCE(!cur))
@@ -2817,7 +2817,7 @@ static int show_kprobe_addr(struct seq_file *pi, void *v)
 {
 	struct hlist_head *head;
 	struct kprobe *p, *kp;
-	const char *sym = NULL;
+	const char *sym;
 	unsigned int i = *(loff_t *) v;
 	unsigned long offset = 0;
 	char *modname, namebuf[KSYM_NAME_LEN];
-- 
2.18.2

