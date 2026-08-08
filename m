Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6840EBA8;
	Sat,  8 Aug 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196281; cv=none; b=jMeImpXL7jHf2iSxqzxWFEInRTMgfa3HJk8XYGJKtJa8ppH+MnEE3vPL8zSK8xpaNzvfnMochp5dVeX3S4Rp1dYItnrnlvhaL3yT1QwZvwDDkkXHH1JMAWtFQu+eA8/Fp/M4eciDuxirk3nR7GTIImPkumFWWnRzn7Co9lpJga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196281; c=relaxed/simple;
	bh=JcIml/YIoZCDF5W6FM67sxrEMPO3FbqWDA4ZwC68bjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERZCsb9qoBKMdIQzfCFryBhvizOJ2wlYVw5bCvyjMWu8dXWE7WQdRVbT93NzzsE/ParhZ40JM/UtOCibCYtMImxhX5gqgxMyi0WX862lmZTaL6qqcVFuSTe+siv8qprJ7qwuruQv1r6ddyOey5G654wZpP5IgUDITuaVObsLMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2872DA2251;
	Sat,  8 Aug 2026 13:37:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 7837417;
	Sat,  8 Aug 2026 13:37:56 +0000 (UTC)
Date: Sat, 8 Aug 2026 09:37:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] eventfs: Use children field for rcu head and add
 memory barriers
Message-ID: <20260808093755.342fb36b@robin>
In-Reply-To: <20260807204441.75a7db89@gandalf.local.home>
References: <20260807204441.75a7db89@gandalf.local.home>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5h6j7i7rppxxs333uima75u1ixe19pjp
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 7837417
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/g5W+rkvDn1xv99leWzP7wHwr+2cqS/0Y=
X-HE-Tag: 1786196276-145530
X-HE-Meta: U2FsdGVkX1/Gc+comChqKiLCPSNvFsztG51CpvhOT18Y+s0UPaHLXypzGSwr5snCOoEp6y5du4+hgTs/iE+G4jYXe1VC3ctvBjwsHXpAilxQ+NAF4ajNKTEnZJ9KYW7LPhkQsFDn4CsRaGGmdgDzrptaBnmJ12dwNUFKg5U3BkQ03Tjl/SmJcrA8qaqoasmqZde1iNgLe65vzev1063LqXNDjivTun6FgRx2UvEygPDkA/WQ0XKTwZyotU3cW83dWFj5cTGlyN8X5wTSdXQf1bC0Gutz2x08qN1oosizXhdhmn66Zi5aO5w2qabB/krlMZUnZlIyk6DZiWe30Df/c4bWhXaztFpu+NFSpY0C5ejXunwnsiOw7qluTkETboVG

On Fri, 7 Aug 2026 20:44:41 -0400
Steven Rostedt <steven@rostedt.org> wrote:

> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 39c7a34531e8..7d2431f2bb08 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -124,7 +124,17 @@ static inline void put_ei(struct eventfs_inode *ei)
>  static inline void free_ei(struct eventfs_inode *ei)
>  {
>  	if (ei) {
> +		/* The ei should have no children if it is being freed. */
> +		WARN_ON_ONCE(!list_empty(&ei->children));
>  		ei->is_freed = 1;
> +		/*
> +		 * The SRCU iteration has a smp_rmb() to make sure it
> +		 * sees a child (that may have already been freed)
> +		 * before it reads is_free. If is_free is set, it must
> +		 * not use the child it acquired from ei->children, as
> +		 * the list may be used for SRCU.
> +		 */
> +		smp_wmb();
>  		put_ei(ei);
>  	}
>  }
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

Bah! Now Sashiko is complaining that the wmb is in free_ei() and not
put_ei(). Yes it is correct, but I wish it pointed this out last time
:-p

I'll send a v3.

-- Steve


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

