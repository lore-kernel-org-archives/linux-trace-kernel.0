Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC35042464B;
	Wed,  9 Sep 2026 23:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997297; cv=none; b=F2aUOJ+V8t2k0okozBSxB17f4AIkWyYJbMC8bwZrgz6MQgep9xI9UpuMT0Z42ejB3ixwRAeN6ndggDFQuVWqBg4R4MWKUaWVOm6pmTQ0buLnLKeZbmMZqfKNzfbwUp1q0cUaYdIBvPbh5fGKqWKM0a1Uw3S0s3aqN/yND1JIRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997297; c=relaxed/simple;
	bh=FILuQt1DMDpTEzS8BJcO4mtA+1dGkW/Mz6ptobLdNMw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mPOzNhoMng89rzOoLK+wi/9nzFrzOAKtZQhepaQpcn0j2LiuHV8y0444sib7lgPCtn4H14AJ6tenpvq0En2co/1kvbb34HqmbqC20FB+oNKly6PB9uvznb+OQtzfl3bl08GzjriH54D6t6FBSafuOeO2DtEn+gY/5MVeCcNpDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWMRYlbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWMRYlbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B60F1F000FF;
	Wed,  9 Sep 2026 23:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788997295;
	bh=FB0oTa7ZeTIoXN149EygwWFlLgtj9V3NiJgcBzuDbPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KWMRYlbrBV1oPuNuNAajTPWEnzMVhBM9GhRdRqqRHpfz2lcooNX8sGDJoV/MJRuwP
	 Vr1Or9aXMcZ3J4iFSR7ugWvIKoRaO5lPmo+YMm886vB+KDlB5Rv4c1bIjbAssUzmKE
	 JI+9KkUdmWVcf6EAuCpExC+yCnPEx2WLfVO7DOzgF82mdSCHrWy+tmy883OInnAjyx
	 ltWkgk0VozR/U8osdcJ2w5Ci/e6nD+bJ6bveGFtT3WUNKTkmi8kmnCe1IC2jVvJ0h1
	 bLWt1JG8GrzymJ7gr0bSFanHgfw3uWnnkM0EOWtmnoezbYLrbpAb/issWV1zyyuZsZ
	 hRemVoZJYw+Yg==
Date: Thu, 10 Sep 2026 08:41:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Fix unique symbol check in
 kprobe_non_uniq_symbol.tc
Message-Id: <20260910084130.c19c45e1d4582835979aa241@kernel.org>
In-Reply-To: <20260909092954.2200558-1-svens@linux.ibm.com>
References: <20260909092954.2200558-1-svens@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 11:29:53 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> The current regex also matches symbols in modules, which makes the
> test fail on s390 where name_show is present only once in the kernel,
> but also multiple times in modules:
> 
> 000001b1401cdc20 t name_show
> 000001b0c05e6c40 t name_show    [mdev]
> 000001b0c0495f30 t name_show    [i2c_core]
> 
> Fix this by changing the regular expression to only match the function
> name.

Ah, nice catch! I'll add this fixes tag.

Fixes: 03b80ff8023a ("selftests/ftrace: Add new test case which checks non unique symbol")

Thanks,

> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> index bc9514428dba..07b1177c1634 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> @@ -6,7 +6,7 @@
>  SYMBOL='name_show'
>  
>  # We skip this test on kernel where SYMBOL is unique or does not exist.
> -if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
> +if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' ]; then
>  	exit_unsupported
>  fi
>  
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
