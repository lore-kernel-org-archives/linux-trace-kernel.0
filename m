Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8F6EE7FE4
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  8 Sep 2023 12:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjIHMYw (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 8 Sep 2023 08:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjIHMYv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:24:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49881BEE
        for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:24:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E09EC433CC;
        Fri,  8 Sep 2023 12:24:47 +0000 (UTC)
Date:   Fri, 8 Sep 2023 08:25:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Fix the NULL pointer dereference bug in
 eventfs_remove_rec()
Message-ID: <20230908082503.158955ff@gandalf.local.home>
In-Reply-To: <20230908074816.3724716-1-ruanjinjie@huawei.com>
References: <20230908074816.3724716-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 8 Sep 2023 15:48:16 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 237c6f370ad9..e6efa4078f48 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -693,7 +693,7 @@ static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head,
>  {
>  	struct eventfs_file *ef_child;
>  
> -	if (!ef)
> +	if (IS_ERR(ef))
>  		return;
>  	/*
>  	 * Check recursion depth. It should never be greater than 3:
> @@ -730,7 +730,7 @@ void eventfs_remove(struct eventfs_file *ef)
>  	struct dentry *dentry_list = NULL;
>  	struct dentry *dentry;
>  
> -	if (!ef)
> +	if (IS_ERR(ef))
>  		return;
>  
>  	mutex_lock(&eventfs_mutex);
> -- 

Now the above will crash if NULL is passed to it. Which can happen!

Usually I would say fix the places where it failed, but I'm fine with doing
both the NULL and ERR checks.

	if (IS_ERR_OR_NULL(ef))
		return;

-- Steve

