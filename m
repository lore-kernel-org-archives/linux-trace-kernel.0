Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5104C0015E
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 14 Jul 2023 20:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjGNUeC (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 14 Jul 2023 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjGNUeA (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:34:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F25735B1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:33:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so1574216b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1689366838; x=1691958838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAeO44fspvwOoH7nvzffkhGKK/SjhUPUJKy34qDXlFM=;
        b=dCwKT0VSj3simmiqlpl48yZ6sLmUEEhlefo8jBCedH1UDexzmM/7NMzp3My2D7jvsJ
         IlfEuWV9Gi4VeNPn8YTXhmZ66NCQtspqQM1Uyx/zzvWd8Q0lAcMqdh18ws+dk5oG/XBn
         HSTk0cNgum3FrP/ED5FvYjhBPux/oQJkDlOjw5H0GswLZByKXgPqnjR/ZMzZJ4IAOeOR
         3k7XN/n3X5rxyRsjVbLwJoFJ+t+75tO2tXOycgMzlhEFbJf+9PTSglFxmMNhzQwiS3ps
         fdJaqowXB62u/V+KuC95ulJpvzk4DY/LUWNHbfy688d2NKIKqFJzLEwbbRCaxGR052kn
         Ia+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689366838; x=1691958838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAeO44fspvwOoH7nvzffkhGKK/SjhUPUJKy34qDXlFM=;
        b=LaLikJcvqK91ToATqfHwjnR4ne1A+63IDwScqXOz6bKugFskFOAnTIXNO0JTK1Esv0
         a6paXHUQwVqJcdJKDKSM6KOOoW+B8hY4XWK3IqrIU7QqZefOovfqxHNKXiliX77B7oAV
         D/096SwHiLeejnxt23uSRWeJvGFStrEFurRMruyRsRdR5LSNeMYSCkJ3S8XLwSOiwbwl
         wgg9Qe+1zZVh4gPIuiICuFTlB20tEq0kmdWEno0vVmAtaUi2MRdsVhYdzN7ISuVrKPud
         Nn1/wPpiHj+KYo3nbylkRZ9e51fes0uCuSgZPxhwqbHkKElUo+YQHnHsUBko7ze3pLLC
         //hg==
X-Gm-Message-State: ABy/qLaApHL8oMSf2r0WEO2IZstXZSsxdIDg6G6hLmZt3XS72cr9geq2
        iJLKBtUqf2B8k9uimWOYXO5OCA==
X-Google-Smtp-Source: APBJJlElOmdfj8g8K9Zrqqt5arZ20c5fArBaKq/JVCRrKXIJ317zcGZOY+Z3T4f4tEKlm322ZI7vUw==
X-Received: by 2002:a05:6a00:190b:b0:66a:2ff1:dee4 with SMTP id y11-20020a056a00190b00b0066a2ff1dee4mr5554905pfi.2.1689366837881;
        Fri, 14 Jul 2023 13:33:57 -0700 (PDT)
Received: from gaia.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id m13-20020aa78a0d000000b006828ee9fa69sm7525951pfa.206.2023.07.14.13.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 13:33:57 -0700 (PDT)
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     mhiramat@kernel.org
Cc:     Mohamed Khalfella <mkhalfella@purestorage.com>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v2] tracing/histograms: Return an error if we fail to add histogram to hist_vars list
Date:   Fri, 14 Jul 2023 20:33:41 +0000
Message-Id: <20230714203341.51396-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a9ae750e-5ea5-ff07-d031-51f4abefb89d@web.de>
References: <a9ae750e-5ea5-ff07-d031-51f4abefb89d@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Commit 6018b585e8c6 ("tracing/histograms: Add histograms to hist_vars if
they have referenced variables") added a check to fail histogram creation
if save_hist_vars() failed to add histogram to hist_vars list. But the
commit failed to set ret to failed return code before jumping to
unregister histogram, fix it.

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

