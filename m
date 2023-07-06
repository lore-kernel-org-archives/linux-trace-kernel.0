Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B1EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Jul 2023 05:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjGFFul (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Jul 2023 01:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFFuk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:50:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45604E6E
        for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Jul 2023 22:50:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a573cso2813725e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Jul 2023 22:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688622638; x=1691214638;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyEHwZJMKPpKnL4OmLe3gTQE6H1sBJKChjkNoj0yKM8=;
        b=eqA4fdtSduT2vdL/YyH2FwLkF323QqPBw4ZxLuYvFvfbb/tWUGMl4IFirO0D1WUuAA
         dCLuErnA2014Eheb0qwPht26N14Sl+ogKy0OJ/Ke+rh+s8e+z/LbuBCOGlgNSX4V55xM
         eihLvaMgVLb/HeRPG99w7FmZyXxTNupTvQ9ynToe+3SXU87q9GnDq58RmrnW8YrRnGnS
         FoUmCq8tROA7kVjmchjY4CJgklArNszxKC7G3+io+WsxpyAcA8QaqxE0nVPg+hY+mdGb
         NPDgScqBMa7zSE9HHqsrVhpW7TRLiJQm/KyDZPExVgUvahdbx54FPkLphBLdt4OKbNp2
         VQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622638; x=1691214638;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyEHwZJMKPpKnL4OmLe3gTQE6H1sBJKChjkNoj0yKM8=;
        b=gyJ2wKMpfTdQekD+1yQJ3BwgEGJB7hxsGV/77nwzSKO291Huds+UFNlb+Q5Ibd3Zvu
         elMR6tuDfj9cr410UWtNGtZWAQ4xCfJeIzRaji6XXJboK2oHHiPCodV8a/XrjZNvNugs
         gi5rGl+hO4kOQNgdzJMHCInoya2Wx+Ly9jFUZ2Eg+fc35Y0EASNhIqPSvmdvU0dhuQRM
         vQ5H05WjBAM9T31FUJB5TIRJkJGA0UUETHCMuvwNhO55dqJzAtxCAbJE9Fw/tHY6GJhR
         vAxE72vjoXUkTbAU/T7aWmkLyYCBZbIM9v3G69uKvXt5uG2wOXyFq2atZParyscfZsP5
         hl4g==
X-Gm-Message-State: ABy/qLbjTAG8GmPtnV/buc5DkucwsSWqeIQ2cnPZB54jE1HS2YqzM4t2
        2rsxQeWkFjcoj0tn1bnYM9ep0Q==
X-Google-Smtp-Source: APBJJlEZNbEHxRY8Ap8LzIFF13T16PP6OMWcRhgbVLz4gpbheBhblDKf6DH2oLk6E2yX0jrC34RYGg==
X-Received: by 2002:a05:600c:21c4:b0:3fb:ab7d:ad95 with SMTP id x4-20020a05600c21c400b003fbab7dad95mr517991wmj.4.1688622637698;
        Wed, 05 Jul 2023 22:50:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003fbda7d2d41sm3956031wmj.48.2023.07.05.22.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 22:50:35 -0700 (PDT)
Date:   Thu, 6 Jul 2023 08:50:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     rostedt@goodmis.org
Cc:     linux-trace-kernel@vger.kernel.org
Subject: [bug report] x86/ftrace: Make function graph use ftrace directly
Message-ID: <8d9bf4bb-693a-4368-8db1-9de1b80a33e1@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hello Steven Rostedt (VMware),

The patch 0c0593b45c9b: "x86/ftrace: Make function graph use ftrace
directly" from Oct 8, 2021, leads to the following Smatch static
checker warning:

	kernel/trace/trace_selftest.c:769 trace_graph_entry_watchdog()
	warn: sleeping in atomic context

kernel/trace/trace_selftest.c
    765 static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace)
    766 {
    767         /* This is harmlessly racy, we want to approximately detect a hang */
    768         if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
--> 769                 ftrace_graph_stop();

This is a sleeping function.

    770                 printk(KERN_WARNING "BUG: Function graph tracer hang!\n");
    771                 if (ftrace_dump_on_oops) {
    772                         ftrace_dump(DUMP_ALL);
    773                         /* ftrace_dump() disables tracing */
    774                         tracing_on();
    775                 }
    776                 return 0;
    777         }
    778 
    779         return trace_graph_entry(trace);
    780 }

The call tree is:

prepare_ftrace_return() <- disables preempt
-> function_graph_enter()
   -> trace_graph_entry_watchdog()

The ftrace_test_recursion_trylock() function disables preemption.  The
trace_graph_entry_watchdog() function is called as a pointer so it's
the ftrace_graph_entry() call.

regards,
dan carpenter
