Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6721849
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0p6VTcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A0C433C8;
	Thu,  2 Nov 2023 02:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698891270;
	bh=CJMrtyfuHl+r7KeAJXfcnHc6hF/5D0/sWKNgaLrPbP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0p6VTcKuIV1vgCZCk8pSw3J6KhLx27uHXZ/WwFbauiM3l2pgfo+yxUp+gNnYbrus
	 qaK/zijM8d7Upy0dhFnDUjU52LLkq8mrNJS6wEwXSiu5s5L9745JfmmzoEHMIX/Ndg
	 dc0MQ/wLuls9kMEa2yYNnyNdXNJtv3OI8Vsc+dlWnLVqPIxQRDo3w2ZuFTACe0qXoK
	 LWJiq+vnwOATmRfLrJi5ruLxtNuWtcVQhsPbx9E6GU4H+ljBcz6x3pMAIfnDKVWhbR
	 d01j1lSrJBm21FtZH2NxIQxEw+GoRMcNOLoEQFUQLoAoidRZnxyZkvNRPAk0e+KSRC
	 De1VBceZtVDNA==
Date: Thu, 2 Nov 2023 11:14:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH v6 7/8] eventfs: Remove special processing of dput() of
 events directory
Message-Id: <20231102111426.5ca004d4f8fce591b536708c@kernel.org>
In-Reply-To: <20231101172650.340876747@goodmis.org>
References: <20231101172541.971928390@goodmis.org>
	<20231101172650.340876747@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Nov 2023 13:25:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The top level events directory is no longer special with regards to how it
> should be delete. Remove the extra processing for it in
> eventfs_set_ei_status_free().
> 
Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Cc: Ajay Kaher <akaher@vmware.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v5: https://lkml.kernel.org/r/20231031223421.185413077@goodmis.org
> 
> - Resynced to this patch series
> 
>  fs/tracefs/event_inode.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 0a04ae0ca8c8..0087a3f455f1 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -274,28 +274,11 @@ static void free_ei(struct eventfs_inode *ei)
>   */
>  void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
>  {
> -	struct tracefs_inode *ti_parent;
>  	struct eventfs_inode *ei;
>  	int i;
>  
> -	/* The top level events directory may be freed by this */
> -	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
> -		mutex_lock(&eventfs_mutex);
> -		ei = ti->private;
> -		/* Nothing should access this, but just in case! */
> -		ti->private = NULL;
> -		mutex_unlock(&eventfs_mutex);
> -
> -		free_ei(ei);
> -		return;
> -	}
> -
>  	mutex_lock(&eventfs_mutex);
>  
> -	ti_parent = get_tracefs(dentry->d_parent->d_inode);
> -	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
> -		goto out;
> -
>  	ei = dentry->d_fsdata;
>  	if (!ei)
>  		goto out;
> @@ -920,6 +903,8 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	inode->i_op = &eventfs_root_dir_inode_operations;
>  	inode->i_fop = &eventfs_file_operations;
>  
> +	dentry->d_fsdata = ei;
> +
>  	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>  	inc_nlink(inode);
>  	d_instantiate(dentry, inode);
> -- 
> 2.42.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
