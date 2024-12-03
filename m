Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A502646;
	Tue,  3 Dec 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239072; cv=none; b=eAh8p/x3urVxX0SxvfRb/NBuydtxW+Sv5hbyCCEcew/9G5Q/sxUuAihndR8mVgvs7QW0Uky/PEuPdm+6VR6jR8l+8l2kqNB9ba1kZ5799C38j1ZHX3k8X6Jl1AFg+NXQwg/t997eK/0Ly1im7OQk4qRzoZdQq70qPqsfaBLDFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239072; c=relaxed/simple;
	bh=UngUAn5lnqytfDePhPf8C7jw42gbkWziclwCMR3F/eU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXHjpigto/QTT8w9IAK2K9uPPcH4wYkCcR6FBIoZHOmgVBU54/Nr2CXoIfbsv+qSv7PupLHJhXd+LDv1/mqeIAWIgry7e3GWXhxdMQsl6bfEAcySH8f+EyHBhSJccXpfp7k69NnaeFgCR21lQhc4WlyAUyw/UiuFM1ct3Y0uV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BEEC4CED8;
	Tue,  3 Dec 2024 15:17:50 +0000 (UTC)
Date: Tue, 3 Dec 2024 10:17:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mike Rapoport <rppt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Show timings of how long nop patching took
Message-ID: <20241203101750.62a85ca2@gandalf.local.home>
In-Reply-To: <37824159-8f7b-49ca-80d7-99c6d76e3f9a@csgroup.eu>
References: <20241017113105.1edfa943@gandalf.local.home>
	<6fb1e232-3bc3-4d5d-bff9-9f1a8c784782@csgroup.eu>
	<20241201150406.17f10247@rorschach.local.home>
	<Z01Vn8yZv-AlB-Z4@kernel.org>
	<20241202150516.3cf52584@gandalf.local.home>
	<37824159-8f7b-49ca-80d7-99c6d76e3f9a@csgroup.eu>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 08:21:49 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> > Which should turn the above to:
> > 
> >    25850 pages:14 groups: 3
> >    ftrace boot update time = [Unavailable]
> >    ftrace module total update time = 0 (ns)
> > 
> > Which should at least make it not confusing.  
> 
> Well. Maybe, but at the end what we need is the measured value, if it 
> only works on x86 it is just pointless, isn't it ?
> 
> trace_clock_local() calls sched_clock()
> 
> I don't know about other architectures, but on powerpc sched_clock() is:
> 
> 	notrace unsigned long long sched_clock(void)
> 	{
> 		return mulhdu(get_tb() - boot_tb, tb_to_ns_scale) << tb_to_ns_shift;
> 	}
> 
> boot_tb, tb_to_ns_scale and tb_to_ns_shift are not known before 
> time_init() is called.
> 
> But get_tb() returns a valid value already so it is possible to get the 
> ticks and do the calculation later with tb_to_ns()

We could add code to make that work for all archs via arch_xxx() functions.

But as the merge window is already closed, I'll just submit a
"[Unavailable]" patch to Linus as a "fix" and then for the next merge
window we can have code that will allow architectures to print real timings.

-- Steve
