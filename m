Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8935893;
	Mon,  6 Apr 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775438423; cv=none; b=ZfQeaW9U5m9a7pq16JnKjduGYNFblLx8Fkat0C8PAzYc+l8jOUMppFYnpXQKjLptIOH+O2ZxCc9j7yCotpkkWebnQ3O8WOiCc8i2Zln/PmGGsbIhEcr9ZLkj548wK/hm5LYfr6i/JqbgEnZkRLdjywISlladjVKi/hX7XQ+NMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775438423; c=relaxed/simple;
	bh=ChWpWgnzDX+VRDW6JkBu6ZbaCADUSRGwuid6PaHCBVI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BqJwSQAhgijw/1afJ3QnRp1dM1Eadre5YFO90afPlk8AE9FJupLe3+IZBrDoynZoFFlTQ6cfvRWEjs+Z3/YGT7pObP+kEWm6i7izbQdXwhVLAZ133j/Cmrh1n5FD0EakHlwrjpapqsfPidyrcQFTUtjYQfRNuVpCO3ne/JgHrmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlW9AOn0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlW9AOn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CF5C116C6;
	Mon,  6 Apr 2026 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775438423;
	bh=ChWpWgnzDX+VRDW6JkBu6ZbaCADUSRGwuid6PaHCBVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SlW9AOn0bSJ49bAhEjhhrEGCOJzl3TuBL7k/1mlZtviEfITAx985IpDYHGRq1ukP7
	 PmtvY3L8ZeqVFGg+TFG8sKPSmeOm7QbL88kWezKQ2OdCceedzTKqmEYzu0QydLpHcx
	 PGJTjzvs7fjiV0Im7VD5fmjVY1vIalsnVqO+r8A7oNjlEhEVHWoVrEScqxWQxFgvyo
	 TtXYsL5kXFs+O6o/v9kEW4oNNv4jownrcwQkjJORYDyG0XwPc5rz+iiocF8K8U77Mr
	 UxwRykoSIoa6Vh7NIAadXedY9vlrncfVy+bXzPVdNaZN3jSfL152zTAWdDYIV9ngd6
	 InYlT/IharP5w==
Date: Mon, 6 Apr 2026 10:20:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/probe: reject empty immediate strings
Message-Id: <20260406102019.8a73535655f62e12c1479d62@kernel.org>
In-Reply-To: <20260406101124.e4e5af12634fb1136cd7d132@kernel.org>
References: <20260330062920.40766-1-pengpeng@iscas.ac.cn>
	<20260401160315.88518-1-pengpeng@iscas.ac.cn>
	<20260404093359.e3bc3f7ededeba6a73858e5d@kernel.org>
	<20260406101124.e4e5af12634fb1136cd7d132@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 10:11:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi,
> 
> On Sat, 4 Apr 2026 09:33:59 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > > index e0a5dc86c07e..e1c73065dae5 100644
> > > --- a/kernel/trace/trace_probe.c
> > > +++ b/kernel/trace/trace_probe.c
> > > @@ -1068,7 +1068,7 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
> > >  {
> > >  	size_t len = strlen(str);
> > >  
> > > -	if (str[len - 1] != '"') {
> 
> It seems that this is not correct fix, because __parse_imm_string()
> is only called from below code:
> 
> 	case '\\':	/* Immediate value */
> 		if (arg[1] == '"') {	/* Immediate string */
> 			ret = __parse_imm_string(arg + 2, &tmp, ctx->offset + 2);
> 			if (ret)
> 
> Thus the call-site already checked the double-quotation.
> This means this if block itself is meaningless.

Nevermind, this fix is correct. But the title is not correct because
we still can specify an empty string (\""), but this rejects non-closed
empty immediate string (\").

Thank you,


> 
> Thanks,
> 
> > > +	if (!len || str[len - 1] != '"') {
> > >  		trace_probe_log_err(offs + len, IMMSTR_NO_CLOSE);
> > >  		return -EINVAL;
> > >  	}
> > > -- 
> > > 2.50.1 (Apple Git-155)
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
