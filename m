Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713AE208A0;
	Thu,  6 Feb 2025 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802338; cv=none; b=BwenW6q4p4GX+gmWaoVUyqT7xhJ2u/dsHw0ncsaRZXafCmhscT6yusdVl9xRhKibscHtt3Wk36pOXB49cFpMvVcDriLYSGUX3numbcyAoEyntS2ZZ04PXIUzIQex2HrL4rirs5tGo4ZeT5LSuzVZ2jiGodjiC41GiYBkJK/yoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802338; c=relaxed/simple;
	bh=6NEWffn5TF7fJkmlSgu4+HtDk/hvUt/HNmUs50Ldhgo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rvLdw6+WXr61ZKDY4uqiNG2rU3tnlnunRSnyh3RLqCJ2s3YutO2plK4lszETzW/20T8llDaU6zyFVoMaxVEp526L1dGxXvBzWAx5yTMrSLk4Gn8tcL2CC5hiy5sWIIUQROp0r6kZnqBx5MM5xiquE2qytTsBIXyA/bDGp4kWWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwXnynat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwXnynat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFF7C4CED1;
	Thu,  6 Feb 2025 00:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738802338;
	bh=6NEWffn5TF7fJkmlSgu4+HtDk/hvUt/HNmUs50Ldhgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DwXnynatjPhZhz97feGwcw9AChGqr1AUObOIEutlsutljbu9x8Ytvk5V1GyTgYK7S
	 qHiwZC2fW337eu/1tXq6pG45S9iN8dzbrULmCBWet6r6grps466R/0XhfG7tpbKmln
	 Dx25bxDZOThGg+Xbr/m96aMybtnmX6hRWTCzJRGc3pXCz4oUZ4YnBpbQvOGyIsKB+S
	 jOeP9FFzlZ7/eFYHNJlKbrOLRDIVVxC02hwV2HfaOZNvoXNSjMKfaMv9nIuinDtH9g
	 /XdhNeqyji58mIwpl2tfVIrfOoz68lqDkCvsZ1hO9ARIQpc0uyYv8s6vwfvgE8ICF5
	 90+qMLI2hy0Tw==
Date: Thu, 6 Feb 2025 09:38:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Haiyue Wang <haiyuewa@163.com>
Cc: x86@kernel.org, linux-trace-kernel@vger.kernel.org,
 samitolvanen@google.com, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org (open
 list:FUNCTION HOOKS (FTRACE))
Subject: Re: [PATCH v1] ftrace: Fix compile error when CONFIG_GENDWARFKSYMS
 is enabled
Message-Id: <20250206093853.4e55405ccfcba7111705f395@kernel.org>
In-Reply-To: <20250205180116.88644-1-haiyuewa@163.com>
References: <20250205180116.88644-1-haiyuewa@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu,  6 Feb 2025 02:00:42 +0800
Haiyue Wang <haiyuewa@163.com> wrote:

> When switching from CONFIG_GENKSYMS to CONFIG_GENDWARFKSYMS enabled, the
> build is failed:
> 
>   AS      arch/x86/entry/entry.o
> In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
>                  from <stdin>:3:
> ./arch/x86/include/asm/ftrace.h: In function ‘arch_ftrace_get_symaddr’:
> ./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of function ‘get_kernel_nofault’ [-Werror=implicit-function-declaration]
>    46 |                 if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
>       |                     ^~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> File "asm-prototypes.h" is added to entry.S by 'scripts/Makefile.build',
> adding the missed declaration header file can also fix the error:
> 
>  getasmexports =                                                        \
>     { echo "\#include <linux/kernel.h>" ;                               \
>       echo "\#include <linux/string.h>" ;                               \
> +     echo "\#include <linux/uaccess.h>";                               \
>       echo "\#include <asm/asm-prototypes.h>" ;                         \
>       $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
> 
> Fixes: 2bc56fdae1ba ("ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr")

Thanks for the fix. And this fixes one of problems.
Another one is that `is_endbr()` is defined in <asm/ibt.h> but that also depend
on CONFIG_HAVE_FENTRY.

Let's pick this and fix above issue.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> ---
>  arch/x86/include/asm/ftrace.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index f9cb4d07df58..063ce70837bb 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -34,6 +34,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	return addr;
>  }
>  
> +#ifdef CONFIG_X86_KERNEL_IBT
> +#include <linux/uaccess.h>
> +#endif
> +
>  static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
>  {
>  #ifdef CONFIG_X86_KERNEL_IBT
> -- 
> 2.48.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
