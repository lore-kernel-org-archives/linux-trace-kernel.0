Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF833F37A;
	Tue, 25 Aug 2026 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696899; cv=none; b=oiieytRS9t0349pyrn9gJcKlB29cydCDw7Q8krUSyyhJWkeZBqTia2atdVrb1MC3P16g56Zi43CaK2x8U4HDr0ydyBw3AcCu3h+NV3wucaKImG8Red4CZiYvpzJ0PdP9CLdyn2qdgs4w+I/QJ7gIa8GAIAgAMtXxc4TRz0T6plE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696899; c=relaxed/simple;
	bh=da/zxhydi+UOVx1FLnU8UtyS6m1sHLkOIEU/2M3zSJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHQlUBbWGmWttyrEX3bq07gfgC4uhQpVEqdXf9/MhoUtgoC6dhJgJJQjbkMPdUvAv1UZGCqKR/ye4NPgq1H9jVxiQLvwUeh21HjkbFObIWmD/TKdhU4eoWeyc3NFzcJBGDn2zMwduFGzHIKVp5wh5TRjPzWBpfX0yIlxmIp1ijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=LcZ1Fp1f; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="LcZ1Fp1f"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 80E5D801F0;
	Tue, 25 Aug 2026 22:28:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id DA38618;
	Tue, 25 Aug 2026 22:28:07 +0000 (UTC)
Date: Tue, 25 Aug 2026 18:28:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Carlier <devnexen@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfs: Initialise ei->children before it can be freed
Message-ID: <20260825182851.6588b274@gandalf.local.home>
In-Reply-To: <20260825215727.200803-1-devnexen@gmail.com>
References: <20260825215727.200803-1-devnexen@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: DA38618
X-Stat-Signature: eua16hgpx17hc7kepnjd379d8xn4iept
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/tos79TL8/YfJ/QsOWtEYrBSa7Tl/Jg/w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=HiCl2XozwwXXKmv7bMarzGNfH1dlM6I2VoyqqQrSpuE=; b=LcZ1Fp1fcL7/EP6fbL2dohCqHUAmAAoz15+8z7coVBojDm50RBIL5DEMmFEeHb/V+jgBKh/HzTAO9u/8PntJZwhhwwNoGpdLLEaCEBlvx85qmBaDL1i7E2Th38THJwPyT1u2T4Wvc/BqK3JMQgoidJcfa5ASjUcXG2FZ19gd8sA=
X-HE-Tag: 1787696887-413061
X-HE-Meta: U2FsdGVkX1+X5BguuM03X5ELhe3iewOPR0pd5mG/9v5HuACyzCUkeAwm7jcLVGWw8q4QJblGX0bKbsJYajwwLtA1/QATblZXl7J8m0veZBfx0m0wMn+wcgQpwiONJA4XBNo1fr/B0JBAgVAPzshFegfrqWmlZG5ptQUbI6yaFCMcNBhGCY3UMGrBFpiVNKJ3QegwWJtHyglRNjS496VxW4SWPv7g698Nq2dOCirZJQCLg1aDgx8r0XyzD33Pd1jxbqGhxqva3HutvL34YmXDUjLIjHL8AqLQE8qHYiFNFw69Y5NFAtafYG780eFLZw32yz46lH+TTUM7nqX/wA2+wYFdkK3aFdg4Cp0PdmhjXUdSUixLjy4AyeZ+PTV9ue3+nrE5rzdpDju++LvuqKTLy1+h6WsN6hy8YHSv8RvIueS+bz4zejCgEw==

On Tue, 25 Aug 2026 22:57:18 +0100
David Carlier <devnexen@gmail.com> wrote:

> eventfs_create_events_dir() runs INIT_LIST_HEAD(&ei->children) only after
> tracefs_get_inode() succeeds, but that call's failure path jumps to "fail",
> which calls cleanup_ei() and then free_ei(). free_ei() reads the list with
> WARN_ON_ONCE(!list_empty(&ei->children)), and alloc_root_ei() uses
> kzalloc(), so children.next is NULL there and the WARN fires.
> 
> The path is reachable at runtime: mkdir /sys/kernel/tracing/instances/foo
> ends up in create_event_toplevel_files() and eventfs_create_events_dir().
> 
> Move both INIT_LIST_HEAD() calls up to right after the allocation.
> 
> Fixes: f0ece16ffca7 ("eventfs: Use children field for rcu head and add memory barriers")
> Signed-off-by: David Carlier <devnexen@gmail.com>

Already queued by someone else.

https://patch.msgid.link/20260824144653.54044-1-kartikey406@gmail.com

-- Steve
