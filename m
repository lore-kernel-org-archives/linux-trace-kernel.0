Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E652566;
	Fri, 29 Aug 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497226; cv=none; b=cC8b7lbQqaSjKAAE91DBTFcQR+kkzUeoHtnS9hit39xmvuBLombJhXVtYnq3+fdfrVnvdoJ/27xpYU87AtaBzqxrj8U36Y5tl216IwIbv5azbPik7LeFQmfJrdDRfZx3IwiGxHJvuaN9m4RJJCAEsgp+PFsVvJDWM1IgCE690w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497226; c=relaxed/simple;
	bh=0hL1E76/SA5YGNhsibGKMVMTq/mNqQak0i8IxC4NYj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPmlLWAjz2EE1L44Zld+sikXsjsvo4KBiy09F32zam+wGKMlizDLbIVoy99qNqnFZyQn8d5SrSUSM4J1EMLRplAF9ahJmcG7Q0LdvWA0pcDNgbEkZtU/N/aB+Ri1HP7YTztPr/BRusWn/7Gx27mIdb+TijoyDZL9TaAMCGg6JdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BD8C4CEF0;
	Fri, 29 Aug 2025 19:53:42 +0000 (UTC)
Date: Fri, 29 Aug 2025 20:53:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <aLIFRHcsEo2e2GE7@arm.com>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
 <20250819135008.5f1ba00e@gandalf.local.home>
 <436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
 <20250829082604.1e3fd06e@gandalf.local.home>
 <20250829083655.3d38d02b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829083655.3d38d02b@gandalf.local.home>

On Fri, Aug 29, 2025 at 08:36:55AM -0400, Steven Rostedt wrote:
> On Fri, 29 Aug 2025 08:26:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > BTW, the reason not to fault is because this might be called in code that is
> > already doing a fault and could cause deadlocks. The no sleeping part is a
> > side effect.
> 
> The difference between __copy_from_user_inatomic() and
> copy_from_user_nofault() is the above. It is possible to fault in memory
> without sleeping. For instance, the memory is already in the page cache,
> but not the user space page tables. Where that would be OK for
> __copy_from_user_inatomic() but not OK with copy_from_user_nofault(), due
> to the mentioned locking.

The semantics of __copy_from_user_inatomic() are not entirely clear. The
name implies it is to be used in atomic contexts but the documentation
also says that the caller should ensure there's no fault (well, the
comment is further down in uaccess.h for __copy_to_user_inatomic()).

The generic implementation uses raw_copy_from_user() in both atomic and
non-atomic variants. The difference is pretty much a might_fault() call.
So it's nothing arm64 specific here.

> For things like trace events and kprobes, copy_from_user_nofault() must be
> used because they can be added to code that is doing a fault, and this version
> must be used to prevent deadlocks.
> 
> But here, the __copy_from_user_inatomic() is in the code to handle writing
> to the trace_marker file. It is directly called from a user space system
> call, and will never be called within code that faults. Thus,
> __copy_from_user_inatomic() *is* the correct operation, as there's no
> problem if it needs to fault. It just can't sleep when doing so.

The problem is that it's the responsibility of the caller to ensure it
doesn't fault. In most cases, that's a pagefault_disable(). Or you just
go for copy_from_user_nofault() instead which actually checks that it's
a valid user address.

BTW, arm64 also bails out early in do_page_fault() if in_atomic() but I
suspect that's not the case here.

Adding Al Viro since since he wrote a large part of uaccess.h.

-- 
Catalin
