Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F3EC27C76
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 21 Jan 2023 14:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjAUObb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 21 Jan 2023 09:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUObb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:31:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03B39B84
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:31:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e3so7124858wru.13
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPeFm3n4Sr3sAHF6AWYd8mgpdZVoIGrZ/cPna3eTTcY=;
        b=bPoGKWT6xsXVJNIZKOTBgctIUYofB3NfhmiwIlGClXZirxMz8mBZX7oH/4DrgHxK8t
         gmWDXlgQE6NSsv6IiAU2Z23na3bTZJb7j4m87QNCahfhpJG2TjnFO3FaYVQQxzbDP7Sh
         jHTZnqYDAQ1POFmVvFjbZ6Jw4YCFE5BdLgeuJQ9bwnS7T8qJLMu7mmcIryECosbDcov2
         XfbB8LuRPMVHP5jARjlt+WWUcSxmmJSfJQf28PP9l+o1GHh5HmfDUdAjf1VBR07eRqyI
         YSnY9uunMNS2Uvhrb3b16h/oc3BZS2Vsj6g8Z/8YCD9Nejy2v8ZGEhlGM5vwoY/6UX6U
         tQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPeFm3n4Sr3sAHF6AWYd8mgpdZVoIGrZ/cPna3eTTcY=;
        b=gKD8wQ9VeTHaw/xrAbPjxbHbDt7hdi2rdxH7hCrggz9Ekj0oUpJsfOa7ss5VSDxpOa
         lV69WTYePGZmnkbjjvuLTq6on8rxRsSU3UmHFaEO7GFXlZnyOjtwdX6ApQGSR3UKUEgz
         JmnmepnPB4J/ap+Eqrt3eYWlbd6pZ1EXTSJPRfKWwRov7nHf7mVlxDs/1nW5qT4IL15H
         UDKTXI7vWI+0DWnpGyoN5wmqEEyjqmy7zHAjfB33GUWNwXuZlHGX4ADxjDhjryEbzGbl
         eF8UjgbsT/2XVExI8vSMA6rOA3TTh6A8l/BE6QJ4slDHLxYR+LecoM/Q09ZuMndr1OXq
         TmZA==
X-Gm-Message-State: AFqh2kqndvZRG2FaOSiKRILiY2w4ycibI5+5aeszC2Yxk7UFpl6GmEJo
        jfpOHboqPOzfTQfXKxagDDs5RVSApsUtBHob
X-Google-Smtp-Source: AMrXdXtunu5LMrKDq+jQfC4rwEpPifHf4o+jr7K7DL5t05rz1b2p2OEcY49VUydhgC6ueu7zaVR5kg==
X-Received: by 2002:a5d:5e85:0:b0:2bb:32bd:1dc0 with SMTP id ck5-20020a5d5e85000000b002bb32bd1dc0mr17120725wrb.58.1674311486439;
        Sat, 21 Jan 2023 06:31:26 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.mpl.intranet (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4588000000b002bdfb97e029sm16314604wrq.19.2023.01.21.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 06:31:25 -0800 (PST)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 1/3] Documentation: kprobetrace: Fix some typos
Date:   Sat, 21 Jan 2023 15:31:08 +0100
Message-Id: <20230121143110.1706962-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121142242.1706081-1-yoann.congal@smile.fr>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

* Uncapitalise tracepoint
* Hyphen in *-based
* Plurals
* fetch-args -> fetchargs
* 2bytes -> 2-bytes
* .. -> .
* arch -> architecture

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 Documentation/trace/kprobetrace.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 08a2a6a3782f0..1eb2c68aa0a71 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -6,16 +6,16 @@ Kprobe-based Event Tracing
 
 Overview
 --------
-These events are similar to tracepoint based events. Instead of Tracepoint,
+These events are similar to tracepoint-based events. Instead of tracepoints,
 this is based on kprobes (kprobe and kretprobe). So it can probe wherever
 kprobes can probe (this means, all functions except those with
 __kprobes/nokprobe_inline annotation and those marked NOKPROBE_SYMBOL).
-Unlike the Tracepoint based event, this can be added and removed
+Unlike the tracepoint-based event, this can be added and removed
 dynamically, on the fly.
 
 To enable this feature, build your kernel with CONFIG_KPROBE_EVENTS=y.
 
-Similar to the events tracer, this doesn't need to be activated via
+Similar to the event tracer, this doesn't need to be activated via
 current_tracer. Instead of that, add probe points via
 /sys/kernel/debug/tracing/kprobe_events, and enable it via
 /sys/kernel/debug/tracing/events/kprobes/<EVENT>/enable.
@@ -68,7 +68,7 @@ Synopsis of kprobe_events
 
 Types
 -----
-Several types are supported for fetch-args. Kprobe tracer will access memory
+Several types are supported for fetchargs. Kprobe tracer will access memory
 by given type. Prefix 's' and 'u' means those types are signed and unsigned
 respectively. 'x' prefix implies it is unsigned. Traced arguments are shown
 in decimal ('s' and 'u') or hexadecimal ('x'). Without type casting, 'x32'
@@ -76,14 +76,15 @@ or 'x64' is used depends on the architecture (e.g. x86-32 uses x32, and
 x86-64 uses x64).
 These value types can be an array. To record array data, you can add '[N]'
 (where N is a fixed number, less than 64) to the base type.
-E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
+E.g. 'x16[4]' means an array of x16 (2-bytes hex) with 4 elements.
 Note that the array can be applied to memory type fetchargs, you can not
 apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
 wrong, but '+8($stack):x8[8]' is OK.)
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out. "ustring" type is an alternative of string for user-space.
-See :ref:`user_mem_access` for more info..
+See :ref:`user_mem_access` for more info.
+
 The string array type is a bit different from other types. For other base
 types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
 as +0(%di):x32.) But string[1] is not equal to string. The string type itself
@@ -120,8 +121,8 @@ space. 'ustring' is a shortcut way of performing the same task. That is,
 
 Note that kprobe-event provides the user-memory access syntax but it doesn't
 use it transparently. This means if you use normal dereference or string type
-for user memory, it might fail, and may always fail on some archs. The user
-has to carefully check if the target data is in kernel or user space.
+for user memory, it might fail, and may always fail on some architectures. The
+user has to carefully check if the target data is in kernel or user space.
 
 Per-Probe Event Filtering
 -------------------------
-- 
2.30.2

