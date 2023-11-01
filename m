Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A98125A0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAXtZY9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA84BC433C7;
	Wed,  1 Nov 2023 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698841203;
	bh=tAtOQmbzm5eMQzkZff08sjJNZWcEJ/iNxr2mqnxM42c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EAXtZY9k9QZO7JJMwQvB76hIRbmnuGB2V+dWbV73fAVvyG7jCNtDVp/kAeTCaSLxM
	 GEpBmKMe8/fQFWMTxY6Bonfzv+Vzq31bJTh4Lf+sEmT+PofY69RmhOf/Y2XYD/UaCZ
	 PA2jpZQL29t63+E5obyJybpE0Hmo9WIcEs6E9xT6glez1qrmHvZIsFmzRcoZbBdauV
	 ITBA3QdRERcSLV03DKr+/XYPAnFQetw8+45ekv5L09J1/PwhJ7A0Q+hpCo1wicRU76
	 eGyRIdskHKkM8N/3hkhOX/V0GM5lzbmcTDFtpOauqPXRzbj2CL0N7unC87oLB4611X
	 glRwAjI/yi1Sg==
Date: Wed, 1 Nov 2023 21:19:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ajay
 Kaher <akaher@vmware.com>, Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 1/7] eventfs: Remove "is_freed" union with rcu head
Message-Id: <20231101211947.cdff280e1ed9cd8c01746f7f@kernel.org>
In-Reply-To: <20231031223419.935276916@goodmis.org>
References: <20231031223326.794680978@goodmis.org>
	<20231031223419.935276916@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Oct 2023 18:33:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The eventfs_inode->is_freed was a union with the rcu_head with the
> assumption that when it was on the srcu list the head would contain a
> pointer which would make "is_freed" true. But that was a wrong assumption
> as the rcu head is a single link list where the last element is NULL.
> 
> Instead, split the nr_entries integer so that "is_freed" is one bit and
> the nr_entries is the next 31 bits. As there shouldn't be more than 10
> (currently there's at most 5 to 7 depending on the config), this should
> not be a problem.

Yeah, even 16 bit nr_entries is enough.. (maybe the biggest user is
syscall event group)

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,


> Cc: stable@vger.kernel.org
> Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/tracefs/event_inode.c | 2 ++
>  fs/tracefs/internal.h    | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 754885dfe71c..2c2c75b2ad73 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -824,6 +824,8 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head,
>  		eventfs_remove_rec(ei_child, head, level + 1);
>  	}
>  
> +	ei->is_freed = 1;
> +
>  	list_del_rcu(&ei->list);
>  	list_add_tail(&ei->del_list, head);
>  }
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index 64fde9490f52..c7d88aaa949f 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -23,6 +23,7 @@ struct tracefs_inode {
>   * @d_parent:   pointer to the parent's dentry
>   * @d_children: The array of dentries to represent the files when created
>   * @data:	The private data to pass to the callbacks
> + * @is_freed:	Flag set if the eventfs is on its way to be freed
>   * @nr_entries: The number of items in @entries
>   */
>  struct eventfs_inode {
> @@ -38,14 +39,13 @@ struct eventfs_inode {
>  	 * Union - used for deletion
>  	 * @del_list:	list of eventfs_inode to delete
>  	 * @rcu:	eventfs_inode to delete in RCU
> -	 * @is_freed:	node is freed if one of the above is set
>  	 */
>  	union {
>  		struct list_head	del_list;
>  		struct rcu_head		rcu;
> -		unsigned long		is_freed;
>  	};
> -	int				nr_entries;
> +	unsigned int			is_freed:1;
> +	unsigned int			nr_entries:31;
>  };
>  
>  static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
> -- 
> 2.42.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
