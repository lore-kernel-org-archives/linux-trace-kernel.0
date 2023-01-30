Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733CDC54EAA
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 30 Jan 2023 18:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjA3SUF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbjA3STv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:51 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC533CE3F
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:47 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id k12so451765ilv.10
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFIqgVTcMIkkVJ93WrMRe7xk5hOeBy6iHYq/c2dnAus=;
        b=BOXkMcmV7Kg852E/lMV7VPR9bxQHwZJ1VHOqpllPBP1SPusf47QZzPxzqalItFJl+E
         h6nY4dhdr/HYhYO0zqlz9dGhFYDJIhs8qJoibnsTiBOqLYIthHpGfkJc3OH6cH/UfAL+
         CYsejaXnNlcgjAXUTVlZ9/Ibodd9dneGfTxTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFIqgVTcMIkkVJ93WrMRe7xk5hOeBy6iHYq/c2dnAus=;
        b=F+sNaQY+BgNIH0pqRpFoCC8QmbUQN4zm67BNgYC/RyZ/2PTxRKw84ir8BLeH1kIeBO
         UFmosfgv1Zmv3ZGSnIfND+U7O+BTNnzpBNJGxSA1FJcXl85jVntBHwWwlVSQolHSSouC
         O8i3SDAgvCIGtJyBSZ2wCQVD7STx/5O1iAC/gbC1RbPbr6MOocsY31T1lUV7ptBYFeHO
         QX7i/1PCCGaK3bypMnHQp4bCEJW93VUQQtoTSynoRaTTvIRUWTsykmcTtbbtduLJO6nh
         uOAXICyM0hYhir6AasFrhp99xFDzSzEtlAWpj5Cv0HpqMRYlKtmy2VNmRd63lwUjOUkr
         nQSA==
X-Gm-Message-State: AO0yUKWoM4cWPylBh1cwiZmwX6iFl9Y7yFax3d16MwWZkuFPnf6IaadE
        jyKYySUaYlBcSyxji7IE03262A==
X-Google-Smtp-Source: AK7set8M9u01+a5gnWBWumGHfQfWw+OV0WvXprCsJSsUeNjRozqjV2EnxgHWdTQxe8fVrDNFccalzA==
X-Received: by 2002:a92:b301:0:b0:310:be1e:78e6 with SMTP id p1-20020a92b301000000b00310be1e78e6mr7959753ilh.26.1675102786604;
        Mon, 30 Jan 2023 10:19:46 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:46 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 8/9] leaking_addresses: also skip canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:14 -0700
Message-Id: <20230130181915.1113313-9-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
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
2.39.1.456.gfc5497dd1b-goog

