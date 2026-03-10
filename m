Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF74327BFA;
	Tue, 10 Mar 2026 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158340; cv=none; b=fnEMOccs7rYykma49B+gLGCsyooNc3Od9wT0/sa6UPZEK81CBgy6KNwCONmR6FRvGWwVN/v54oTeNfDZzRRRWxHGuxV3eJfmZxQ5RVMrBvaEEE+Spx47G7PHl3yD8BostuYnAQXIZMJJY9R6WG8zgW/bbFODAntBBaa8T8FOiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158340; c=relaxed/simple;
	bh=nFhmW9ypNXSEYdoRSDcd44zsFb0+4x5DAqpI4L6Jj3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dch4OH5yZQaeXcg0Zb9qHvkA8a5N87yHpyfEp4qK6C9f8jskBmsM9BzZE7x6iDthNcVC91ck10GPkSIKg3f9YCjUTnxqV5EQlhbxoo5OB93zf1JCaDo8OkMDKWsw1/OsVlC4OtUA1rQDfFy7jKmlyhHNL/BUdoqc2EfxAfgXKSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=QGosPnBK; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="QGosPnBK"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 291DFB3809;
	Tue, 10 Mar 2026 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773158337;
	bh=5vlJfxBBCcVrEZ7p5s6NGxIJP61hQIWzfEdRwFuO0H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QGosPnBKix7V1ImVswshZCyVbOuBq5zkg71RTX/QX0u0HSH+zR5Q/eAYmW9v+h3Gc
	 A6A/rgWbh3AucUHPVdpC1XI2qDRc0rVmkkSZBbedTLD1J/IIGj9ZiaaDnKl5B/G+DV
	 7GJhF8pHm9HJI8kKn40331lLMuKWsF53tgp9s55s=
Date: Tue, 10 Mar 2026 15:58:55 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 1/3] locking: Add contended_release tracepoint
Message-ID: <abA_v9g5p-w1-1fI@shell.ilvokhin.com>
References: <cover.1772642407.git.d@ilvokhin.com>
 <f8605471fd84ebff963c011aa98f79ed17f493c7.1772642407.git.d@ilvokhin.com>
 <20260305075552.0840e6b107dd9560e09e4f86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305075552.0840e6b107dd9560e09e4f86@kernel.org>

On Thu, Mar 05, 2026 at 07:55:52AM +0900, Masami Hiramatsu wrote:
> On Wed,  4 Mar 2026 16:56:15 +0000
> Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > Add the contended_release trace event. This tracepoint fires on the
> > holder side when a contended lock is released, complementing the
> > existing contention_begin/contention_end tracepoints which fire on the
> > waiter side.
> > 
> > This enables correlating lock hold time under contention with waiter
> > events by lock address. Subsequent patches wire this tracepoint into
> > the individual lock implementations.
> > 
> 
> OK, but I don't recommend you to split the traceevent definition
> and its usage. Could you combine [1/3] and [3/3], so that we can
> understand why this event is introduced and where it is recorded
> by checking one commit?

Thanks, Masami, absolutely. I'll squash these commits.
