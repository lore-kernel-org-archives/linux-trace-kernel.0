Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F0313285;
	Fri, 27 Feb 2026 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223350; cv=none; b=K4HUtLxKI6exzvQ3ZW9ZH61jd+VkVLND+G06PljMpLKTML5l8v/KOGfcRu/Du21dwM7n5X9Qd9sHYaTL4xGQBYbXIOasFuBpbWJMladF4JmYG1DCVUF8ahuLMLrsJ9c0E8VlB1h1A/ZUoD929EZtDqsC0QqVBCrPbM1x5iAy0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223350; c=relaxed/simple;
	bh=b7ZZdAgAIqWzIEOFXroT0v2OFLk0n+ycadHEhHcQOPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR/b53o4DUNMld5+EmEYO2SQqfRMZcVkZSuWnrgmAfF6GIKW+jdGVnoBJGzb0s4DeCaHrre0nxXPo+7vhcQWua3XFCymXEeXbEqsHdgXhsRuBavA5CHCO3ILj8HKPJ9RYh9k/p1Aotofo1sKQ0ndf1rr4dUjWYVZZN24NIZPKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R3S5KzNQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R3S5KzNQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XYHL3Oxll3MKy5Rbj1rpKl8FC9rHX17TK7N8fb0L25M=; b=R3S5KzNQaexuN0cGETgbT1Ku7s
	XNWR1JnEeECm47qfydfO/3R+Wa25A64ea6nFu2pCABbRe49nKp36escUdqNHiiiZ/MUqgZvm8u7e0
	YUN77mni6wBury4euVO4rCf41HlmN+kJdTBXNx5tM8ysbXHznGXlG+RaEu29B2IN7kiwmebOr8TQ/
	R0fcV3cFmbJyiV8dzTvp9zzxjDYfOrvXRxKhuI2nYbvjWd98eW0LdiLCwnNylO+0g1vsZSYaVNOZr
	Vsz0IPONKOHzCt9BftCbOZMzYUwscYjOXReyH9NzwerGYGm2l3rcfzBXg0gpXqjII8toDDEqwOjwl
	L0SDft5g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vw4I4-00000009R5t-1LJ3;
	Fri, 27 Feb 2026 20:18:24 +0000
Date: Fri, 27 Feb 2026 20:18:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: AnishMulay <anishm7030@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracefs: Simplify get_dname() with kmemdup_nul()
Message-ID: <20260227201824.GE3836593@ZenIV>
References: <20260227194453.213095-1-anishm7030@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227194453.213095-1-anishm7030@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 27, 2026 at 02:44:53PM -0500, AnishMulay wrote:
> index d9d8932a7b9c9..86ba8dc25aaef 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -96,17 +96,7 @@ static struct tracefs_dir_ops {
>  
>  static char *get_dname(struct dentry *dentry)
>  {
> -	const char *dname;
> -	char *name;
> -	int len = dentry->d_name.len;
> -
> -	dname = dentry->d_name.name;
> -	name = kmalloc(len + 1, GFP_KERNEL);
> -	if (!name)
> -		return NULL;
> -	memcpy(name, dname, len);
> -	name[len] = 0;
> -	return name;
> +	return kmemdup_nul(dentry->d_name.name, dentry->d_name.len, GFP_KERNEL);
>  }

Why not have the callers use {take,release}_dentry_name_snapshot()
instead of doing any allocations at all?

I mean,
static struct dentry *tracefs_syscall_mkdir(struct mnt_idmap *idmap,
                                            struct inode *inode, struct dentry *dentry,
                                            umode_t mode)
{
        struct tracefs_inode *ti;
        struct name_snapshot s;
        int ret;
 
        take_dentry_name_snapshot(&s, dentry);
	...
        ret = tracefs_ops.mkdir(s.name.name);
	release_dentry_name_snapshot(&s);
	...
}

and similar on the rmdir side.  Then remove get_dname()...
