Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63D2877E5;
	Thu,  8 Jan 2026 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841662; cv=none; b=BgLmVTObARZ6/TsMkf2TqIGyS0pQbZ20BDol1QlGGzYP7qolrblMtrCYgxkSLf8kg8yLe+cu0AQDYhkOdMslevPjncW9I3wx/Sdtfnh53m6Cgcb7iUcbWVAj4sLhllcn/Z7tY7Xg+91uOG2jHM3TPi5b+EtTWXgKe4NsWSPztWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841662; c=relaxed/simple;
	bh=EQF2mwts8iP61P8n0FF/RKpdNZVZKdbWtdM90aB5FZY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Eo81d744ZDAldyjPaQmb0Rgb4vGDENce8cL9pCscmRjpmE4NVzoggonAGlCIRPyN7tXzvE/uH48DEZcI5bqi66Yec+p4psQn/yJgjkzTEvh2ef1l3FPoeaw4z8K25x1nR32RuumUpKcQvTBlBsBmOgnxzmvlr3jX09g/dNvO4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVF7EHZ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVF7EHZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584C0C4CEF1;
	Thu,  8 Jan 2026 03:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767841662;
	bh=EQF2mwts8iP61P8n0FF/RKpdNZVZKdbWtdM90aB5FZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVF7EHZ/ON0N1p0vkIopMnxTMRt55g0usaku1vaXLqVlGZvtwifKPvQqmod+knOIs
	 0ku/hsDDsu2x8pNkxf96C9xvtU/x82i9uf9/UwefCD+Wr4ocmicu1U/BhDqVHLJruC
	 HwZxhGuGza7hCOALIaPelfT9bf5HuJKVmb2SS4R/u/hBcaWm8vOMiqxdC5eY39dtvR
	 aCOk6sB1Vm4HVsLnLpCmfIHkSB6bkgsXso8oL1tVr7OXcZlk1YSXd7trB2el4WADYV
	 /TqiJhGF1td4vJBR4Gvda8zr/OfcpasXo4yJ2u62FuQgtaBdqXy4R1lKUV7GHfP2on
	 aak52PA7SgFbg==
Date: Thu, 8 Jan 2026 12:07:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Make the backup instance readonly
Message-Id: <20260108120739.e85941b9d7d67f15ded52410@kernel.org>
In-Reply-To: <20260107114133.7f14dac2@gandalf.local.home>
References: <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
	<176779715937.4193242.8486149802702305279.stgit@mhiramat.tok.corp.google.com>
	<20260107114133.7f14dac2@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 11:41:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > @@ -4888,6 +4888,9 @@ static int tracing_open(struct inode *inode, struct file *file)
> >  		int cpu = tracing_get_cpu(inode);
> >  		struct array_buffer *trace_buf = &tr->array_buffer;
> >  
> > +		if (trace_array_is_readonly(tr))
> > +			return -EPERM;
> 
> So this fails if someone opens a file in RDONLY mode?
> 
> Why?

This is for `trace` file and this block is to erase the buffer.

 -----
	/* If this file was open for write, then erase contents */
	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
		int cpu = tracing_get_cpu(inode);
		struct array_buffer *trace_buf = &tr->array_buffer;

		if (trace_array_is_readonly(tr))
			return -EPERM;
 -----

Thus, if user opens it RDONLY mode to read the buffer, we don't care
because it is readonly (readable).

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
