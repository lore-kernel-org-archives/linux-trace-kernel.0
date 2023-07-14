Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30745EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 14 Jul 2023 19:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjGNTWX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 14 Jul 2023 15:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjGNTWW (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:22:22 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1681FC0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:22:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so2303387a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1689362540; x=1691954540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MAy1Nmg9Ap1Qe0UwHvT/6xtuWqD4pHgiKYUbjAYyU40=;
        b=WKnOfHWdVmhkN7isgvYOXqKox4Cd1GAlUg7TbK46LrTxhFBYsUk2PsvxTqbrJF1Ff5
         XohvYMV2xNdZma3khBnSe4bvrxmxBp8PDZtZyJiMmv388jnhJh4d6vtfgUso1yxTFXuo
         HQdxTU43e71ouoVt5V45Q694F3sdAVn9Tv26recHjyLmxCp3XDUHSZP3DFDSqXELFtOT
         9F9kae8R2iyfvLFnajADd66G8hiB1E66qKA4ZjHQZZeIe4Z3GtG5zsM6pNxP5vPXNZ/Q
         18laIQw0NlAfhBmUg13pNWWZN2JCa8p1cGdhWld5u9Oq1BrFKU8zYFQYRuAcwoItbLSr
         oYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689362540; x=1691954540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAy1Nmg9Ap1Qe0UwHvT/6xtuWqD4pHgiKYUbjAYyU40=;
        b=OYhbENBzlGiHEcBSBcmea/8U3k4AI61jH9fWulznXcnVH9cU5gD9QnDonwWrvhmUSQ
         64gRyYgEKHUqliGnd78xlPGWwHtkWiE2PuGGV1xgvd57iwf0c3067py9pxFGHNIkNsrR
         BLnVmDbsZ/WkdML3nCtgL+4lDmKC7LJXJxr+DAT54WwGRIvSUTOcEd2JT0aU43WCCwQu
         AqoiTHEPC1NLZvD/Fetet5bgSJkHoNE/c5DB+llfle4LUKUYlMaR5gyiGKZIaaQlkjcg
         fT76hpHdAu+T9a6obJr1pdyI0c8eFn/oCQ9z8pmghKonjnQZBHGgMNvGb6oXS7QUUJbi
         z81A==
X-Gm-Message-State: ABy/qLb0KoEPKEKKMl+alZ9GqfG6FV6WCB9zE8D8LD21mekJIpku+5PY
        r399H4pXZrZG2ljBgblb8UYaCA==
X-Google-Smtp-Source: APBJJlFHW1hxE0Y+jKVjsjwsoL2NoUjnUmgyrdOBUsowtg6aP6QU8U85OoEZ7AvpE/BQV8qu1bgn/w==
X-Received: by 2002:a17:90a:43c6:b0:265:780e:5edc with SMTP id r64-20020a17090a43c600b00265780e5edcmr4957528pjg.10.1689362539885;
        Fri, 14 Jul 2023 12:22:19 -0700 (PDT)
Received: from gaia.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090a199400b00263ba6a248bsm1520537pji.1.2023.07.14.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:22:19 -0700 (PDT)
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     mkhalfella@purestorage.com
Cc:     stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] tracing/histograms: Return an error if we fail to add histogram to hist_vars list
Date:   Fri, 14 Jul 2023 19:21:43 +0000
Message-Id: <20230714192143.3656-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

If the code fails to add histogram to hist_vars list, then ret should
contain error code before jumping to unregister histogram.

Cc: stable@vger.kernel.org
Fixes: 6018b585e8c6 ("tracing/histograms: Add histograms to hist_vars if they have referenced variables")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c8c61381eba4..d06938ae0717 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6668,7 +6668,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		goto out_unreg;
 
 	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		if (save_hist_vars(hist_data))
+		ret = save_hist_vars(hist_data);
+		if (ret)
 			goto out_unreg;
 	}
 
-- 
2.34.1

