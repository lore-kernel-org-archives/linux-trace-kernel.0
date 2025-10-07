Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAF2D8DC4;
	Tue,  7 Oct 2025 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845471; cv=none; b=pCz3zlUth8QXzRa9KJWxWcPHNW+BQTaUVQbYCAsKVP6vQrK4VojP1zX0C/u9lfOF1k9raLt1+782AkWcBLqzo2RcrOEzwl7FaApgo8TJ7a2PhDtYuXxDQI6x0fAQcSG4F4gMAHvtS5i1L38BeP612iaaDJKlDMWHhBDHbGU6Q38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845471; c=relaxed/simple;
	bh=7vnxx2vBKX3soaR1xXeZZuy2f6p/mUPDTKDAPWVOmNo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Nyid+sMcmSdyg3s1XGdRb+EOuCKW1aH9VoRbBIeYgZGRV8QL3eXVDkowoCvBi29Gxq4jY5WFLBMxOBD9EyVoayAtvdCWqq23lI3IerWMW9kBcWRFxZdpj8/5z/dwQPg4qAhse+dMuZPb1/VsP8/gfQVajtndKS1R+3D7porYMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUwhgWa5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUwhgWa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C825CC4CEF1;
	Tue,  7 Oct 2025 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759845471;
	bh=7vnxx2vBKX3soaR1xXeZZuy2f6p/mUPDTKDAPWVOmNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HUwhgWa5oEbqFGlZ6ZKOSM8DpaD2YOUwTIfPAJMudQz8ace8CS7QNWqW8QeVHJTS2
	 Xc0GwOQEYQ8OdpFYvqunqr9BnpHkM6gdqM//o8CbWZMvMk9pWqhg+4ZThQN4FbO172
	 eK4Tq3NE9EJDLL1neFQJAf6rjPAsYymK7UYPgoaD1Y3J7t9faWVPJ7o9UT2GiRJvsw
	 n7THZUujSk+IOP/hXGo7wXqNVe1K1P8tK8Oc3gqk4YC7Hm9qYCUMqHPjhMLVvHrvGi
	 dz/SKct1cSxtZ1whiXI66+90cb4hIV2BjggpiTl+zMyXCVIuiw6mmm/9QMOd/jDwas
	 VojdWV6i5WQzw==
Date: Tue, 7 Oct 2025 22:57:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [for-next PATCH v2] tracing: wprobe: Fix to use IS_ERR_PCPU()
 for per-cpu pointer
Message-Id: <20251007225746.ad26cec6b6fa71b47033a7d7@kernel.org>
In-Reply-To: <6198553.lOV4Wx5bFT@7950hx>
References: <175979899246.1800846.1725245135731182727.stgit@devnote2>
	<6198553.lOV4Wx5bFT@7950hx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Oct 2025 11:12:18 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:

> On 2025/10/7 09:03, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since wprobe uses IS_ERR() for per-cpu pointer, it failed to build.
> > 
> > /tmp/next/build/kernel/trace/trace_wprobe.c: In function '__register_trace_wprobe':
> > /tmp/next/build/kernel/trace/trace_wprobe.c:176:20: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
> >   176 |         if (IS_ERR((void * __force)tw->bp_event)) {
> >       |                    ^
> > /tmp/next/build/kernel/trace/trace_wprobe.c:177:35: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
> >   177 |                 int ret = PTR_ERR((void * __force)tw->bp_event);
> >       |                                   ^
> > 
> > Use IS_ERR_PCPU() instead.
> > 
> > Reported-by: Mark Brown <broonie@kernel.org>
> > Closes: https://lore.kernel.org/all/aN6fTmAjD7-SJsw2@sirena.org.uk/
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  - Confirmed that `make allmodconfig && make` passed on x86_64 and arm64.
> >  Changes in v2:
> >  - Remove unneeded casting.
> >  - Use PTR_ERR_PCPU() too.
> > ---
> >  kernel/trace/trace_wprobe.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> > index 4b00a8e917c1..98605b207f43 100644
> > --- a/kernel/trace/trace_wprobe.c
> > +++ b/kernel/trace/trace_wprobe.c
> > @@ -173,8 +173,8 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
> >  	attr.bp_type = tw->type;
> >  
> >  	tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
> > -	if (IS_ERR((void * __force)tw->bp_event)) {
> > -		int ret = PTR_ERR((void * __force)tw->bp_event);
> > +	if (IS_ERR_PCPU(tw->bp_event)) {
> > +		int ret = PTR_ERR_PCPU(tw->bp_event);
> 
> This version LGTM.
> 
> Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>

Thank you! Let me push it in probes/for-next.

> 
> >  
> >  		tw->bp_event = NULL;
> >  		return ret;
> > 
> > 
> > 
> 
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
