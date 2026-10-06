Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE53E3BB695;
	Tue,  6 Oct 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290336; cv=none; b=fV2SqU8X/w1wvNz1GIFq4Rcn8W1mFwajX/zAxRjzqX19AB/V3UyDKyEVoDUsnbShByGwH4i9pPHZwCgzXhpdS882KlZpqMdN4ecUXRRCb25vaFj5eU332Wz/kw8aOXCaZV4F4lgq/Xe8xekVBi3OJlsldzUr7AR75gZ6VlyHkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290336; c=relaxed/simple;
	bh=Bt2DYz05yvJhE0QXotlcSuBia636kVJ9T2VUtRltyYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlPV6R1tFUNOvpRcyBwMaIrZzcwlb8y3rgp8Vnsqr0hbKJRy8Rpn7hf7+PSgQ4N8b0C5MPYBJYoIMPe9ln4rlz1ZgrHIIBfo/wY11rLoivj7oatPcv+SQfb1j46xOMSuXKT8FiiyfMTAc7cqESfTE4TcklFc8p/PGmRJ8VKRnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=HfjvW7ol; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="HfjvW7ol"
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 2BE1F12017E;
	Tue,  6 Oct 2026 12:38:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 1422920025;
	Tue,  6 Oct 2026 12:38:28 +0000 (UTC)
Date: Tue, 6 Oct 2026 08:38:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "kees@kernel.org"
 <kees@kernel.org>
Subject: Re: [PATCH] tracing/user_events: Fail fork when event state
 duplication fails
Message-ID: <20261006083825.2bbeaef2@fedora>
In-Reply-To: <B502490D-E683-4401-A06F-067B47CBC2E6@getmailspring.com>
References: <20261005215619.GA404-beaub@linux.microsoft.com>
	<B502490D-E683-4401-A06F-067B47CBC2E6@getmailspring.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 1422920025
X-Stat-Signature: as9woai9kbsycpfuc45brr764s9xqc6o
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/yFsuBiot7rLeDHNRTCz/3ah2cXs/7YHw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Vh48PBtAVbf/WywjYrSe3RJhNz6QVz1orVCag/swWzU=; b=HfjvW7olN1GK87342kwDBgS5Kyff5hOHPkp6zbTBKnpEhSvLsjPUVatEjaDVUV+xzgxZWlQFZJ+sTNegZW+DyOY/mDM8kN2lZeDX+aSYlqZwt5gEuPT7Zh3GLuuZr5+0mITwBifzh6atlI5OuIwYWuOeOJT15Qn+Xu7ORS777eE=
X-HE-Tag: 1791290308-74166
X-HE-Meta: U2FsdGVkX18mPGQ22UHHyoLh5CDCmJWsJqFFBqoDjdgrmAMHuHHzd/oeeqhcizOxeZmDajsWUpj1433PtzreUm3HJUbTmqx3wO3olJXNsUTjCneceOoboZhPX9jVan6siteRKbCSIZClC4MurDLqxxCeLGUn95tcVRceKk5quG+3cpW5820T+O69scfTbXRlWyl6g3OIVEqPMmnK9oSkdX5KbcVRaPxNDfBs9FQisjMGhH/z0LRQk9sZ0Gi5HwmlSgWxOv+zzTPYWZvH50wT9Cn7XYomeHMXKU/21L0DhcYI4yApDr9ql/y+0RUGhuX8L7DHZSuLslnguvGNQh82DLaiN7GsCvhZ

On Tue, 6 Oct 2026 08:01:14 -0400
Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:

> Yes, that was intentional. My concern with allowing fork() to succeed
> after removing the child's user_events state is that the allocation
> failure then becomes a silent loss of inherited tracing state.
> 
> The enable word is the userspace-visible indication that an event is
> enabled. If the child loses its inherited enablers, later enable and
> disable changes will no longer be reflected in that child. Removing the
> state fixes the stale-value inconsistency, but userspace has no
> indication from fork() that the child is no longer following the
> inherited tracing state.
> 
> I also think there is a potential security implication here. If
> user_events are being used for tracing or auditing, an allocation
> failure could result in a successfully created child silently no longer
> following subsequent enablement changes. I don't want to characterize
> that as a security vulnerability without a demonstrated security
> boundary, but silently losing that state seems undesirable for auditing
> in particular.
> 
> That is why I favored returning -ENOMEM: either the child is created
> with the inherited user_events state intact, or the failure is visible
> to userspace and the fork is unwound.
> 
> I agree that uprobes provides a useful comparison. If you think
> user_events should likewise be best-effort across fork, then removing
> the state on duplication failure would address the inconsistency without
> introducing the new fork() failure path.

Question, to use user events the application needs to be involved,
correct? That is, there's code in the application specific for
user_events, as supposed to uprobes that can attach to any application.

Thus, it makes sense for uprobes to only warn on failure. Why should a
task fail to fork if something attaches a uprobe on it and it causes
issues.

Now if user_events is driven by the application that has them, then
yes, it makes sense for fork() to fail if the user_event it created
fails processing inside the fork(). If the user application is
expecting something, then if it fails it should know about it.

But this is only if user_events is driven by the application doing the
fork().

-- Steve

