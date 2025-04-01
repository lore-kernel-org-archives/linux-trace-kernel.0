Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F9189F56;
	Tue,  1 Apr 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523761; cv=none; b=sNmNaz6JZudxZfy4oK2AxolTPdiM2Lr8vY8hfgsT51Wtgn9D//XFUfeRNmvrEXxOoYYzri+e7S657N+xnMYYzvcm2KCZt+8Nn3JBmLzji54GqBZaCYmV3zN3kA5ACFcag7TxAP1h2Qd6FnITScngvynWBD2W4SvjfYAXr9RaDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523761; c=relaxed/simple;
	bh=KSZKrN/SN3l0Xw75oGAzYmZAFHUTN7+TeDne5TmqYAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdrkDWF83DEDyQgVzAmXMUhbMUUoDjJ2poE5UZ+gSuoQfZJLi6x/QYLWs8xWcnAooysXxf77kjRp/nTv8jv7kcGRx/xhuMqbQN4rFgX2NWiP+laTTAf+mBtK9fdY9Vy6kkXo5d4jBb1cKCW54xNLhMJNGMQ2oj6ogserxXEaPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA7391424;
	Tue,  1 Apr 2025 09:09:20 -0700 (PDT)
Received: from [10.57.40.234] (unknown [10.57.40.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF9763F63F;
	Tue,  1 Apr 2025 09:09:15 -0700 (PDT)
Message-ID: <025df044-ed66-4d24-a2bc-39febac29a39@arm.com>
Date: Tue, 1 Apr 2025 17:09:13 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: Have tracing function args depend on
 PROBE_EVENTS_BTF_ARGS
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Leon Romanovsky <leon@kernel.org>
References: <20250401113601.17fa1129@gandalf.local.home>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250401113601.17fa1129@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/25 16:36, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The option PROBE_EVENTS_BTF_ARGS enables the functions
> btf_find_func_proto() and btf_get_func_param() which are used by the
> function argument tracing code. The option FUNCTION_TRACE_ARGS was
> dependent on the same configs that PROBE_EVENTS_BTF_ARGS was dependent on,
> but it was also dependent on PROBE_EVENTS_BTF_ARGS. In fact, if
> PROBE_EVENTS_BTF_ARGS is supported then FUNCTION_TRACE_ARGS is supported.
> 
> Just make FUNCTION_TRACE_ARGS depend on PROBE_EVENTS_BTF_ARGS.
> 
> Fixes: 533c20b062d7c ("ftrace: Add print_function_args()")
> Closes: https://lore.kernel.org/all/DB9PR08MB75820599801BAD118D123D7D93AD2@DB9PR08MB7582.eurprd08.prod.outlook.com/
> Reported-by: Christian Loehle <Christian.Loehle@arm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Tested-by: Christian Loehle <Christian.Loehle@arm.com>

> ---
>  kernel/trace/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 033fba0633cf..a3f35c7d83b6 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -265,8 +265,7 @@ config FUNCTION_GRAPH_RETADDR
>  
>  config FUNCTION_TRACE_ARGS
>         bool
> -	depends on HAVE_FUNCTION_ARG_ACCESS_API
> -	depends on DEBUG_INFO_BTF
> +	depends on PROBE_EVENTS_BTF_ARGS
>  	default y
>  	help
>  	  If supported with function argument access API and BTF, then

