Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEF2DB7AD;
	Sat, 31 Jan 2026 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825997; cv=none; b=t1hWDB/DecxFFFYjbFvhGFm8j2YjCwHBJC/mBLkegALrYC9GidOsqVoCt114MIONy1gHnvf1PQf2F+BaRUYl1mkxEH3UZ5jfroFIb33EXUM9lGFaIdbpoSg6GG0Ktt4DBLuc2hmPUTfkXky8OzrN0hCxd8jGTOAI/QpNDlaP3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825997; c=relaxed/simple;
	bh=FzypzMsIx1auhhmIROFgxVR1ihamkqARKK/IIYyo8dA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mnKuZIZL6GX4JFCWRu0RH/rKO20naT18chtt4SlpEKeOR3F8aJmDehg9FH5i/5pJ5BrrHQX5FPm2AL+39U22VgdOuPQS3wkoi9pNpzZBJNl/grfFwVyU0qSzUyAACosc0/zdYUx9NQtHOtKZ/XLXXvNCDDap7ZREwZ3JSBaothw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+DZ0SQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+DZ0SQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBF6C4CEF7;
	Sat, 31 Jan 2026 02:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769825996;
	bh=FzypzMsIx1auhhmIROFgxVR1ihamkqARKK/IIYyo8dA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S+DZ0SQGNPlnq8EoobLfFuFmI594SWd3HvJHtbLxTXFTTFn08JCjPG4uQ1hg8COcI
	 YnEhb/XqY63+OoNmxdzy8xGoLfwpsFpaKQDZAUBphTu+SJgx5Pzh3c2RAG4OB0v28T
	 Dx0zGIrSE1uLCQ4fcz6n57he2BapzGzQKrAmPCq7cK8dirXpbvp1yKntrmVvfPRC00
	 Pwta2nCOO82Ie8y0BT5zic4hsQyXwyFC+hXgMrlzW5uilpkezFGBJyqQ9sq9x50MtT
	 FROx4YstCQtyEaWqTAhB9lJA4OE48XTdTd7AZD6N1tnTULTsbnFA6Q7hBYpSyv6p8x
	 Hwf37pCuU546g==
Date: Sat, 31 Jan 2026 11:19:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Julius Werner <jwerner@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bootconfig: Fix to terminate value search if it hits a
 newline
Message-Id: <20260131111951.99058146c69f2a729f7be643@kernel.org>
In-Reply-To: <CAODwPW90ALuMy6kFPqQSj_vN7krRz6cpksAUm2WHJNYwRNxHnA@mail.gmail.com>
References: <176974810577.124104.16012554973099890517.stgit@devnote2>
	<20260130095331.5c9f754e@gandalf.local.home>
	<CAODwPW90ALuMy6kFPqQSj_vN7krRz6cpksAUm2WHJNYwRNxHnA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 15:26:46 -0800
Julius Werner <jwerner@google.com> wrote:

> > > Note that if the line has a comment, it still keep searching the
> > > value to the next line::
> > >
> > >   foo = # comment
> > >   value
> 
> This seems inconsistent to me tbh. I think someone could reasonably
> write a bootconfig like this:
> 
> foo =                  # We leave foo empty here because <reason>
> bar = value
> 
> and expect it to work. There's nothing in the documentation that
> suggests empty values would behave differently if there is a comment
> behind them.

But we already accept that example in the tree.

  tools/bootconfig/samples/good-array-space-comment.bconf

So it is hard to change this syntax. But without comment, the
document defines the value is terminated with a newline. Thus
it needs to be fixed.


> 
> Also, I believe your patch might inadvertently break this case (which
> I think(?) is supposed to work):
> 
> foo = first array value,
>       second array value,
>       third array value

Oops, good catch! I should add this as a good sample.

> 
> Because __xbc_parse_value() returns from the first value with `&next`
> pointing at the newline behind the comma, and that is passed to the
> next iteration of __xbc_parse_value() which will now no longer skip
> it. I think an already started array may need to be treated as a
> special case here and you may want to add another
> skip_spaces()/skip_comment() to the loop in xbc_parse_array().

OK, let me fix it.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
