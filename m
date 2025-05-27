Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4F4A04;
	Tue, 27 May 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748389242; cv=none; b=hJ0gbm8afY8IEJpTyeop6wRyflPzMzwfyd5WcSzXPJ2YahoXEt2icTW6+L65+6hHPm9NBz4VAbo7Nj1xWzJutebGPL2KzcmOB/wCqkWdc9lfPibp5W9ZL/ZA+9g3xPJdCMmelMKuo1phsr0qiHZ6RPSnmToHADxGg1i0m1Kacp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748389242; c=relaxed/simple;
	bh=nk1C4i86GH8zQGfebFsOhrIjArGpj9Hi9dwiXgsZumo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O8qqyOvL5P1qwIkjlBCEQ1p10P6cKG+4y7HE8WfpQ0u+dvE/BSx73Hm8HTsh0sMcGe0yK5OwftfF5pfA3ZTLSQbU/QzKiowWju/FyKBNRHtP5GJ3wN0F82PlPQMwdJxtaUdyrV7DvW1OmDGaqwP8RkLabtFW1GRqGvExdin30U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPQ0Z5xo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPQ0Z5xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18609C4CEE9;
	Tue, 27 May 2025 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748389241;
	bh=nk1C4i86GH8zQGfebFsOhrIjArGpj9Hi9dwiXgsZumo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KPQ0Z5xowyWWNDyDJJCRqDi9EquNvbl6yxO5OsWcwzJa2bdzDs127B7mZcXcBYUyq
	 OnBAbtgaTnvnjw5iOzOPgLTzXxm9d0rM8uDau6GTYtvzUqUUpjLb14AZXKLGGkMJ20
	 p0+FA6hvVL/ExhuoNWLrhGd0FBu7GWwl6AUf4h5FhytOwJ4NYkjArsACCOEziQ0stG
	 AvglWd+PgK30vlt1Kg9exFUkHZVNr09mmshcC6xbxWGUkbXJKtRdqZBLGLe5SWNUXS
	 9ZZziqEWVNBuhY2XO3A1AnI5yL9uYEF4mGYTKQ1tIqthBQ5N925tWZM5iGQzqHxPnn
	 amtkNjugx5kzA==
Date: Wed, 28 May 2025 08:40:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Runji Liu <runjiliu.tech@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: trace: boottime-trace.rst: fix typo
Message-Id: <20250528084038.e9d91c6717af6163ccf46849@kernel.org>
In-Reply-To: <20250527100145.1e974c21@gandalf.local.home>
References: <20250526134046.1042-1-runjiliu.tech@gmail.com>
	<20250527100145.1e974c21@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 10:01:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 26 May 2025 21:40:46 +0800
> Runji Liu <runjiliu.tech@gmail.com> wrote:
> 
> > Replace misspelled "eariler" with "earlier" and drop the stray period
> > after "example".
> > 
> > Signed-off-by: Runji Liu <runjiliu.tech@gmail.com>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This looks good to me. Thanks!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> 
> -- Steve
> 
> > ---
> >  Documentation/trace/boottime-trace.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
> > index d594597201fd..3efac10adb36 100644
> > --- a/Documentation/trace/boottime-trace.rst
> > +++ b/Documentation/trace/boottime-trace.rst
> > @@ -198,8 +198,8 @@ Most of the subsystems and architecture dependent drivers will be initialized
> >  after that (arch_initcall or subsys_initcall). Thus, you can trace those with
> >  boot-time tracing.
> >  If you want to trace events before core_initcall, you can use the options
> > -starting with ``kernel``. Some of them will be enabled eariler than the initcall
> > -processing (for example,. ``kernel.ftrace=function`` and ``kernel.trace_event``
> > +starting with ``kernel``. Some of them will be enabled earlier than the initcall
> > +processing (for example, ``kernel.ftrace=function`` and ``kernel.trace_event``
> >  will start before the initcall.)
> >  
> >  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
