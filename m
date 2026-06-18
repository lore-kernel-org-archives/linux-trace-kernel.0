Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D13175A91;
	Thu, 18 Jun 2026 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826224; cv=none; b=BdtKkZ85QuL1XSUM8Migjq4x0NDA0w+crAwd9T9aQnjTVUgEgd+DeE4vPHdCrchoqr/S2WaYTYtJA29GwGK523YrOFoihiPgefe3QDGiTWuE4IkOvHjCZxQYJ4odhuBr+65GUJJJCuabZ05Uy9mYxMPKu5zcR1kdyULSV+Eh8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826224; c=relaxed/simple;
	bh=8EgXfQrinEHiUzqNTtW815IBjbxAivVwgMMNy7FAsZU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YO5TKAn/RNQhRdOKn/wr+VoounJyor4cSMUSI43M4wIXhltzCgExjXafOCuIc6OYh+RVsYoM9wq7Qf9aw3vRJJJnuSe+ejVxJeelPmZIMlMNR3/ugWUpnBWyUE5AYtISVMoCRIHRpWmJBFJ50jJnsVuI9Gd3vaXa6+SUlUYEwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFbwMjd4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFbwMjd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8381F000E9;
	Thu, 18 Jun 2026 23:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826222;
	bh=6nv5cI1MVOeSlqPYP9zFJTdmCXFmbEnLcSfsLoaZpSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BFbwMjd4LBIt+2bOsOV2EgBi7jltM/GBxxRliowzl0lARydaH8rJwh5Mb0wP8ctNn
	 alHHjUKH5WMkvEowsV16Jn35j1OhLLckSmjDDCkG+gE+O8uKfj08rYbOnBDgkj9y60
	 oIPaTfDajvW6LICowmDL+QNLNDenYHJLthxDUAwyZRRjRZQJx7A2jFiwDph1eFrLfl
	 uIdhkUPilYhECKuW3R90Qs156X5hVu4HgKUsJTxiczX3Q2EasrjDWSd1Hpwp/2qFNk
	 Ljgp0xVSbXTCfVaY6zmXvtQprUnck38xJ5YLZWoEZtBYl9V4QS+87gGf0+iJXFCTZx
	 O5mT6CQMa+7qg==
Date: Fri, 19 Jun 2026 08:43:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tracing: probes: fix typo in a log message
Message-Id: <20260619084339.21692bed9afedccd305f2548@kernel.org>
In-Reply-To: <20260507081041.885781-4-martin@kaiser.cx>
References: <20260507081041.885781-1-martin@kaiser.cx>
	<20260507081041.885781-4-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 10:09:08 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Fix a typo ("Invalid $-variable") in a log message.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

This looks good to me. Let me pick it.

Thanks,

> ---
>  kernel/trace/trace_probe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 262d8707a3df..df68d40de161 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -509,7 +509,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(NO_RETVAL,		"This function returns 'void' type"),	\
>  	C(BAD_STACK_NUM,	"Invalid stack number"),		\
>  	C(BAD_ARG_NUM,		"Invalid argument number"),		\
> -	C(BAD_VAR,		"Invalid $-valiable specified"),	\
> +	C(BAD_VAR,		"Invalid $-variable specified"),	\
>  	C(BAD_REG_NAME,		"Invalid register name"),		\
>  	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
>  	C(BAD_IMM,		"Invalid immediate value"),		\
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
