Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6439B948;
	Tue, 24 Mar 2026 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325277; cv=none; b=Ff+RzMGpAInNVMSzT9ibvbooPHWM56aYsCWyucFOewsKtv3fkwi/lJB0xQ2Bt1ZSVK/Ofn0ZggA/xwCohUuZTukaibPiCzjnnokxnhMs8F4xkpoRcyggbWcCl7C7OL8m/fEhoVtlC9HxcaE7u6xIgTK6szFTBxfOWTTYkTmJ1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325277; c=relaxed/simple;
	bh=g0uP+ITUU1U67ATUiHynyJwxJvS1YFKGjeahZR3lWeQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c4r9XVAeqCeSphjMvGPi3Jm0LjSZj9Dd3j2QDOduNttLOeCQCg4ndsT7FLCQuLTK6pALiYx411LQHQrCxoVr//gDYAEaIHPdkDuaxdGBtV0Yqk/AlwrpM+GuU4VcinFvp1y2jNPOf145eBwjryzsOp3EMNtnBBHQ7Z/K/psNPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt+dhWq3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt+dhWq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E44DC19424;
	Tue, 24 Mar 2026 04:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774325276;
	bh=g0uP+ITUU1U67ATUiHynyJwxJvS1YFKGjeahZR3lWeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nt+dhWq3euDYS8fV2Aswubqi8csvQu0xsIg4u+IH47GrvVxUDf9LIJl/viyNwYWbI
	 RhtrgKDKSn+qaJKww3clTHknPH53YZAFWu1VLNRTdyBsl+PjLN/IsCHYIIZIwiWaFB
	 SSWdIAE6oVnUnQHI8sRfTWcI3a5axv1mea6A2m+kG0ljQOD4LtglO0ptE2DiRM6BUr
	 IplJh2qkf88woxu0LWJVYEhStMw8+qH7PR7J+j8Ee9KqJh9PhoW7Zs+gLwRWfxwrO6
	 5iSAPaiQYvaXj6HgeU749qcTIBGn1DyG9ETp9kjdRpHnp0EnhNv6GmA/dpeRKInfjU
	 TSA8t8vncx05A==
Date: Tue, 24 Mar 2026 13:07:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 3/4] docs: tracing/fprobe: Document list filters and
 :entry/:exit
Message-Id: <20260324130754.c3f266811e2ec5ace8bcb689@kernel.org>
In-Reply-To: <20260205135842.20517-4-seokwoo.chung130@gmail.com>
References: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
	<20260205135842.20517-4-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Feb 2026 08:58:41 -0500
"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:

> Update fprobe event documentation to describe comma-separated symbol lists,
> exclusions, and explicit suffixes.
> 
> Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
> ---
>  Documentation/trace/fprobetrace.rst | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> index b4c2ca3d02c1..bbcfd57f0005 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -25,14 +25,18 @@ Synopsis of fprobe-events
>  -------------------------
>  ::
>  
> -  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
> -  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
> +  f[:[GRP1/][EVENT1]] SYM[%return] [FETCHARGS]		    : Single function

We also accept wildcard pattern instead of SYM.

  f[:[GRP1/][EVENT1]] (SYM|PATTERN)[%return] [FETCHARGS]	 : Single target

> +  f[:[GRP1/][EVENT1]] SYM[,[!]SYM[,...]][:entry|:exit] [FETCHARGS] :Multiple

Hmm if this is for multiple function, we can not omit event name, so

  f:[GRP1/]EVNET1 SYM[,[!]SYM[,...]][:entry|:exit] [FETCHARGS]   : Multiple function

> +  function

Also, if you put this in the next line, please indent it.

>    t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
>  
>   GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
>   GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
>   EVENT1         : Event name for fprobe. If omitted, the event name is
> -                  "SYM__entry" or "SYM__exit".
> +		  - For a single literal symbol, the event name is
> +		    "SYM__entry" or "SYM__exit".
> +		  - For a *list or any wildcard*, an explicit [GRP1/][EVENT1] is

an explicit EVENT1 is required. (group name can be omitted)

> +		    required; otherwise the parser rejects it.
>   EVENT2         : Event name for tprobe. If omitted, the event name is
>                    the same as "TRACEPOINT", but if the "TRACEPOINT" starts
>                    with a digit character, "_TRACEPOINT" is used.
> @@ -40,6 +44,13 @@ Synopsis of fprobe-events
>                    can be probed simultaneously, or 0 for the default value
>                    as defined in Documentation/trace/fprobe.rst
>  
> + SYM		: Function name or comma-separated list of symbols.

Doesn't SYM still be a function name? In above synopsis, SYM is an entry of
comma-separated list.

> +		  - SYM prefixed with "!" are exclusions.
> +		  - ":entry" suffix means it probes entry of given symbols
> +		    (default)
> +		  - ":exit" suffix means it probes exit of given symbols.
> +		  - "%return" suffix means it probes exit of SYM (single
> +		    symbol).


And we need PATTERN here.

  PATTERN     : Function name pattern with wildcards (You can use "*" or "?").

Thank you,

>   FETCHARGS      : Arguments. Each probe can have up to 128 args.
>    ARG           : Fetch "ARG" function argument using BTF (only for function
>                    entry or tracepoint.) (\*1)
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
