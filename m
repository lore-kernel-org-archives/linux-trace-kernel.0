Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC0B677;
	Thu,  9 Jan 2025 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736387015; cv=none; b=sTUzI2lp6B2t1qiXE402U5OUjos34QXARwlqPGmSx2FSa0VkzUPBSoHYJsSV5tYMlf+kYfAT72w1FhFoKmEJjbBAcDTV9YDlCQzURt1vZ9Ifc3V4+3gy2npW6jxdAQr27zSaLntfY4CLbKF6I+0FmF1LvlYgE3wKrcmDsGIMk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736387015; c=relaxed/simple;
	bh=4VZGRbwDQMjhfb27iMKjXVTICDpNjW5ULueMAzAFUAQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jg8yFu66yVdxQ1S2TEVHVeMqFmZnenKzDAM2YiebO832N6cnwFP6LQ2Rmnt8elnug/bCNokJhitTb3IJpIUzHBadmkB34kAIPNSLJB4SQKYnf05npPvVzPyGPW8AJibpCembnXOJQzJilrz5ppuZwqQObn5zsGoCrZJ187Gv250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVQdzpTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVQdzpTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FFCC4CED3;
	Thu,  9 Jan 2025 01:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736387014;
	bh=4VZGRbwDQMjhfb27iMKjXVTICDpNjW5ULueMAzAFUAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oVQdzpTh4a6l0Jt78h5H/RxR2tJJuM/VthJSf1FYSJI8TI+RoDMyAtxNIY5+gnhmF
	 zAqUxTN+n6jpw26kmbuWUKaLP4JhL9VN4J8AdR404lNHMNid5q3SJ8AGmrMDh4H8pI
	 TrxzmyXHpsBWvdSXf/4++jt6b8Jx+w+vFOnjWm48pyCLm0xHFzWuJkJr1WTwoC8H2J
	 HU+nbTQPoWfbpkVcg6UcxPbhfuBxmrTZxpzy7M7FzUwzNSfop/+JAhZ4eiFYKYDf3a
	 2zEKPs29M/YWCEt4/LGo87Ezqzc+0EJPsF6nFDImJRv4ZEZaVbOYnU3emxfaC5VgQ7
	 LkU0FmFVQwpng==
Date: Thu, 9 Jan 2025 10:43:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] tracing: Adopt __free() and guard() for
 trace_fprobe.c
Message-Id: <20250109104331.5a11a889c4d07b9ebddcadd3@kernel.org>
In-Reply-To: <20250108100736.7f08d054@gandalf.local.home>
References: <173630223453.1453474.6442447279377996686.stgit@devnote2>
	<173630229003.1453474.2286376301458030998.stgit@devnote2>
	<20250108100736.7f08d054@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 10:07:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  8 Jan 2025 11:11:30 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -1234,24 +1223,26 @@ static int __trace_fprobe_create(int argc, const char *argv[])
> >  			trace_probe_log_err(0, BAD_PROBE_ADDR);
> >  		else if (ret != -ENOMEM && ret != -EEXIST)
> >  			trace_probe_log_err(0, FAIL_REG_PROBE);
> > -		goto error;
> > -	}
> > +		ret = -EINVAL;
> > +	} else
> > +		/* 'tf' is successfully registered. To avoid freeing, assign NULL. */
> > +		tf = NULL;
> >  
> > -out:
> > -	if (tp_mod)
> > -		module_put(tp_mod);
> > +	return ret;
> > +}
> > +
> 
> Hmm, the above could probably be simplified as:
> 
> 	ret = register_trace_fprobe(tf);
> 	if (ret) {
> 		trace_probe_log_set_index(1);
> 		if (ret == -EILSEQ)
> 			trace_probe_log_err(0, BAD_INSN_BNDRY);
> 		else if (ret == -ENOENT)
> 			trace_probe_log_err(0, BAD_PROBE_ADDR);
> 		else if (ret != -ENOMEM && ret != -EEXIST)
> 			trace_probe_log_err(0, FAIL_REG_PROBE);
> 		return -EINVAL;
> 	}
> 
> 	/* 'tf' is successfully registered. To avoid freeing, assign NULL. */
> 	tf = NULL;
> 
> 	return 0;

Indeed. Thanks!

>  }
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
