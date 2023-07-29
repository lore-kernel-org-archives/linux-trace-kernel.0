Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885C0EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 29 Jul 2023 01:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjG2B2A (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 28 Jul 2023 21:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjG2B1v (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:27:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC084AB
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:27:49 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCRfT6dVyzVjgC;
        Sat, 29 Jul 2023 09:26:09 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 09:27:47 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <cuigaosheng1@huawei.com>
CC:     <linux-trace-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3] ARM: ftrace: remove unused ftrace_graph_caller_old() declaration
Date:   Sat, 29 Jul 2023 09:27:46 +0800
Message-ID: <20230729012746.2714282-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

All uses of ftrace_graph_caller_old() were removed by
commit d3c61619568c ("ARM: 8788/1: ftrace: remove old
mcount support"), so remove the declaration, too.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v3:
- linus.walleij@xxxxxxxxxx -> linus.walleij@linaro.org, thanks!
v2:
- Nothing change, resend, thanks!
v1:
- links: https://www.spinics.net/lists/linux-usb/msg231303.html
 arch/arm/kernel/ftrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index a0b6d1e3812f..0320cfba5b74 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -261,7 +261,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern unsigned long ftrace_graph_call;
 extern unsigned long ftrace_graph_call_old;
-extern void ftrace_graph_caller_old(void);
 extern unsigned long ftrace_graph_regs_call;
 extern void ftrace_graph_regs_caller(void);
 
-- 
2.25.1

