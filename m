Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E244199FA9;
	Tue, 22 Oct 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592954; cv=none; b=USTKD7xdGJYn73yD8MnbWxO2e4xs1zo4ap3fNzcnYbGmb4lT7nvHQfkhVzj0Ca+ymqjMjBCDfkf2DAaa5JOmS0iv9uOqan+Ghc/YMXrzIj4zol4cxjyO9cETT3LiicuVMEkB0XWS993UMHMro13P7g3QUScIOD1cIlCXVlFGoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592954; c=relaxed/simple;
	bh=AdqEWVCjvQ9cX5LIitiP/udTDEsBSHs7TRfODlwnqxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceuVmv6uQpcGWbUDrMu6vkkAe8UO2lhOBkTiJg0m3VOjBHWa+jodp84NGTOGeV31H3a1VgiSaSOR6vHCwFDwqJoAtKz5HnfmMYQRlm9Ry5laM9HS+Xw/cQ+ocGYnW9Z0Ck1AJ5CkhOiIYIPaThqzsR8NBjRdfTrL3lkSLc5YKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zs9blZI+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uSrCMAvb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zs9blZI+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSrCMAvb"
Date: Tue, 22 Oct 2024 12:29:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729592950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAdvRwujWMRHeBKzzgyAj7FeqHh/4jni2bkEpMcquyQ=;
	b=zs9blZI+TsCB7J5FS8pPdWCj3vGIB4dNscF74H1u07K2i8SIqn/ZeirC0hsrxnnpwRTuWe
	oZUGBW3B30eb6MLoJL3h3T9/oehsZK3ruAIyhBmfpAfn6sjso4ZqbjZ7tYve7FqB/9PHkN
	gG0HgSlrbRlaIh3s/0rCENVhTaB5px+IaouHfSSFQ75M9oUZY79uYi43A9iKwduri3iOFN
	zSZeZwGceqPKeXZ8JyvQJsj2QdhVMjd/cxg1bE264PBrL2+olHJqXe6ogosthj6FUnRK4S
	lBcXdbhbhAD5CUOKXNQMDtywWQO6uz/5XXx4+aOXU71eIC7NFbQMZeXxOEI8OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729592950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAdvRwujWMRHeBKzzgyAj7FeqHh/4jni2bkEpMcquyQ=;
	b=uSrCMAvbHgB3OuLjG8vZDxGdrUEf6PEIajH8RXM0Quui7p7YTVWhHKT5LYRuYSKddjwNKo
	C5F3Y+quNcIjyeDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 1/3] tracing: Replace TRACE_FLAG_IRQS_NOSUPPORT with
 its config option.
Message-ID: <20241022102906.KNgo1A2_@linutronix.de>
References: <20241021151257.102296-1-bigeasy@linutronix.de>
 <20241021151257.102296-2-bigeasy@linutronix.de>
 <20241022031418.12154e63@rorschach.local.home>
 <20241022095241.RFY4Iiu_@linutronix.de>
 <20241022061959.31775f7a@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022061959.31775f7a@rorschach.local.home>

On 2024-10-22 06:19:59 [-0400], Steven Rostedt wrote:
> On Tue, 22 Oct 2024 11:52:41 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > 
> > > Please just remove NOSUPPORT and do not touch NEED_RESCHED.  
> > 
> > Then I put the lazy bit where we have not NOSUPPORT.
> 
> I'm afraid user space will confuse this with the NOSUPPORT.

So? We don't ignore this for now and recycle that bit? If I got it
right, only PPC32 was using that NOSUPPORT bit.
What are the options given that it has to be an 8 bit field?

> -- Steve

Sebastian
