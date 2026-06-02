Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060CC2AD16;
	Tue,  2 Jun 2026 00:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358811; cv=none; b=VcaCuyXKr1jJsqtJRcPP9A83vQSWRdA62+NMOzDNix4jUUf2B3Rtkze1Z2YwHUPCdclEEwkcZSXvjgADRgATNHN9xGpCD86yzoByHwgDroUuVs3V29VP+cIWxYfBNDNMbWAjjPvrPo2rziQHG5ojtY5nXrtNrGPkYsqemAOyWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358811; c=relaxed/simple;
	bh=klzDu+MulMQkNvX5+ID7LxTopvismjKeM+mPSTgys0E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Yt4fMqw3FBsqjhI43iTwM3b3pMDvYnSx7XfURQhc4d6GHWIvbG8wLWyF2ub5c/iH4MIWeaHoCANxhTCAyiVJd2JDN6Nyi8Lp3FBeWEY8sCp224L5lNB4rNVgXLt0yN91GDAz+bpS/wdQouCGU4U46/9OP98W+5BJp8HItV/FHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfZwtk/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfZwtk/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147301F00893;
	Tue,  2 Jun 2026 00:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780358810;
	bh=3qVW+GPEZiDLr7XGEymelxm9uoAye265QaDyUqbNCpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hfZwtk/lEnm2+ABW7PXFIiazsmCSmZw7vNF4zmn42bvSuhESd5gCQxhYinC6oOX7D
	 qFF5OGqARHZ2CL8IrMGMwuz/F88J41E5f3uwAF5GlKTkOTyUW2xOyc7mnvD2csfESY
	 xa4edXdSUWIDqhE0mBZMy6bnXXxZ621mFmIO2IWk6MtzyghBHPvDiJ7s81TG17vLP0
	 zwIt4aCS8qGnuut7qY5O+c6Q+ws7lr4d5HIxrSdSfKKRJr0bck5YnFGS2p4hQHW9e/
	 kbffKu47QmkkKkSkX8XxvftXiggzpiaKF6Jjio8Rb4naI5k0kMcIDwCPEVaGV9kjzj
	 BvYWKN0RbhJ5Q==
Date: Tue, 2 Jun 2026 09:06:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian  Rogers <irogers@google.com>, Jiri Olsa
 <olsajiri@gmail.com>
Subject: Re: [PATCH v8] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260602090645.502c6cb8cc9ed4c4d255d75f@kernel.org>
In-Reply-To: <20260601133129.4a1e9dec@gandalf.local.home>
References: <20260601130746.2139d926@gandalf.local.home>
	<20260601133129.4a1e9dec@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 13:31:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 1 Jun 2026 13:07:46 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Changes since v7: https://patch.msgid.link/20260529110442.0967a64c@fedora
> > 
> > - Add error message in parse_btf_args() for failed parsing of TEVENT.
> >   (Sashiko)
> > 
> > - Remove TPARG_FL_TYPECAST and just use ctx->struct_btf instead.
> >   The flag was redundant and added unnecessary complexity.
> > 
> > - Restructure to keep the lifetime of the TYPECAST to the end of
> >   traceprobe_parse_probe_arg_body(). This allows the last_type to stay
> >   around in case there's not a type parameter and then btf can still be
> >   used.
> >   (Sashiko and Masami Hiramatsu)
> 
> And I rebased onto probes/for-next
> 

Thanks, but it seems Sashiko failed to apply (because it is using
linux-trace/HEAD branch?) Hmm, we may always need "base-id" tag.

Thanks,

> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
