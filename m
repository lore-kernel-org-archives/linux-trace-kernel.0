Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEFC3D45F2;
	Tue, 12 May 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604456; cv=none; b=N28dRE4maCB+AH8dG4W7bOaiBaXBHqxPxTLGFJo23MlxivAXuJy7V0AU8g4kFNFtUAKDwQjdYuaWBJWu4Y8yX/s4m+OsC1E+PMCXMVCanoeStDPjuSpbdb6LqEoUVLGXZnyJVVDh9giCGj04eNcT46SyKdDAGqHdy1bJGnzZ0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604456; c=relaxed/simple;
	bh=SQiXRCTMHitWKtX9nn8ITcwXQ1w75Kgz8MfeWODfDw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERzkSYDKsXjvmc+QB5RHL6v6kWxB4Qkk3OrNO40xF/9xLXHHOrpFksbET2cLKlWuXq+ZwJ+tol0Ew2Bm6QMJBI/0M3baAjAQ/2WJDI9t/BOuITklUYuwfH6OJLVLaa0ivbQWT7mkj+d6VfqbRRv+H+sHohWOpFIGqISpEdUrNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jccz+lMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jccz+lMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B30EC2BCB0;
	Tue, 12 May 2026 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778604455;
	bh=SQiXRCTMHitWKtX9nn8ITcwXQ1w75Kgz8MfeWODfDw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jccz+lMYj0olvOYzDF57O3t/wqeKW+yPU+Rs95yBAAQlrfRzEHYmQa3kffK04a7Fd
	 2r6R9jgo7Q4hnkq5kf5+n/fs8E78sk2vjAWoi+XwgnieByKJ+BE3GyuupdUi3n2QZP
	 dOfsC996CQqCkDjPQmEYdkspHjFv/vV2xv4DG4ybvaGPN2dlHOrN5n44Ei1zbgp1s1
	 5LWDoxF9V2CBiTBxhXOSe8PacPnS6fzCUQ1QxPbYp6Mc3Gu7/c3C9FC8P3r6/c/YSO
	 m8obpZ/z4CZveOAFe7efWcd92sMrtv7aPV0wnGlXqKYi14rVe2tWhJKJHV0Xv01QO6
	 ZDkV2MAHd5TUA==
Date: Tue, 12 May 2026 12:47:33 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees Cook
 <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>, Sam James
 <sam@gentoo.org>, Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
Message-ID: <20260512124733.57a38cb5@gandalf.local.home>
In-Reply-To: <43158d95-b4c2-44d2-a244-eb546fb2bfaa@linux.ibm.com>
References: <20260429114355.6c712e6a@gandalf.local.home>
	<43158d95-b4c2-44d2-a244-eb546fb2bfaa@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 09:46:30 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> >   STACKTRACE_REGISTER_SFRAME - This registers the sframe
> >   STACKTRACE_UNREGISTER_SFRAME - This removes the sframe
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>  
> 
> LGTM.  Some comments/questions below.

Note, after talking with people at LSF/MM/BPF, I plan on completely
changing this system call into two distinct ones, and only for sframes.
I'll be sending that later this week.

> 
> > diff --git a/include/uapi/linux/stacktrace.h b/include/uapi/linux/stacktrace.h  
> 
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_STACKTRACE_H
> > +#define _UAPI_LINUX_STACKTRACE_H
> > +
> > +enum stacktrace_setup_types {
> > +	STACKTRACE_REGISTER_SFRAME	= 1,
> > +	STACKTRACE_UNREGISTER_SFRAME	= 2,
> > +};
> > +
> > +#endif /* _UAPI_LINUX_STACKTRACE_H */  
> 
> > diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c  
> 
> Having the syscall live in kernel/unwind/sframe.c means it is only
> available if config option HAVE_UNWIND_USER_SFRAME is selected (which
> triggers sframe.o to be built and linked into the kernel), which makes
> sense as long as it only implements sframe-specific functionality.
> I suppose it could be moved elsewhere if non-sframe use cases would
> arise in the future?

The new system calls will only be for sframes. Other unwinders will need to
implement their own system calls.

> 
> Would Dylan need to guard it when introducing HAVE_UNWIND_KERNEL_SFRAME?
> Provided the syscall fails with -ENOSYS if not implemented (e.g. when
> HAVE_UNWIND_USER_SFRAME is not enabled) the dummy implementations of
> sframe_add_section() and sframe_remove_section() in linux/sframe.h also
> return -ENOSYS, so the user observable behavior would be the same and
> it would not matter.  Do you agree?

I'll reply to that when Dylan's patches get closer to acceptance ;-)

> 
> > @@ -12,8 +12,10 @@
> >  #include <linux/mm.h>
> >  #include <linux/string_helpers.h>
> >  #include <linux/sframe.h>
> > +#include <linux/syscalls.h>
> >  #include <asm/unwind_user_sframe.h>
> >  #include <linux/unwind_user_types.h>
> > +#include <uapi/linux/stacktrace.h>
> >  
> >  #include "sframe.h"
> >  #include "sframe_debug.h"
> > @@ -838,3 +840,38 @@ void sframe_free_mm(struct mm_struct *mm)
> >  
> >  	mtree_destroy(&mm->sframe_mt);
> >  }
> > +
> > +/**
> > + * sys_stacktrace_setup - register an address for user space stacktrace walking.
> > + * @op: Type of operation to perform
> > + * @addr_start: The virtual address of the stacktrace information
> > + * @addr_length: The length of the stacktrace information
> > + * @text_start: The virtual address of the text that @addr_start represents
> > + * @text_length: The length of teh text
> > + *
> > + * This system call is used by dynamic library utilities to inform the kernel
> > + * of meta data that it loaded that can be used by the kernel to know how
> > + * to stack walk the given text locations.
> > + *
> > + * Currently only sframes are supported, but in the future, this may be used
> > + * to tell the kernel about JIT code which will most likely have a different
> > + * format.
> > + *
> > + * The type command may be extended and parameters may be used for other
> > + * purposes.
> > + *
> > + * Return: 0 if successful, otherwise a negative error.
> > + */
> > +SYSCALL_DEFINE5(stacktrace_setup, int, op, unsigned long, addr_start,
> > +		unsigned long, addr_length, unsigned long, text_start,
> > +		unsigned long, text_length)  
> 
> Would it make sense to keep the parameters generic from start, similar
> to how it is done in prctl()?  Or can this be changed later, if the need
> arises?

With discussions at LSF/MM/BPF I'll have the system call parameters be a
pointer to a structure, and a size of that structure. All the API will then
be part of the structure.

Thanks for reviewing,

-- Steve

> 
> SYSCALL_DEFINE5(stacktrace_setup, int, op, unsigned long, arg2,
> 		unsigned long, arg3, unsigned long, arg4, unsigned long, arg5)
> 
> > +{
> > +	switch (op) {
> > +	case STACKTRACE_REGISTER_SFRAME:
> > +		return sframe_add_section(addr_start, addr_start + addr_length,
> > +					  text_start, text_start+text_length);  
> 
> Nit:
> 					  text_start, text_start + text_length);
> 
> > +	case STACKTRACE_UNREGISTER_SFRAME:
> > +		return sframe_remove_section(addr_start);
> > +	}
> > +	return -EINVAL;
> > +}  
> Thanks and regards,
> Jens

