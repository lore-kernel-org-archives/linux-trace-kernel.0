Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AC9EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  3 Jul 2023 03:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGCDjt (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 2 Jul 2023 23:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCDjs (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:39:48 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 60B23123;
        Sun,  2 Jul 2023 20:39:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id C32586091588A;
        Mon,  3 Jul 2023 11:39:37 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernel:=20kprobes:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20ret?=
Date:   Wed,  5 Jul 2023 04:10:56 +0800
Message-Id: <20230704201056.3352-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ec50f9f380c1..a009c8ccd8ea 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2692,7 +2692,7 @@ void kprobe_free_init_mem(void)
 
 static int __init init_kprobes(void)
 {
-	int i, err = 0;
+	int i, err;
 
 	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
-- 
2.18.2

