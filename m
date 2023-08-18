Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2B6C7EE24
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 18 Aug 2023 15:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378332AbjHRPxn (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378354AbjHRPxV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C88A4220;
        Fri, 18 Aug 2023 08:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5DF064CE6;
        Fri, 18 Aug 2023 15:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AA1C433C9;
        Fri, 18 Aug 2023 15:53:16 +0000 (UTC)
Date:   Fri, 18 Aug 2023 11:53:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Introduce pipe_cpumask to avoid race on
 trace_pipes
Message-ID: <20230818115322.3dfda470@gandalf.local.home>
In-Reply-To: <20230818232301.902ad9319569379ebd7df557@kernel.org>
References: <20230817115057.1637676-1-zhengyejian1@huawei.com>
        <20230818022645.1948314-1-zhengyejian1@huawei.com>
        <20230818140309.b0a720afa87b05a2b7b27315@kernel.org>
        <20230818094128.7cf1d58b@gandalf.local.home>
        <20230818232301.902ad9319569379ebd7df557@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 18 Aug 2023 23:23:01 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> It uses trace_pipe_raw. I guess if splice(from trace_pipe_raw to virtio-serial)
> returns -1 and errno == EAGAIN, the trace data will be lost?

It shouldn't. If it does, then there's likely a bug. The code will block
and if an interrupt comes in it will return immediately without reading
from the buffer.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace.c#n8262

I don't see where it would return -EINTR and consume data, but I may be
missing something.

-- Steve
