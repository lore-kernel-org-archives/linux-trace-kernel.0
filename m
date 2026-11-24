Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529713;
	b=kuB+pgyxGP+Re0Js0LjtLLDpm6fjb+dKeGw523rrFMaG216Nc39etmtfHT+mVn6EO9wQ
	 vWWBD6JY/khAd170s6TcmVluh5xqqukpEsznySBb/Gjep9CqUjj/FVGaNOTeYtO4fJrnR
	 2RwChrqTevxjMMZrwZgqH/jnqP9ZvEqRhyI0WLGpifv83rxLaJ3Z7KMFS99IrxudxKq/p
	 PxGuqpMHqIjwusPHa2NgYu9OjJxQJceIN7nQ0ydwv7QbYp43dkQGDJgq+bEljmsl2uImx
	 yzfwefI+aXfi00I3N3PYfdsX4JmuP+xGuvVbsSj/3yTKjE3ODKQJzoh5rE+9vRFBErg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529713;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pafrI7EWUMbzwRHzUxm0rlPjN0PkFRkoUHe/ZBWtmUY=;
	b=T8J3Wga5jW775kHuxX/c0WV/JDNmEA/W5+0dT8lqZywCAyY52SCnbLA0QzYzRy5HcWgI
	 JQCqbOrlFTAXql6psCqNpWjhEEwJ4Z147npbzO01XGsPevvjsgU2boXZhqSkii8H8H398
	 rJVq3YhXG0RvMkzrnMeOJhvY+WX5Urt/4y1ffHYNW+1Z2XxNB+vULBXAQ17KdZ/0hESJ/
	 FyS+Ceut/SWu6ykFPoLxg0OR7BufqMMPtC9zJBWARiqNfdWxm6yVKNeb1kP7e3OY60zUI
	 dL89UF/2Ux6ZJW3Ei90kRDKwILJcow9MFHVXYRSfLPczBycn9Oc+QpNMdg0sSku/QLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki36KBgN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E82606A327;
	Tue, 24 Nov 2026 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki36KBgN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527ED1F000C4;
	Tue, 24 Nov 2026 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529713;
	bh=pafrI7EWUMbzwRHzUxm0rlPjN0PkFRkoUHe/ZBWtmUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ki36KBgNt354Jd8iC91MH11OITEzhVajYjxJkr4I0kqqhq8nyaEB/DFDt232QYYcH
	 yJrbkxywNxzMpiShTuH14SPxGufca8ye18oXR1H0+ljK52vtavlFENTaWzG7Vs/jOB
	 n+BPQjbDciMzH4/u9Az5l7cU87zLKfklG8tElu8dJxBzovjXfCfajMd/xWOA9wS/9w
	 yuJugYLplsZ7afMzdhyyVH6XTkd+lC2KWiJL+U5ISSpD1SvayQJx8BjWDnK5yVjiZT
	 qUVw/3qv93jFpzDeDOqHGoGKibxYXBUuvOPGTNV4Ggz2U8J8siX4Wt5Q4fdQ0iA2AH
	 SvzU44bn7FbFw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] tracing/probes: Zero out faulted dereferenced fields
Date: Tue, 24 Nov 2026 23:15:10 +0900
Message-ID: <undine-1795529710371793698-f2bd67810f91497f@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261124090849.7fe8d45f@gandalf.local.home>
References: <20261123213246.00440bfc@gandalf.local.home> <sashiko-outbox-230424@kernel.org> <20261124090849.7fe8d45f@gandalf.local.home>
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

On Tue, 24 Nov 2026 09:08:49 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 24 Nov 2026 02:51:12 +0000
> sashiko-bot@kernel.org wrote:
> 
> > > @@ -193,27 +256,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> > >  		}
> > >  	}
> > >  
> > > +	/* When val is NULL, so should the val + offset */
> > > +	offset = val ? code->offset : 0;
> > > +
> > >  	switch (code->op) {
> > >  	case FETCH_OP_ST_RAW:
> > >  		fetch_store_raw(val, code, dest);
> > >  		break;
> > >  	case FETCH_OP_ST_MEM:
> > > -		probe_mem_read(dest, (void *)val + code->offset, code->size);
> > > +		do_probe_mem_read(dest, (void *)val + offset, code->size);
> > >  		break;
> > >  	case FETCH_OP_ST_UMEM:
> > > -		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
> > > +		do_probe_mem_read_user(dest, (void *)val + offset, code->size);
> > >  		break;  
> > 
> > [Severity: Medium]
> > Should do_probe_mem_read() and do_probe_mem_read_user() check for a NULL
> > src before calling probe_mem_read() and probe_mem_read_user()?
> 
> No, but I guess I should add that as we probably shouldn't be dereferencing
> zero when something fails.

Maybe we should make it rejecting dereference if IS_ERR_OR_NULL(ptr).

Thanks,

> 
> -- Steve
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

