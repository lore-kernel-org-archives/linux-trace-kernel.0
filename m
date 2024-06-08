Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B54149DED;
	Sat,  8 Jun 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857167; cv=none; b=rRdtPzzbvYY1xd03QIF9ySrhZIcyqtuE7ZYGKilJeccSAYHlLenbk0kjMUR23fEMuuCPmV7cB1vGiUsdhUWK3/gSZqk4kepL5pTiaQkv4bTTib6Ck+RJ/Fx7TtCLPPfletDdaTmXdTVKrWEfkmP7ORwfe51e12Qa1IdF9HoGq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857167; c=relaxed/simple;
	bh=+mfH5kPRQKjFbiX+1m7cu4HLvr1f9QnlfzdttOt8hto=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CD9D2pekS2cQChhbG+To+I+wvXD33MJmilXsc5zvZnYK7dZBWMIShPT2B4FeILKaQIdiCztgW9StWTb8qo8WAOtthKJAGX+58Slrkio2IMxjjJiLUNEnQq5iP0aS8yXEUWmVj9BNwE4jZkx904MaJCWLhC7cqNF0SGsmvf6O+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6HGJuTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6HGJuTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D342C2BD11;
	Sat,  8 Jun 2024 14:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717857166;
	bh=+mfH5kPRQKjFbiX+1m7cu4HLvr1f9QnlfzdttOt8hto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W6HGJuTsLphg3hJwaCcOqeBS/036cr1C35LPh+8S97Y+K7jUszwmKWkgwu5GjXPiK
	 LoEX3fxAN2Q/2/ElZBXzpd4aO+B05yvV7V/0xf5CQJ0rW/ivN3zUAgcJ1xVbAjnQBD
	 W6nvC+wkNMVOd/9fbnDQF5SgtqMI6dhEJb5HuzaXEQ7gGjGDqUP8n1QQQluMvNOWTN
	 S5G3rueKMUiWI1aF74l9jSnB90djcoSqWvUGmZgwf4FDQTcPVokTMvAbBZPfsrKc7P
	 Roief3NScRkY1DcjAIcx39RO0GwlU0EDKBV9J3kFkmgNIJ3Hp3ddxszlsLDVkf/RvU
	 OV2DdZ/nqxo1A==
Date: Sat, 8 Jun 2024 23:32:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] function_graph: Rename BYTE_NUMBER to CHAR_NUMBER in
 selftests
Message-Id: <20240608233242.414564f51bcc5db9993eb682@kernel.org>
In-Reply-To: <20240606081846.4cb82dc4@gandalf.local.home>
References: <20240606081846.4cb82dc4@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 08:18:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The function_graph selftests checks various size variables to pass from
> the entry of the function to the exit. It tests 1, 2, 4 and 8 byte words.
> The 1 byte macro was called BYTE_NUMBER but that is used in the sh
> architecture: arch/sh/include/asm/bitops-op32.h
> 
> Just rename the macro to CHAR_NUMBER.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Fixes: 47c3c70aa3697 ("function_graph: Add selftest for passing local variables")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406061744.rZDXfRrG-lkp@intel.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_selftest.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index 369efc569238..adf0f436d84b 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -758,7 +758,7 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  
> -#define BYTE_NUMBER 123
> +#define CHAR_NUMBER 123
>  #define SHORT_NUMBER 12345
>  #define WORD_NUMBER 1234567890
>  #define LONG_NUMBER 1234567890123456789LL
> @@ -789,7 +789,7 @@ static __init int store_entry(struct ftrace_graph_ent *trace,
>  
>  	switch (size) {
>  	case 1:
> -		*(char *)p = BYTE_NUMBER;
> +		*(char *)p = CHAR_NUMBER;
>  		break;
>  	case 2:
>  		*(short *)p = SHORT_NUMBER;
> @@ -830,7 +830,7 @@ static __init void store_return(struct ftrace_graph_ret *trace,
>  
>  	switch (fixture->store_size) {
>  	case 1:
> -		expect = BYTE_NUMBER;
> +		expect = CHAR_NUMBER;
>  		found = *(char *)p;
>  		break;
>  	case 2:
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
