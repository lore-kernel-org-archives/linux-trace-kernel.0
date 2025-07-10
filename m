Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DA173;
	Thu, 10 Jul 2025 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752105992; cv=none; b=YYO+JTO0ArxwCH23+YhXYlzIfeuNQ101Waz5WHcJ8SHFV9zicjnKF1+P/wmsXgmy7qRyefsxrcsriv88rodRtvNKp+tej8RpaDsmEnmy5ilDWYDsgm29Ag1WjKZ4eLv0ZFKEJ3zWZgeL0p667DMof1MitO0cNpYHjqWYGF2kOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752105992; c=relaxed/simple;
	bh=6A1NBhselrYKFebK5UkZ4t+OQWLuowk2Z0FQ1uuVC64=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F21V/yx/ktMk/+4K1ikuGzf2K/v+Psq8IbljOsPU/NsfuFsGl8MXQj8viF3mo5p0ZTb74R281BBdBRGmX2yCvoj1WXCzJPHNAbgKq5XCzXTocrKc15nA+bKSqtUmmtDoWk3RYJz92KbGRCtXhu9cCYhvAHcG08LwtZAtK9wYDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORrp505S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORrp505S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB65C4CEEF;
	Thu, 10 Jul 2025 00:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752105991;
	bh=6A1NBhselrYKFebK5UkZ4t+OQWLuowk2Z0FQ1uuVC64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORrp505S3OyLA/3F6Zb0Y0y8cn5Lu2zljTqBIaGRCRwYeqQtjUiF6wEtSc1mo08mX
	 R01OKtsPlkmiarEki3GD16wHxliQRXlIyvcQDzdWSQSyYs3laLDnOTB5k+FvHsT40T
	 M3sQyQweEj7VNaLd4zOYHV56RNTEjbe6T6W7z1v8qx7F656fzr6BqRNJCArOlXA8Dn
	 hph5s1r8cuIp7XGNTG2W+g52NWg0PAwG56/pXF2VU7mGptLOx60UlWc6c+HiT3yQzo
	 zypq3fds3IWGRNOI2rfI9EcNmwY48Yd4+34b/54rTC+yOO6Ma8HSb/o8fy8F3VkQvy
	 0NhNpOFlPaECw==
Date: Thu, 10 Jul 2025 09:06:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Han
 Gao <rabenda.cn@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi
 <ziyao@disroot.org>
Subject: Re: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a
 race condition
Message-Id: <20250710090627.999979465d2c263ac2833048@kernel.org>
In-Reply-To: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
References: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Jul 2025 08:33:48 +0000
Alexandre Ghiti <alexghiti@rivosinc.com> wrote:

> As reported by lockdep, some patching was done without acquiring
> text_mutex, so there could be a race when mapping the page to patch
> since we use the same fixmap entry.
> 
> Reported-by: Han Gao <rabenda.cn@gmail.com>
> Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reported-by: Yao Zi <ziyao@disroot.org>
> Closes: https://lore.kernel.org/linux-riscv/aGODMpq7TGINddzM@pie.lan/
> Tested-by: Yao Zi <ziyao@disroot.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/ftrace.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4c6c24380cfd9d6c51f0e4340cd674160b83a610..22e7bdf8de2b6ca950cf2c8b734bc82ea46ba8bf 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -14,6 +14,16 @@
>  #include <asm/text-patching.h>
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +void ftrace_arch_code_modify_prepare(void)

To be sure this is acquire the text_mutex, add __acquires(&text_mutex) here.

> +{
> +	mutex_lock(&text_mutex);
> +}
> +
> +void ftrace_arch_code_modify_post_process(void)

Ditto, add __releases(&text_mutex) here.

others looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> +{
> +	mutex_unlock(&text_mutex);
> +}
> +
>  unsigned long ftrace_call_adjust(unsigned long addr)
>  {
>  	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> @@ -29,10 +39,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
>  
>  void arch_ftrace_update_code(int command)
>  {
> -	mutex_lock(&text_mutex);
>  	command |= FTRACE_MAY_SLEEP;
>  	ftrace_modify_all_code(command);
> -	mutex_unlock(&text_mutex);
>  	flush_icache_all();
>  }
>  
> @@ -149,6 +157,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>  	unsigned int nops[2], offset;
>  	int ret;
>  
> +	guard(mutex)(&text_mutex);
> +
>  	ret = ftrace_rec_set_nop_ops(rec);
>  	if (ret)
>  		return ret;
> @@ -157,9 +167,7 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>  	nops[0] = to_auipc_t0(offset);
>  	nops[1] = RISCV_INSN_NOP4;
>  
> -	mutex_lock(&text_mutex);
>  	ret = patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
> -	mutex_unlock(&text_mutex);
>  
>  	return ret;
>  }
> 
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250708-alex-fixes-1e719b9899f3
> 
> Best regards,
> -- 
> Alexandre Ghiti <alexghiti@rivosinc.com>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
