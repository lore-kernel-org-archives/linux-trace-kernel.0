Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CB14658F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959051; cv=none; b=lc+1C0aHZv/QXXBhiLPKDuHRp+QO8AoUTiHbsjXo3cdjwoYjJgMcbEng1e44br09Fasj3BtHnzb7etVGBjHs4MQJKSFidBpq7sZgEd3TPHUXwD2DT0ROg8+GbgAv/ay9aqKdt/l8ocLD1cTpP61abydTtS4bey7tJ64QHWryxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959051; c=relaxed/simple;
	bh=FAmb9OP/yhHqfvp5QJEoMN6GVkuXquZEABUW+jbiC3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJ23RNwbTMcdRIRQkc8kPZg8JeuE8MMc1ea7RCii3b8adH3vMTFikafBS6cYwGo7+ov7++WBcySsLdlsU8n9opjdF55WHdk5lj8rcpuFX1VdWlqhLR+4ulcwWBOXvWUq1/BBfjVzARJKAQnRJ2BpPaUBi31fHlEhYv3JlWa1ei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5B6C4CED1;
	Wed, 15 Jan 2025 16:37:30 +0000 (UTC)
Date: Wed, 15 Jan 2025 11:37:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: kprobe not always triggering
Message-ID: <20250115113733.650db5c0@gandalf.local.home>
In-Reply-To: <e5d64ac8-5a30-4196-a5e5-b3d2743356b1@flourine.local>
References: <f91a64bf-c5cb-4d36-b50b-67cdcdccdccc@flourine.local>
	<20250115101715.12c6cce3@gandalf.local.home>
	<e5d64ac8-5a30-4196-a5e5-b3d2743356b1@flourine.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 17:29:34 +0100
Daniel Wagner <dwagner@suse.de> wrote:

> > There's been cases of a compiler inlining some functions for the code
> > called in the same file. If that happened, then those will likely be
> > dropped. That can be tested by adding:
> > 
> > bool noinline nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >                 enum nvme_ctrl_state new_state) 
> > 
> > You would think it shouldn't inline it, but there's nothing in the spec
> > that says it can't do so.  
> 
> This did the trick, now I see the missing state transitions.

Grumble. I expect this issue to come up more often. We need a way to detect
this. Come to think of it, I believe this is more of a clang "feature". As
I do recall some of the other reports were from the clang compiler as well.

-- Steve
