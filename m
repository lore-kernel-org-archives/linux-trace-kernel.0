Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14F33ABD80;
	Sat, 26 Sep 2026 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425878; cv=none; b=rzLPqspWGJXQMZdEOcNh2JCDBa7KoLI1MqHCP28pL0ukVxgcAfaS459q/M3+d/TaXGH+ck979Hyi1JEl+ACQkY5Nmtq1lTYL2vLUWc9N5EYonlqi/rg7Y5eujvc3mh3CDIXHmGUleQk4fhXMt5TIbhQMOaenZz+3exVHYZOICY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425878; c=relaxed/simple;
	bh=slv2mUguN12KMHBkXDyTurvhj0TSbSsRRo0SbtEdS9E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=R+wIi8tYAu4fpySj6NtTCepQ8/RpavzLkyo6Tx/jqkcGiWFVeSxI/9Th2RZ5HrFtl0Ef9RuMk3vO5UWNCWQ7BSo3VU35tg1ezCgbQUzSnTju6A90KsY9PCTY3rZF8yt8JUNbJeADhBC4rdxZ/YPNjf4sJYsBwpin0dzyh2XpTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrlTOi2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrlTOi2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC041F000FF;
	Sat, 26 Sep 2026 12:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790425876;
	bh=yyWyRTDztZItehKkx4bjDMd437FH163TOsfRDpL0Umk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SrlTOi2IaqpHRA+UgAzI/Wk8QqtrRAHezbJUwO/1sWKhu3VrOAtZCKEWWVq88pj86
	 bNZ4m+atzTY05GsbLr4Vh4jMt46q+JZJhtyS/g941B0ni6yKD3bugNj//Y6TO0xcYk
	 Wa3bxjInrQ1tGm8ZYYxY0cTOveTzYkFCSEut8f95B3E/oaV/9gSESEnpfkCi0wFxsY
	 TLnUapibFmKSSVZ1MIaM8zGoLd/8FWRiza8g/UCaqHWGApnT1IDZzcVIr/NtiOICre
	 S/8AL8fvzMc61SMaoF3lwv41CpUOMWQEsob7zBMVzYyUPCHpOLB7ThJucZ8mEAyrbM
	 qZxvCQsOxoyhg==
Date: Sat, 26 Sep 2026 21:31:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: skip gcov symbols when picking a
 function to probe
Message-Id: <20260926213112.9f92e7958c2d12c946799a0f@kernel.org>
In-Reply-To: <20260925133558.3636030-1-eva.kurchatova@virtuozzo.com>
References: <20260925133558.3636030-1-eva.kurchatova@virtuozzo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 16:35:41 +0300
Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:

> kprobe_eventname.tc takes the last kallsyms entry whose name ends in
> vfs_read and puts a probe on it. On a kernel built with
> CONFIG_GCOV_PROFILE_ALL=y the counter symbol gcc emits for the function
> sorts after it:
> 
>   ffffffff819bd1e0 T vfs_read
>   ffffffff845013e0 t __gcov_.vfs_read
> 
> so the test picks __gcov_.vfs_read, which is not a function entry, and
> the write fails:
> 
>   kprobe_eventname.tc: line 10: echo: write error: Invalid argument
> 
> Leave those symbols out of the choice. The test then picks vfs_read and
> passes; without a coverage build nothing changes, as no such symbol
> exists there.
> 
> This is the same class of problem as commit 23a4b108accc
> ("tracing/selftests: Fix kprobe event name test for .isra. functions"),
> where a compiler-generated symbol was picked instead of a real function.
> 

Oops, good catch! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Shuah, can you pick this fix via your selftest tree? I think this is a
kind of selftest fix/improvement.

Thanks,

> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> ---
>  .../testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> index ba19b81cef39..0688a5c47d1e 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> @@ -5,7 +5,7 @@
>  
>  :;: "Add an event on function without name" ;:
>  
> -FUNC=`grep " [tT] .*vfs_read$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
> +FUNC=`grep " [tT] .*vfs_read$" /proc/kallsyms | grep -v __gcov | tail -n 1 | cut -f 3 -d " "`
>  [ "x" != "x$FUNC" ] || exit_unresolved
>  echo "p $FUNC" > kprobe_events
>  PROBE_NAME=`echo $FUNC | tr ".:" "_"`
> -- 
> 2.55.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
