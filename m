Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AB35AC23;
	Thu,  5 Mar 2026 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747567; cv=none; b=U9MmxTbwH53gSAd/Ar7ZQ7ziAbYEL+z5LybHcxn4uey9Nc1IkDF0q3t5qw1Zo2WTeh78Re/Lxb8sJ/xYCp/pj8ZpsCBQD8BM3hIR42PmKasxN7BoWDFUqFCz44p0xc2upZHJX4vQrYFePlRGydNliLI6Y8iHJXcLNnHd5f9zoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747567; c=relaxed/simple;
	bh=1dJ5rL4nODWx1UfecvGfufEaUOehrN+Fwm8lkT4QctA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbItDcrB8JdxsTZXx+YqAfiDKIoCuKw44/8ICzOXz2KCK2Ee3UY2Cg7QkgTwR1AId06Y9Fz7xhjPhhh/B1W8JDvQd8qnMigjn4h2YH8CB2tQpP26mdfwsOMM3dNpTh4cA8fu0/iAXOUEn78sQC3G7LX2+8fD300zU3JiM5sYFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6155B1388E1;
	Thu,  5 Mar 2026 21:52:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 8FFFF20018;
	Thu,  5 Mar 2026 21:52:37 +0000 (UTC)
Date: Thu, 5 Mar 2026 16:52:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: AnishMulay <anishm7030@gmail.com>
Cc: viro@zeniv.linux.org.uk, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracefs: Use dentry name snapshots instead of heap
 allocation
Message-ID: <20260305165231.67c2491d@gandalf.local.home>
In-Reply-To: <20260227211505.226643-1-anishm7030@gmail.com>
References: <20260227154210.5bd19a45@gandalf.local.home>
	<20260227211505.226643-1-anishm7030@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sy71g4xnfy1fh4md1kuh6name1hbgoa3
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8FFFF20018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/yM9OzXzpL8gU4W++2PJot0pxLYDuIGsE=
X-HE-Tag: 1772747557-866660
X-HE-Meta: U2FsdGVkX1/wA252uzx4tCOJLB3M7SZD+gyt0nrps9MUEFN4sVRL1Dx+KYSyz7uVlfrSFgEPbkrkV5ihybVhCQSB9NXU1kMaNTHPRMydnkIotskhTjTj9lkODf+EFz3Hpa0sZWrZFez3ueDoEvpRX+eiBX5DaBNmTD/FXdlHVDNP4EGDIh/8KNg9zdY0SXDzfGNDbU5y/Uu9prXj/JPiwhA8rZMU+wtvevjTtWxkuj+enUbcOE04bD/iI8RzLrGWeQUMKPKN6osLYhBr/itoQts77cC3nu6VBX7xUGSwRhgPFQ3gT8Q1WPS9U620LgD5HCARorPLpwHNQbOZb/cvRY6NTUh2Dg+E

On Fri, 27 Feb 2026 16:15:05 -0500
AnishMulay <anishm7030@gmail.com> wrote:

> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 86ba8dc25aaef..ad322e8f9e2ad 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -94,23 +94,14 @@ static struct tracefs_dir_ops {
>  	int (*rmdir)(const char *name);
>  } tracefs_ops __ro_after_init;
>  
> -static char *get_dname(struct dentry *dentry)
> -{
> -	return kmemdup_nul(dentry->d_name.name, dentry->d_name.len, GFP_KERNEL);
> -}
> -
>  static struct dentry *tracefs_syscall_mkdir(struct mnt_idmap *idmap,
>  					    struct inode *inode, struct dentry *dentry,
>  					    umode_t mode)

I can't even apply your patch as it appears you based it off of your local
branch that applied your previous version of the patch.

Please rebase it off of 7.0-rc2 and resend.

Thanks!

-- Steve
