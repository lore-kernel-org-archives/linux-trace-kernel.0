Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F19428F95F;
	Wed,  7 May 2025 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651829; cv=none; b=CCPcqrF+p3kx77Jjm+OGhSLjsx1tROY2IKIdrPic977gMZ3yB/qrxHkG2qVkv7oCk43Vwjfeu5WpeVVqoqlFMHvIbUQcKR1kjzsFapC/KoyWg6UVamRtyBj7ino0DWIzTjj/n5QrWaM7CZ9e085t9KGZfpDtB2B8M3plN+p8CpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651829; c=relaxed/simple;
	bh=/gWas1tIfDtR48k/PkaFTnLj0Rc/4uK7R3G2csSqI2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnjAX2CO9MYqjOKeNCwi2WkV5e/wrYRtQGD9Re9q2N4SbzclDY3rnin3iQ82h0WPid7j4AZUGARWqfNrmZFF7jwcDmW2zZDX3Vpp6Zt1BKd2HKFSauZl8sLnm/niM2zI2v2te37dKUR7Y8XtAXoZphrwzI/6yDyk8gnK55MEf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF08C4CEE7;
	Wed,  7 May 2025 21:03:47 +0000 (UTC)
Date: Wed, 7 May 2025 17:03:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH v6 16/22] x86/tracing: Move page fault trace points to
 generic
Message-ID: <20250507170357.25fe1b3d@gandalf.local.home>
In-Reply-To: <1126b28fe3f07a5d2239835fb13ba1128f28c78e.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
	<1126b28fe3f07a5d2239835fb13ba1128f28c78e.1745999587.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 13:02:31 +0200
Nam Cao <namcao@linutronix.de> wrote:

> Page fault trace points are interesting for other architectures as well.
> Move them to be generic.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/x86/mm/fault.c                                 |  2 +-
>  .../asm/trace => include/trace/events}/exceptions.h | 13 ++++---------
>  2 files changed, 5 insertions(+), 10 deletions(-)
>  rename {arch/x86/include/asm/trace => include/trace/events}/exceptions.h (79%)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 7e3e51fa1f95..ad4cb1502316 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -38,7 +38,7 @@
>  #include <asm/sev.h>			/* snp_dump_hva_rmpentry()	*/
>  
>  #define CREATE_TRACE_POINTS
> -#include <asm/trace/exceptions.h>
> +#include <trace/events/exceptions.h>

Note, this requires also changing arch/x86/mm/Makefile:

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 32035d5be5a0..629a8bf12219 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -34,8 +34,6 @@ obj-y				+= pat/
 CFLAGS_physaddr.o		:= -fno-stack-protector
 CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
 
-CFLAGS_fault.o := -I $(src)/../include/asm/trace
-
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o

As that CFLAGS_fault.o was needed to access the asm/trace/exceptions.h file.

-- Steve

>  
>  /*
>   * Returns 0 if mmiotrace is disabled, or if the fault is not
> diff --git a/arch/x86/include/asm/trace/exceptions.h b/include/trace/events/exceptions.h
> similarity index 79%
> rename from arch/x86/include/asm/trace/exceptions.h
> rename to include/trace/events/exceptions.h
> index 34bc8214a2d7..a631f8de8917 100644
> --- a/arch/x86/include/asm/trace/exceptions.h
> +++ b/include/trace/events/exceptions.h
> @@ -7,7 +7,7 @@
>  
>  #include <linux/tracepoint.h>
>  
> -DECLARE_EVENT_CLASS(x86_exceptions,
> +DECLARE_EVENT_CLASS(exceptions,
>  
>  	TP_PROTO(unsigned long address, struct pt_regs *regs,
>  		 unsigned long error_code),
> @@ -22,7 +22,7 @@ DECLARE_EVENT_CLASS(x86_exceptions,
>  
>  	TP_fast_assign(
>  		__entry->address = address;
> -		__entry->ip = regs->ip;
> +		__entry->ip = instruction_pointer(regs);
>  		__entry->error_code = error_code;
>  	),
>  
> @@ -30,18 +30,13 @@ DECLARE_EVENT_CLASS(x86_exceptions,
>  		  (void *)__entry->address, (void *)__entry->ip,
>  		  __entry->error_code) );
>  
> -DEFINE_EVENT(x86_exceptions, page_fault_user,
> +DEFINE_EVENT(exceptions, page_fault_user,
>  	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error_code),
>  	TP_ARGS(address, regs, error_code));
> -
> -DEFINE_EVENT(x86_exceptions, page_fault_kernel,
> +DEFINE_EVENT(exceptions, page_fault_kernel,
>  	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error_code),
>  	TP_ARGS(address, regs, error_code));
>  
> -#undef TRACE_INCLUDE_PATH
> -#undef TRACE_INCLUDE_FILE
> -#define TRACE_INCLUDE_PATH .
> -#define TRACE_INCLUDE_FILE exceptions
>  #endif /*  _TRACE_PAGE_FAULT_H */
>  
>  /* This part must be outside protection */

