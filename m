Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B86FC3DA66
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 18 Aug 2023 01:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357042AbjHRBn7 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 17 Aug 2023 21:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357025AbjHRBnf (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D372723;
        Thu, 17 Aug 2023 18:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8397263AC6;
        Fri, 18 Aug 2023 01:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B868C433C8;
        Fri, 18 Aug 2023 01:43:32 +0000 (UTC)
Date:   Thu, 17 Aug 2023 21:43:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <laijs@cn.fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>
Subject: Re: [RFC PATCH] tracing: Introduce pipe_cpumask to avoid race on
 trace_pipes
Message-ID: <20230817214337.48de3ab8@gandalf.local.home>
In-Reply-To: <12d197d9-99c1-4ffc-a1b1-f7e42a2d43d6@huawei.com>
References: <20230816152308.5f887721@gandalf.local.home>
        <20230817115057.1637676-1-zhengyejian1@huawei.com>
        <20230817101331.21ab6b33@gandalf.local.home>
        <12d197d9-99c1-4ffc-a1b1-f7e42a2d43d6@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 18 Aug 2023 09:38:27 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> >> from being opened by multiple people at the same time.  
> > 
> > I'm fine with the CPU mask.  
> 
> Hi, Steve, if a task open a trace_pipe file, then concurrently read it
> with multiple threads, then the read race problem may also happen, this
> patch will not prevent this case.

I was thinking this too and started to look at a fix for that when I
realized, it shouldn't be a problem. The open creates the iterator and it's
attached to the file descriptor. All the threads will be using the same
file descriptor, which means they will be using the same iterator. That
iter->ent from one thread will be still valid for the next thread.

-- Steve


> 
> Do we need to consider this case? Or just tell user not to do like this
> through some documents?
