Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AC5C080
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583DDC433C8;
	Tue, 28 Nov 2023 14:54:15 +0000 (UTC)
Date: Tue, 28 Nov 2023 09:54:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Sean Paul
 <seanpaul@chromium.org>, Arun Easi <aeasi@marvell.com>, Daniel Wagner
 <dwagner@suse.de>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-ID: <20231128095437.423f5f88@gandalf.local.home>
In-Reply-To: <20231128092029.342f5f03@gandalf.local.home>
References: <20231127174108.3c331c9c@gandalf.local.home>
	<ZWXntcHNflkbrxd7@google.com>
	<20231128092029.342f5f03@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 09:20:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 28 Nov 2023 14:14:29 +0100
> Dmytro Maluka <dmaluka@chromium.org> wrote:
> 
> 
> > This limitation will cause (unrelated) events created by modules that
> > are insmoded after creating the instance to be also added to the
> > instance. Why not filter those as well?  
> 
> I did think of that. But that would be a separate patch. Where I would save
> the string that is passed in, and whenever a new module is loaded, it would
> only add the events if the events' system matches in the string. This would
> also allow adding event systems that do not yet exist.

Now that I'm implementing this, it makes more sense to just do that as one
patch. Otherwise the check against the systems string is redundant, as the
creation of the events needs to check against the tr->systems too. I found
that I was deleting most of this patch to implement the change.

-- Steve
