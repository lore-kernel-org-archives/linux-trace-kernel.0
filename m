Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C158AB4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84687C433C7;
	Tue, 28 Nov 2023 15:35:22 +0000 (UTC)
Date: Tue, 28 Nov 2023 10:35:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, dmaluka@google.com,
 Sean Paul <seanpaul@chromium.org>, Arun Easi <aeasi@marvell.com>, Daniel
 Wagner <dwagner@suse.de>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-ID: <20231128103544.2ef0d584@gandalf.local.home>
In-Reply-To: <20231129001738.5041154000c4c1df58f6c7a1@kernel.org>
References: <20231127174108.3c331c9c@gandalf.local.home>
	<20231129001738.5041154000c4c1df58f6c7a1@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 00:17:38 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> On Mon, 27 Nov 2023 17:41:08 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > A trace instance may only need to enable specific events. As the eventfs
> > directory of an instance currently creates all events which adds overhead,
> > allow internal instances to be created with just the events in systems
> > that they care about. This currently only deals with systems and not
> > individual events, but this should bring down the overhead of creating
> > instances for specific use cases quite bit.  
> 
> This sounds good, but can the eventfs reduce such overhead because
> if the user doesn't touch the actual event, the event dentry will
> be released soon?

Yes, but this also removes the creation of the meta data behind it. Which
has a descriptor for every event. And since there are over a thousand
events, this is still quite a bit of savings. It also removes the
eventfs_inode that represents each directory.

> > Note, this may also be useful for creating instances in the eventfs, but
> > I'm not sure how to do this there. I could add a deliminator:
> > 
> >   mkdir /sys/kernel/tracing/instances/foo::sched,timer  
> 
> Can we limit this after making an instance? In that case, we can use
> rmdir to remove unused "systems" directories. Or, maybe we can create
> it afterwards with mkdir or use comand to a pseudo file.
> 
> echo sched:* timer:* > instances/foo/available_events

That, or I even thought of allowing rmdir on event systems, and even mkdir.

 # cd instance/foo/events
 # rmdir *
 # mkdir sched timer

-- Steve
