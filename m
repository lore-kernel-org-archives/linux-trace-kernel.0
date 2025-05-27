Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E001CD2C;
	Tue, 27 May 2025 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748315753; cv=none; b=P8xJViwraa79YR8aFCQdYbpI/OrRVix9HXqhnNSIvNk7OwCo+BMUuQWt/XQoa5zsC+E3K74ZqZXub95N0iHzFnIW8fztMRJzyBbRBd3xINDE3YWG5nJIQlk2JGypaCcxk+lpwqpPRIZo6AS+MRZCYqiKZ+lekrvs4gpMjqSAgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748315753; c=relaxed/simple;
	bh=IVG8hcaS0HMjvnDTtNlgb60z2Nuvm9LQjKKz3uFlBkU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J2bNTq6u9HRbktAnJjyUlCC+tZRyG8vGQ+EIdnI3Xx5LcJ4SDQNUTiIeppn2Ui7s1p3RmQoZlNpO6/HNrS6hGvL6IqVfkkuP43J1c5oVuguQGAogRymFsdE9SxPqCtWIvSJoDwWuQXWf+U86k9SwAc0uCu5vpXIQx7j6eZIBdVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQf6w47o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQf6w47o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60697C4CEE7;
	Tue, 27 May 2025 03:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748315752;
	bh=IVG8hcaS0HMjvnDTtNlgb60z2Nuvm9LQjKKz3uFlBkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rQf6w47oz1XGQ4g2lZld5xAtoZrVqHMKIB/c0G55sj//106lgfmYQFEiqhdG1QCDV
	 WidOU8l5ESm8ZbLNR5teOBg+x7WFJXb1KAj3536jtFQeqzppg3jb9dNMZXSCnKd2V1
	 sLxPJ3nvKgxZALMjOsWE4qXMjsAuONA14K1CzbxSGMnNnRH3i8zYGLw9dP/ncL9hRR
	 EuchWUy8QKZuVKNLzhJI6RsHipCT8c32SibXEis/iksUMgjKIYQsX4M/GUatYTXh9C
	 V9QXYxff2alHwq0wq53hZGuEr04ckZfbKvGek0boR055n8/yqUnCGpPh5MhEqdjGg4
	 EFn32kFhxGFCA==
Date: Tue, 27 May 2025 12:15:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-Id: <20250527121549.2d40608e9463199d85bf9ba4@kernel.org>
In-Reply-To: <20250527091743.d036018195b7668aea0753c0@kernel.org>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
	<20250523172857.02ab4a75@gandalf.local.home>
	<20250526120342.cdcfca9ac3c2161d48c03af5@kernel.org>
	<20250527091743.d036018195b7668aea0753c0@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 09:17:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 26 May 2025 12:03:42 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Fri, 23 May 2025 17:28:57 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Fri, 23 May 2025 16:54:25 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > I think we also need this:
> > > > 
> > > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > > index 7d837963dd1e..456efebc396a 100644
> > > > --- a/kernel/trace/ring_buffer.c
> > > > +++ b/kernel/trace/ring_buffer.c
> > > > @@ -3638,6 +3638,9 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
> > > >  
> > > >  	rb_reset_tail(cpu_buffer, tail, info);
> > > >  
> > > > +	/* The new page should have zero committed */
> > > > +	rb_init_page(next_page->page);
> > > > +
> > > >  	/* Commit what we have for now. */
> > > >  	rb_end_commit(cpu_buffer);
> > > >  	/* rb_end_commit() decs committing */
> > > 
> > > No we don't need it ;-)
> > > 
> > > I'm looking deeper into the code and we have this:
> > > 
> > > 		/*
> > > 		 * No need to worry about races with clearing out the commit.
> > > 		 * it only can increment when a commit takes place. But that
> > > 		 * only happens in the outer most nested commit.
> > > 		 */
> > > 		local_set(&next_page->page->commit, 0);
> > > 
> > > When the tail page gets moved.
> > 
> > Yeah, when the page gets written, it is cleared.
> 
> What about this? It seems if we keep the reader->page->commit, when we
> catch up the tail page, rb_get_reader_page() returns new reader (== tail)
> because reader->read(==0) < reader->page->commit. But we should not return
> new reader.
> 
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 5034bae02f08..179142db9586 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5522,6 +5522,12 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>                 cpu_buffer->last_overrun = overwrite;
>         }
>  
> +       /* But if we catch up to the tail, do not return reader page. */
> +       if (cpu_buffer->commit_page == cpu_buffer->reader_page) {


Hmm, I found this might not work if it is called twice.
Maybe rb_get_reader_page() can check the reader_page->ts > head_page->ts
and return NULL (or reader_page if read < commit) at first.

Thank you,

> +               reader = NULL;
> +               goto out;
> +       }
> +
>         goto again;
>  
>   out:
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
