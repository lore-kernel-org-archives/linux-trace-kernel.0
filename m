Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5E45009;
	Fri, 25 Oct 2024 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819808; cv=none; b=De6FeVTzda/7mKQ+iP0ODi2YYmqueTSJc9R3/G7gPHwlKPr9ep5FYwl3UpxcPTncXCZrPjaJma7H7p+yK5fuaUcE5dFfRDQRnvOD7crPd3zbTm91/4cfkzrv2fQ9qTngL088YJV8QpI5vHeLWrm/7Wkq6ghD2iZmj+Jgg6ZqWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819808; c=relaxed/simple;
	bh=99Fnk9GqMcV0nClKxtjmeIeLszpN7gBzAAYHUoZt8+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmTT7fMXjPw4LJZCy67TNsXUIJkEz885Gt3r/Ni+xLNgEsIDrpD3CMk85xPvW2rGK28KnmeJAyrBFmcVyOZyy45ntj0vD/sGj/bdHki5A38oP7pyKQdSmuKafpXcK6TT6rJ/076wFFrNfC6PQml6PF9sg3FPit94VVy9IJL6+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0595EC4CEC7;
	Fri, 25 Oct 2024 01:30:06 +0000 (UTC)
Date: Thu, 24 Oct 2024 21:30:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
Message-ID: <20241024213003.6e27de6b@rorschach.local.home>
In-Reply-To: <20241021145810.9a9daec35cb83a04fe10208a@kernel.org>
References: <20241018214300.6df82178@rorschach>
	<20241021145810.9a9daec35cb83a04fe10208a@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 14:58:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +	if (!fgraph_initialized) {
> > +		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",  
> 
> Nit: Maybe it is better to call it as "tracing/fgraph:online" ?

I'm going to call it "fgraph:online" as it's not technically tracing.

I'll also add it to my urgent branch so it gets into 6.12.

-- Steve
