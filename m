Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDF376
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20F2C433C7;
	Wed,  4 Oct 2023 01:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696382845;
	bh=yTvWR13RSP/MZoj7Q5M+5eAsbvb/Cb/re1TdaZF6QWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vHH6otbNjUX0863bHcWAejSkNzIOQ4rj+9+2Vtwj1mlrLp3WIsZ133c/rfOuX9c4C
	 l2tS3XKKzC/44nAb34iTO9c4lLOYFIoe8/AxMxqPhfCfuDK0KfAV6YYqjt1ft99Rte
	 QHvr3FgHJgnTtkONH/hyDj1Om9EMzDLsMYfcYtYqzCpQ6gi7USBYoZQPSW+V0Tf/Xa
	 4srsD8x5VNqxa2/xQYBhBlNSrezvf6bBOB37XkUZVnR3f0jQTDcIzN2m/hBOHBhp/z
	 JihsP5EKpk8Ag1/druZzyAQrUDIg0XMaNmYrOXHIJbHlRHWvgQ61AQYi8f7UsPb9XQ
	 at2st+eLwJ4Vg==
Date: Wed, 4 Oct 2023 10:27:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sami
 Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now
 prefixed with __riscv_
Message-Id: <20231004102722.7baddc2a0e4969afffb55eed@kernel.org>
In-Reply-To: <20231003182407.32198-1-alexghiti@rivosinc.com>
References: <20231003182407.32198-1-alexghiti@rivosinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Oct 2023 20:24:07 +0200
Alexandre Ghiti <alexghiti@rivosinc.com> wrote:

> ftrace creates entries for each syscall in the tracefs but has failed
> since commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") which
> prefixes all riscv syscalls with __riscv_.
> 
> So fix this by implementing arch_syscall_match_sym_name() which allows us
> to ignore this prefix.
> 
> And also ignore compat syscalls like x86/arm64 by implementing
> arch_trace_is_compat_syscall().
> 

Looks good to me,

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/ftrace.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 740a979171e5..2b2f5df7ef2c 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -31,6 +31,27 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	return addr;
>  }
>  
> +/*
> + * Let's do like x86/arm64 and ignore the compat syscalls.
> + */
> +#define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
> +static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
> +{
> +	return is_compat_task();
> +}
> +
> +#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> +static inline bool arch_syscall_match_sym_name(const char *sym,
> +					       const char *name)
> +{
> +	/*
> +	 * Since all syscall functions have __riscv_ prefix, we must skip it.
> +	 * However, as we described above, we decided to ignore compat
> +	 * syscalls, so we don't care about __riscv_compat_ prefix here.
> +	 */
> +	return !strcmp(sym + 8, name);
> +}
> +
>  struct dyn_arch_ftrace {
>  };
>  #endif
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
