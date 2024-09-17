Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB22905;
	Tue, 17 Sep 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561591; cv=none; b=b0QJZ+7PRHYR/TnwKbAafYM696n+HWYZStVVdkhfrGSnd3iIiD70CyyEjzQhTx3wDI0Izi9QQ0aaZmFTxXzE0y21JY1MkAEDigj931zw5f3l3foyUzNnQdoI14ylAVRc8HV9mLo3QlmPP7cDBfjZ26LWkT32ggMDT4Q//FLJ/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561591; c=relaxed/simple;
	bh=yX8WybCaNIWhzTkbjSWRx9jTOwkDZkYTQGTxrYRDcI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgsECLyn9eMKdaeE5kmFgA1hHtZTUSQ9KEYdwwMevbascEekpqECZhiy8ckckDzb0h0g6nuf/nnyPyVrFgV9O8yDYFq8+jtCzJuXFTZFyLVHWQ8iFm5W2d5FsphsusSOXLyOFSBzgYlu+NpZJ9SI63tUKz2N9PRQMsI9Yf+CxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rifoRMQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rifoRMQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138CCC4CEC6;
	Tue, 17 Sep 2024 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726561591;
	bh=yX8WybCaNIWhzTkbjSWRx9jTOwkDZkYTQGTxrYRDcI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rifoRMQL3+zR0FXXPfapgOmRYlb9GjXyEP6JxSCdSt51CcQHUrVMqO8TJqg3ogKsD
	 cXQkEv/N8owpRl+A1Jv2OudODUg3VP1xEKvq/PUU3vPWmiTwXYlnG5GxTyK5lJkAf+
	 G/lupAVj5DCYBCDBtBZ9+zTNBNZuFbrn9hC0HElmW17HAoaYRtD/RaaAgPmPfKQPFm
	 Y9Ycxexf9DHiMrhUvOvYEfJzgMfay78SwfZDaxOh71qbrAuQBFKBwTNHpfB/ZHDZ3Y
	 12Tyb6aq37kF/XIhLPT2P/14mNmmKDD1M13i4+UNfkU/p6TI/MEZ5li8iYSIpiodmk
	 xrIyGp2Uf68zg==
Date: Tue, 17 Sep 2024 09:26:25 +0100
From: Will Deacon <will@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 03/19] function_graph: Pass ftrace_regs to entryfunc
Message-ID: <20240917082624.GC27290@willie-the-truck>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <172615372005.133222.15797801841635819220.stgit@devnote2>
 <20240915044614.5721947e@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915044614.5721947e@rorschach.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Sep 15, 2024 at 04:46:14AM -0400, Steven Rostedt wrote:
> Can I get an Acked-by from the AARCH64 maintainers for this patch?

Sorry, I wasn't CC'd on the thread, so I missed this.

> On Fri, 13 Sep 2024 00:08:40 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Pass ftrace_regs to the fgraph_ops::entryfunc(). If ftrace_regs is not
> > available, it passes a NULL instead. User callback function can access
> > some registers (including return address) via this ftrace_regs.

Under which circumstances is 'ftrace_regs' NULL?

The arm64 implementation of ftrace_graph_func() is:

> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index a650f5e11fc5..bc647b725e6a 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -481,7 +481,25 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
> >  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> >  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> >  {
> > -	prepare_ftrace_return(ip, &fregs->lr, fregs->fp);
> > +	unsigned long return_hooker = (unsigned long)&return_to_handler;
> > +	unsigned long frame_pointer = fregs->fp;

Which dereferences the unchecked pointer here ^^.

Will
