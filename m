Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391238B7D6;
	Fri, 27 Feb 2026 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224910; cv=none; b=YSckhHbnFhPADdTJXRoPXnoWtqqeVmn5I8creoW417Z5M21rqir7FnNwBQAcGEqy5CTVP8tHgYJIdqladFyty+txnA7AsBvWBJtMw0sBIIujHid+gQkWrA9bGKs3wMV1OCdRUP4J9YeePstGZT7snTyHsIIGCWGVKky1DrrxG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224910; c=relaxed/simple;
	bh=f6IesxbTxBzlXQ9pKl8/a/R9E8X0LD8yZ8bdeG54vVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjXnoelhKR0YpiaOh4xXD25B5oeZV6WsBOvxUKk62nGreo713ljLcvuHgP6JmvTIZwGtnZWxZ4QxYAcewc51toGZN6DxXDPxQPQeDS64QDfCPtIjyRI9dM5wwzdvsBh91FmlR9NuQDkr5MMUBGDKT9ifYte8SYDFEe2znlqrvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1476D1B8368;
	Fri, 27 Feb 2026 20:41:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 3EB8220013;
	Fri, 27 Feb 2026 20:41:45 +0000 (UTC)
Date: Fri, 27 Feb 2026 15:42:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: AnishMulay <anishm7030@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracefs: Simplify get_dname() with kmemdup_nul()
Message-ID: <20260227154210.5bd19a45@gandalf.local.home>
In-Reply-To: <20260227201824.GE3836593@ZenIV>
References: <20260227194453.213095-1-anishm7030@gmail.com>
	<20260227201824.GE3836593@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dxxxhgt5z98g8nkawf9n7whkyssubqc8
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3EB8220013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+RdIuIPyP9VqoURY3LGRGMrU/oR0bMVxg=
X-HE-Tag: 1772224905-24359
X-HE-Meta: U2FsdGVkX19uiKS4qJNdnNaBGYs8xffVKJ+5UwuX2+11JHCInTMBPn1U4hVSMNvHOCyNY7EKzUqIyTY1zNwkZYfCz52oDHn/vX4X8buURwUxALg6XVxke1a0n5yIL7XfXAO/RvsPj3De1Afwpy6UnHE13+uuq0s0AsAG+iPOZa2iCYAbgPKr0FSZ0C3eWWFgbpq4ZsZ8txAaJOsF1fIz9VHCUohGUoPqtsfsEnJ1vY1Bc7rOQwJF4Jk1U4rn3JylstijH83XtRXoEk3a4rV9C6lrb0kcSerhqMVYukU752unOsKAX0Hf0EWoVSsTe8bIUk6AaV2heEUqHgUkKqVJZ9YwuXOIVSlhHLUSWsv+wpLjeX6LnU6R5CAz9azUmxc4

On Fri, 27 Feb 2026 20:18:24 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Fri, Feb 27, 2026 at 02:44:53PM -0500, AnishMulay wrote:
> > index d9d8932a7b9c9..86ba8dc25aaef 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> > @@ -96,17 +96,7 @@ static struct tracefs_dir_ops {
> >  
> >  static char *get_dname(struct dentry *dentry)
> >  {
> > -	const char *dname;
> > -	char *name;
> > -	int len = dentry->d_name.len;
> > -
> > -	dname = dentry->d_name.name;
> > -	name = kmalloc(len + 1, GFP_KERNEL);
> > -	if (!name)
> > -		return NULL;
> > -	memcpy(name, dname, len);
> > -	name[len] = 0;
> > -	return name;
> > +	return kmemdup_nul(dentry->d_name.name, dentry->d_name.len, GFP_KERNEL);
> >  }  
> 
> Why not have the callers use {take,release}_dentry_name_snapshot()
> instead of doing any allocations at all?
> 
> I mean,
> static struct dentry *tracefs_syscall_mkdir(struct mnt_idmap *idmap,
>                                             struct inode *inode, struct dentry *dentry,
>                                             umode_t mode)
> {
>         struct tracefs_inode *ti;
>         struct name_snapshot s;
>         int ret;
>  
>         take_dentry_name_snapshot(&s, dentry);
> 	...
>         ret = tracefs_ops.mkdir(s.name.name);
> 	release_dentry_name_snapshot(&s);
> 	...
> }
> 
> and similar on the rmdir side.  Then remove get_dname()...

That sounds good to me.

-- Steve
