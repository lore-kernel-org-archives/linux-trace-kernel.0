Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537621D043E;
	Wed,  2 Oct 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877767; cv=none; b=dRmwD2ju8P9TI2hCR0pdRDbISdfK7jbHz5XNGUjoLgMP43Um18LyiPEJpaynfxZS8VzLjFtbHJHPrY4VGCiDBuywX8nVmR7hRFhSAYqzg/k+NkRrhbfB7AcIsx6V9/gfBoJqGuAMMTnAAFYV/0Fgun7aWr3x445W94eGi0eiplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877767; c=relaxed/simple;
	bh=vosB+aV8QyFYxiK/n9xHHxzA99t66jgbJQJsSQUBTGI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JkVtnLveka263+0d7UnhHfjygoaGljeX8Oeon0wP5IHm1LOYD/pqTqy7A90u4cBycSoSpT3YxjkFiEJ9CFwf+bIec9SkmvBHSbT2nkpzUDhknNOF36iknXNmLv+uxZ3QYmU+pcRg8eYnrDuQLTen2jFv0XuAAEGq/K3wWLk6KpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qM6HttVi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qM6HttVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9E3C4CEC2;
	Wed,  2 Oct 2024 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727877767;
	bh=vosB+aV8QyFYxiK/n9xHHxzA99t66jgbJQJsSQUBTGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qM6HttViUgran8+ReSaenmRItAp4jX5flLVaEz4QDVn9A0yu4OVBBvyOacQeJYqYk
	 UhccS/nTQfDGWRVkqMvzvHx4jpmfjGl4qr9Qx7JucpQcVj4HNhiHlctMFN4dK15h0q
	 CP6Ryepd/n8p1Eg5Gk133CyiSA0AsfvceZ+QN9h3nMjCg6VVe/ck0YkWrZDq96jSGf
	 gr7k5AA3bpVmN0nvgOWilxYSh2PvyBa5BQCs0Nypnix88AUVAPtsuhQByYG00qVCyD
	 zSkHiqaVo9jy00NnM1cQlLz2oau7qOja372Xe/uK2uyt26Hhjc96POUG1U3LD/lijH
	 ZKyI2jvO0jwVA==
Date: Wed, 2 Oct 2024 23:02:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Hide a extra entry in stack trace
Message-Id: <20241002230243.db4bd69dfa815f9af06007a6@kernel.org>
In-Reply-To: <b0ec6a2d-8734-46f3-8cfb-f2bbe17dbf59@gmail.com>
References: <20240926061311.25625-1-tatsuya.s2862@gmail.com>
	<20240930085139.5d34f28236a67ef1e9143655@kernel.org>
	<509829ab-98b5-4429-ba59-e1fc7b300682@gmail.com>
	<20241001094742.1282d2ad@gandalf.local.home>
	<b0ec6a2d-8734-46f3-8cfb-f2bbe17dbf59@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 15:43:35 +0900
Tatsuya S <tatsuya.s2862@gmail.com> wrote:

> 
> 
> On 10/1/24 10:47 PM, Steven Rostedt wrote:
> > On Tue, 1 Oct 2024 22:27:03 +0900
> > ts <tatsuya.s2862@gmail.com> wrote:
> > 
> >>> ...
> >>>                 sh-140     [001] ...1.    18.352601: myevent: (vfs_write+0x4/0x560)
> >>>                 sh-140     [001] ...1.    18.352602: <stack trace>
> >>>    => ksys_write
> >>>    => do_syscall_64
> >>>    => entry_SYSCALL_64_after_hwframe
> >>>                 sh-140     [001] ...1.    18.352602: vfs_write <-ksys_write
> >>>                 sh-140     [001] ...1.    18.352604: <stack trace>
> >>>    => ftrace_regs_call
> >>>    => vfs_write
> >>>    => ksys_write
> >>>    => do_syscall_64
> >>>    => entry_SYSCALL_64_after_hwframe
> >>> ------
> >>> As you can see, myevent skips "vfs_write".
> >>> (and function tracer still have ftrace_regs_call() )
> >>
> >> Thanks for the other tests. This issue may be function_trace_call()
> >> specific problem.
> >>
> >> So I will change the place to increment skip number.
> > 
> > My fear is that we are going to just break it elsewhere. The problem with
> > the "skip" is that there's so many configurations when we get here, we may
> > not really know what to skip. If the compiler inlines something, then we
> > may skip something we do not want to.
> > 
> > I rather have extra information than not enough.
> > 
> > -- Steve
> 
> It may not be clean and be bit redundant, but I think it would be more 
> maintainable to treat
> 
> "skip(and skipped functions)" separately only at the top(parent) of 
> functions that display stack trace.

I think you'd better make a set of test programs which gets the stacktrace
with several different conditions (combinations of tracers/probes/kconfgis)
at first. Then we can make sure it does not break anything. 

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
