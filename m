Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB162139D7;
	Thu, 20 Feb 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073076; cv=none; b=ONhJUh8oxQRDOQSQ8mTx8RY8OkAjKO0a0e/6sLVhxVjqwY1pDFNrFWeh029E+cHvnkKjeb3Y0nX/rTBwBR8B0blKa4UuHal9gAdWoCL4DJRHyFlIepV6rbojtWHFHxxhzI+19+xDbQs3IHwMItNxiGSQ7NqqAga1H3tPAlaf0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073076; c=relaxed/simple;
	bh=MpLllEGAEHcOOYPUbbnTLlLfJ5xE1l1fr0Dnvk2wq5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cnuo31R7bekOmmoZ/Lc20WTCYw5E2J6NoD60Pr0recWxJYRH5i3W17lf+KgUxM7MFmzEs6BWQ0BbPDCq8O2vG74/8Ka/+uoy+pIk4ulkSInpx1qh0NTkhRVMEKTJexahjP6Kaiqe7L9RL/+Yi4TcHbAyxS80K5TqaJp6Lg5Z70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA741C4CEDD;
	Thu, 20 Feb 2025 17:37:54 +0000 (UTC)
Date: Thu, 20 Feb 2025 12:38:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not
 the instances
Message-ID: <20250220123821.495f1512@gandalf.local.home>
In-Reply-To: <3ae6c7de-fb0a-4c65-afca-c0c91289650b@linuxfoundation.org>
References: <20250115191758.35b62738@gandalf.local.home>
	<20250115202607.00c6d353@gandalf.local.home>
	<571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
	<20250123172530.474e873f@gandalf.local.home>
	<d39de60f-c87f-4c59-9226-9080f9008f3e@linuxfoundation.org>
	<3ae6c7de-fb0a-4c65-afca-c0c91289650b@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 09:18:09 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 1/23/25 16:54, Shuah Khan wrote:
> > On 1/23/25 15:25, Steven Rostedt wrote:  
> >> On Thu, 23 Jan 2025 14:56:55 -0700
> >> Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>  
> >>>>
> >>>> Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p  
> >>>
> >>> Do I need to do anything or is this taken care of?  
> >>
> >> I think you can take that series. If you want I can resend with you and the
> >> mailing list Cc'd.
> >>  
> > 
> > Yes please resend.
> >   
> 
> Steve, did you resend the series?
>

I may have forgotten to. Let me do that just in case.

-- Steve
