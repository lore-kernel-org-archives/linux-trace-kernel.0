Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A18CA0EC3
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 12 Sep 2023 13:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbjILNeY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjILNeD (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:34:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F59A35B0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:33:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641A9C433C9;
        Tue, 12 Sep 2023 13:33:05 +0000 (UTC)
Date:   Tue, 12 Sep 2023 09:33:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH v4] eventfs: Fix the NULL pointer dereference bug in
 eventfs_remove_rec()
Message-ID: <20230912093322.759a7d2a@gandalf.local.home>
In-Reply-To: <20230912025808.668187-1-ruanjinjie@huawei.com>
References: <20230912025808.668187-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 12 Sep 2023 10:58:08 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

This looks good. But I have a small nit.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index ed367d713be0..8e0593d4c6a6 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2296,6 +2296,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
>  		    struct trace_event_file *file, struct dentry *parent)
>  {
>  	struct event_subsystem *system, *iter;
> +	struct eventfs_file *ef;
>  	struct trace_subsystem_dir *dir;
>  	int res;
>  

Can you move the ef below dir to keep the "upside-down x-mas tree" format:

	struct event_subsystem *system, *iter;
	struct trace_subsystem_dir *dir;
	struct eventfs_file *ef;
	int res;

That's easier to read.

Thanks!

-- Steve
