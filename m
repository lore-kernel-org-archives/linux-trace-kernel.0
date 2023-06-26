Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2EDEB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 26 Jun 2023 13:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFZNf6 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 26 Jun 2023 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFZNf5 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:35:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534E10DD
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:35:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e742a787so1506925f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687786549; x=1690378549;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzHcQlrS80lsHOQlbumDYqs3SB44sq4Hj325/8aYHmU=;
        b=lrV0OmdMM976qt5qrTcrNqSYxO4k7sXK7LbD/Cfmk8TcrI9nwT8w8l0wwAg3HFsEQz
         DkweIkdiv/eIAAO78Fm31XQsv7GTV3K5sCNq8cD9lS/oKJOdbWetLjPPVpvcS83Zw5FQ
         v0yq2HdPwRwphrULEtFlkO8VcgozS4DDXjCZL7Tq34TPky60FGA6tkG8SbTRZqgyD2DP
         RTnBxqNXCP/bOAXWphpVQ+5dkt0E/QNuRIzvFVhl2CdrRMO7O1Yq8jYLVdww0cQGcD20
         PoGal9jPyxLA4RL89TNS+k1cKw/PH90rqxecLQ6WvB2MuypyfsYi9ygOLhCxURCUGccV
         dbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687786549; x=1690378549;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzHcQlrS80lsHOQlbumDYqs3SB44sq4Hj325/8aYHmU=;
        b=RJWWr3KhFH5re1qsQ8wmMJ8IavenFtFN853pJvjjeuSZsCla++T7ZHt6OGuiAunJjm
         ARMeF+UaDeqrvsoZCvrljhM72r2mipGlfUQkwGtLYmLzLbqEyO8SyUywWiNatQW0vEJT
         7NPSw16HMDn/68jGwWHcfvFjm9Al8B/MJIHzSEy4NuDWTQObYc0018LBLiF+aDmvlwqF
         nfGk+VPAn1cp7FS669qjo7U1jIoEb11sQqTp84INV+ElUCZqeXolTK0TEZKFY7CATgzB
         H6DBUD79OqivWM/bTUMN4ufU6dWaJP4pwRmExs9mbmu4IB0tkcAUApEey0dZoyCKx+ph
         PoJA==
X-Gm-Message-State: AC+VfDyhH+adDYC1IZHxginMIwim/7LavIfxeaz5F4gyXcAo61GRs9ca
        FoXZeC9WxzK9xmJ9eZJ53wV1pA==
X-Google-Smtp-Source: ACHHUZ5YfJzBWaBG7gIfZtGZv0EhEYLxuFTJGGJmyp2PUJnzgePbCLY45G6Q04bMwsYBYNVg8b9Xjg==
X-Received: by 2002:a5d:6585:0:b0:311:281e:ad3c with SMTP id q5-20020a5d6585000000b00311281ead3cmr23543091wru.28.1687786549056;
        Mon, 26 Jun 2023 06:35:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c210600b003fafe32c8f6sm1534855wml.10.2023.06.26.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 06:35:47 -0700 (PDT)
Date:   Mon, 26 Jun 2023 16:35:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [RFC] tracing: Cleanup the correct ep in enable_trace_eprobe()
Message-ID: <72b05526-4dda-430a-b4ca-2ee4f26f2185@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

If enable_eprobe() function fails, then we call  disable_eprobe() on the
"ep" that failed.  That doesn't feel right.  Shouldn't we
call disable_eprobe() on the previous "ep" instead?  Or even better on
all the previous eps (but I don't know how to do that)...

This patch is not tested at all.  I'm mostly sending it as a kind of
bug report.  If this patch is correct or the fix is simple enough for
an absolute moron to fix it then I can probably do that.  But if it's
something I'm too stupid to handle then could you just give me reported
by credit?  (That is the solution I really would prefer).

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/trace/trace_eprobe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index b5181d690b4d..29de54347b8c 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -640,8 +640,8 @@ static int disable_eprobe(struct trace_eprobe *ep,
 static int enable_trace_eprobe(struct trace_event_call *call,
 			       struct trace_event_file *file)
 {
+	struct trace_eprobe *ep, *prev = NULL;
 	struct trace_probe *pos, *tp;
-	struct trace_eprobe *ep;
 	bool enabled;
 	int ret = 0;
 
@@ -666,13 +666,13 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
-		enabled = true;
+		prev = ep;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled)
-			disable_eprobe(ep, file->tr);
+		if (prev)
+			disable_eprobe(prev, file->tr);
 		if (file)
 			trace_probe_remove_file(tp, file);
 		else
-- 
2.39.2

