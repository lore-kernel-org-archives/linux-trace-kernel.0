Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B346C38142
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 23 Jan 2023 16:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjAWQyN (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjAWQyJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:54:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26577DA0;
        Mon, 23 Jan 2023 08:54:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68FE560F9B;
        Mon, 23 Jan 2023 16:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074E5C4339B;
        Mon, 23 Jan 2023 16:54:05 +0000 (UTC)
Date:   Mon, 23 Jan 2023 11:54:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com
Subject: Re: [PATCH 6/8] eventfs: adding eventfs lookup, read, open
 functions
Message-ID: <20230123115404.30f03a37@gandalf.local.home>
In-Reply-To: <1674407228-49109-6-git-send-email-akaher@vmware.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
        <1674407228-49109-6-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, 22 Jan 2023 22:37:05 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> +int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
> +{
> +	struct tracefs_inode *ti;
> +	struct eventfs_inode *ei;
> +	struct eventfs_file *ef;
> +	struct inode *f_inode = file_inode(file);
> +	struct dentry *dentry = file_dentry(file);
> +
> +	ti = get_tracefs(f_inode);
> +	if (!(ti->flags & TRACEFS_EVENT_INODE))
> +		return -EINVAL;
> +
> +	ei = ti->private;
> +	list_for_each_entry(ef, &ei->e_top_files, list) {
> +		if (ef->created) {
> +			dget(ef->dentry);
> +			continue;
> +		}
> +
> +		ef->created = true;
> +
> +		inode_lock(dentry->d_inode);

> +		if (ef->ei) 

There's an extra space at the end of the above line.

-- Steve


> +			ef->dentry = eventfs_create_dir(ef->name, ef->mode, dentry,
> +							ef->data, ef->fop, ef->iop, 1);
> +		else
> +			ef->dentry = eventfs_create_file(ef->name, ef->mode, dentry,
> +							 ef->data, ef->fop, 1);
> +		inode_unlock(dentry->d_inode);
> +
> +		if (IS_ERR_OR_NULL(ef->dentry)) {
> +			ef->created = false;
> +		} else {
> +			if (ef->ei)
> +				eventfs_post_create_dir(ef);
> +			ef->dentry->d_fsdata = ef;
> +		}
> +	}
> +	return dcache_dir_open(inode, file);
> +}
> +
