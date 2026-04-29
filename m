Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F5371CE3;
	Wed, 29 Apr 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777477654; cv=none; b=ONb8YA4T8ftSq+t8YmVWWhiNLJbXz9rJA6E10sTLhuyR2zoP1L9qIHUM6H3h3gwj8GSXuYoK9wkn+3eu++OPXjrwBnx0R0NwmHcIXHJlI3e6iRA2QKk7XEacWK+5r2UZ8IEzWMjh5LOh8CWE36qa8yvLEHVMrp5Sis6gZOLr12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777477654; c=relaxed/simple;
	bh=XQfWx4ioTmZGJSGwwIVnRnI6ZqPKhsQ2meJtxo5IF8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSyiM20OeQWkXK15Sguo9Rs3HkknHIsmi87oVd0w5rE6vWI1FBQt/7Lb73GWRHP98M9G0AjpUXS0F6kbMLOIZtsqc6yPID6k1+wJuLrIU7v/8gV8wdlZwAy4RQLwVM8wWQhARN37MHgxX6UmcE6no3gY6vE/spprK/rMJ+sJXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az7JqNvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az7JqNvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59114C19425;
	Wed, 29 Apr 2026 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777477654;
	bh=XQfWx4ioTmZGJSGwwIVnRnI6ZqPKhsQ2meJtxo5IF8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=az7JqNvDJ2uEKvZ+AGXKx0euHfWjEXHHLmpdrdaj4ArA8xg0jL4Pzujywkk7KvwvH
	 6rqvZgfWLHksceFfifT0xtrVo0EqS1qcRCtGAle7YGKqgLgyjxhlbTWXjJw31KODWI
	 yOsjfwAhx2CdDhm91Z+seejHqQwVhjCOOEHQPAJnoEKMUtgMnFWgsaRWHMUSbQgr0u
	 ntx/qSjNObSXi2a4iJ4u5ZJqTsRZsPfhLZPwH24t/jpgyE4YOLabi4A/cVYSilAq/j
	 WuehLSkYVLKeJ0/f/Ra6E493bEgeujDuEOz1CHl7g9Wsp0VWxtKsZeQcDd5ZFxcuZU
	 e6sqcSgLxrZlw==
Date: Wed, 29 Apr 2026 11:47:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, "Carlos
 O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
Message-ID: <20260429114747.4cf74d04@gandalf.local.home>
In-Reply-To: <20260429114355.6c712e6a@gandalf.local.home>
References: <20260429114355.6c712e6a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 11:43:55 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 4fcc7c58a105..005441233932 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -562,3 +562,4 @@
>  469	common	file_setattr			sys_file_setattr
>  470	common	listns				sys_listns
>  471	nospu	rseq_slice_yield		sys_rseq_slice_yield
> +472	nospu	stacktrace_setup		sys_stacktrace_setup

BTW, I have no idea what "nospu" is. I did some searches for PowerPC and
spu vs nospu and the only thing I found was a stackoverflow asking about
it, and the response was "don't worry about it".

I only picked nospu because I noticed that rseq_slice_yield used it, but
that doesn't give me a good feeling that it's correct.

-- Steve
