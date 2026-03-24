Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33F3FE37B;
	Tue, 24 Mar 2026 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370593; cv=none; b=DZlyAsxVW1OrJb+QmgPetTQcipm7Krj8HJCCNoEFmOlm8vNq7TrRKZxTNzLeTQ0xtOMOLiIx7M4sixBR0vtaAAXGENlAyAJOisIZvQ9ryf4YIlAJc26bxUBCo1UookXnceXSy/n4nfw744fBmdAWvkXPDxtutdBZz4USvR0YMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370593; c=relaxed/simple;
	bh=DV1w+atlMSzJQmvBD6AJgpQRCNsFQU1P5lcXjTsOeSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLpTMbXRAxP5HQysrUQGIm12IlU+E/gAMJS6j78p1lI82SZQO4IapTapj0r0pHPAqisxK1UZa32ZK8LNzhHgtBGir0hblGqVevJlK/zxmVfPgrH6gcY+XmXiUXoGn+/KnZVzgkC/cthTRbpS/Rwou7z/IdNVsCqPgPboXdDiubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id D28BEB7E4D;
	Tue, 24 Mar 2026 16:43:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 1AA1E20026;
	Tue, 24 Mar 2026 16:43:03 +0000 (UTC)
Date: Tue, 24 Mar 2026 12:43:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] tracefs: Check file permission even if user has
 CAP_DAC_OVERRIDE
Message-ID: <20260324124345.7fb9bda6@gandalf.local.home>
In-Reply-To: <177071303130.2293046.2400906233143699263.stgit@mhiramat.tok.corp.google.com>
References: <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
	<177071303130.2293046.2400906233143699263.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1AA1E20026
X-Rspamd-Server: rspamout06
X-Stat-Signature: wysd8ih1g4tnr616x5e9ut5zdrfug4n3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18q2USRxW4/goNAkF7mwWxwudW1TDehyXg=
X-HE-Tag: 1774370582-510733
X-HE-Meta: U2FsdGVkX1+NhTzPzP33f7boyABWhAkwqFg+zrMBLoCy3fDZQHVTy16vLYvr3WSKl1DEBfxz7ZzXAlIkuV6uGNDB5CyEN8tuWa06L/XfASGByB6PBAojoo7IieFjRjs7o8uQTsY8S8crJ9q0neona0Bs9G3PpNC7fqf+2EtJriH/xOc3tRzBPpkEgisW8WsOhWhJorHopf/uGhV8GOdS5rDV0cEdBYi1yNooB31jAW3tg5eLvrXPe172ods3s/DoHhRHazUtSUNqKJUrijJ3aBAqa0F/TrVYg+pXPoLVbZJaOY4zKYN4yn5CFe3sj9363i8KRQjAIT1nMdqvFofDxv45aADGUPtV

On Tue, 10 Feb 2026 17:43:51 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

Hi Masami,

Did you send a new version of this patch series yet? I don't see it.

> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index d9d8932a7b9c..eb1ddc0cc13a 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -212,10 +212,40 @@ static void set_tracefs_inode_owner(struct inode *inode)
>  		inode->i_gid = gid;
>  }
>  
> -static int tracefs_permission(struct mnt_idmap *idmap,
> -			      struct inode *inode, int mask)
> +int tracefs_permission(struct mnt_idmap *idmap,
> +		       struct inode *inode, int mask)
>  {
> -	set_tracefs_inode_owner(inode);
> +	struct tracefs_inode *ti = get_tracefs(inode);
> +	const struct file_operations *fops;
> +
> +	if (!(ti->flags & TRACEFS_EVENT_INODE))
> +		set_tracefs_inode_owner(inode);
> +
> +	/*
> +	 * Like sysfs, file permission checks are performed even for superuser
> +	 * with CAP_DAC_OVERRIDE. See the KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK
> +	 * definition in linux/kernfs.h.
> +	 */
> +	if (mask & MAY_OPEN) {
> +		fops = inode->i_fop;
> +
> +		if (mask & MAY_WRITE) {
> +			if (!(inode->i_mode & 0222))
> +				return -EACCES;
> +			if (!fops || (!fops->write && !fops->write_iter &&
> +				      !fops->mmap))
> +				return -EACCES;
> +		}
> +
> +		if (mask & MAY_READ) {
> +			if (!(inode->i_mode & 0444))
> +				return -EACCES;
> +			if (!fops || (!fops->read && !fops->read_iter &&
> +				      !fops->mmap && !fops->splice_read))
> +				return -EACCES;
> +		}

The above if block is way too coupled with the workings of fops and is very
fragile. Is it even needed? If there are no read or write functions,
wouldn't the vfs stop it anyway?

-- Steve


> +	}
> +
>  	return generic_permission(idmap, inode, mask);
>  }
