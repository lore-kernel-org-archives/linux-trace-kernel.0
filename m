Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F42A1D7;
	Fri, 18 Apr 2025 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936477; cv=none; b=OyxZ0WH4ZVwM/Y7XLDWU65zFNsWcUCik6AJHOCnGCLS7yYO8bftySQ9aPRfpyLm4AwuXXViUBlrt0FInUpu8Ze2EvA97zDrPWHtTw8u035nr7OYuE1Y28lOU1PCYvxXZ3etQYiTmyoZd/9VtSv9I6S6XdvoYoYRhGRiinyTWG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936477; c=relaxed/simple;
	bh=cBSvAwhKrRG0vCUUb/QRYu1HPi/TZiqVAC2UB9DmaY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s959QXA5pmcf6PUc4LsrpMQkoKzFJ1Aza0yC5iCRPuhDib5DN3biyYKmtxFzMW9doF+YixsJ32DSRli9kgMCpkhwPc6VZPvGNv9rMMUbMJT/k5IJHtnK3TKMGuQLQpiRKLBeD6Rzrs+oDQX4nMvknUN7s/s0dvYcIjgMfK0dCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067DBC4CEE4;
	Fri, 18 Apr 2025 00:34:35 +0000 (UTC)
Date: Thu, 17 Apr 2025 20:34:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH] tracing: Fix filter string testing
Message-ID: <20250417203438.413da315@batman.local.home>
In-Reply-To: <20250417162927.e1117ce02e612e29a34985ef@linux-foundation.org>
References: <20250417183003.505835fb@gandalf.local.home>
	<20250417162927.e1117ce02e612e29a34985ef@linux-foundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 16:29:27 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 17 Apr 2025 18:30:03 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > The filter string testing uses strncpy_from_kernel/user_nofault() to
> > retrieve the string to test the filter against. The if() statement was
> > incorrect as it considered 0 as a fault, when it is only negative that it
> > faulted.  
> 
> changelog forgot to describe the userspace-visible effects of the bug?
> 
> > Cc: stable@vger.kernel.org  
> 
> Which is more important when proposing this!
> 

I can update the change log to show how it's broken. In fact, I'm
working on a selftest to catch it if it breaks again.

  # cd /sys/kernel/tracing
  # echo "filename.ustring ~ \"/proc*\"" > events/syscalls/sys_enter_openat/filter
  # ls /proc/$$/maps
  # cat trace

If it works you get:

              ls-1192    [007] .....  8169.828333: sys_openat(dfd: ffffffffffffff9c, filename: 7efc18359904, flags: 80000, mode: 0)

If not, you get nothing!

-- Steve
