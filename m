Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE171DFE20;
	Wed,  2 Jul 2025 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453456; cv=none; b=XA1IRo6mg80z0BL+LLEcHPK1PNi+je3CNSYwWT9FkuoOkRQe3ExdLx/0rJC17eASNtIx/uq0Pa5Zis4+vdyBJ9upJ3/n01CIhILwO/I3wWtweCOQ6BtLPO6sYjnTZ2YTVUOUwZSsQlRwfvSSmbr25sIfCCm3fUcJMvF7y8w12uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453456; c=relaxed/simple;
	bh=vmWjYoBfYxlOYco20r6RIBn8cZBvLKaPN8KKU21TzFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUJmWs/cABK/VEU6GhCpoaa2DCcZ2LjJbY5Vu2oSWrZvzopaQGqM3Fapj7z+KjCw+sZritSPa794lXkGkwbIVKq7cRNX5rnkJKEQkwG2xuXd160o9H99filsH+LaaUgu9VeTfznrgq2GT+qnWuMiN5YMN6J2f6jeEwz6Yd8KH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=RnVx24f9; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="RnVx24f9"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D1B6D25989;
	Wed,  2 Jul 2025 12:50:44 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wXDIgFDv1hRC; Wed,  2 Jul 2025 12:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1751453443; bh=vmWjYoBfYxlOYco20r6RIBn8cZBvLKaPN8KKU21TzFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RnVx24f9NbGTPcW02J4/MbYtrfymL7Riba0/wdfkV2lAwx9rP1m+kCb0/bcq307O4
	 oo9GMzcj/rrGQHZbDaRM4t07RH4cxgUK3TTX28E+t9UGTl7uB57tiZLJIqt+uWJY9G
	 8V4Hut87c6Yg8tkudmT3/DYNX8AokQCL2xqQN6Ney3mA4DulZg7hJIyOQHsQNWydD0
	 kuTPDcem79XpW8KZVfCXb5OyWqMHGfDMNuXZCECPze1vHh8B1U4vylPGACv1d2nfOA
	 UFivrXR741lHUtMOtf8VrjvIZpDhJpYf9idLf9b7WxCIwe5TC3y24Iyw73FmSH5JD+
	 HB4t47eI68uJQ==
Date: Wed, 2 Jul 2025 10:50:24 +0000
From: Yao Zi <ziyao@disroot.org>
To: Alexandre Ghiti <alex@ghiti.fr>, Andy Chiu <andybnac@gmail.com>,
	alexghiti@rivosinc.com, palmer@dabbelt.com,
	Andy Chiu <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Mark Rutland <mark.rutland@arm.com>, puranjay12@gmail.com,
	paul.walmsley@sifive.com, greentime.hu@sifive.com,
	nick.hu@sifive.com, nylon.chen@sifive.com, eric.lin@sifive.com,
	vicent.chen@sifive.com, zong.li@sifive.com,
	yongxuan.wang@sifive.com, samuel.holland@sifive.com,
	olivia.chu@sifive.com, c2232430@gmail.com
Cc: Han Gao <rabenda.cn@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	regressions@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [REGRESSION] Random oops on SG2042 with Linux 6.16-rc and
 dynamic ftrace
Message-ID: <aGUO8L7oXpvEpvZo@pie.lan>
References: <aGODMpq7TGINddzM@pie.lan>
 <b060e694-caa0-4aa5-ac67-75531a5f60eb@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b060e694-caa0-4aa5-ac67-75531a5f60eb@ghiti.fr>

On Tue, Jul 01, 2025 at 02:27:32PM +0200, Alexandre Ghiti wrote:
> Hi Yao,
> 
> On 7/1/25 08:41, Yao Zi wrote:
> > Linux v6.16 built with dynamic ftrace randomly oops or triggers
> > ftrace_bug() on Sophgo SG2042 when booting systemd-based userspace,

...

> > Not sure either reverting the commits or fixing them up is a better
> > idea, but anyway the fatal first issue shouidn't go into the stable
> > release.
> 
> Let's fix this, we were expecting issues with dynamic ftrace :)
> 
> So the following diff fixes all the issues you mentioned (not the first
> crash though, I'll let you test and see if it works better, I don't have
> this board):

Thanks for the fix! I've tested it with both QEMU and SG2042, it does
fix the lockdep failures as well as the boot time crash on SG2042. The
boot-time crash is caused by the race so will disappear as long as we
fix the race.

> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4c6c24380cfd9..97ced537aa1e0 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -14,6 +14,16 @@
>  #include <asm/text-patching.h>
> 
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +void ftrace_arch_code_modify_prepare(void)
> +{
> +       mutex_lock(&text_mutex);
> +}
> +
> +void ftrace_arch_code_modify_post_process(void)
> +{
> +       mutex_unlock(&text_mutex);
> +}
> +
>  unsigned long ftrace_call_adjust(unsigned long addr)
>  {
>         if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> @@ -29,10 +39,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long
> fentry_ip)
> 
>  void arch_ftrace_update_code(int command)
>  {
> -       mutex_lock(&text_mutex);
>         command |= FTRACE_MAY_SLEEP;
>         ftrace_modify_all_code(command);
> -       mutex_unlock(&text_mutex);
>         flush_icache_all();
>  }
> 
> @@ -149,16 +157,17 @@ int ftrace_init_nop(struct module *mod, struct
> dyn_ftrace *rec)
>         unsigned int nops[2], offset;
>         int ret;
> 
> +       mutex_lock(&text_mutex);

Besides using the guard API, could we swap the order between
ftrace_rec_set_nop_ops() and calculation of the nops array? This shrinks
the critical region a little.

With or without the change, here's my tag,

Tested-by: Yao Zi <ziyao@disroot.org>

and also

Reported-by: Han Gao <rabenda.cn@gmail.com>
Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>

for their first-hand report of boot-time crash and analysis for the
first lock issue.

Regards,
Yao Zi

>         ret = ftrace_rec_set_nop_ops(rec);
>         if (ret)
> -               return ret;
> +               goto end;
> 
>         offset = (unsigned long) &ftrace_caller - pc;
>         nops[0] = to_auipc_t0(offset);
>         nops[1] = RISCV_INSN_NOP4;
> 
> -       mutex_lock(&text_mutex);
>         ret = patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
> +end:
>         mutex_unlock(&text_mutex);
> 
>         return ret;
> 
> Andy is also taking a look, I'll let him confirm the above fix is correct.
> 
> Thanks for the thorough report!
> 
> Alex
> 
> 
> > 
> > Thanks for your suggestions on the problems.
> > 
> > Regards,
> > Yao Zi
> > 
> > [1]: https://lore.kernel.org/all/20250407180838.42877-1-andybnac@gmail.com/
> > 
> > #regzbot introduced: 881dadf0792c
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
