Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661322D4F1;
	Wed,  5 Feb 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738758347; cv=none; b=XUYBQkokSaPAmvJBzNQ6SyYshpqqzRU/DZNkXQ1dNif1dQLIrEwBzf8zw1qeLT6kjBrmb1g8YCC65NKH4gljGwGSUigMl3JWgWrC1ZFaXO1b4ViFBplEd/pqZShv5PRqBA5H1ZRkP33zt9Y6JB71YELZYp1vnLhcxwndjFRFlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738758347; c=relaxed/simple;
	bh=ggoaN55ddTjO79DYzE/IRBUIulmCS4JeJwzkFnfz7xg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JPI5T50QyvlbTphlA724EKGiGAabpo/WeJssh+bqJQlkUwLD0GL8uC2Va5faE9WQ0dmfnSbW/6OY45Ikr3OHHxiiPjDWRSYlksRrVG7ovakuoCMagci925hOzc94rfnLOsohfTsulm3vbumCHoBRem2hj8sh5f2aUP/h71NYi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzDYxQH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzDYxQH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C829C4CED1;
	Wed,  5 Feb 2025 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738758347;
	bh=ggoaN55ddTjO79DYzE/IRBUIulmCS4JeJwzkFnfz7xg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GzDYxQH+Oazd2qhIazHDBqPtQ92DgCBrI59o1S0PZZbuLvJOQCKMua15R1ZSgB15+
	 QSLJ11UVpO9SjAzJLfW3Sj+/hm2390z5+092e+KpQQCXaHa5n+i9uu+lTru/jN37Ig
	 k9D+2y2/75aH6H0H4qnbNowSnNW7/wF9ILAnuam1LI/4MuEpTqolnIo1FF9HtjYjDx
	 fug50dN5GilR5tjqXrXDPIOuSzVyAGHWqvvoOifx+B0bKbCZ81PtBHm5cu56iShLM3
	 BeLBE4uJUzimxCuYRFswofXcP6BBVe6iBzcrpvaqVDohIg7hOvgeeL6c2SNFJ8Stl3
	 u0Ol60sFuupQQ==
Date: Wed, 5 Feb 2025 21:25:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tracing: Introduce relative stacktrace
Message-Id: <20250205212543.42bd11a8093a074e9df27670@kernel.org>
In-Reply-To: <20250203103234.79c4a388@gandalf.local.home>
References: <173839458022.2009498.14495253908367838065.stgit@devnote2>
	<20250203103234.79c4a388@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 10:32:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat,  1 Feb 2025 16:23:00 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here is the 2nd version of adding relative stacktrace for tracing.
> > The previous version is here;
> > 
> > https://lore.kernel.org/all/173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com/
> > 
> > In this version, I changed the idea to only use the first 32bit of
> > the build_id of the modules instead of using live hash/id to identify
> > the module. Also, save the offset from the .text section for each
> > module instead of using the offset from the _stext for the module
> > address. (For the core kernel text address, keep using the offset
> > from _stext.)
> > 
> > This brings the following benefits:
> >  - Do not need to save the live module allocation information on
> >    somewhere in the reserved memory.
> >  - Easy to find the module offline.
> >  - We can ensure there are only offsets from the base, no KASLR info.
> > 
> > Moreover, encode/decode module build_id, we can show the module name
> > with the symbols on stacktrace.
> > 
> > Thus, this relative stacktrace is a better option for the persistent
> > ring buffer with security restricted environment (e.g. no kallsyms
> > access from user.)
> > 
> >  # echo 1 > options/relative-stacktrace 
> >  # modprobe trace_events_sample
> >  # echo stacktrace > events/sample-trace/foo_bar/trigger 
> >  # cat trace 
> >     event-sample-1622    [004] ...1.   397.542659: <stack trace>
> >  => event_triggers_post_call
> >  => trace_event_raw_event_foo_bar [trace_events_sample]
> >  => do_simple_thread_func [trace_events_sample]
> >  => simple_thread [trace_events_sample]
> >  => kthread
> >  => ret_from_fork
> >  => ret_from_fork_asm  
> >
> 
> I thought we decided that we didn't need the relative stack trace? That all
> we need to do is to expose the offset from the last boot, and a list of
> modules that were loaded and their addresses, and then we can easily
> decipher the stack traces into human readable format?

Hmm, if it is for the last boot, it is OK. So when the user mmapped the
buffer before using it for trace, such base-address metadata will be
exposed, and after using the trace, it is not exposed because that will
leak the current boot base address? (Or we can expose that?)

I meant that exposing the table for previous boot is safe, but it may
not be allowed for the live tracing. That is my concern.

Anyway, let me try storing the module table.

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
