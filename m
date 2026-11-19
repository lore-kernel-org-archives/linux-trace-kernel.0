Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051402;
	b=XA3plYK4KnN5a4Vva1aTIUBECxuW7jP40E4usk4Hp7mqJr+ax77IKUOnx0IE4Xn2kzDN
	 70ZLLrlaA/vzNzJvHLDEt/V6iCQ+bdNNlpFFvYtrj5FgAnjGYvpqe1l+UF8u074sXIpIH
	 ypMda8VkvAa29gXZ+9UxMYAaApqT1k+PCa4cUm0gehmovYFQ0zHZaA7BrcOBmgM2G2L0j
	 uOPDVatbZ0wqLn4XAKGN9jKePBjM95ydofbCuliHwXi6rCLqKt8OnOZAvZIpfGMtmWG7o
	 v7dlFZ7Bt5BguLod9cbpOED1mC3J/VINOjavGIJQruiht0Pr4qKb9Q3OVxZkGd8ifpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ugdf1JDwtIYL2rl1GRFqW8mRRpFfDP7eM8709/bjVsM=;
	b=iDbX5+wqkrnuprLhueGNsQ4bKaxx0CM8NMlt5Uvkk7eRDwnTDKH9X+8EBJnRjt0ZZi/X
	 MFKT4JSM0RjVnzPKQyVVbCVzVGMHzPupR6yjqM1NLqEW4mSgRH14W7Ihud6SjNIoAER8n
	 r4SXZhq8tdSyxizblgWUjaw9tfxVpsGTg/rsABkcZs22d5zglExltWMZTYCAgO1bzX5s9
	 nCWRxZgFW/WqWd6XBELMhg69tOgLWw2ZX0XmRov+OlbQImHLSbiKcc394iKMN51ZrScKC
	 WNU13jZgYhJxm68f7/TTIYOsCLDdp1XenmS2eHm+rmm6oh4oQZIar6qm+Y4gTCGuZow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPAna9fE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB60606A320;
	Thu, 19 Nov 2026 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPAna9fE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0801F000C4;
	Thu, 19 Nov 2026 01:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795051402;
	bh=Ugdf1JDwtIYL2rl1GRFqW8mRRpFfDP7eM8709/bjVsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPAna9fEwd3/tvrR5eHalRzsQG9X/1PgpFAEu0iKkJdnpsqX3ZhERyxNa5KfdtgwJ
	 jnuNsns9Jey7NukNBShPBWZqPOL383/0mRbTrkwZiGeHrEEoxwUqLsCzEy8/q7GJ3m
	 xL1pf0MCMYyqpAJFxjlDVP3x1Hj90UQ6zXSvbb9dTy1T65pBwqgjYObUWF3RAxENzr
	 8jXGUofX/H80tEGC23NZzdkC7DgjihFGUvwGDDxAwNwyZMaKDXHLob6Wm4Rr+ZBll6
	 GIxfWJamP+9hKqAsdaYZ1Zy4zO7yNp9lzjVrnXS9xAljH8sX7wGbgAfaxx5ZnUXxXG
	 ytbWqLngZtdqg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 08/15] tracing/filters: Reject unsupported field sizes in parse_pred()
Date: Thu, 19 Nov 2026 10:23:19 +0900
Message-ID: <undine-1795051399139783125-8a432c8e1f39e433@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261117191700.7e5f1a10@gandalf.local.home>
References: <179323784538.740114.15323117974242744566.stgit@devnote2> <179323791927.740114.2174706496595446472.stgit@devnote2> <20261117191700.7e5f1a10@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 19:17:00 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 29 Oct 2026 10:38:39 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Prior to commit 80765597bc58 ("tracing: Rewrite filter logic to be simpler
> > and faster"), parse_pred() checked whether select_comparison_fn() returned
> > NULL and failed with FILT_ERR_INVALID_OP and -EINVAL. That check was lost
> > during the rewrite, and commit 3cbec9d7b93d ("tracing/filters: Enable
> > filtering a scalar field by a cpumask") similarly omitted a default error
> > case when matching field->size for CPUS{} comparisons.
> > 
> > If a non-string field (FILTER_OTHER) has a size other than 1, 2, 4, or 8
> > (such as a fixed-size integer array field), pred->fn_num remains
> > FILTER_PRED_FN_NOP (0) and parse_pred() returns success. Subsequently,
> > update_preds() rejects FILTER_PRED_FN_NOP via WARN_ON_ONCE() and returns
> > -EINVAL without setting a parse_error() message, triggering a kernel
> > warning from user-supplied filter input.
> > 
> > Restore the check for FILTER_PRED_FN_NOP in both the numeric scalar and
> > CPUS{} branches of parse_pred() and report FILT_ERR_INVALID_OP.
> 
> Again, please show real examples of what fails, so I can test it.

Yeah, this is much easier to check via tracefs.

# cd /sys/kernel/tracing
# cat events/raw_syscalls/sys_enter/format | grep args
	field:unsigned long args[6];	offset:24;	size:48;	signed:0;

So this event has args[6] array field. So filter needs [] to specify
the element. However,

# echo 'args == 0' > events/raw_syscalls/sys_enter/filter
# echo $?
0

This passed, and

# cat events/raw_syscalls/sys_enter/filter
args == 0

With this patch,

# echo 'args == 0' > events/raw_syscalls/sys_enter/filter
sh: write error: Invalid argument

# cat error_log 
[   23.864399] event filter parse error: error: Invalid operator
  Command: args == 0

Thanks,

> 
> Thanks,
> 
> -- Steve
> 
> > 
> > Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> > Fixes: 3cbec9d7b93d ("tracing/filters: Enable filtering a scalar field by a cpumask")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_events_filter.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index a645af9eb1f8..40efcef94e02 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -2013,6 +2013,10 @@ static int parse_pred(const char *str, void *data,
> >  				break;
> >  			}
> >  		}
> > +		if (pred->fn_num == FILTER_PRED_FN_NOP) {
> > +			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
> > +			goto err_free;
> > +		}
> >  
> >  	/* This is either a string, or an integer */
> >  	} else if (str[i] == '\'' || str[i] == '"') {
> > @@ -2166,6 +2170,10 @@ static int parse_pred(const char *str, void *data,
> >  		else {
> >  			pred->fn_num = select_comparison_fn(pred->op, field->size,
> >  							    field->is_signed);
> > +			if (pred->fn_num == FILTER_PRED_FN_NOP) {
> > +				parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
> > +				goto err_free;
> > +			}
> >  			if (pred->op == OP_NE)
> >  				pred->not = 1;
> >  		}
> 
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
