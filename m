Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6934A04;
	Mon,  7 Apr 2025 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743986037; cv=none; b=NlLZTta92lFq/nFufcOCI3v7oHKlpbIbNbXJJctMz057uW6jnPW0MNUNZlq3ZYqKsx8UjEady+lSSGfaHrTX21UGfUN5vHp/y7IMVskmmdvuV3JVBn7dRhjgvwAy0xSjkYqP1T15dk8wxPoRQgLP//ZrviKwPX7o0vZ2+mMDaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743986037; c=relaxed/simple;
	bh=YKkc3sQ/4L552d8qUaKPTIAMhzZq6WvaxTu60Lnsawk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q3psxrMHOWsGvyRG1RmZNuO/KgEoaFuxH6FeWXseyjPU53/Hi6B/xgbdxkWAhF2+falmXj7fAkm4X8yAKYBxKafHhT49rdUT4rq/GwH/fEiWN5UkxgaQMwTN9HBnwnIdASDn2YTve+AjhZt6bJ3z3iCOYzH0UxNyTcQs0t5RXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYQrUKzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYQrUKzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598DBC4CEE3;
	Mon,  7 Apr 2025 00:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743986036;
	bh=YKkc3sQ/4L552d8qUaKPTIAMhzZq6WvaxTu60Lnsawk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OYQrUKzQ1RIBYp/uDc2apiy5EEbvGf8ejCwVwXpy0lr6cA13cR4nK4rVkLQfLKTKQ
	 XCqo9jz1X1Jyy92KOKhXzgJC/3y2TtiwHjs9J0Y5WsaE5IOqUruvTWMclkjvQdTosc
	 PuhHMf6jvSRnot9F7jrLqU4DapR4p4IrR+y3dX9OARPURYIlFmUrXlXAW3ms0fG922
	 WOt4OulUbHbzstkCSSYQl19bmgTDufPn6ebwFbPTF39oXrVS+s4/yJOaOGHn8jfqOE
	 /GBUyMjkzg9ww7hjXmQfpTi+bhoqzzaLpIXNmjlmKUsPAjbTDW3FnjqbEyb5vAlT6j
	 bI63r8JrhAwDQ==
Date: Mon, 7 Apr 2025 09:33:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 1/2] mm/memblock: Add reserved memory release
 function
Message-Id: <20250407093351.5514960330bebbe07b707431@kernel.org>
In-Reply-To: <20250405023018.g2ae52nrz2757b3n@master>
References: <173989132750.230693.15749600013776132201.stgit@devnote2>
	<173989133862.230693.14094993331347437600.stgit@devnote2>
	<20250405023018.g2ae52nrz2757b3n@master>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 5 Apr 2025 02:30:18 +0000
Wei Yang <richard.weiyang@gmail.com> wrote:

> On Wed, Feb 19, 2025 at 12:08:58AM +0900, Masami Hiramatsu (Google) wrote:
> >From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> >Add reserve_mem_release_by_name() to release a reserved memory region
> >with a given name. This allows us to release reserved memory which is
> >defined by kernel cmdline, after boot.
> >
> >Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >Cc: Andrew Morton <akpm@linux-foundation.org>
> >Cc: linux-mm@kvack.org
> >---
> > Changes in v4:
> >  - Use free_reserved_area() according to Mike's comment.
> > Changes in v2:
> >  - Rename reserved_mem_* to reserve_mem_*.
> >---
> > include/linux/mm.h |    1 +
> > mm/memblock.c      |   66 +++++++++++++++++++++++++++++++++++++++++++---------
> > 2 files changed, 55 insertions(+), 12 deletions(-)
> >
> >diff --git a/include/linux/mm.h b/include/linux/mm.h
> >index 7b1068ddcbb7..1ee9e7447485 100644
> >--- a/include/linux/mm.h
> >+++ b/include/linux/mm.h
> >@@ -4123,6 +4123,7 @@ void vma_pgtable_walk_begin(struct vm_area_struct *vma);
> > void vma_pgtable_walk_end(struct vm_area_struct *vma);
> > 
> > int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
> >+int reserve_mem_release_by_name(const char *name);
> > 
> > #ifdef CONFIG_64BIT
> > int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
> >diff --git a/mm/memblock.c b/mm/memblock.c
> >index 95af35fd1389..8cd95f60015d 100644
> >--- a/mm/memblock.c
> >+++ b/mm/memblock.c
> >@@ -16,6 +16,7 @@
> > #include <linux/kmemleak.h>
> > #include <linux/seq_file.h>
> > #include <linux/memblock.h>
> >+#include <linux/mutex.h>
> > 
> > #include <asm/sections.h>
> > #include <linux/io.h>
> >@@ -2283,6 +2284,7 @@ struct reserve_mem_table {
> > };
> > static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
> > static int reserved_mem_count;
> >+static DEFINE_MUTEX(reserve_mem_lock);
> > 
> 
> This looks break the memblock tests in tools/testing/memblock.
> 
> memblock.c:2289:8: warning: type defaults to ‘int’ in declaration of ‘DEFINE_MUTEX’ [-Wimplicit-int]
>  2289 | static DEFINE_MUTEX(reserve_mem_lock);
>       |        ^~~~~~~~~~~~
> memblock.c:2289:1: warning: parameter names (without types) in function declaration
>  2289 | static DEFINE_MUTEX(reserve_mem_lock);
>       | ^~~~~~
> memblock.c: In function ‘reserve_mem_find_by_name’:
> memblock.c:2332:9: warning: implicit declaration of function ‘guard’ [-Wimplicit-function-declaration]
>  2332 |         guard(mutex)(&reserve_mem_lock);
>       |         ^~~~~

Hmm, this means the memblock test builds the kernel source code in user
space. I think we need to add linux/mutex.h under tools/testing/memblock.

But this is fragile by design. As I did for lib/bootconfig and
tools/bootconfig, you should use __KERNEL__ and makes it not depending on
the kernel header files because it does not expected to be used in user
space.
Even if I added mutex.h, it stopped with another reason.

test -L linux/memblock.h || ln -s ../../../../include/linux/memblock.h linux/memblock.h
test -L asm/asm.h || ln -s ../../../arch/x86/include/asm/asm.h asm/asm.h
test -L asm/cmpxchg.h || ln -s ../../../arch/x86/include/asm/cmpxchg.h asm/cmpxchg.h
cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o main.o main.c
test -L memblock.c || ln -s ../../../mm/memblock.c memblock.c
cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o memblock.o memblock.c
memblock.c: In function 'memblock_add_range.isra':
memblock.c:685:17: warning: 'end_rgn' may be used uninitialized [-Wmaybe-uninitialized]
  685 |                 memblock_merge_regions(type, start_rgn, end_rgn);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
memblock.c:591:42: note: 'end_rgn' was declared here
  591 |         int idx, nr_new, start_rgn = -1, end_rgn;
      |                                          ^~~~~~~
cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o lib/slab.o lib/slab.c
cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o mmzone.o mmzone.c
cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o slab.o ../../lib/slab.c
../../lib/slab.c:6:10: fatal error: urcu/uatomic.h: No such file or directory
    6 | #include <urcu/uatomic.h>
      |          ^~~~~~~~~~~~~~~~
compilation terminated.
make: *** [<builtin>: slab.o] Error 1


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
