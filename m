Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D040D576;
	Fri,  7 Aug 2026 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140911; cv=none; b=BAX+aZH9xpuvWYM972uKryEngXJd0MhZQp8wir3gRqDNG3YJvZUDH8mrNdOOY11SO0P5pSf9Iz8md42k4Sk5Lo3wIty9uhLYDCM29Fz2zWcNpvrOYst/seOK6SMloPWnA2v7JT2Y+Pv8Duyy39px0+NcM/WDzdh/zjldP9ghwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140911; c=relaxed/simple;
	bh=gawGpVkH7DEnzHU4z+0uECYt8V3bN8C/+JQCm/V6aLs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b8ANfPBcKcSHez415GRT53CAf2+2rRObyhbx4NlSd2c7mfYMUKD/klxIkNgSLuEA3i+M+Wej3DB3ZdKfFqlUhyc4wMf+3xcjihxxMXA6KMISZO1AS9SCFezqradPnjkIuG54h8aZ0h+lijPH/aXtYNLJUJc/zP4onI46ZLg6EXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHD1i/I3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHD1i/I3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C53E1F000E9;
	Fri,  7 Aug 2026 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140909;
	bh=qwNwBuryfPfm3N2Jhn0pU80HjKaztRmbnDWoBa6NXFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gHD1i/I3kLQf04ZItWfjgu13ccZ1VakLwDXmJBRR6KceNJSAeZh4rVGPTl8bMfX9k
	 0fsh+xSJioAdciOEbiBUGAtG3YBXEq3QlYSZyVsiNygDV/0cMz55kTuo+x6O5D5QW1
	 yCmEuWGAec8GKXykFU3Ioi1b8HlBQhSphZ8dmCc2TrTe4prnC7GOyLF95Cr+u6/SnP
	 cMfZjV1npKN4YghQ5wEC6+zUhsAgOvhRzsRRpLBmUV58sq+I/tkZ7ODt5lej/dQQXo
	 L6SUHd+G3IGHEkd9VpPl87dlZAVqQt1g3TDkb1iBLk3/q0i9nuyRdNmuotxoA/QSjP
	 y3UFWrh4f9m/A==
Date: Sat, 8 Aug 2026 07:15:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <steven@rostedt.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] eventfs: Use children field for rcu head and add memory
 barriers
Message-Id: <20260808071506.cacd0c21059c942a5d2d173b@kernel.org>
In-Reply-To: <20260807170408.2d324df5@gandalf.local.home>
References: <20260807170408.2d324df5@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 17:04:08 -0400
Steven Rostedt <steven@rostedt.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When an eventfs inode is freed, it sets ei->is_freed and then uses its
> ei->list to add it to the srcu link list as the list field is a union with
> the rcu list head. As the ei->list is used to iterate over an SRCU
> protected list without taking the eventfs_mutex, there's nothing stopping
> the iteration over that list to see the ei->rcu instead of the ei->list
> and it will read a corrupt target.
> 
> To fix this, change the union of the rcu list head with the children list.
> On freeing the eventfs inode, set the is_free and execute a smp_wmb()
> before adding the eventfs inode to the SRCU list.
> 
> On iteration of the ei->children list, at the start, execute a smp_rmb()
> and then read the is_freed of the ei to see if the children list is still
> valid. If is_freed is set, then the ei_child read is not valid and the
> loop should exit immediately.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The critical issues Sashiko mentioned will be fixed by Shuangpeng's patch[1].
[1] https://lore.kernel.org/all/20260806022719.375354-1-shuangpeng.kernel@gmail.com/

Thank you,

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260806022719.375354-1-shuangpeng.kernel%40gmail.com
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  fs/tracefs/event_inode.c | 24 ++++++++++++++++++++++++
>  fs/tracefs/internal.h    |  4 ++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 39c7a34531e8..677c39b0d62f 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -124,6 +124,16 @@ static inline void put_ei(struct eventfs_inode *ei)
>  static inline void free_ei(struct eventfs_inode *ei)
>  {
>  	if (ei) {
> +		WARN_ON_ONCE(!list_empty(&ei->children));
> +		/*
> +		 * The ei should have no children if it is being freed.
> +		 * The SRCU iteration has a smp_rmb() to make sure it
> +		 * sees a child (that may have already been freed)
> +		 * before it reads is_free. If is_free is set, it must
> +		 * not use the child it acquired from ei->children, as
> +		 * the list may be used for SRCU.
> +		 */
> +		smp_wmb();
>  		ei->is_freed = 1;
>  		put_ei(ei);
>  	}
> @@ -627,6 +637,20 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  	list_for_each_entry_srcu(ei_child, &ei->children, list,
>  				 srcu_read_lock_held(&eventfs_srcu)) {
>  
> +		/*
> +		 * If the ei is being freed, then the ei->children may be
> +		 * being used as the rcu list, which means the next element
> +		 * may be garbage. The ei->is_free is set before switching
> +		 * the ei->children over to ei->rcu. The read memory barrier
> +		 * here makes sure the ei_child is read before is_free is
> +		 * updated.
> +		 *
> +		 * Matches the smp_wmb() in put_ei()
> +		 */
> +		smp_rmb();
> +		if (ei->is_freed)
> +			return -EINVAL;
> +
>  		if (c > 0) {
>  			c--;
>  			continue;
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index a4a7f8431aff..c61481d04c8e 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -46,11 +46,11 @@ struct eventfs_attr {
>   * @ino:	The saved inode number
>   */
>  struct eventfs_inode {
> +	struct list_head	list;
>  	union {
> -		struct list_head	list;
> +		struct list_head	children;
>  		struct rcu_head		rcu;
>  	};
> -	struct list_head		children;
>  	const struct eventfs_entry	*entries;
>  	const char			*name;
>  	struct eventfs_attr		*entry_attrs;
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
