Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCE282F33;
	Wed, 11 Mar 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238596; cv=none; b=AQ8/0a+3TNgwgJC+dQzvV8fUYLd00eoMOiNcp1SVyVacpL9ihbq+Xu7va474JXJOF+FoCfkjCSZrlO12FR98CezNXjlbsQp6uK83+2sFGv8CPS9LSrMyK8w5cb7dsYgT9RVDdSZPK86QGi9q8iSixZabG4nzVstZHLAaInQUOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238596; c=relaxed/simple;
	bh=XrwgcSxcb9O4rCNigDKF8+s3gg+hKNFkbhogsAsxOBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzsp+Xa4SobD9BD3Tc2gnzLP6GVCbttmN644s9Zz+TnSFqwyyWssUatiujn/G/nlc3zDS6bdaPBrdp8mQDCyvc63pXJEESOtH4jhgN3QUje4LuEkxOLuPvrypSO7+N21WdxXnkAaflJI/fmQeEH4WopXUgI1a9heEy6C+92kFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL56GW+L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL56GW+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467B2C4CEF7;
	Wed, 11 Mar 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773238596;
	bh=XrwgcSxcb9O4rCNigDKF8+s3gg+hKNFkbhogsAsxOBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fL56GW+LAE5ttUKEJqEJkmW46AuSqDSIEl8FiS0yJUcswItAANCi0uMLrCtVIRxLm
	 hdyn01Q3upYcxoLlx8mai/WSjlKGK94D84ow2O0al3R9AcZOo/k98ZB+RzUuAMy/55
	 nsxfY2pAFJPQ1dxqtrRG3yZUaMrSOpXR/u+Va20l9y6u/hlF/HvCaLWfSYIwX69krz
	 BYlvsi0GvfPgbj85B6jqIwdqlxZ0w09a72vNDPhKFFU4R9VY+BpEiCNHInckBL34Wj
	 hRgDveSpL7RWcq47FKNJxpG3GDmaccwBlmeVIceYIrpPiYrqtuMcnrWFbr5Q937VLh
	 by0O0FTjAlFaw==
Date: Wed, 11 Mar 2026 10:16:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Brian Geffon <bgeffon@google.com>, John
 Stultz <jstultz@google.com>, Ian Rogers <irogers@google.com>, Suleiman
 Souhlal <suleiman@google.com>
Subject: Re: [PATCH v2 1/3] tracing: Have futex syscall trace event show
 specific user data
Message-ID: <20260311101647.0ee39228@gandalf.local.home>
In-Reply-To: <20260311180325.488f724d97204d1a3c66f071@kernel.org>
References: <20260310200954.285663884@kernel.org>
	<20260310201036.542627924@kernel.org>
	<20260311180325.488f724d97204d1a3c66f071@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 18:03:25 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"  __print_symbolic(REC->op & 0x%x, ", FUTEX_CMD_MASK);
> > +
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_WAIT\"}, ", FUTEX_WAIT);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_WAKE\"}, ", FUTEX_WAKE);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_FD\"}, ", FUTEX_FD);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_REQUEUE\"}, ", FUTEX_REQUEUE);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_CMP_REQUEUE\"}, ", FUTEX_CMP_REQUEUE);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_WAKE_OP\"}, ", FUTEX_WAKE_OP);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_LOCK_PI\"}, ", FUTEX_LOCK_PI);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_UNLOCK_PI\"}, ", FUTEX_UNLOCK_PI);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_TRYLOCK_PI\"}, ", FUTEX_TRYLOCK_PI);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_WAIT_BITSET\"}, ", FUTEX_WAIT_BITSET);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_WAKE_BITSET\"}, ", FUTEX_WAKE_BITSET);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_WAIT_REQUEUE_PI\"}, ", FUTEX_WAIT_REQUEUE_PI);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_CMP_REQUEUE_PI\"}, ", FUTEX_CMP_REQUEUE_PI);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			"{%d, \"FUTEX_LOCK_PI2\"}),", FUTEX_LOCK_PI2);  
> 
> Hmm can we share __futex_cmds[] with kernel/futex/syscalls.c?
> Then these could be
> 
> for (i = 0; i <= FUTEX_LOCK_PI2; i++)
> 	pos += snprintf(buf + pos, LEN_OR_ZERO,
> 			"{%d, \"%s\"}%s", i, __futex_cmds[i],
> 			i == FUTEX_LOCK_PI2 ? ")," : ", ");

Hmm, I created the above *before* creating the __futex_cmds. But yes, that
makes sense. Thanks for the suggestion.


> 
> 
> > +
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			" (REC->op & %d) ? \"|FUTEX_PRIVATE_FLAG\" : \"\",",
> > +			FUTEX_PRIVATE_FLAG);
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			" (REC->op & %d) ? \"|FUTEX_CLOCK_REALTIME\" : \"\",",
> > +			FUTEX_CLOCK_REALTIME);
> > +
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			" REC->val, REC->utime,");
> > +
> > +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> > +			" REC->uaddr, REC->val3");
> > +	return pos;
> > +}
> > +
> >  static int __init
> >  __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
> >  {  
> [...]
> > @@ -689,6 +799,48 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
> >  	return 0;
> >  }
> >  
> > +static int
> > +syscall_get_futex(unsigned long *args, char **buffer, int *size, int buf_size)
> > +{
> > +	struct syscall_user_buffer *sbuf;
> > +	const char __user *ptr;
> > +	char *buf;
> > +
> > +	/* buf_size of zero means user doesn't want user space read */
> > +	if (!buf_size)
> > +		return -1;
> > +
> > +	/* If the syscall_buffer is NULL, tracing is being shutdown */
> > +	sbuf = READ_ONCE(syscall_buffer);
> > +	if (!sbuf)
> > +		return -1;
> > +
> > +	ptr = (char __user *)args[0];
> > +
> > +	*buffer = trace_user_fault_read(&sbuf->buf, ptr, 4, NULL, NULL);
> > +	if (!*buffer)
> > +		return -1;
> > +
> > +	/* Add room for the value */
> > +	*size += 4;
> > +
> > +	buf = *buffer;  
> 
> As kernel test bot says, this does nothing. (*buffer is already assigned)
> 

Oops, I think this was a cut-and-paste error :-p

-- Steve
