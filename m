Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3872DC54EBE
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 12 Jan 2023 23:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjALX0d (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 12 Jan 2023 18:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjALX0c (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:26:32 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B9E625CE
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:26:31 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id v6so591388ilq.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YN3h+2e9LlRoJQY+cOQKqTDFq1o3A0FXklNmBBS/AyM=;
        b=LnxiIFu/sY1fEVR8odODwZns74Rl8nliou+v/w6/x1c6VKUkA5bVFR9MH2FVz0cFO/
         eaDPayWxgN7VRO70B8Ha+BLMaSOL9F2CyXmz6/LbWirqKC+f9mgnWEwvamiSaqpWJMXw
         nbztvveZlAWIr0AueERPTiid7jR7CyMbL7CjvEC6OinxhSGuPs2o+0iO/BCOc4p2In89
         ERrXVMSLSo7ejrP5rhobFVpPFiRcUBJNyyMqoBMpvBcDc9lkGDwwNXyo9xmZ0VpC9oJ8
         nLhsMtcOBSp804qg3mdNzSpAgu8vQ2DSnOnQ9f8T6aUwtNRW6Jg/JQaW93cZL9qsAN26
         38QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN3h+2e9LlRoJQY+cOQKqTDFq1o3A0FXklNmBBS/AyM=;
        b=aICJuFB+lVShCSXdasN1mGvKfd8H3FxXO3rjJ+09BvmkI7jMa/k9WDHc0m3PAbCCzJ
         kWyuetWI6MUEjPka1x9I4zvZ3jddL0WvkTCkW8EPuOJ6GywsyutWghjFvJZ0+i+QDdKl
         Zyii41rWjY72aQ1sgBlfelGkk9Zay6lmrbXzB2u8P4rEM/UoW3vs6H9xBXk/iDXDoWgM
         i2LEyTJSJlttoqr6BE/Gn0DH3UqOA2L4znS27cJgwpGoEohnMJPIeAUSaez/jhKHwvwX
         bVgfmM8g9+ERgQv0gy6Lqg2lH0oCY8ROzlBG7bG453Ul7a/zFgWIYuqNc59s4p4z08YM
         8m0w==
X-Gm-Message-State: AFqh2kr0zGNjLs5gWp+H2XcyzQmr7r5qIZXKHAr1pXYgu7jgzmpRBLpb
        vmrjK98dZ1svdFpncjWpJ0jLag==
X-Google-Smtp-Source: AMrXdXv9IgLxOVnLwFFqLWzmkmQcYUw4SLMTSgux4s5U1J6WQ02IqXCVxyo8hYXgISlmjatSk/RpZg==
X-Received: by 2002:a92:cd8d:0:b0:30e:d7f3:216b with SMTP id r13-20020a92cd8d000000b0030ed7f3216bmr2327206ilb.8.1673565990785;
        Thu, 12 Jan 2023 15:26:30 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4a23:5fbb:9bb3:1279])
        by smtp.gmail.com with ESMTPSA id p2-20020a92d682000000b0030ceac941dcsm5578481iln.17.2023.01.12.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:26:30 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:26:27 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] tracing: Add trace_array_puts() to write into
 instance
Message-ID: <Y8CXI1h9hsPeiu6u@google.com>
References: <20230111145636.450953217@goodmis.org>
 <20230111145842.694147820@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111145842.694147820@goodmis.org>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:56:39AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add a generic trace_array_puts() that can be used to "trace_puts()" into
> an allocated trace_array instance. This is just another variant of
> trace_array_printk().
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/trace.h | 13 +++++++++++++
>  kernel/trace/trace.c  | 27 +++++++++++++++++----------
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index 80ffda871749..afe61949e83a 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -33,6 +33,19 @@ struct trace_array;
>  int register_ftrace_export(struct trace_export *export);
>  int unregister_ftrace_export(struct trace_export *export);
>  
> +/**
> + * trace_array_puts - write a constant string into the trace buffer.
> + * @tr:    The trace array to write to
> + * @ip:	   The address of the caller

@ip is not an arg to trace_array_puts(), an can be dropped from the comment.

Other than that, you can add:

Reviewed-by: Ross Zwisler <zwisler@google.com>
