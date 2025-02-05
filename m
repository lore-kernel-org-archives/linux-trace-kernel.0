Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D6524C;
	Wed,  5 Feb 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762128; cv=none; b=Ow+3LvPu9FQ7cRhvF4EDVc1eQC+AWrxwpRgxuJyt0oHDkM+MEJ86hVbV1BQcRGdzOm2/bAOlWdw1t33T55lFCkm21nZa/Ogej++w5sMH9jwx0skuqGXsqs9MVOGy/vSCuyy4OMml3Ewsg/S1ePpHzsgeZGoTRsoMa1p8GSNgFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762128; c=relaxed/simple;
	bh=VliUYrxzvWGZYXPpZPbQBqc18smjVB0ZVSPKC6q2eRY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bqeQ3q8mYsZ2LK3UMkVAKWLu4KmYdrB+hxHQxOWzJP08XfG/I/1/23XN4V91WvWrv4t5PychCHtEn2O7ZVuA+C7RpAvn3qkx8wyPWKnz7Av1BKkVYKP8o9AtpjCj/enq4DNzlOftYVQytZFONZ6btjbTlteHv0YCNRI0IttkBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuhj6jCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuhj6jCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497EAC4CED1;
	Wed,  5 Feb 2025 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738762127;
	bh=VliUYrxzvWGZYXPpZPbQBqc18smjVB0ZVSPKC6q2eRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fuhj6jCtWyohPKupVEjuhUXE1wiJDq20QhloVigbMTrf7IKHmFVOPulm0dM2R1gmI
	 lohaJI91SsR2qbBuX6medMCSDx7S4CeRp7KPm4qmiounpLPZ9yW8tCfUQMkVlXCw41
	 T6nqkigvXN15eN4OjQKjE15R3yhWFWhUewKe1meJjwXZ3abZJ+cg8biBeo/RIq4GEO
	 1rp1YPd8NGkqsd/Au+L/8BJo8OlQcPdVKKpOhn1vj4/1DiHwl4RerDsOZDKZg7TSpz
	 CBoVOqatN0Eiu7B6y6zm9fndyO3V/EV3QKYQGiGvuwp1XxakF0jPlMIDbrLhgHevE4
	 2n9Bd5zI4U2cg==
Date: Wed, 5 Feb 2025 22:28:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tracing: Introduce relative stacktrace
Message-Id: <20250205222843.ba78a0319089ad8cb8915f89@kernel.org>
In-Reply-To: <20250205212543.42bd11a8093a074e9df27670@kernel.org>
References: <173839458022.2009498.14495253908367838065.stgit@devnote2>
	<20250203103234.79c4a388@gandalf.local.home>
	<20250205212543.42bd11a8093a074e9df27670@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 21:25:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 3 Feb 2025 10:32:34 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat,  1 Feb 2025 16:23:00 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > Hi,
> > > 
> > > Here is the 2nd version of adding relative stacktrace for tracing.
> > > The previous version is here;
> > > 
> > > https://lore.kernel.org/all/173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com/
> > > 
> > > In this version, I changed the idea to only use the first 32bit of
> > > the build_id of the modules instead of using live hash/id to identify
> > > the module. Also, save the offset from the .text section for each
> > > module instead of using the offset from the _stext for the module
> > > address. (For the core kernel text address, keep using the offset
> > > from _stext.)
> > > 
> > > This brings the following benefits:
> > >  - Do not need to save the live module allocation information on
> > >    somewhere in the reserved memory.
> > >  - Easy to find the module offline.
> > >  - We can ensure there are only offsets from the base, no KASLR info.
> > > 
> > > Moreover, encode/decode module build_id, we can show the module name
> > > with the symbols on stacktrace.
> > > 
> > > Thus, this relative stacktrace is a better option for the persistent
> > > ring buffer with security restricted environment (e.g. no kallsyms
> > > access from user.)
> > > 
> > >  # echo 1 > options/relative-stacktrace 
> > >  # modprobe trace_events_sample
> > >  # echo stacktrace > events/sample-trace/foo_bar/trigger 
> > >  # cat trace 
> > >     event-sample-1622    [004] ...1.   397.542659: <stack trace>
> > >  => event_triggers_post_call
> > >  => trace_event_raw_event_foo_bar [trace_events_sample]
> > >  => do_simple_thread_func [trace_events_sample]
> > >  => simple_thread [trace_events_sample]
> > >  => kthread
> > >  => ret_from_fork
> > >  => ret_from_fork_asm  
> > >
> > 
> > I thought we decided that we didn't need the relative stack trace? That all
> > we need to do is to expose the offset from the last boot, and a list of
> > modules that were loaded and their addresses, and then we can easily
> > decipher the stack traces into human readable format?
> 
> Hmm, if it is for the last boot, it is OK. So when the user mmapped the
> buffer before using it for trace, such base-address metadata will be
> exposed, and after using the trace, it is not exposed because that will
> leak the current boot base address? (Or we can expose that?)
> 
> I meant that exposing the table for previous boot is safe, but it may
> not be allowed for the live tracing. That is my concern.

Ah, nevermind. Anyway when we trace stack from specific trace event,
it exposes the symbol address which is easily estimated.

So for completely different context, one possible way to use case of
this relative stacktrace (and relative pointers as wider application)
is not exposing any kernel text address to users including the address
in the trace events (maybe we can introduce something like `POINTER()`
macro for TRACE_EVENT(). But this is another story.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
