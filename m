Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052713D8B4;
	Thu, 28 Nov 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797986; cv=none; b=ImqpZe99x53T9NDrwCsjLpjmARZ54sm7FJMMfYbJzrPhfl7h/9VH1xFoMqUoMC7OJYup4lTyXKT6gDC5sTjeZmaG8yF1CnselvPr7gqLLaF/OdAS4LXK/CLA1ScIx4mds97H9ZcLXiBFun7/U7MIwb2yPpwqQdM519qRcYGSiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797986; c=relaxed/simple;
	bh=SQC8WxODwO+T+8/DHtWNt1GiH/evT4S/oUcqw1Hb4+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=objhqPUQazzQJJKJmLBPdCwxzCQk6sd698nkHIV/NTmtG/qnfz1nLKH3+ymykLvUs0fQda3Elx25lXKxOzw0ysAsT0oamOvDhmwX5vaNyMfP2SHtRRa+3Re7P6+KJp16yJRyNPlXJr5KOA7ghXK0IiTzR52UOvuITSJcans8bzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51BDC4CECE;
	Thu, 28 Nov 2024 12:46:24 +0000 (UTC)
Date: Thu, 28 Nov 2024 07:46:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tao Chen <chen.dylane@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Add WARN_ON_ONCE for syscall_nr check
Message-ID: <20241128074623.063bf253@rorschach.local.home>
In-Reply-To: <20241128115319.305523-1-chen.dylane@gmail.com>
References: <20241128115319.305523-1-chen.dylane@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 19:53:19 +0800
Tao Chen <chen.dylane@gmail.com> wrote:

> Now, x86_64 kernel not support to trace syscall for ia32 syscall.
> As a result, there is no any trace output when tracing a ia32 task.
> Like unreg_event_syscall_enter, add a WARN_ON_ONCE judgment for
> syscall_nr in perf_syscall_enter and ftrace_syscall_enter to give
> some message.

So on a system that has "panic_on_warn" set and they trace a 32 bit
system call, it will cause their system to crash. Is that the intended
behavior?

WARN*() is for self testing the kernel to detect real bugs, not to
inform users that something isn't supported.

BIG NAK!

-- Steve
