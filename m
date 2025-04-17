Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC579C4;
	Thu, 17 Apr 2025 05:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744866600; cv=none; b=mLYJcPb1srzCsYZrsYO8IkIxGXSYM8dCng5ih9hOqCfwtnxBTmQ+idUD0nieMB2JfKG7rZk07ezZ428vY8akDMpL38z+BK7JL/JyBu5kvtr1McPc2ZbifBHVFB5lV2ZMPYcC12qXruFEl8OoLrbkA0/c1CD6hdJ1KVo3VpXye4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744866600; c=relaxed/simple;
	bh=a0PxjADT9yns48CkGR8gkFWxExFp1tdMczNAaBszUpo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QGUDhSmaKeoJ87RY7oNc7ok4hLwkakpbIB3K8ZFqLUKhOCwGCCW4/8ZbNryiUKQsIqzDc82PNYgL8VnhsLzkCqd72U67wmGCOWrEMSDUeE9uKY7iLZOPZQAbrB27XOWBft8FmnQ/8AjUI3/iRRwAy/vnZW2rtANPIZX0whl3bZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAz3yEzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAz3yEzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01EBC4CEE7;
	Thu, 17 Apr 2025 05:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744866599;
	bh=a0PxjADT9yns48CkGR8gkFWxExFp1tdMczNAaBszUpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jAz3yEzQAnjL8mgiPPDzRsidGrabee2AwWCs9N6n6CWGErlYcTp7ab3vtfWbOGO53
	 sML9SM4zpk93n/S1ASmd6YNPwmfemNBC/7ZnkUPMidlK63CUk8N3p3h/cfU1wA0yIV
	 qsjVw/Mq+vrYACGQ9/4nof4ScbamWL4P8OE/siSx6OQSlxvGc+mLf3lpuGZI7xUZ+t
	 UlTW5Yr0n+PT2sCnpPnOPxa99Uj3POVgpJQB3hmOVgOI2CI/zdG9sPFXsSosHAYFvq
	 3/xFCr0o9hVsos3dKHPtV60J9K80HCG45APB5kqitL6CSMmKLtYgRCQkjFOVF4R7B1
	 mZYjMCuREaiWg==
Date: Thu, 17 Apr 2025 14:09:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Record trace_clock in last_boot_info
Message-Id: <20250417140957.d0051e19f562cb2b80a8e1c0@kernel.org>
In-Reply-To: <20250416111227.34299b4e@batman.local.home>
References: <174481479787.2426861.10924329074660376176.stgit@mhiramat.tok.corp.google.com>
	<20250416111227.34299b4e@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 11:12:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 16 Apr 2025 23:46:38 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Record trace_clock information in the trace_scratch area and show
> > it via `last_boot_info` so that reader can docode the timestamp
> > correctly.
> > With this change, the first line of the last_boot_info becomes
> > trace_clock which is used when the trace was recorded. E.g.
> > 
> > /sys/kernel/tracing/instances/boot_mapped # cat last_boot_info
> > trace_clock: mono
> > ffffffff81000000        [kernel]
> > 
> 
> As this will not go in this cycle, which means tools may be built
> around this.
> 
> Either we put it at the end, or we make it:
> 
> # trace_clock: mono
> ffffffff81000000        [kernel]
> 
> Where "info" like "trace_clock" will be in the comment section, and all
> non comments will be addresses.

OK. Anyway, as we discussed offline, I'll update it to just set the
value to the "trace_clock" file instead of using "last_boot_info".

Thank you,

> 
> Tooling can then just ignore the comment section, or read it for more
> information.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
