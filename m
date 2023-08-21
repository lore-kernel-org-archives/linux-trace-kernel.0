Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5698DEE4996
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 21 Aug 2023 15:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjHUPRO (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjHUPRO (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D6FF3;
        Mon, 21 Aug 2023 08:17:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65E2B618BF;
        Mon, 21 Aug 2023 15:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40911C433C8;
        Mon, 21 Aug 2023 15:17:11 +0000 (UTC)
Date:   Mon, 21 Aug 2023 11:17:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Introduce pipe_cpumask to avoid race on
 trace_pipes
Message-ID: <20230821111725.4bfbe7c5@gandalf.local.home>
In-Reply-To: <20230819104257.80203c3916509cc9eb9327c1@kernel.org>
References: <20230817115057.1637676-1-zhengyejian1@huawei.com>
        <20230818022645.1948314-1-zhengyejian1@huawei.com>
        <20230818140309.b0a720afa87b05a2b7b27315@kernel.org>
        <20230818094128.7cf1d58b@gandalf.local.home>
        <20230818232301.902ad9319569379ebd7df557@kernel.org>
        <20230818115322.3dfda470@gandalf.local.home>
        <20230819104257.80203c3916509cc9eb9327c1@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 19 Aug 2023 10:42:57 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> >From 92242480285448360c9390a743ea7b3751bb3e61 Mon Sep 17 00:00:00 2001  
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Thu, 17 Aug 2023 14:08:40 +0900
> Subject: [PATCH 1/3] tools/virtio-trace: Ignore EAGAIN error on splice()
> 
> splice() can return EAGAIN error instead of returning 0 size read.
> In that case, wait a while and try to call splice() again.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Bah,

When I pulled in Zheng's patch from patchwork, it included the above
signed-off-by. I was confused to why it added your SoB.

Probably best if we had started this conversation on another thread and
not hijack the discussion about this patch.

-- Steve


> ---
>  tools/virtio/virtio-trace/trace-agent-rw.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

