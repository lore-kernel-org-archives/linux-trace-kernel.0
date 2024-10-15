Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D3148FE1;
	Tue, 15 Oct 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982379; cv=none; b=XKNvFR08mK+900h5tmHSkbgUGfmjnfJ/KecFUSK8RtcVNtXdnWUE6UVeN7fi1V5auLju6Ua3NMGu4sfiUYSGlZjPjlaUKN8eTI5QkHyfrxFfljxp74Cj0xBvGnwC3Ux5kvJYFcpI/g97dZzrem1PuakOrtbU+OxXVmPlaRDiqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982379; c=relaxed/simple;
	bh=BKJ3P8C8X9Uyv3rS2m9K9VYrOMNfdiuDwYEdrx5Njhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBr6iTn/ULx0WLNEBl87+RWCpOQm+bSY2ZKSbgUyponmLlRxAJcim9qc49idgdnPb9XIQlVSDBPq0Znjd3O6vSNg10JDrHmrKGQxNn4yI9r1JGNn7D9i4sBYJzjdgR2cm2SiRf682P5DNtlC33QhKblHimoZCYOC7lRVgjATSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N52+UOcm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N52+UOcm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tADmReae8PUwtMPdqzngbDG531D18HRsicXZDEfUBf4=; b=N52+UOcmR8BpG8UetqR9ABLorp
	IeCmTlgMpuLKHB9gikzYYNv7+ACeyjoZfqkfE9eR4gOdlEQPt0n/joEfsN8LLxnaepVikhHpZfUQl
	AJuJ8l+u4hFL94wTd/gHKHq5/VMveZec3jhSC9//zNUV5wIzBI1A8KuTQjsamz+7xSgUASSPGMfuv
	278j/wOkMWTmDWtCKgrluCXP2wbM+G7MZeQwFtk24HcGzaZpLytaCtApUoq2NjrB7D90DdiGQQHb6
	3nUPMKvaeFuuNCsE2Aa53KqD2satQqpj6YRmh1DxwBDKSFiAD4MM+PGp43ec9BXivPgU5PyPr3njt
	FF3L0LEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0dIN-00000006WOH-2NwR;
	Tue, 15 Oct 2024 08:52:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 84D47300777; Tue, 15 Oct 2024 10:52:45 +0200 (CEST)
Date: Tue, 15 Oct 2024 10:52:45 +0200
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
Message-ID: <20241015085245.GO33184@noisy.programming.kicks-ass.net>
References: <20241014210841.5a4764de@gandalf.local.home>
 <20241015080149.GP16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015080149.GP16066@noisy.programming.kicks-ass.net>

On Tue, Oct 15, 2024 at 10:01:49AM +0200, Peter Zijlstra wrote:

> > Would this be something that the compiler could do?
> 
> Linker, this is link time. The linker would not only have to drop the
> (weak) symbol from the symbol table (which is all it really does), but
> it would now have to go and muck about with other sections.

Ah, one thing that might actually help is if instead of dropping the
weak symbol from the table, it would retain it but rename it -- add a
unique suffix or somesuch.

Then it becomes yet another unused symbol.
