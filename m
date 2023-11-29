Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B3249F4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8283AC43391;
	Wed, 29 Nov 2023 15:25:23 +0000 (UTC)
Date: Wed, 29 Nov 2023 10:25:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, dmaluka@google.com,
 Sean Paul <seanpaul@chromium.org>, Arun Easi <aeasi@marvell.com>, Daniel
 Wagner <dwagner@suse.de>
Subject: Re: [PATCH] tracing: Allow creating instances with specified system
 events
Message-ID: <20231129102545.56901df5@gandalf.local.home>
In-Reply-To: <20231129235821.d99da161644525a2fa988938@kernel.org>
References: <20231128122117.2276f4a7@gandalf.local.home>
	<20231129235821.d99da161644525a2fa988938@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 23:58:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > - Dynamic events had to be specified directly to still allow them to be
> >   created.  
> 
> I have a question about this point. Does this mean the dynamic event files
> will be created in the instance which limits the "system"?
> For this point, I would like to allow limiting dynamic events on instance too.
> If user needs to use specific one, e.g. synthetic, then it is possible to
> add it to the filter.

I'm going back and forth on this. Here's my thoughts about it.

Arguments for allowing all dynamic events:

1. There's not many. This code is basically a way to keep the overhead of
   an instance down. By removing all static events, it can substantially lower
   the memory footprint.

   As synthetic events are user created, there shouldn't be too many that
   would cause a memory foot print issue, and the user also has a bit of
   control of what events are created.

2. We have no idea what a user may want to do with those events. What if
   the user wants to see an event in that buffer and creates a synthetic
   event for it? Should the kernel create a policy for that?

Arguments against defaulting dynamic events in:

1. The list is created in the kernel. The instance is not created by the
   user and thus the kernel could have more control over it.

2. If the user really wants to have dynamic events, they can create another
   instance with the needed events or use the top level.

Hmm, writing this out, I am now leaning more toward not defaulting dynamic
events in. And if we can create a way to dynamically add and remove events
systems from an instance (via mkdir and rmdir), this should not be an issue.

Anyone else have any thoughts about this?

-- Steve
