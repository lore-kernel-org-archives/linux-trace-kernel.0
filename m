Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836E329E6B;
	Thu, 26 Feb 2026 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148603; cv=none; b=PBZkpBg4DqqvW841OTVEZduPDySiUwvGntqYCpW7zVVvkKCGjJUHUTc/KRsoMp5qIxkGIt3iDvEU4u1//PE7Xaqz+N3haWSb2D/bgdfdH8+FQOd9GMZ8DvBHtkDFufRHmvurY1xMroPjrnpO92dRIbXuwT3G1a+q5DRaba3CI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148603; c=relaxed/simple;
	bh=YW0Ly/yjMy7lS7G1Rf1wJwoyOF7BZ6PzzcCplnlXLS0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K0LMFpcitIH2Yshb85PGUQFM37SMY04igUXSZUnTrGihie9WmHgwnRudAUbglCwvUR5gS4tGdK/qiWZ6vhXCJ8PiUjXIgeq32325I7RNQnchW0NEOb+812Y3pOhXustR5Rg/TiuD1UcCvwvRlYOnOYt+AbYmsPjwIjFkSPdk8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8+Iugjb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8+Iugjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EBCC116C6;
	Thu, 26 Feb 2026 23:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772148602;
	bh=YW0Ly/yjMy7lS7G1Rf1wJwoyOF7BZ6PzzcCplnlXLS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d8+Iugjb49qxtDHizRbO56vmKD4x27WZ3wCUYPlCP2xbYRA+e9A4Z8f/mHpRw5Yyr
	 /OQPizIcyTw/BOE7TfJRBq/W2Wp83kU0jT5F9tzRwV5ge7c8S/aQYjIvXLiuO2RzNn
	 eTe6hcJ1dBCuxWquqngHhrYD+1q8YjKL2gkMdXakcY8HqBlNAFniwty6rD1bsjtgI4
	 HBvzc27vikWxalQLYQV2DCJg5AUdGEZXRgiB/0zj6gsrZ2KMpiT77gSoDBvByGdPgt
	 HhIR0XCCZsOPQZL1RYW3shbgrUL96B3QSNbvQ6eZewtBw6xuGJcMNQhwKJ1jHFw83l
	 Q/CsADFD8QRgg==
Date: Fri, 27 Feb 2026 08:29:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-Id: <20260227082958.8046dd1eb3e5f51f9fb77b28@kernel.org>
In-Reply-To: <20260226123655.4d2ca691@gandalf.local.home>
References: <177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com>
	<177191597760.435720.2484229987964512451.stgit@mhiramat.tok.corp.google.com>
	<20260226215833.4ad4f07f2cd06c9ccf5c1afa@kernel.org>
	<20260226123655.4d2ca691@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 12:36:55 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Feb 2026 21:58:33 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -2058,17 +2058,18 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> > >  		if (ret < 0) {
> > >  			pr_info("Ring buffer meta [%d] invalid buffer page\n",
> > >  				cpu_buffer->cpu);  
> > 
> > This pr_info() should be removed too, because multiple pages
> > can be discarded.
> 
> I wouldn't discard it, but instead add a "once" variable, where it shows it
> only once per CPU.

OK, let me update it. 

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
