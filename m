Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF2C6FA9D
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Feb 2023 22:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjBOWeF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBOWeB (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:34:01 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E19637F30
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:00 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id k14so160916ilo.9
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glq2V86DV/XIT2xAdhHc3LZ7W3YqMn+eHqv8u2YnMs8=;
        b=jafmjIUSQwdQGTkpdGWZZjLCzunKS2ryf5YEJI/DkWCeRLKgq8RyQv+/2tSq6zDttr
         rNoW4TRxgKUpe54vqM9AmNg/j0o3A4bx6wyEwYY3ExHKfOb2x3hOjUSA1EotT0Ja27nr
         XbLB7Oz5APUOQyujdvvGe/cLKSqUWM0d9BXho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glq2V86DV/XIT2xAdhHc3LZ7W3YqMn+eHqv8u2YnMs8=;
        b=lHnzxQaRqoqZgEmfZB0ByJFq9jjsIc8+CWCTkrldGlfszm9HfH3n41zKsOlDIT/oU4
         YZe9NxH4lV661k8EIVVrEmqu83PRN997zSRRZ47o5ceOeMyIr8YS2RJ2JEavYyzz6OJn
         4os1W3ISf+TTmCCdMzIP9Xq6kc0D188TXxKpEG9bBFE+XKl6g7KevMsS63dY1CuIegHd
         gCsKb02vM6bdLQH8qoSPFiez4ii4OHnnduraRLLYKZi8pHvB6K/EtJsSKYY4QzcLNeBe
         YDZavyIbHK81bB+RABLA1c2jlMCEBRqbvEhvmPMpLokdi41jXDu2+W1sk6ReN9VsyxY0
         PP8A==
X-Gm-Message-State: AO0yUKW4S/Q3SvOwnb4avdxam8r1WPrNbA4DXO3Ldy8UB2yaXZdAQMoQ
        KDxkZbfQq/ZlTIGP+n4yPur5Cw==
X-Google-Smtp-Source: AK7set9qLvATTMAF3X5InVYtcDXlTGsbfdkd029j3+Afaa3eJzjf8D8MQHpdxM9eNj5oz98WH5ot0A==
X-Received: by 2002:a05:6e02:1b08:b0:314:1aec:c7a9 with SMTP id i8-20020a056e021b0800b003141aecc7a9mr3730923ilv.23.1676500440035;
        Wed, 15 Feb 2023 14:34:00 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:6299:179b:a6e4:be59])
        by smtp.gmail.com with ESMTPSA id b15-20020a92c14f000000b003141eddd283sm1131489ilh.22.2023.02.15.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:33:59 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-hardening@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 3/6] leaking_addresses: also skip canonical ftrace path
Date:   Wed, 15 Feb 2023 15:33:47 -0700
Message-Id: <20230215223350.2658616-4-zwisler@google.com>
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

scripts/leaking_addresses.pl only skipped this older debugfs path, so
let's add the canonical path as well.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Acked-by: Tycho Andersen <tycho@tycho.pizza>
---
 scripts/leaking_addresses.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 8f636a23bc3f..e695634d153d 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -61,6 +61,7 @@ my @skip_abs = (
 	'/proc/device-tree',
 	'/proc/1/syscall',
 	'/sys/firmware/devicetree',
+	'/sys/kernel/tracing/trace_pipe',
 	'/sys/kernel/debug/tracing/trace_pipe',
 	'/sys/kernel/security/apparmor/revision');
 
-- 
2.39.1.637.g21b0678d19-goog

