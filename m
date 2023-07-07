Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18EEEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  7 Jul 2023 16:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGGQiK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGGQiI (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A7118;
        Fri,  7 Jul 2023 09:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92847619FD;
        Fri,  7 Jul 2023 16:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34D4C433C7;
        Fri,  7 Jul 2023 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688747886;
        bh=z5OvZI907J55BnsSh4IUeHhRHonp+m90un+FTNJFTqo=;
        h=From:To:Cc:Subject:Date:From;
        b=D0H7JozZVOTKA59VtoO+1CrvsSSK+Ro30XK0XxVQeSghbcyaOe2myJE67cDySo5Xq
         2LvgVWo/siDjstj7KR/N81gjghLvYn2eaUrO7DVpS70KBQZIF2rGDEu2bc7yFB7sFK
         69KHY8r9MDP8SuS//qMh6ecuA019UbsVXYkKgywL3gUu6avojpp+Ju5n1BglbLSLyk
         2sDZIAa9N5fFFVhzTpKiSWKG0yPAp+rYqHQwZby/IKEgB1wvaolq8T5mqtfme7OTf1
         E+s0PIURqjFllrciTx5FV4EHEkmSi3LD+C+vpNiVxrwzcifBcM6ET7DoZnupCdpCJc
         Pt/FCzUihN98A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] fprobes: Add a comment why fprobe_kprobe_handler exits if kprobe is running
Date:   Sat,  8 Jul 2023 01:38:03 +0900
Message-Id: <168874788299.159442.2485957441413653858.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a comment the reason why fprobe_kprobe_handler() exits if any other
kprobe is running.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://lore.kernel.org/all/20230706120916.3c6abf15@gandalf.local.home/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 75517667b54f..133b31f44945 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -100,6 +100,12 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 		return;
 	}
 
+	/*
+	 * This user handler is shared with other kprobes and is not expected to be
+	 * called recursively. So if any other kprobe handler is running, this will
+	 * exit as kprobe does. See the section 'Share the callbacks with kprobes'
+	 * in Documentation/trace/fprobe.rst for more information.
+	 */
 	if (unlikely(kprobe_running())) {
 		fp->nmissed++;
 		return;

