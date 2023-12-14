Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CAD6108
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSEWEqGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09AAC433C7;
	Thu, 14 Dec 2023 05:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702531148;
	bh=Qmguxw2VEVkdVujawfXKj9hwmQrHGLFvLZ7pg6rQI8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSEWEqGEva6OY5Pl9k5S1taXN2jrycqHbr7jLJyw0uTdJz3uyiILDCkwtjoIwfeIF
	 B4FLQo71YhYmk4SpI+sGDAiOb0e8+lwzcchJHmqLA0EV1megEwmY64VoL2N9c3HHEl
	 OBf+FmSRd9xKHbln/tnWntDdRYXGbmHjm4RgKoZYQqJ2JWQv8hawASRySqRIRBlOMa
	 7Vw/dACuRBnenN28rwhFZQtBWEZEnoEaK2KZo1JUzCKHOdjBNFzefbLTB9CUTN2odZ
	 0UudCTtjJwxRrkgrBc/Xmp2iYcJC4VrkasxVq8TmtFw3F54RKN+a9SXD8nONekoHGt
	 by/vNuvkNg8EQ==
Date: Thu, 14 Dec 2023 10:46:56 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Srikar Dronamraju <srikar@linux.ibm.com>
Subject: Re: [PATCH v3] trace/kprobe: Display the actual notrace function
 when rejecting a probe
Message-ID: <adcah2zl66ghxbavtqaxzrnkbw5j2qhm4zghpen2byou45u4ck@oojp275o57pi>
References: <20231213143914.1591175-1-naveen@kernel.org>
 <20231214080210.99ff94d956307b036208520d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214080210.99ff94d956307b036208520d@kernel.org>

On Thu, Dec 14, 2023 at 08:02:10AM +0900, Masami Hiramatsu wrote:
> On Wed, 13 Dec 2023 20:09:14 +0530
> Naveen N Rao <naveen@kernel.org> wrote:
> 
> > Trying to probe update_sd_lb_stats() using perf results in the below
> > message in the kernel log:
> >   trace_kprobe: Could not probe notrace function _text
> > 
> > This is because 'perf probe' specifies the kprobe location as an offset
> > from '_text':
> >   $ sudo perf probe -D update_sd_lb_stats
> >   p:probe/update_sd_lb_stats _text+1830728
> > 
> > However, the error message is misleading and doesn't help convey the
> > actual notrace function that is being probed. Fix this by looking up the
> > actual function name that is being probed. With this fix, we now get the
> > below message in the kernel log:
> >   trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0
> > 
> > Signed-off-by: Naveen N Rao <naveen@kernel.org>
> > ---
> > v3: Remove tk parameter from within_notrace_func() as suggested by 
> > Masami
> > 
> >  kernel/trace/trace_kprobe.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 3d7a180a8427..dc36c6ed6131 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -449,9 +449,8 @@ static bool __within_notrace_func(unsigned long addr)
> >  	return !ftrace_location_range(addr, addr + size - 1);
> >  }
> >  
> > -static bool within_notrace_func(struct trace_kprobe *tk)
> > +static bool within_notrace_func(unsigned long addr)
> >  {
> > -	unsigned long addr = trace_kprobe_address(tk);
> >  	char symname[KSYM_NAME_LEN], *p;
> >  
> >  	if (!__within_notrace_func(addr))
> > @@ -471,12 +470,14 @@ static bool within_notrace_func(struct trace_kprobe *tk)
> >  	return true;
> >  }
> >  #else
> > -#define within_notrace_func(tk)	(false)
> > +#define within_notrace_func(addr)	(false)
> >  #endif
> >  
> >  /* Internal register function - just handle k*probes and flags */
> >  static int __register_trace_kprobe(struct trace_kprobe *tk)
> >  {
> > +	unsigned long addr = trace_kprobe_address(tk);
> > +	char symname[KSYM_NAME_LEN];
> >  	int i, ret;
> >  
> >  	ret = security_locked_down(LOCKDOWN_KPROBES);
> > @@ -486,9 +487,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
> >  	if (trace_kprobe_is_registered(tk))
> >  		return -EINVAL;
> >  
> > -	if (within_notrace_func(tk)) {
> > +	if (within_notrace_func(addr)) {
> >  		pr_warn("Could not probe notrace function %s\n",
> > -			trace_kprobe_symbol(tk));
> > +			lookup_symbol_name(addr, symname) ? trace_kprobe_symbol(tk) : symname);
> 
> Can we just use %ps and (void *)trace_kprobe_address(tk) here?
> 
> That will be simpler.

Indeed - that is much simpler. v4 on its way...

Thanks!
- Naveen
