Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF00A1F12F8;
	Tue,  7 Jan 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264117; cv=none; b=ac0Hxb30KYnFodzec6jDuvmE1/lJXhD5t9y3Ef1dkb48ChBTc31EKzrimm2u3UEplyO3PiURetNezGGT82ABJC0iJIk8ppgaLDnl4w0WDVctZ+nrRxX5g7qkz0aVU6AiBYtJZbInbhuvqpghZ0OJ9ueOUcB+g4oltp90yuDTod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264117; c=relaxed/simple;
	bh=NrnL++ktB77pMqrNUvPhSWRgzwBdEa+vF1akfkRydUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFR4Kwjh7HFO0kfg530z0DLU9YS6OypDG8uGAktiXU0f0N4f0RjCBdMsTOaglifN1cElN3Xrp6P2YVbnYgHOyg/oseHdHHTtjTq6fxo2z+ZGDUGmrR2i/YiX1YHY+2h3nbq3BG4Ecn0nr1njENoP6ADMIcPH7E0mf5GP6flo+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF65C4CED6;
	Tue,  7 Jan 2025 15:35:15 +0000 (UTC)
Date: Tue, 7 Jan 2025 10:36:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracing: Use __free() in trace_probe for cleanup
Message-ID: <20250107103643.37a3b002@gandalf.local.home>
In-Reply-To: <173625062518.1375434.10516553019799245668.stgit@devnote2>
References: <173625060316.1375434.11048027439794595989.stgit@devnote2>
	<173625062518.1375434.10516553019799245668.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 20:50:25 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -1790,18 +1777,15 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
>  				       offsetof(struct file, f_path.dentry),
>  				       equal ? equal + 1 : tmp);
>  
> -		kfree(tmp);
> +		kfree(no_free_ptr(tmp));

I don't get this? You are telling the compiler not to free tmp, because you
decided to free it yourself? Why not just remove the kfree() here altogether?

-- Steve


>  		if (ret >= bufsize - used)
> -			goto nomem;
> +			return -ENOMEM;
>  		argv[i] = tmpbuf + used;
>  		used += ret + 1;
>  	}
>  
> -	*buf = tmpbuf;
> +	*buf = no_free_ptr(tmpbuf);
>  	return 0;
> -nomem:
> -	kfree(tmpbuf);
> -	return -ENOMEM;
>  }
