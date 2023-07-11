Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D304EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 11 Jul 2023 13:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjGKN6I (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjGKN6H (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F99E;
        Tue, 11 Jul 2023 06:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B91614F9;
        Tue, 11 Jul 2023 13:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A37C433C8;
        Tue, 11 Jul 2023 13:58:05 +0000 (UTC)
Date:   Tue, 11 Jul 2023 09:58:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>
Subject: Re: [PATCH v2] ftrace: Fix possible warning on checking all pages
 used in ftrace_process_locs()
Message-ID: <20230711095802.71406422@gandalf.local.home>
In-Reply-To: <20230711201630.1837109-1-zhengyejian1@huawei.com>
References: <20230710104625.421c851a@gandalf.local.home>
        <20230711201630.1837109-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 12 Jul 2023 04:16:30 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 3740aca79fe7..b46e539dc085 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6473,7 +6473,9 @@ static int ftrace_process_locs(struct module *mod,
>  {
>  	struct ftrace_page *start_pg;
>  	struct ftrace_page *pg;
> +	struct ftrace_page *pg_unuse = NULL;
>  	struct dyn_ftrace *rec;
> +	unsigned long skipped = 0;
>  	unsigned long count;
>  	unsigned long *p;
>  	unsigned long addr;

Nit, to keep the upside-down-xmas-tree format:

	struct ftrace_page *pg_unuse = NULL;
	struct ftrace_page *start_pg;
	struct ftrace_page *pg;
	struct dyn_ftrace *rec;
	unsigned long skipped = 0;
	unsigned long count;
	unsigned long *p;
	unsigned long addr;

-- Steve
