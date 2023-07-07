Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65761EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  7 Jul 2023 17:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjGGRYm (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjGGRY2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89EA2699
        for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688750554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thuwuWrD51j/PCw+xxhEtLF5o2/5RQb/+JUh6XwKh6w=;
        b=AYbPz8m+/5r5XlQxuV4Zrr+P+eEWdnZsNgtCtDVsyzJyiB+SRYkX6iPbMe9S8NN5wvzKFn
        /0kQGKD8s7OjY81sAdAOLWElyAb8YXIhXJEivMM9AL2Bk06AGsnvJYRaI0spbd9sC9cYzN
        +4+lS9T02soHRGO+fhwDwUxrJFiW+ec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-QkjpcIHqOhKLMUo-kwZLvA-1; Fri, 07 Jul 2023 13:22:28 -0400
X-MC-Unique: QkjpcIHqOhKLMUo-kwZLvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47760858EED;
        Fri,  7 Jul 2023 17:22:28 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03FA11454142;
        Fri,  7 Jul 2023 17:22:26 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2 9/9] tracing/filters: Document cpumask filtering
Date:   Fri,  7 Jul 2023 18:21:55 +0100
Message-Id: <20230707172155.70873-10-vschneid@redhat.com>
In-Reply-To: <20230707172155.70873-1-vschneid@redhat.com>
References: <20230707172155.70873-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Cpumask, scalar and CPU fields can now be filtered by a user-provided
cpumask, document the syntax.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/trace/events.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index f5fcb8e1218f6..34108d5a55b41 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -219,6 +219,20 @@ the function "security_prepare_creds" and less than the end of that function.
 The ".function" postfix can only be attached to values of size long, and can only
 be compared with "==" or "!=".
 
+Cpumask fields or scalar fields that encode a CPU number can be filtered using
+a user-provided cpumask in cpulist format. The format is as follows::
+
+  CPUS{$cpulist}
+
+Operators available to cpumask filtering are:
+
+& (intersection), ==, !=
+
+For example, this will filter events that have their .target_cpu field present
+in the given cpumask::
+
+  target_cpu & CPUS{17-42}
+
 5.2 Setting filters
 -------------------
 
-- 
2.31.1

