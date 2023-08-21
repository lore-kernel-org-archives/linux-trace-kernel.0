Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2156AEE4993
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 21 Aug 2023 14:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjHUOBi (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 21 Aug 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHUOBi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:01:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4FBE6;
        Mon, 21 Aug 2023 07:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8CE6150E;
        Mon, 21 Aug 2023 14:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2852C433C8;
        Mon, 21 Aug 2023 14:01:32 +0000 (UTC)
Date:   Mon, 21 Aug 2023 10:01:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-docs@vger.kernel.org
Subject: Re: [PATCH] tracefs: Fix kernel-doc warnings
Message-ID: <20230821100146.5379a9c2@gandalf.local.home>
In-Reply-To: <20230818201414.2729745-1-willy@infradead.org>
References: <20230818201414.2729745-1-willy@infradead.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 18 Aug 2023 21:14:13 +0100
"Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Move the per-member documentation into the header to fix the complaints
> from kernel-doc.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/tracefs/event_inode.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index da8d2e73cc47..7ca3857ddb89 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -37,6 +37,9 @@ struct eventfs_inode {
>   * @ei:		list of files and directories within directory
>   * @fop:	file_operations for file or directory
>   * @iop:	inode_operations for file or directory
> + * @del_list:	list of eventfs_file to delete
> + * @rcu:	eventfs_file to delete
> + * @is_freed:	Non-zero if @del_list or @rcu is active
>   * @data:	something that the caller will want to get to later on
>   * @mode:	the permission that the file or directory should have
>   */
> @@ -49,9 +52,9 @@ struct eventfs_file {
>  	const struct file_operations	*fop;
>  	const struct inode_operations	*iop;
>  	union {
> -		struct list_head	del_list; /* list of eventfs_file to delete */
> -		struct rcu_head		rcu; /* eventfs_file to delete */
> -		unsigned long		is_freed; /* Freed if one of the above is set */
> +		struct list_head	del_list;
> +		struct rcu_head		rcu;
> +		unsigned long		is_freed;

This is one of the cases I disagree with kerneldoc. I mean, this isn't a
public structure (it's only in this file) so I don't expect it to be
parsed. These three fields act as one. Having them in the kerneldoc format
above makes them look as three distinct fields. Perhaps the solution is to
get rid of the starting /** so that it's no longer in kerneldoc format.

Maybe move the comments just above the union?

 	const struct file_operations	*fop;
 	const struct inode_operations	*iop;
	/*
	 * @del_list:	list of eventfs_file to delete
	 * @rcu:	eventfs_file to delete
	 * @is_freed:	Non-zero if @del_list or @rcu is active
	 */
	union {
		struct list_head	del_list;
		struct rcu_head		rcu;
		unsigned long		is_freed;
	};

-- Steve


>  	};
>  	void				*data;
>  	umode_t				mode;

