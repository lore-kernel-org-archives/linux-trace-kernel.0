Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB5158218;
	Tue,  1 Oct 2024 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825087; cv=none; b=OD9SLDJlwp5wWKDYfIKS0INnArftQtgSk4eRs3H/T8Cu+0LKkbcQ+IlMPfYSnRaqICWK9xcZR5AIjWJjvCcYNEjnjmjx82j427+gOU1PdAhRSW9Eh07JgBzS5oWcaVRnzOiBZGoLnx14Skn0gcLvyACNlVvKfMufMQBpCo+82fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825087; c=relaxed/simple;
	bh=E7pdhOtR2rHLVVHc5+lB03lkJEdDwGbAarZ8dCCD65I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AIl44RZASMyTVJaK7dHCDW9+MnztisKtkHAa9mNRQizolbI7tZsijZ4n7oKCyjv7wSVIKA2xM1MrVu9V2xAMgDhV3tDp0KcQvVq+wK/LZ+RDZs7+vwG30H9wpxAzPzuBpn1zX1ImZrBvyVQj/TvZORUTNfqdgZvhlHgsEdOtdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyM4qsCi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyM4qsCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DA0C4CEC6;
	Tue,  1 Oct 2024 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727825085;
	bh=E7pdhOtR2rHLVVHc5+lB03lkJEdDwGbAarZ8dCCD65I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QyM4qsCixCY6idN6G/ACjPAk+bwTXxn1GoEWZ/Q4BNv1DW7CWNqco3BAiX/Hd3Zid
	 iKIbHk4OGqFMuHW+Ak6DaH7DJ00+6RJ5xCn7yUy0TSq93AKBAnjxnYPdhRNG8+VQIl
	 mTOKyj9pcQ6mXtLeDZcPQw6csAicl53FA/krEd05pk6da00RPr0M7xmZdSW+hIfBjW
	 TSNZhx/J1EIZOxfIS81WTCzd692ZXu6NLa8FVjT79JpeTx3/riCMLuOJV5qySEdaY9
	 6xSx+SfEKS5LO/2Byv3F5ZsiuMAns23zOdXwlwFHiHCZmFiqi/Tq7Dcz32N5pEkAfS
	 PWdZ6QZ0sRcEQ==
Date: Wed, 2 Oct 2024 08:24:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 05/19] function_graph: Pass ftrace_regs to retfunc
Message-Id: <20241002082440.6fd01f29dcc00e7fe4d10cdd@kernel.org>
In-Reply-To: <20240930150302.6c5c9f0a@gandalf.local.home>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615374207.133222.13117574733580053025.stgit@devnote2>
	<20240915044920.29a86d25@rorschach.local.home>
	<20240917100848.GB27384@willie-the-truck>
	<20240930150302.6c5c9f0a@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 15:03:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 17 Sep 2024 11:08:48 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > > > @@ -787,6 +789,9 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> > > >  	}
> > > >  
> > > >  	trace.rettime = trace_clock_local();
> > > > +	if (fregs)
> > > > +		ftrace_regs_set_instruction_pointer(fregs, ret);  
> > 
> > Where does the instruction pointer get used after this? The arm64
> > 'return_to_handler' function doesn't look at it when we return.
> 
> It's for the hooks to the return instruction. kretprobes will start using

not kretprobes, but fprobe. kretprobes continue using rethook.

> function graph tracer to hook to a return of a function (via fprobes), and
> the callbacks will need access to the return pointer. The callbacks get
> passed the ftrace_regs, and this is how they can see what the function is
> returning to. For example, BPF programs will need this.
> 
> So it's not needed for the infrastructure, only the callbacks that hook to
> it.

Yes, it will be used for showing where to return in the fprobe exit event.
More specifically, in the fprobe_return()@kernel/trace/fprobe.c in PATCH 13/19,
it is extracted from fregs.

+static void fprobe_return(struct ftrace_graph_ret *trace,
+			  struct fgraph_ops *gops,
+			  struct ftrace_regs *fregs)
+{
+	unsigned long *fgraph_data = NULL;
+	unsigned long ret_ip;
+	unsigned long val;
+	struct fprobe *fp;
+	int size, curr;
+	int size_words;
+
+	fgraph_data = (unsigned long *)fgraph_retrieve_data(gops->idx, &size);
+	if (WARN_ON_ONCE(!fgraph_data))
 		return;
+	size_words = SIZE_IN_LONG(size);
+	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
+

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
