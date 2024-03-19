Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1E7D3EA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857259; cv=none; b=M1/SBTfEMYRJfSP0Tv5gANj6/dm02EyIxFxVQEOoBJ8WgrRH5d0cBvUfD0aXQKJ9iSuIxab5S+5CBJzh2qaTHophjn+y8l+yVXI+4q8B1Xyq3DFMBm7ygnxzljPytWviAJynO5CwtcL34rDJHIWbMiYo0wTzEFLamOPVuZKWrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857259; c=relaxed/simple;
	bh=ZlVUs0/KB7IKP2SWFA553HRl7W+N31B6sODTfvnt57E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7pkzmNNe7GOe9BNKDNEm1clrR3rb9KRTe9qTmAgANNayX1H8G1OLIHKxe9MQg4eK2jloVkYZYV8R1oG2UMvrqweqXwumfqKyhg6TgUKpOM1dIFImJ9OD2Dg4rT6VQlkU2Fgs8aVGayphd7wA3m/1XMO9zqwggL6tU06aNMazTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12F6C433F1;
	Tue, 19 Mar 2024 14:07:38 +0000 (UTC)
Date: Tue, 19 Mar 2024 10:10:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing/probes: Support $argN in return probe
 (kprobe and fprobe)
Message-ID: <20240319101000.4dbe0cc5@gandalf.local.home>
In-Reply-To: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
References: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 10:19:09 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Masami Hiramatsu (Google),
> 
> Commit 25f00e40ce79 ("tracing/probes: Support $argN in return probe
> (kprobe and fprobe)") from Mar 4, 2024 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	kernel/trace/trace_probe.c:856 store_trace_entry_data()
> 	error: uninitialized symbol 'val'.
> 
> kernel/trace/trace_probe.c
>     846                 return;
>     847 
>     848         for (i = 0; i < earg->size; i++) {
>     849                 struct fetch_insn *code = &earg->code[i];
>     850 
>     851                 switch (code->op) {
>     852                 case FETCH_OP_ARG:
>     853                         val = regs_get_kernel_argument(regs, code->param);
>     854                         break;
>     855                 case FETCH_OP_ST_EDATA:
> --> 856                         *(unsigned long *)((unsigned long)edata + code->offset) = val;  
> 
> Probably the earg->code[i] always has FETCH_OP_ARG before
> FETCH_OP_ST_EDATA but Smatch isn't smart enough to figure that out...

Looks that way:

		case FETCH_OP_END:
			earg->code[i].op = FETCH_OP_ARG;
			earg->code[i].param = argnum;
			earg->code[i + 1].op = FETCH_OP_ST_EDATA;
			earg->code[i + 1].offset = offset;
			return offset;

But probably should still initialize val to zero or have a WARN_ON() if
that doesn't happen.

-- Steve


> 
>     857                         break;
>     858                 case FETCH_OP_END:
>     859                         goto end;
>     860                 default:
>     861                         break;
>     862                 }
>     863         }
>     864 end:
>     865         return;
>     866 }
> 
> regards,
> dan carpenter

