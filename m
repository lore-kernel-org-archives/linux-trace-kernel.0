Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF851024;
	Mon, 11 Dec 2023 17:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A085C433C9;
	Mon, 11 Dec 2023 17:51:12 +0000 (UTC)
Date: Mon, 11 Dec 2023 12:51:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, outreachy@lists.linux.dev,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing: Update snapshot buffer on resize if it is
 allocated
Message-ID: <20231211125152.045f8b8a@gandalf.local.home>
In-Reply-To: <20231211213134.bd21cf745b8c5a0892891946@kernel.org>
References: <20231210225447.48476a6a@rorschach.local.home>
	<20231211213134.bd21cf745b8c5a0892891946@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 21:31:34 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sun, 10 Dec 2023 22:54:47 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The snapshot buffer is to mimic the main buffer so that when a snapshot is
> > needed, the snapshot and main buffer are swapped. When the snapshot buffer
> > is allocated, it is set to the minimal size that the ring buffer may be at
> > and still functional. When it is allocated it becomes the same size as the
> > main ring buffer, and when the main ring buffer changes in size, it should
> > do.  
> 
> nit: There seems two "when the snapshot buffer is allocated" case, maybe latter
> "it" means main buffer?

I changed the paragraph to be:

    The snapshot buffer is to mimic the main buffer so that when a snapshot is
    needed, the snapshot and main buffer are swapped. When the snapshot buffer
    is allocated, it is set to the minimal size that the ring buffer may be at
    and still functional. When it is allocated it becomes the same size as the
    main ring buffer, and when the main ring buffer changes in size, the
    snapshot should also change in size if it is allocated.

> 
> > 
> > Currently, the resize only updates the snapshot buffer if it's used by the
> > current tracer (ie. the preemptirqsoff tracer). But it needs to be updated
> > anytime it is allocated.
> > 
> > When changing the size of the main buffer, instead of looking to see if
> > the current tracer is utilizing the snapshot buffer, just check if it is
> > allocated to know if it should be updated or not.
> > 
> > Also fix typo in comment just above the code change.
> >   
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> BTW, the historical naming leads this kind of issues.
> Maybe we'd better to rename 'max_buffer' to 'snapshot_buffer'?

Agreed. But that's a cleanup for another day. Hmm, maybe that too should be
marked as "KTODO"?

  https://lore.kernel.org/all/369bc919-1a1d-4f37-9cc9-742a86a41282@kadam.mountain/


There's a lot of things that we have been discussing on these ring-buffer
patches that could be KTODO items.

-- Steve
