Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233940BFC;
	Wed, 20 Dec 2023 16:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E1C433C8;
	Wed, 20 Dec 2023 16:29:36 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:30:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 06/15] ring-buffer: Clear pages on error in
 ring_buffer_subbuf_order_set() failure
Message-ID: <20231220113037.5432487d@gandalf.local.home>
In-Reply-To: <20231221012314.1d041383caf29e31c49dfc4e@kernel.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185629.179352802@goodmis.org>
	<20231221012314.1d041383caf29e31c49dfc4e@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 01:23:14 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 19 Dec 2023 13:54:20 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > On failure to allocate ring buffer pages, the pointer to the CPU buffer
> > pages is freed, but the pages that were allocated previously were not.
> > Make sure they are freed too.
> > 
> > Fixes: TBD ("tracing: Set new size of the ring buffer sub page")  
> 
> Do you merge this fix to the original one in the same series later?
> I think it is better to merge it for git bisect.

It only fixes the new functionality. If a git bisect gets here for that,
then we know the issue already. But it shouldn't break bisect for things
that happened before this change.

The reason I'm not merging this with the other patch is because the
original patch is from Tzvetomir, who isn't working on this anymore. I want
to keep his patches untouched, and anything I do is on top of it.

-- Steve
