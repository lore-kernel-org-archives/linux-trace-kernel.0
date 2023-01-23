Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5127DC05027
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 24 Jan 2023 00:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjAXANd (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 23 Jan 2023 19:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAXANc (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:13:32 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83A3253C
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:13:31 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 72E35641C65;
        Tue, 24 Jan 2023 00:13:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EA2CF641A23;
        Tue, 24 Jan 2023 00:13:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674519210; a=rsa-sha256;
        cv=none;
        b=p/T0zlJL1blmhy/dwlo2fva1os4LNodX0D7h96/BNA/Rzz16hubyuZMkllwEuZ1vp/sJ2P
        mEzC5sflp4RxnIXZ3R2chEj5DEGK37d2hxj+F84JoNdyYyRl9xxEQAB1FlOqAkDdxd/cPO
        5k1/ZBAPjXhjrX3S9mTS31QycFRYJWxyUqAltzUcXkpRLSCpIy55xhcezXfW5V+Zd+1Ehu
        xgPSjkx8Qf3Lihyvt9H/Nz6DRv8galPhbnULaFVBSU6p5cyM66gjfhDWCDIbUC+1T1VawH
        k7ZWEonW1u5UuFY2ipNdX/WS76Cps58bAKFPBpE6pVgAsakCn8DJT2Z+KgVS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674519210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=uo/w4fk1luLCBuR0M1BTp2rAHIWu6Ng5jQ07fooQoBQ=;
        b=rzULWitDZeo6plkGPsQpmUOL9Aa5ZQfhVcsMGDDEmWF8IVzmlNpQNXL4jiwqpCtSlsTILK
        ZLoRd1NeWTiXfAvE9D7/p1Xfy66efso9R++lUYw1V4htYDLgVBS3CIzQI113Ysa1r2agb2
        2gZ4D/8ugI4SOfkbAyRs83sqyR6JihwSNp6r7FVPBtDrEQUca8Eih6aLunRFPmTYtQ2+t3
        7JpOJO/NxWXTDtdH43Z1glPM2l/BqyuwmAruVNysGUL31Ky8SuJDpJWWxUBmMciOtKWnvf
        kIGwTJhdbTtsvYCbAT7NrjcSvJWai1FT7XFEEQtcH9MeHydEu3Ws26g1z4otrA==
ARC-Authentication-Results: i=1;
        rspamd-7cf955c847-hgtc9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Coil-Eyes: 1df232e721f57139_1674519210206_3605518885
X-MC-Loop-Signature: 1674519210205:2914372810
X-MC-Ingress-Time: 1674519210205
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.45 (trex/6.7.1);
        Tue, 24 Jan 2023 00:13:30 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4P16rT2S1Hz2r;
        Mon, 23 Jan 2023 16:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674519209;
        bh=uo/w4fk1luLCBuR0M1BTp2rAHIWu6Ng5jQ07fooQoBQ=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=cO8AIBg3x1idiBSe8O1IDo6mEhfdrd9B53U4DEcXdN6+kFo4DITCTEICQ0LhWnAm0
         D4oIwAyAItF9ah/b+isS4ag2p5HUL5OBBQ7f76U5loqGSytWcmnw/J0q97yA9chJpT
         oSInz513Fz9HGzWS/n0LzgXnRCa+kKHe5LvTJ/RBvBz4PEMwfzl3GQ+j6k0yUWzsbq
         Mqvdz7wLW1oWf6Rl9NX9EBvTC5+CSfhXRds9RdYw3Iub6JcCOy8vyDglcyYSxdvHD8
         39NSBYmRYmAxEY17rqRcDXwAXhVyqe/fE/ALj+2IGt8a5WBvw7t26Z36GvH6vuoAnC
         rjRDTREX6Qo0A==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     rostedt@goodmis.org, bristot@kernel.org
Cc:     dave@stgolabs.net, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/osnoise: No need for schedule_hrtimeout range
Date:   Mon, 23 Jan 2023 15:46:49 -0800
Message-Id: <20230123234649.17968-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

No slack time is being passed, just use schedule_hrtimeout().

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Found while looking at schedule_hrtimeout users.

 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 94c1b5eb1dc0..2c1175b7d64f 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1540,7 +1540,7 @@ static void osnoise_sleep(void)
 	wake_time = ktime_add_us(ktime_get(), interval);
 	__set_current_state(TASK_INTERRUPTIBLE);
 
-	while (schedule_hrtimeout_range(&wake_time, 0, HRTIMER_MODE_ABS)) {
+	while (schedule_hrtimeout(&wake_time, HRTIMER_MODE_ABS)) {
 		if (kthread_should_stop())
 			break;
 	}
-- 
2.39.0

