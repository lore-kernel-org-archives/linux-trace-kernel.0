Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74939C0015E
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 11 Aug 2023 19:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjHKTZ3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHKTZ3 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032F230DB;
        Fri, 11 Aug 2023 12:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9005E66316;
        Fri, 11 Aug 2023 19:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C74C433C9;
        Fri, 11 Aug 2023 19:25:27 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:25:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Message-ID: <20230811152525.2511f8f0@gandalf.local.home>
In-Reply-To: <20230810123905.1531061-1-zhengyejian1@huawei.com>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 10 Aug 2023 20:39:05 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> When concurrently splice_read file trace_pipe and per_cpu/cpu*/trace_pipe,
> there are more data being read out than expected.

Honestly the real fix is to prevent that use case. We should probably have
access to trace_pipe lock all the per_cpu trace_pipes too.

-- Steve
