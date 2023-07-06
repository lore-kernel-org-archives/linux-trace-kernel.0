Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70826EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Jul 2023 14:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGFO1H (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGFO1G (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD7210F5;
        Thu,  6 Jul 2023 07:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0668D61989;
        Thu,  6 Jul 2023 14:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8203AC433C8;
        Thu,  6 Jul 2023 14:27:03 +0000 (UTC)
Date:   Thu, 6 Jul 2023 10:27:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 77/92] tracefs: convert to ctime accessor functions
Message-ID: <20230706102701.2b8ac596@gandalf.local.home>
In-Reply-To: <20230705190309.579783-75-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
        <20230705190309.579783-1-jlayton@kernel.org>
        <20230705190309.579783-75-jlayton@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed,  5 Jul 2023 15:01:42 -0400
Jeff Layton <jlayton@kernel.org> wrote:

> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/tracefs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 57ac8aa4a724..2feb6c58648c 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -132,7 +132,7 @@ static struct inode *tracefs_get_inode(struct super_block *sb)
>  	struct inode *inode = new_inode(sb);
>  	if (inode) {
>  		inode->i_ino = get_next_ino();
> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  	}
>  	return inode;
>  }

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
