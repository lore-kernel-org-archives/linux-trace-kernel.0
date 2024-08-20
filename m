Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580AA1370;
	Tue, 20 Aug 2024 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724197436; cv=none; b=pSH8R/zEHeKSMUsNyMdCLUVnll1OQ9KL6WCu4QZslz4fBBpVHOu+GJHKAKb2iN3YE97+emFIMKRBPEXzeXZalxwy3v5d4y+cW6KHHpYmfcY+oNfRa73420zmLo3brk+eLuskdN0Yb1xrKFf1ad080nYI6gXKO07VIIYeKIn1eWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724197436; c=relaxed/simple;
	bh=rznuTR1pqbYxKs1HdN8k/Aw0Ws/gZWqUO9JIi2Ea0/8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pklzqiOVEl2yRZqj8irjAGNMwtsfrB6n4a/pNp6ABdBXGbsRTKhdt8rbjI/oDJN0KZGR62yEzP3uMs/pD7zU280Ns/YLYm8QdK3xEyP5g3LGquTtuPnFbsm8mUU09gmdUaxlHtpKj4CeSEmIV9Iuzd99EOROrjKSrCB7ONBsbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqMSduQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqMSduQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16703C4AF14;
	Tue, 20 Aug 2024 23:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724197436;
	bh=rznuTR1pqbYxKs1HdN8k/Aw0Ws/gZWqUO9JIi2Ea0/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NqMSduQo4/ABdSbtKdAD3zRPsRLmFyND+TSngNFGrR3bM0pJ7N9CbdVjbl9oIcDG5
	 xzPXCxraQpQJHuGRDkEYy15LI463YXkQmP8V/m+Y6yslg8WlqTe+TOOonFgLOP17A8
	 or13YUkEjrcfeVtXeynytwFTr3MtCy0u/gtxTcin9z+Af3JtChEVvgfYXjVs2OMljZ
	 /MlS8JJQhOaA6iu+kZROuZqUynTw0unZepcf/mmN99XebWDTZJ2DCKEbMhK0SF3YxD
	 FsLHAC3dCPRnZc5xb4pxDT0crDYcfR7gYCh6mwao1qtvdt/HZ0OHNyz7Da74wFHu+k
	 dD/RsKEQgMtMA==
Date: Wed, 21 Aug 2024 08:43:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Mark Rutland
 <mark.rutland@arm.com>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor
 <nathan@kernel.org>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-Id: <20240821084351.4b1c9d4d52b5aa7e07681d69@kernel.org>
In-Reply-To: <20240820181109.4203158d@gandalf.local.home>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
	<20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
	<ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
	<CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
	<20240821070539.981b42e5f3b939c5ce5e3a71@kernel.org>
	<20240820181109.4203158d@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 18:11:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 21 Aug 2024 07:05:39 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> 
> > Does the noinline attribute prevent embedding callsite too? I mean
> > 
> > extern callee()
> > 
> > noinline callee()
> > {
> > ...
> > }
> > 
> > caller()
> > {
> > 	callee() // (*)
> > }
> > 
> > In this case, does noinline prevent LTO to embed the callee at the callsite(*)
> > or prevent LTO remove the callee() symbol?
> >
> 
> Even though we have it passed as a parameter, I think the compiler and
> linker is smart enough to see that and notice its use, and that the
> function passed in is a nop, which doesn't break the flow.
> 
> Can you add the __used and see if it fixes it?

Adding __used to DYN_FTRACE_TEST_NAME() and DYN_FTRACE_TEST_NAME2() does
not change, the test still fails. Hmm, what about makes the caller
(trace_selftest_startup_dynamic_tracing()) called via a function pointer?
In that case, wouldn't it be subject to constant propagetion?

Let me try.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
