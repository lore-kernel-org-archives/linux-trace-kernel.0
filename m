Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E7FCA0FE6
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  1 Sep 2023 15:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350136AbjIAPMq (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbjIAPMp (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D7F10F9
        for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693581069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6plOE05wtAOE2J15C66Bubu1b7lLRziMMVbmgfVPQXg=;
        b=WlBoMqKaaGl2WrCpx6wxlw9VcYCcUAOpBCEgGx0V615TEx5XMGp/cQrruOlAseghLsz2Cs
        Hu06hBi/bsEB5sExB4l6ieeaGBrg43mNPktYzLaD6QcFbWvRciHguaDw2ieiDtV5XNmHRV
        meXGMDeLZTEhwqg+KjrwlDy6lEFtmiI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-BSsqkJlyMnaqU7tQ4Cxcdw-1; Fri, 01 Sep 2023 11:11:06 -0400
X-MC-Unique: BSsqkJlyMnaqU7tQ4Cxcdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C716381CC0B;
        Fri,  1 Sep 2023 15:11:05 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.39.193.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE7262012F37;
        Fri,  1 Sep 2023 15:11:04 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 4/4] tracing/filters: Fix coding style issues
Date:   Fri,  1 Sep 2023 17:10:39 +0200
Message-Id: <20230901151039.125186-5-vschneid@redhat.com>
In-Reply-To: <20230901151039.125186-1-vschneid@redhat.com>
References: <20230901151039.125186-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Recent commits have introduced some coding style issues, fix those up.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/trace/trace_events_filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 09b4733a2933d..33264e510d161 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1360,7 +1360,7 @@ int filter_assign_type(const char *type)
 			return FILTER_DYN_STRING;
 		if (strstr(type, "cpumask_t"))
 			return FILTER_CPUMASK;
-		}
+	}
 
 	if (strstr(type, "__rel_loc") && strstr(type, "char"))
 		return FILTER_RDYN_STRING;
@@ -1731,7 +1731,9 @@ static int parse_pred(const char *str, void *data,
 		maskstart = i;
 
 		/* Walk the cpulist until closing } */
-		for (; str[i] && str[i] != '}'; i++);
+		for (; str[i] && str[i] != '}'; i++)
+			;
+
 		if (str[i] != '}') {
 			parse_error(pe, FILT_ERR_MISSING_BRACE_CLOSE, pos + i);
 			goto err_free;
-- 
2.31.1

