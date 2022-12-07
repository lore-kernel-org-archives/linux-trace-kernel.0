Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F023EC352A1
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  7 Dec 2022 09:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLGJQc (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 7 Dec 2022 04:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiLGJP6 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:15:58 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA29331EC6;
        Wed,  7 Dec 2022 01:15:09 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NRs6f6tVgz15MwZ;
        Wed,  7 Dec 2022 17:14:18 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 17:15:07 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <zanussi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] tracing: Fix issue of missing one synthetic field
Date:   Wed, 7 Dec 2022 17:15:57 +0800
Message-ID: <20221207091557.3137904-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The maximum number of synthetic fields supported is defined as
SYNTH_FIELDS_MAX which value currently is 64, but it actually fails
when try to generate a synthetic event with 64 fields by executing like:

  # echo "my_synth_event int v1; int v2; int v3; int v4; int v5; int v6;\
   int v7; int v8; int v9; int v10; int v11; int v12; int v13; int v14;\
   int v15; int v16; int v17; int v18; int v19; int v20; int v21; int v22;\
   int v23; int v24; int v25; int v26; int v27; int v28; int v29; int v30;\
   int v31; int v32; int v33; int v34; int v35; int v36; int v37; int v38;\
   int v39; int v40; int v41; int v42; int v43; int v44; int v45; int v46;\
   int v47; int v48; int v49; int v50; int v51; int v52; int v53; int v54;\
   int v55; int v56; int v57; int v58; int v59; int v60; int v61; int v62;\
   int v63; int v64" >> /sys/kernel/tracing/synthetic_events

Correct the field counting to fix it.

Fixes: c9e759b1e845 ("tracing: Rework synthetic event command parsing")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index c3b582d19b62..67592eed0be8 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1282,12 +1282,12 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 				goto err_free_arg;
 			}
 
-			fields[n_fields++] = field;
 			if (n_fields == SYNTH_FIELDS_MAX) {
 				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
 				ret = -EINVAL;
 				goto err_free_arg;
 			}
+			fields[n_fields++] = field;
 
 			n_fields_this_loop++;
 		}
-- 
2.25.1

