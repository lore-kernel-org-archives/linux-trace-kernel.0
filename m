Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40A14F132;
	Wed, 29 Jan 2025 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738112304; cv=none; b=NA2MDIHeFYxqNgFIVZSmkmQAGGS9wT75rolvaqlSKdA4+tZwYxl4gE8ZTpIzGzxbfzYx4eKT/Sm5LE7v2GRM9pWWUfp4GLJgOCxa8tLyF4vBOzpg3O0DzNta39T9K9vs51fJQZjYYnJ2vySRb+FtxxnTYcNy6/XllUtczur0q1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738112304; c=relaxed/simple;
	bh=whcj9Hs0q16vQkrU5wz6cz2kiH/mCZLtj64NzerX3Ic=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FfW1Zz5DGDWcqbh1lfwofz05WvjSf5e60gaXGHCIy7hPBOoUcUhUOWjoXMpGye09crrvWuL60IHbfSb+8oml1Un3lSXl+eKXHKYDMNxXestk/miLb8cQlp2y6v/T2ULZqvpXgoVqmgUT/HaCz3b6u64+KYiE7LbfZojHBsSgg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsQyxe1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsQyxe1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7EBC4CED3;
	Wed, 29 Jan 2025 00:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738112304;
	bh=whcj9Hs0q16vQkrU5wz6cz2kiH/mCZLtj64NzerX3Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MsQyxe1mqvr3zIBZ38yx0iCAZbgnbkl5ZBkl4KqbCGGXBayZnXlxfJDuFElwVdrsU
	 PchX7I11OXqi8UyyCItU4K5F4GNXneB9vS62fE0GUJUTcQ52xjJTYfxUKKLtsBuvOx
	 kq3WgiA/1Ckt9hyLwijM56skWQDnTYIp8YRhjbzaxzQxSyphuO+OvE6ydyUvvPEdLc
	 GqdkuwM0by/bOyYWGUYJvngXryITI8pULZtUoLfb5Jy9JxcxCl9JMtNU+4WqcnWMRl
	 5PAWu1yEkxjH7q4tjv6mn/zOUoiPZwKTTN5O7OoN9h87a81x1RV7i8vZZ0Pwt6oc4l
	 942IKa3jV2dYw==
Date: Wed, 29 Jan 2025 09:58:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Daniel
 Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Message-Id: <20250129095819.fe6846ddab613460647db919@kernel.org>
In-Reply-To: <c3842632-cb15-469f-a6e8-8e9ccb3fff56@efficios.com>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
	<20250128112733.37d7c771@gandalf.local.home>
	<c3842632-cb15-469f-a6e8-8e9ccb3fff56@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 11:46:25 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2025-01-28 11:27, Steven Rostedt wrote:
> > On Tue, 28 Jan 2025 10:46:21 -0500
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> >> This does not handle the situation where a module is already loaded
> >> before tracing starts. In LTTng we have a statedump facility for this,
> >> where we can iterate on all modules at trace start and dump the relevant
> >> information.
> >>
> >> You may want to consider a similar approach for other tracers.
> > 
> > Last night Masami and I were talking about this. The idea I was thinking of
> > was to simply have a module load notifier that would add modules to an
> > array. It would only keep track of loaded modules, and when the trace hit,
> > if the address was outside of core text, it would search the array for the
> > module, and use that. When a module is removed, it would also be removed
> > from the array. We currently do not support tracing module removal (if the
> > module is traced, the buffers are cleared when the module is removed).
> 
> I'm trying to wrap my head around what you are trying to achieve here.
> 
> So AFAIU you are aiming to store the relative offset from kernel _text
> and module base text address into the traced events rather than the
> actual address.
> 
> Based on Masami's cover letter, this appears to be  done to make sure
> users can get to this base+offset information even if they cannot read
> kallsyms.
> 
> Why make the tracing fast path more complex for a simple matter of
> accessing this base address information ?
> 
> All you need to have to convert from kernel address to base + offset is:
> 
> - The kernel _text base address,
> - Each loaded module text base address,
> - Unloaded modules events to prune this information.
> 
> What is wrong with simply exporting this base address information in the
> trace buffers rather than rely on kallsyms, and deal with the conversion
> to module name / base+offset at post-processing ?

Hmm, that also works if we only consider the kallsyms access. But that
means to export KASLR information in the trace buffer. We need to check
it is OK.

My another concern is how to handle this stacktrace on live system. The
stacktrace has to be handled in both crash and live trace, but in both case
we need to consider not leaking KASLR offset.

Hmm, for avoiding the security concern, as Steve said, we may need to save
the module relative address, which may introduce a bit more overhead, but
it should be safer.

Anyway, this v1 may be able to leak the KASLR offset (or estimate it easier).
I think we have 2 options; (A) as Mathieu pointed, expose the offset
information via trace buffer. (B) as Steve pointed, fully relative offset
in stacktrace.

For the crash analysis, if we expose the offset information only when the
machine get a panic, (A) is safe because no one will continue to work. But
this may not work with live system (if we can not access to kallsyms).

(B) is always OK, but it takes more overhead to save the stacktrace.
(but how much it increase, we need to measure that)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
