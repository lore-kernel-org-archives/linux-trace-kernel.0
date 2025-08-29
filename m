Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA32C374B;
	Fri, 29 Aug 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471004; cv=none; b=bq8ooj7R3ntXBYwwK2yi3ENjHsC0sY39+sZafVs/7+yv0PruWLQkliHtUl3DJ0yyP8fGX9DZ1uoJ2d+oPF62p7ZMomFJSBghw+0ycU1uw8u/ws/H/xcZ8F026aTfF7pLd+qEWNM9vAJ4Bf+3jRduPS+W6wS6wXd87dHDiMXXBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471004; c=relaxed/simple;
	bh=ke6oRiLVjqDMwEDoh2gVhgxONFWefFB+M016sliLWUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pgim7ges2jhLnvc7M3ySu93BdxJpNdVvZeIuQZQKlEEwx+eqopymhJ2SdtPRhHMdaFGaCxzT7UXOh2o9PoeMnGaLe4HxxUVvjkbXZ5WjTMDdDLnpQexthnKd5cEGczHuduvB3r/ZDgpP1E+57yj/mV+Na1MPjwcvtFUd7nfSSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2F7641199C8;
	Fri, 29 Aug 2025 12:36:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 15AEE2002B;
	Fri, 29 Aug 2025 12:36:32 +0000 (UTC)
Date: Fri, 29 Aug 2025 08:36:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <20250829083655.3d38d02b@gandalf.local.home>
In-Reply-To: <20250829082604.1e3fd06e@gandalf.local.home>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
	<20250819135008.5f1ba00e@gandalf.local.home>
	<436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
	<20250829082604.1e3fd06e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 15AEE2002B
X-Stat-Signature: i77fizctsna1z8euc6knaq8nkx9ineo3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+yQ+YsxWmh2Lo5DjJW2xbGjyvMyvcjQ9o=
X-HE-Tag: 1756470992-991028
X-HE-Meta: U2FsdGVkX19SLfoVFSBRHC5XJMpeUKVqAKL8kXAIkL+7CAoQKp+2El+NQ/7+vcj5oMfGwtPnUyvD5tEbLt7f0dutbohqYFdTVxrZ4UEdZMKYSskXAVaIpjhkQgQPkcJN807ruTwTGcc9mB8xMR2iGY+qEKd9GP0rmHA7SiQHpUy95ayfWGzIO+c2syZS9ZSNustpBfbojDh5Ri8adNPBHlW8ct+qjK5cXDWVANMCBWncGhaJinXcHsVymqUoUsO3R9to8PnAepQyI7mBDLqn/l5uSXNKYFltwUmPshGo3pg14KNqASBwcyA3M3q8d5tEe9btR5sqnqo3iumhXFgUYurIyBAFhSW1oFx9TTLpK54q0B8AJ+44VBM7S4Br8zTw

On Fri, 29 Aug 2025 08:26:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> BTW, the reason not to fault is because this might be called in code that is
> already doing a fault and could cause deadlocks. The no sleeping part is a
> side effect.

The difference between __copy_from_user_inatomic() and
copy_from_user_nofault() is the above. It is possible to fault in memory
without sleeping. For instance, the memory is already in the page cache,
but not the user space page tables. Where that would be OK for
__copy_from_user_inatomic() but not OK with copy_from_user_nofault(), due
to the mentioned locking.

For things like trace events and kprobes, copy_from_user_nofault() must be
used because they can be added to code that is doing a fault, and this version
must be used to prevent deadlocks.

But here, the __copy_from_user_inatomic() is in the code to handle writing
to the trace_marker file. It is directly called from a user space system
call, and will never be called within code that faults. Thus,
__copy_from_user_inatomic() *is* the correct operation, as there's no
problem if it needs to fault. It just can't sleep when doing so.

-- Steve
