Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5BA154BF5;
	Mon,  8 Dec 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765173598; cv=none; b=KTgYmzfdghkyXtifBDTWUu9J3VoRnB84fIKlpbOk2Tiux3lxLO4FmI9EFENG+fdjsuq5f7nDGj7p0phTdPH+xWNDaZEjB/SWYcoKrGgLpK/bfN2j+lM783KEVjHSoQAzla3BwnMtnrVeybga9KWT2nI3gw0S9l7Wo19aKJp6Ojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765173598; c=relaxed/simple;
	bh=aMT5FJgyUn78/c+kEvPqsEByXoUn4Byxfq8zgDe330o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B0HqJ594K8elxDpk/XkhjM10UtUTibmcbC8bB9UwhvuFO/SCL5jLjbfhr/WbxChWP3/g18rPKnVqu0iRN+eSrv6B1QRokD9955wlhsJ7KrXbUVemsojE3Y29FsNOBTt2DWuutpjCJ3lEmcZR1Ns/3XIoTWIVIRogUzCDCdcMsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI/cUEJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI/cUEJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBABC4CEF1;
	Mon,  8 Dec 2025 05:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765173598;
	bh=aMT5FJgyUn78/c+kEvPqsEByXoUn4Byxfq8zgDe330o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qI/cUEJWgr3xtwKdqtNrS8WYDJxYzy9VyFI1Coz8W8JRNMJ/VoWspMex1m+4AVGiM
	 lb20GO+R4pB5f3ra/duuEv+qbEu3W0HoPDdmwDcQYUvCaZppDTdi2J92UnCJNzULxE
	 GP6YGOlqir7s3axB37J7rCHv0IcY+NwVNm0TPyvX7RhaefG7VONaBf3WQ3NxGxW2CC
	 uuxtnDx1EjM1LQarWZjhmtKwSXH92L6DTN5F9xaCd5m0oG2G+jbEvPhY/kxo8X3E+R
	 MvCs3vTz+0qrYMTgoUAfyjkXPEF0sR7+R30/txeVYu0VnxgO1gL48OFrduDjykuJ7J
	 k9qLuGKw5HxrQ==
Date: Mon, 8 Dec 2025 14:59:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "qingwei.hu" <qingwei.hu@bytedance.com>
Cc: naveen@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Call check_ftrace_location() on
 CONFIG_KPROBES_ON_FTRACE
Message-Id: <20251208145955.b2fbb3a8bb0befbc769597bf@kernel.org>
In-Reply-To: <20251205092933.3889547-1-qingwei.hu@bytedance.com>
References: <20251205092933.3889547-1-qingwei.hu@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Dec 2025 17:29:33 +0800
"qingwei.hu" <qingwei.hu@bytedance.com> wrote:

> From: Qingwei Hu <qingwei.hu@bytedance.com>
> 
> There is a possible configuration dependency:
> 
>   KPROBES_ON_FTRACE [=n]
>        ^----- KPROBES [=y]
>          |--- HAVE_KPROBES_ON_FTRACE [=n]
>          |--- DYNAMIC_FTRACE_WITH_REGS [=n]
>                 ^----- FTRACE [=y]
>                   |--- DYNAMIC_FTRACE [=y]
>                   |--- HAVE_DYNAMIC_FTRACE_WITH_REGS [=n]
> 
> With DYNAMIC_FTRACE=y, ftrace_location() is meaningful and may
> return the same address as the probe target.
> 
> However, when KPROBES_ON_FTRACE=n, the current implementation
> returns -EINVAL after calling check_ftrace_location(), causing
> the validation to fail.
> 
> Adjust the logic so that ftrace-based checks are performed only
> when CONFIG_KPROBES_ON_FTRACE is enabled, ensuring correct
> kprobe behavior even when KPROBES_ON_FTRACE=n.

It is a bit complicated but CONFIG_KPROBES_ON_FTRACE is a hidden
static option set by architecture. If it is not enabled, that
feature is not usable on the architecture. And as Steve mentioned
we can not put a software breakpoint code on where the ftrace will
modify. IOW, ftrace reserves the instruction address.
Thus, we will check whether it is reserved by ftrace, and if so,
it returns -EINVAL, or if architecture already implements the
kprobes on ftrace feature (it requires to implement a ftrace handler
which mimics kprobe), it uses that.

So I can not accept this.

Thank you,

> 
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
> ---
>  kernel/kprobes.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ab8f9fc1f0d1..f4aa4ba1ca9c 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1512,19 +1512,15 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
>  	return 0;
>  }
>  
> -static int check_ftrace_location(struct kprobe *p)
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +static void check_ftrace_location(struct kprobe *p)
>  {
>  	unsigned long addr = (unsigned long)p->addr;
>  
> -	if (ftrace_location(addr) == addr) {
> -#ifdef CONFIG_KPROBES_ON_FTRACE
> +	if (ftrace_location(addr) == addr)
>  		p->flags |= KPROBE_FLAG_FTRACE;
> -#else
> -		return -EINVAL;
> -#endif
> -	}
> -	return 0;
>  }
> +#endif
>  
>  static bool is_cfi_preamble_symbol(unsigned long addr)
>  {
> @@ -1540,11 +1536,9 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
>  static int check_kprobe_address_safe(struct kprobe *p,
>  				     struct module **probed_mod)
>  {
> -	int ret;
> -
> -	ret = check_ftrace_location(p);
> -	if (ret)
> -		return ret;
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	check_ftrace_location(p);
> +#endif
>  
>  	guard(jump_label_lock)();
>  
> -- 
> 2.39.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
