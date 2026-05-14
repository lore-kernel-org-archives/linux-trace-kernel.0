Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7C2E65D;
	Thu, 14 May 2026 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732345; cv=none; b=KPY8IIUtT1eu8CxSa+MUT7GTGdVNybXMMOhwuWZmoFU3dxXVCjkPVCVbV37s43Og8lovU0H0pZ8cBIiCvGcUtCNpWn3xyTo2FIFv/dmTKmEqaG1fYIJ9GDZga11PlmPio9Mi60Os5lWZtFfjCJzxLVH0PlAuSLaVKVnc7AqOI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732345; c=relaxed/simple;
	bh=58Ncvm8U4NftlxbL2NaoLkxD00l5Dv7NqDsx6U775wY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oI3IT9kxP307Q6B8fswZ52oBOLMRqe4rXBff7aOrwcIXusTUK/u1MixgRvioUu0CzkywBoORuQEMtw+5/S8qa6+C6SMIi0d7CQ/kL+PK6wIOMZ6LHoXQ/nkut8r4l4cet2xAw0fsri3x3gSADuA6UYyxEg+G0VsTik4kTtT2hq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAAjImvb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAAjImvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D27C2BCB7;
	Thu, 14 May 2026 04:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778732344;
	bh=58Ncvm8U4NftlxbL2NaoLkxD00l5Dv7NqDsx6U775wY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aAAjImvbUaJXmRK1QPhmcgTLjCXSWuSOSBf5Mj5yJYJ8UkLHbBwxpORoUZfWlBCBY
	 ghsVYC1UK++lXOsC0IA7tIodmJySg6TsYtOxD6bdFHmwE1RjXR4S4zGmnh7lHBfl5V
	 tUogxmvmGSJ2pid68TZlrKxfeZsZ+GvA7/Y6mRwjdSjvqN+k8tqGS600tnqJ1z/9Sx
	 TPaVg+Llbp6EvR3cP8VSXutxHNplxF7/ay2BojH+6NlBeksEbjzjGVnSbiIfOoPRHn
	 0CW/d6sA55VB73Kuqro7bKgsm3IsAglSliff6P94zihEpG5+bzSyoQi0GYqqGR0vOL
	 6Ax/2QDm83Ynw==
Date: Thu, 14 May 2026 13:19:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chen Jun <chenjun102@huawei.com>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: Introduce a new filter_pred "caller"
Message-Id: <20260514131901.8c94136f6fede18c608c8a55@kernel.org>
In-Reply-To: <20260513124017.770e3098@gandalf.local.home>
References: <20260508122623.74290-1-chenjun102@huawei.com>
	<20260512084750.c17a93d0ccdacddfd52d3d40@kernel.org>
	<20260513124017.770e3098@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 12:40:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 12 May 2026 08:47:50 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Fri, 8 May 2026 20:26:23 +0800
> > Chen Jun <chenjun102@huawei.com> wrote:
> > 
> > > Low-level functions have many call paths, and sometimes
> > > we only care about the calls on a specific call path.
> > > Add a new filter to filter based on the call stack.
> > > 
> > > Usage:
> > > 1. echo 'caller=="$function_name"' > events/../filter  
> > 
> > Thanks for interesting idea :)
> > 
> > BTW, we already have "stacktrace". Since this actually checks
> > stacktrace, not caller, so I think we should reuse it.
> > Also, I think OP_GLOB is more suitable for this case.
> > (and more useful)
> 
> Actually, it's not a stack trace, it's a function that is called from other
> functions. But since "caller" sounds like a direct called function (stack
> trace of the first instance), I think perhaps it should be "called_within" or
> something similar. :-/

Yeah, what about "callers"?

> 
> Also, OP_GLOB can't work because it only works for a single function. At
> the time of parsing, it finds the function (and should probably error out
> if there's more than one function with a given name). It then records the
> start and end address of the function so it only needs to find if one of
> the entries in the stack trace is between the start and end of the function.

Ah, OK. It is just comparing address, not name.

> 
> I don't think this is possible with GLOB. We don't want to do a search of
> the functions when the event is triggered.

Agreed.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
