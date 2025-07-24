Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB71FC3;
	Thu, 24 Jul 2025 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753335070; cv=none; b=l37fBCkfPd+NRabiyuBkVMNlDkUDw//bPe25lZ5y5Z+hOPNCBKmIenjhYl/1VYbJVOjdjD6wO/OSx0KGShhdHgIplCJmkSlMA5UF0x7YZQ4gRxnaVJU9ce1SoC3RS1t3GCHpq7wfGh9jcyJ9bH9zppN91CJua3zHddcvkohGqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753335070; c=relaxed/simple;
	bh=86R1j6MbWEtTK6G7NlVajUAnkNYlTRCgOgM8O7O9ELY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qvDg9uZp/SrLQxLzkkhRHRdZg+iY+li8sZQg2F1ZzrhndqlnNCw+JeE1//Pi/0diAOjOVQSQTzHAI0RqtjBdqIVJKk/LGLzfTzxQVSDGP2bN2xoy6ADZt99DIWbw1oVNf2FAuDXJiePjBlKvuaID3H3S/+qa5a5hJgMVbBUcWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q04SwNZe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q04SwNZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA5DC4CEED;
	Thu, 24 Jul 2025 05:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753335070;
	bh=86R1j6MbWEtTK6G7NlVajUAnkNYlTRCgOgM8O7O9ELY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q04SwNZeIES58S0tpg4f7i2hWzKCFZrHRo2f7YFQ4F9MCJk1x4dToMVGsUU1s4Z/1
	 30MHkLI66+MxBKou0pMjFbT/Q896zAe74dnnExJ0M6Wq9WhL2VVG3UdsrVcpAZse57
	 7MuNMOJEfw/OclE9aSRqSShUXpEibeD+40y7jNeOlA1o7c+OyJAz1mhSCzo8mN2FVE
	 T3Uq3pqJbEzO6croTT0Z9HZHqauBiGH4z904Lg0ZTtCfqkrh+UJSYlx34ahOx66/1a
	 ADSx8R4zslzJEwjiQgmNX9jpXeqxsR8aL87tyE073S8gGlk3NPGXYbk13orNZLesPm
	 BGiWWJ82xjQNw==
Date: Thu, 24 Jul 2025 14:31:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Have eprobes handle arrays
Message-Id: <20250724143107.2f9b7aee45612ad1cfac33fd@kernel.org>
In-Reply-To: <20250723125232.15affc52@batman.local.home>
References: <20250723124202.4f7475be@batman.local.home>
	<20250723125232.15affc52@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 12:52:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 23 Jul 2025 12:42:02 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> >  [
> >    Create an eprobe called "sys" and attach it to sys_enter.
> >    Read the id of the system call and the second argument
> >  ]
> >  # echo 'e:sys raw_syscalls.sys_enter nr=$id:u32 arg2+8($args):u64' >> /sys/kernel/tracing/dynamic_events
> 
> The above has a typo. I originally had it as "filename=+8($args):u64"
> but decided to change it to "arg2" as its attached to the generic raw
> syscall. But in the process, I accidentally deleted the "=". So the
> above should be:
> 
>  # echo 'e:sys raw_syscalls.sys_enter nr=$id:u32 arg2=+8($args):u64' >> /sys/kernel/tracing/dynamic_events

Yeah, it should be :)

> 
> 
> > 
> >  [
> >    Create a synthetic event "path" that will hold the address of the
> >    sys_openat filename. This is on a 64bit machine, so make it 64 bits
> >  ]
> >  # echo 's:path u64 file;' >> /sys/kernel/tracing/dynamic_events
> > 
> >  [
> >    Add a histogram to the eprobe/sys which tiggers if the "nr" field is
> >    257 (sys_openat), and save the filename in the "file" variable.
> >  ]
> >  # echo 'hist:keys=common_pid:file=filename if nr == 257' > /sys/kernel/tracing/events/eprobes/sys/trigger
> 
> And I forgot to update this, as it's not "filename" any more, but
> "arg2". So this needs to be:
> 
>  # echo 'hist:keys=common_pid:file=arg2 if nr == 257' > /sys/kernel/tracing/events/eprobes/sys/trigger

OK, let me fix when I pick this.

The code looks good to me.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
