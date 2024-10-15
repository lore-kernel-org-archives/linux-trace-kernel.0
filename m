Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CC1741C3;
	Tue, 15 Oct 2024 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979325; cv=none; b=MT/xJutRVnZDZCKSvViZl1JDoUywoNVcF4f18JaEWOzztyx8IYjyQPwGsB3GtPO0GpBngJ3qjJBsnllDTdUon5nOMoTK39NGqQ5lKuVNvW/RiXNUkEjGt7M6DzBfI2dxH9AeMhRa+HfgN2umiixJUuS0ICbzgEpRkIv05B0pPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979325; c=relaxed/simple;
	bh=ub78Fj7PCTFI7adxyeCQY8inXoEvVxn+YvQzp6OGWQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY80wX+gMYfrU0RmaoDcW+8nJUcF2LvWHXlSWnc2FVZAXXwTwEO84RdQm+qfEaTUn+cn02Jalfq/QRkPvhlhoLuTdtUNl3xUEaU8R5YSlZCCzt7jqiOfI10JswMVZfeMRvFioee8E/vceEQW55ils/sd1b+YFhhG983RtJhHi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZumZydWW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZumZydWW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gO8AXV3B3+bik/RmMlaIBDc/tPOhu1CUoXsAdzC3rhk=; b=ZumZydWWVsQBa++m6UFoeoy0vB
	FLXl1TcBc3Zi01yXnKrG+W1FK/OPXske7V28LyWG3UTejn0fKVutu8yHOiw4r89dhFcgh0qPU/kFg
	Sd8j/HxQ1iqps4UtWEKJyl6cQYNjUlcFKwoGKmiJ0583SbH64+FdS63WwNvgxW+29QXRhSTwm0Isj
	dznMNsZ6cJAugWGqilbiTWdLg/ZlVUQIF7q7SfkWEoqOJS6pYYftmOdJS5HEM622IdIiJZLpnWSps
	v6AkB1rvlFbP2yXB5d/TuxLicOz1lEaPeox7a/aINoGk3DnPQ68McYutFNJcJ5ytM6/RZgkRBg73C
	yQVDoHew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0cV4-00000006VX3-0lUY;
	Tue, 15 Oct 2024 08:01:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEFE43005AF; Tue, 15 Oct 2024 10:01:49 +0200 (CEST)
Date: Tue, 15 Oct 2024 10:01:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zheng Yejian <zhengyejian@huaweicloud.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: Have compiler remove __fentry locations from overwritten weak
 functions
Message-ID: <20241015080149.GP16066@noisy.programming.kicks-ass.net>
References: <20241014210841.5a4764de@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014210841.5a4764de@gandalf.local.home>

On Mon, Oct 14, 2024 at 09:08:41PM -0400, Steven Rostedt wrote:
> There's a long standing issue with having fentry in weak functions that
> were overwritten. This was first caught when a "notrace" function was
> showing up in the /sys/kernel/tracing/available_filter_functions list.
> 
>    https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/
> 
> What was happening is that ftrace uses kallsyms (what is basically listed
> by nm) 

Ah, if only. NM lists the symbol table, and that has strictly more
information than kallsyms, notably it includes symbol length. Using
symbol length it is trivial to distinguish the case you're tripping
over.

> to map the location of __fentry to the previous symbol ahead of it.
> Then it says that function is the name of the function for that __fentry.
> But when you have weak functions, you can have this:
> 
> 
>   int notrace do_not_watch_me(void)
>   {
> 	return whatever;
>   }
> 
>   void __weak define_me_in_arch(void)
>   {
> 	return;
>   }
> 
> The define_me_in_arch() gets a __fentry, but because it is overwritten, it
> becomes attached to the end of do_not_watch_me(). When ftrace asks kallsyms
> for the symbol name of that __fentry location, it returns
> do_not_watch_me(), and ftrace will simply list that.

Which is a kallsym bug that does not exists in the ELF space.

There is a patch set that tries to fix this here:

  https://lore.kernel.org/all/20240723063258.2240610-1-zhengyejian@huaweicloud.com/T/#u

Instead of adding size to kallsyms it adds extra symbols to denote the
holes, which ends up being similar.

> But I was thinking, since gcc (and perhaps clang?) now has:
> 
>   -mrecord-mcount
> 
> that creates the __mcount_loc section that ftrace uses to find where the
> __fentry's are. Perhaps the compiler can simply remove any of those
> __fentry's that happen to exist in a weak function that was overridden.
> 
> Would this be something that the compiler could do?

Linker, this is link time. The linker would not only have to drop the
(weak) symbol from the symbol table (which is all it really does), but
it would now have to go and muck about with other sections.

It would have to go re-write the __mcount_loc section and drop entrie(s)
that were inside the dropped symbol. But then, what about other extra
sections? For instance, we can have (and still patch) alternatives in
the 'dead' weak text.

Where does this stop?

LTO can do the right thing and completely eliminate the weak function,
but anything short of that is a really big ask. Esp. since this is a
problem of our own making -- kallsyms is a flawed representation of the
symbol table.

