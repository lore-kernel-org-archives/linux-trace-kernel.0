Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87A173;
	Tue, 13 Jan 2026 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264988; cv=none; b=mblx3EJeduH2dXAxjAe+ozatFx7ci6jJ/e8TMTK+NfmVzEYTTAvIgqXten0LuPn6eznGkdNnKM7ckHdH/GUy4/9jJ0HIBCDs6dRB5b0yK7b7t8NtgN23uHrTXWQ37ROlMXM110fTeNQFSbehICWRGhmOvpp5h6V0XUxQyyVWxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264988; c=relaxed/simple;
	bh=YOM2EmLGOUU7xKkfvu9jn6cbM55Qed6f/BFbYQwFdeE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gkGh7yWM9kb35EEG/GDD0gsdEGvXLsVhl+e0huyk4XYxObNt9Zgk135RL8Fmq4N8wIW456Wl1j/Kw7vpcGfqIi4/hyVn1HfgJQs5oS87DEP7/mXsp4mOFdTtHYPNZhScDyjDxtcaLrLQxkZVOYtm75f4f4XsNuZfTwyz7Gpqjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI96VDPq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI96VDPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6FFC116D0;
	Tue, 13 Jan 2026 00:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264988;
	bh=YOM2EmLGOUU7xKkfvu9jn6cbM55Qed6f/BFbYQwFdeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bI96VDPqdj+KRCRja0jlebKsz9iJiLcOJoLsh2DwFUpV9bTDFTGBS59EQNPoR2IC3
	 HHY7K2xw6E8W/6/Gk2eFT9n4Jb08FlUjWnbJZRCmQP7tpSXtrRxWB/y9BA0IuDZNPy
	 EoVzAhZXH2Nyvj8wKciPQLiP31CjpLu/rQF0IWdQWaJVTs1Yi+fAx/fzNWSD7GLmBF
	 u3jkhX7mdLxJM1EvszVSc333tt40dvIl9cCMKTBFC8BOavJMFAuW7uVDYB9dy19Lbv
	 UEz6XvxJx4+q/IDgueCUVyzsYqq0YP+8NM3n4gZ2n+3Maq8JIFSe96QXd8VORliqNj
	 md3341T5Ekznw==
Date: Tue, 13 Jan 2026 09:43:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin
 <ipravdin.official@gmail.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtla: Fix parse_cpu_set() bug introduced by strtoi()
Message-Id: <20260113094303.d47b662251df7136e18391b8@kernel.org>
In-Reply-To: <20260112192642.212848-2-costa.shul@redhat.com>
References: <20260112192642.212848-2-costa.shul@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 21:26:41 +0200
Costa Shulyupin <costa.shul@redhat.com> wrote:

> The patch 'Replace atoi() with a robust strtoi()' introduced a bug
> in parse_cpu_set(), which relies on partial parsing of the input string.
> 
> The function parses CPU specifications like '0-3,5' by incrementing
> a pointer through the string. strtoi() rejects strings with trailing
> characters, causing parse_cpu_set() to fail on any CPU list with
> multiple entries.
> 
> Restore the original use of atoi() in parse_cpu_set().
> 
> Fixes: 7e9dfccf8f11 ("rtla: Replace atoi() with a robust strtoi()")
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> 
> v2:
> - Split the patch.
> 
> ---
>  tools/tracing/rtla/src/utils.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
> index 18986a5aed3c..0da3b2470c31 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -128,18 +128,16 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
>  	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  
>  	for (p = cpu_list; *p; ) {
> -		if (strtoi(p, &cpu))
> -			goto err;
> -		if (cpu < 0 || cpu >= nr_cpus)
> +		cpu = atoi(p);
> +		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
>  			goto err;
>  
>  		while (isdigit(*p))
>  			p++;
>  		if (*p == '-') {
>  			p++;
> -			if (strtoi(p, &end_cpu))
> -				goto err;
> -			if (end_cpu < cpu || end_cpu >= nr_cpus)
> +			end_cpu = atoi(p);
> +			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
>  				goto err;
>  			while (isdigit(*p))
>  				p++;
> -- 
> 2.52.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
