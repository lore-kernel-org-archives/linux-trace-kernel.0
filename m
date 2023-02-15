Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4548AC636D4
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Feb 2023 22:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjBOWeO (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjBOWeD (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:34:03 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB2930199
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:01 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id b9so197758ila.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+WvHGj+U9hKhpX1MO7CbT0bAOa+eFHb7XRSNPNylZ8=;
        b=nQZZwoOAYpjgtW8gOVskWl1KV7dhHa7P+KU0NTAeSzYeCbd4NkPHKC92/aJKS1V+Am
         RCLr9IRTt50cDY8azwnYsOUdGAAuCop3Q5tJoOPqlpZN38n8FaI9/CsX5tWF7rbkVew9
         faXxQZYh9z2g6xsVrP7Vr51SLummS4/+kG4pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+WvHGj+U9hKhpX1MO7CbT0bAOa+eFHb7XRSNPNylZ8=;
        b=vltYcx28r0bOshFf1z0IT/WRPSWlxOWpYs3iH3f0lHoLh4i2hXzOF5YLuvkuUWMZDS
         HwwClaM5+dHyFSQnuJk0BNLdrdUnaDI8F+XWUzVllt7B7TXK6ucspWmCwPe0+k8r4ch4
         yJqZOZyYlMxeRkdm9AIiXptG+rA5TDuCOzFXIEBaU1fwu+nZMUaoumbj8/gvHqBrkvAH
         Gxjvq6TpA4gUZLH15pnl+6hPkPzdcOLJGJhGZRW1DU3MMowefVbE4ut+LhI1rUnZqmje
         9w4SPU5HKRD+jnS2W7YevLCVI4vTgg5c/y8FuUeo6Pr09xqpeggK61pferpJD+xiE3cL
         NsSg==
X-Gm-Message-State: AO0yUKUYYR+Kr9CcZSwJmNyPcP1B49R8MmS34F1PddynpiaHGXwv2zHd
        DiK2HSFEC1cih+4tjsPfewpLsw==
X-Google-Smtp-Source: AK7set+EMfXkBaB31iKQyYe/+Wg5XHQlwKLorA+RovqRpO3jD7TgVAfAJEZ+djN0XoHF3I5aIbY59w==
X-Received: by 2002:a05:6e02:214c:b0:310:f912:5a68 with SMTP id d12-20020a056e02214c00b00310f9125a68mr121487ilv.3.1676500441191;
        Wed, 15 Feb 2023 14:34:01 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:6299:179b:a6e4:be59])
        by smtp.gmail.com with ESMTPSA id b15-20020a92c14f000000b003141eddd283sm1131489ilh.22.2023.02.15.14.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:34:00 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 5/6] tools/virtio: use canonical ftrace path
Date:   Wed, 15 Feb 2023 15:33:49 -0700
Message-Id: <20230215223350.2658616-6-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
In-Reply-To: <20230215223350.2658616-1-zwisler@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

A few spots in tools/virtio still refer to this older debugfs
path, so let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/virtio/virtio-trace/README        |  2 +-
 tools/virtio/virtio-trace/trace-agent.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/virtio/virtio-trace/README b/tools/virtio/virtio-trace/README
index b64845b823ab..cea29a2a4c0a 100644
--- a/tools/virtio/virtio-trace/README
+++ b/tools/virtio/virtio-trace/README
@@ -95,7 +95,7 @@ Run
 
 1) Enable ftrace in the guest
  <Example>
-	# echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+	# echo 1 > /sys/kernel/tracing/events/sched/enable
 
 2) Run trace agent in the guest
  This agent must be operated as root.
diff --git a/tools/virtio/virtio-trace/trace-agent.c b/tools/virtio/virtio-trace/trace-agent.c
index cdfe77c2b4c8..7e2d9bbf0b84 100644
--- a/tools/virtio/virtio-trace/trace-agent.c
+++ b/tools/virtio/virtio-trace/trace-agent.c
@@ -18,8 +18,9 @@
 #define PIPE_DEF_BUFS		16
 #define PIPE_MIN_SIZE		(PAGE_SIZE*PIPE_DEF_BUFS)
 #define PIPE_MAX_SIZE		(1024*1024)
-#define READ_PATH_FMT	\
-		"/sys/kernel/debug/tracing/per_cpu/cpu%d/trace_pipe_raw"
+#define TRACEFS 		"/sys/kernel/tracing"
+#define DEBUGFS 		"/sys/kernel/debug/tracing"
+#define READ_PATH_FMT		"%s/per_cpu/cpu%d/trace_pipe_raw"
 #define WRITE_PATH_FMT		"/dev/virtio-ports/trace-path-cpu%d"
 #define CTL_PATH		"/dev/virtio-ports/agent-ctl-path"
 
@@ -120,9 +121,12 @@ static const char *make_path(int cpu_num, bool this_is_write_path)
 	if (this_is_write_path)
 		/* write(output) path */
 		ret = snprintf(buf, PATH_MAX, WRITE_PATH_FMT, cpu_num);
-	else
+	else {
 		/* read(input) path */
-		ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, cpu_num);
+		ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, TRACEFS, cpu_num);
+		if (ret > 0 && access(buf, F_OK) != 0)
+			ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, DEBUGFS, cpu_num);
+	}
 
 	if (ret <= 0) {
 		pr_err("Failed to generate %s path(CPU#%d):%d\n",
-- 
2.39.1.637.g21b0678d19-goog

