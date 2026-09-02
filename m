Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83C266565
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309928; cv=none; b=AjXKfHhVcgscx3bTBWQxQP0bbLjn2B97bZPpvKPUs2cBsNGFuzvwA44Fjpal58+QyuRW1TXAsECxVItG0MH/1O7yiE1N5IbjTWt07CWbgcfVVi+Xfg1zdLzF5YzCOBKtyhc6zaGs1iZFJQH72Cach4POJDhi/okwqKo2jYnJUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309928; c=relaxed/simple;
	bh=2Y3uH8+b1Is9zVddxMo5vBE1v9PD8ynNc/NlnNm1tEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWil/+PhPJVPnWN7NmXudXma80VXOLD7WE5i4LtA9YaZ63bMhFheg73lVIQgm2u47iv7Y4x03l5J4pa5C/PJiNLZVcENcwSpP5l8DrUP/oQO9NMd4PXRJ9/gwuRW/6Wg4UIU6aZofdB7yGl8iJTLtrDIw4Mh/T7cr72edlOexvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=oleXDru6; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="oleXDru6"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C4CB0120566;
	Wed,  2 Sep 2026 00:45:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 139A38000F;
	Wed,  2 Sep 2026 00:45:23 +0000 (UTC)
Date: Tue, 1 Sep 2026 20:45:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Synchronize the initialization of ftrace_ops
Message-ID: <20260901204522.4ec50773@robin>
In-Reply-To: <20260902003344.117481F000E9@smtp.kernel.org>
References: <20260901202020.09a1119a@robin>
	<20260902003344.117481F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 139A38000F
X-Stat-Signature: mxbghmhdqm8wxtrhhew5c6errtycybcp
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/FmEw0h2EXcKbdgJYgrcG9XgE99BAztw0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=p9+J7zu5BohaH9elaXWFc6QFrjgmA/MGscnIXicteNo=; b=oleXDru6MxkCNxsAFDNsLxNrsAT7bRGnVCbjmo2dMaFGwTtEeM7/g+cNiaT1Y1vI0EgWLdj4/jva43/HmpMForVZkQNKxA9dlfqXcvESzxketUZL8WiXYXnpaKHKEZGpYaKrGUA7RXgWTmy4IchR58/P/ko8pA4wJeQNUED92y8=
X-HE-Tag: 1788309923-930560
X-HE-Meta: U2FsdGVkX18rB8XnbGRfBDHIWSbKiy9xDAoFZ3oAwqWRTSWATVwcuwf6gMZLQBzdYSt8aqNj9Q3+8psh3sc12xPJFITUhOhfVJdQS0Huv1N5Ll7rGaAmsKm2Rn+2shsQ/2gXcYj4hUbQ3GSFhOYcsinaIDPdbi0FXzq0hHx1KUo9AUZRg2bdE8bDDXgda0Ys3nQcTM81Gig5AnVoNgDg1SXE6zECzxa4/XMywnQY5zRjXWostsf9vYhf/MdUfFuxrgqYnaUQVy4dk7AKG9IvrvPLmpPUQdM4KtS/6bdNiH8L//X8gUzOF8Ywbm2uQ9NeVhlg65xK3oC4GECsHEg9LLjQtEbsnnXOiSxTusW14m/S+Z6perDfDq773PRpT0wCKJEzg7oiW6zmcT4gTyuWXQ==

On Wed, 02 Sep 2026 00:33:43 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The newly introduced `ops_mutex` logic implements a Double-Checked Locking pattern for `ftrace_ops` initialization but misses required memory barriers, allowing concurrent threads to observe a partially initialized structure on weakly-ordered architectures.
> --
> 
> commit 0d99940712b506309368df1237eae674da6b9bc1
> Author: Steven Rostedt <rostedt@goodmis.org>
> 
> ftrace: Synchronize the initialization of ftrace_ops
> 
> This commit introduces a mutex to synchronize the initialization of ftrace_ops
> across multiple tasks. It implements a fast-path optimization by checking the
> FTRACE_OPS_FL_INITIALIZED flag before acquiring the lock.
> 
> Link: https://lore.kernel.org/all/20260829025528.49A831F000E9@smtp.kernel.org/
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index f9d80c7bd9f16..0dcc1ec1a366f 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c  
> [ ... ]
> > @@ -160,6 +162,10 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
> >  {
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >  	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
> > +		guard(mutex)(&ops_mutex);
> > +		/* Could have been initialized before lock taken */
> > +		if (unlikely(ops->flags & FTRACE_OPS_FL_INITIALIZED))
> > +			return;
> >  		mutex_init(&ops->local_hash.regex_lock);
> >  		INIT_LIST_HEAD(&ops->subop_list);
> >  		ops->func_hash = &ops->local_hash;  
> 
> [Severity: High]
> Does this double-checked locking pattern introduce a memory ordering
> regression on weakly-ordered architectures?
> 
> The initial lock-free fast-path check !(ops->flags & FTRACE_OPS_FL_INITIALIZED)
> uses a plain load, while the subsequent completion signal
> ops->flags |= FTRACE_OPS_FL_INITIALIZED (which occurs just after the quoted
> lines) uses a plain store.
> 
> Without an acquire memory barrier on the load side and a release memory
> barrier on the store side, is it possible for memory accesses to be
> reordered by the CPU?

Yeah yeah, I figured this would be triggered. I'll update with
smp_load_acquire() and smp_store_release().

-- Steve
