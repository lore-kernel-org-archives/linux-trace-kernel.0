Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923122D7DF3;
	Tue, 17 Mar 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789344; cv=none; b=kJcEXQbdihgin2/V5DmcS2M2SMdLHis9fqKutRZG7wmiUDb0iGh3uAJyuXX9GGyL0UKyWrXMO+Iv1H+/7Qys0Xdmg54abBhag9yuQctLh66OO38pujI9gzPt7IACFBtaTW5D/NzLj4UGS8ZayOxvydU0uNsKzvEu7VA9Ruim6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789344; c=relaxed/simple;
	bh=j/lS+nianmSuhwWNx8h3Yu0rZEIMlohN1K7/B7efM9Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GMTOqJUbiAEy1Dmni5jSTAJ5z5hF5OnpbnIZNjVRNE19zngW33NxlsP+XQv9KaCQGbF4ZJW9cD+cI4UWoULwy7+PEysCVLM+G2jYGm1TldCb2ZahCnMCPkpMa6E4so6HoGFF5G6pQiWjRhDnYQ+k3kreFgWRQwpFMQMPb5Wa4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUaY9zjv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUaY9zjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B289EC4CEF7;
	Tue, 17 Mar 2026 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773789344;
	bh=j/lS+nianmSuhwWNx8h3Yu0rZEIMlohN1K7/B7efM9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qUaY9zjvDBH/4UJ0uujmIskx/ADBvEkPURssSlU1kpZquvmeHnS7eMm4Ilu5JxYeW
	 s+nUmBHP3QdhmVXfqqvEQHlOINWCPRg3ZY1T0cwFZSHOIQMkgzifJ5T+MM7AqxgGyp
	 tThcNBX2mPYeP4qzCdXfTVKOkSRnsiPzqJhbdoy3YBRYf9LZHPJZT+Ko+Do7UgIWBr
	 KmYsRa8f6YhEgCkpqRLEy2Wpv1FELvCOyx9PlouS8W+3XyDGdUvm+jLcaodnTTlXGm
	 7Eedeb7t2EhGxyQQk6a+CoPNGaf3lc5A1xxvwwlXw4cx/B4Yg9nSd5OzhYSBGc0jtW
	 qRWTEywkS+n9Q==
Date: Wed, 18 Mar 2026 08:15:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Law <objecting@objecting.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 16/17] lib/bootconfig: fix sign-compare in
 xbc_node_compose_key_after()
Message-Id: <20260318081540.44c164f2c67d80acf14eaf2e@kernel.org>
In-Reply-To: <20260317121507.30735331@gandalf.local.home>
References: <20260315122015.55965-1-objecting@objecting.org>
	<20260315122015.55965-17-objecting@objecting.org>
	<20260317165549.99ea4171d7672f83ec3b6fc4@kernel.org>
	<20260317121507.30735331@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 12:15:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 17 Mar 2026 16:55:49 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > --- a/lib/bootconfig.c
> > > +++ b/lib/bootconfig.c
> > > @@ -319,10 +319,10 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
> > >  			       depth ? "." : "");
> > >  		if (ret < 0)
> > >  			return ret;
> > > -		if (ret >= size) {
> > > +		if (ret >= (int)size) {  
> > 
> > nit:
> > 
> > 	if ((size_t)ret >= size) {
> > 
> > because sizeof(size_t) > sizeof(int).
> 
> I don't think we need to worry about this. But this does bring up an issue.
> ret comes from:
> 
> 		ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
> 			       depth ? "." : "");
> 
> Where size is of type size_t
> 
> snprintf() takes size_t but returns int.
> 
> snprintf() calls vsnprintf() which has:
> 
> 	size_t len, pos;
> 
> Where pos is incremented based on fmt, and vsnprintf() returns:
> 
> 	return pos;
> 
> Which can overflow.

I think that is vsnprintf() (maybe POSIX) design issue.
I believe we're simply using the size_t to represent size of memory
out of convention.

> 
> Now, honestly, we should never have a 2Gig string as that would likely
> cause other horrible things. Does size really need to be size_t?

Even if so, it should be done in vsnprintf() instead of this.
This function just believes that the caller gives collect size
and enough amount of memory. Or, we need to check "INT_MAX > size"
in everywhere.

> 
> Perhaps we should have:
> 
> 	if (WARN_ON_ONCE(size > MAX_INT))
> 		return -EINVAL;

I think this is an over engineering effort especially in
caller side. This overflow should be checked in vsnprintf() and
should return -EINVAL. (and the caller checks the return value.)

Thank you,

> 
> ?
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
