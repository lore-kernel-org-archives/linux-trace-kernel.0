Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D09A927;
	Tue, 27 May 2025 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748305067; cv=none; b=h4kzAQOYXz4nBm17DhBZa1zydSGROm8w9dNWlgArhiqYXVD77qMMcmVIZisd8bSFEeDor0cHIQJfxvZjb04KhpKwi5UUQtqIS+nwC9OlKWh1TJ+GNouuGBKFwE+qF2t5zHnljbVoLgeU/kpTcNFGU6VIjIlgJ72lbWXk6nvyfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748305067; c=relaxed/simple;
	bh=wMr1HOcueB5Am6KF/Ss7kwFnpRQwGEkr9hpd5ICRctU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qHjVV7goBTRCDjUQ/JNaNgEJOkh6P6PO+MylprFteGNHgxcxajPBFHSZp07PBFgD/ssKwqrz/xnLHQ/r9ZAmCp9ntg19Ez6Otwk4HMoeyXL6Smq5UcXx2UG50rtfMfVoWEwyTuvz0/U0XViycnHLJcpa1tl182mwMKtiM1MResk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJtR09PK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJtR09PK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78129C4CEE7;
	Tue, 27 May 2025 00:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748305066;
	bh=wMr1HOcueB5Am6KF/Ss7kwFnpRQwGEkr9hpd5ICRctU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bJtR09PKSIGXNwtceQGOGnEOWVPbiYxFDrm6KgKis0CwtB6sQeCOjAENolVvYP3P2
	 +lnrLu6N0zBd4MxIrhS1ZbZSFWnDjqWFAY+5vGstfcOHjtjCOi6bgVz7AGfkEN/n6Q
	 i/Q8zzuTiQNArcWc7Pqs7bEDhyJ4Y0s/GYtV7tdh60Fr9DBTAaeEu2+UOK6Z/JDxT+
	 HTK015xBK4ZluGjMFsRh6tG025HGC6p+rBn0nOs9EDbGYo27U8OeD3pjuLnF2gaeog
	 tJt51ub3hCVwJjynlRw4+uGX6OGk1/0jRsUPs36GTHytRXJaQeUFfVBNG1gjvrjrq6
	 BK2tsBI/jK8gA==
Date: Tue, 27 May 2025 09:17:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-Id: <20250527091743.d036018195b7668aea0753c0@kernel.org>
In-Reply-To: <20250526120342.cdcfca9ac3c2161d48c03af5@kernel.org>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
	<20250523172857.02ab4a75@gandalf.local.home>
	<20250526120342.cdcfca9ac3c2161d48c03af5@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 12:03:42 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 23 May 2025 17:28:57 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 23 May 2025 16:54:25 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > I think we also need this:
> > > 
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index 7d837963dd1e..456efebc396a 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -3638,6 +3638,9 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
> > >  
> > >  	rb_reset_tail(cpu_buffer, tail, info);
> > >  
> > > +	/* The new page should have zero committed */
> > > +	rb_init_page(next_page->page);
> > > +
> > >  	/* Commit what we have for now. */
> > >  	rb_end_commit(cpu_buffer);
> > >  	/* rb_end_commit() decs committing */
> > 
> > No we don't need it ;-)
> > 
> > I'm looking deeper into the code and we have this:
> > 
> > 		/*
> > 		 * No need to worry about races with clearing out the commit.
> > 		 * it only can increment when a commit takes place. But that
> > 		 * only happens in the outer most nested commit.
> > 		 */
> > 		local_set(&next_page->page->commit, 0);
> > 
> > When the tail page gets moved.
> 
> Yeah, when the page gets written, it is cleared.

What about this? It seems if we keep the reader->page->commit, when we
catch up the tail page, rb_get_reader_page() returns new reader (== tail)
because reader->read(==0) < reader->page->commit. But we should not return
new reader.


diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5034bae02f08..179142db9586 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5522,6 +5522,12 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
                cpu_buffer->last_overrun = overwrite;
        }
 
+       /* But if we catch up to the tail, do not return reader page. */
+       if (cpu_buffer->commit_page == cpu_buffer->reader_page) {
+               reader = NULL;
+               goto out;
+       }
+
        goto again;
 
  out:


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
