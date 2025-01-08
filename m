Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7652F50;
	Wed,  8 Jan 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348773; cv=none; b=n4gXANQ6VDwTMF3o/EEAUl+q02XAeGopGtGJ8PbKlCjRQRS0i8WFH+UK9YDkxTIe4LYnqOZwuiEfxp0hTccYyw0FpC+wCeJ1z/E3i7CoztQLgpQhDz2/mGpUbJQhWjFpxdJ5xLUVgYRlxLoSgWGYIPiLEqYOyyuSi9IvmLQrjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348773; c=relaxed/simple;
	bh=r+DLd5CNlsTdmFIrDt+3iLIh6ciF41DtpmpHruI6fh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jO1EAJ7dxmpEk6lcwrsJ4KDZKosY1hkvrzaoEsDl5n2Iqbn5y8eNMWJiXPSk/gcMIGdYBBcDMbkI8PP6+SMG0552Mmur9r92VCDFF91jTV128qTZBFMpOh/Co0xPR7d+hjSzwtmxH6kmvCFgxqyDkkezkd51yXAC3Q7bQyyDSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBDEC4CED3;
	Wed,  8 Jan 2025 15:06:11 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:07:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] tracing: Adopt __free() and guard() for
 trace_fprobe.c
Message-ID: <20250108100736.7f08d054@gandalf.local.home>
In-Reply-To: <173630229003.1453474.2286376301458030998.stgit@devnote2>
References: <173630223453.1453474.6442447279377996686.stgit@devnote2>
	<173630229003.1453474.2286376301458030998.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jan 2025 11:11:30 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -1234,24 +1223,26 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  			trace_probe_log_err(0, BAD_PROBE_ADDR);
>  		else if (ret != -ENOMEM && ret != -EEXIST)
>  			trace_probe_log_err(0, FAIL_REG_PROBE);
> -		goto error;
> -	}
> +		ret = -EINVAL;
> +	} else
> +		/* 'tf' is successfully registered. To avoid freeing, assign NULL. */
> +		tf = NULL;
>  
> -out:
> -	if (tp_mod)
> -		module_put(tp_mod);
> +	return ret;
> +}
> +

Hmm, the above could probably be simplified as:

	ret = register_trace_fprobe(tf);
	if (ret) {
		trace_probe_log_set_index(1);
		if (ret == -EILSEQ)
			trace_probe_log_err(0, BAD_INSN_BNDRY);
		else if (ret == -ENOENT)
			trace_probe_log_err(0, BAD_PROBE_ADDR);
		else if (ret != -ENOMEM && ret != -EEXIST)
			trace_probe_log_err(0, FAIL_REG_PROBE);
		return -EINVAL;
	}

	/* 'tf' is successfully registered. To avoid freeing, assign NULL. */
	tf = NULL;

	return 0;
 }

-- Steve
