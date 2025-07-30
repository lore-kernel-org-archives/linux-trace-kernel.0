Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475A25D535;
	Wed, 30 Jul 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879948; cv=none; b=KjGlQo6edTIuRynQ8KOlfAzvMYJEaQxMlqF3zlAU80JNN+838kiJo/Zoh48ub1K378i5Jf3xVRDECQBOiZYkTZySRV/CYC5q4Yu2+vbChZkce/dIU4jNFUiMb/SxVRrNXMyH8Rmk3Pm2AOBlC2kw5zNe69sSbcJBR+3rvDPXD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879948; c=relaxed/simple;
	bh=rfYs7tctZ558R926KABtIkF+iyQ1+6NU2VbGfThrg2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n99L3QSnJs62DX+HuX3Q2zpCOPqhFTzR8g30nAG+RJmPuTe9+r3EcNAlPTYCO8d0xJ57ocwq+fj6qGJs/rYQUXCwi1Arq03sEEO6KpB8RYmKjm6+WnLLHDCCcXQV3ms/rRIGnNN1xdQXigh7W27HSLbQvKP44LipPTe3IckMvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N72aMYBK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/x5JhkQM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N72aMYBK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/x5JhkQM"
Date: Wed, 30 Jul 2025 14:52:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753879945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x4kR7swDBpRGfrhkd2C5GZrj+dfbIV5+qItMJqO4So=;
	b=N72aMYBK9swpX0ChcBibBcum12TYFQk6PqRLFbPp7wlqsnHOg3iF8DrBcOUla3XALqllxV
	k23v2b4H/+zPX3nGIFbkDZ4SSrWQYvVHg61U/6z1D/Fn+C6Xxr8/SguEHNdbD6NfBXqHcU
	Bo4Gqs80V6T1O32+zw0F3/t5Fy5CQiJNJR0ZxsctAtZfu6wq/lp5H1KF4UgVuBYwKzFk9k
	pxevA3fzI0l8E5taJyF1KRwA69zrQHWUcq0wj8Bm7vJMOEz45mUnRXq+4z0zvzPmWF82pq
	p7DpNDPyNpTKpjqQNCZyKS40UX9EKKJkI9n2L6UflX2r78xFsVQlorklS+z+mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753879945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x4kR7swDBpRGfrhkd2C5GZrj+dfbIV5+qItMJqO4So=;
	b=/x5JhkQMRpSeFhd+9zF9+jbT3UcJOVU6TpSQSkCwVQIB+ay7NE7UFLaVr7g/BCJDeiAsO9
	EDkTZFVLsEwjzYBg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
Message-ID: <20250730125224.ScWqm03r@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-8-gmonaco@redhat.com>
 <20250728155332.sbkepHj7@linutronix.de>
 <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
 <20250729092510._Hq3RWF_@linutronix.de>
 <20250729093717.3AqIu_f0@linutronix.de>
 <5803d2623278c7516406534b035a641abfdecee6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5803d2623278c7516406534b035a641abfdecee6.camel@redhat.com>

On Tue, Jul 29, 2025 at 04:06:17PM +0200, Gabriele Monaco wrote:
> On Tue, 2025-07-29 at 11:37 +0200, Nam Cao wrote:
> > On Tue, Jul 29, 2025 at 11:25:12AM +0200, Nam Cao wrote:
> > > Kernel:
> > >   - base: ftrace/for-next
> 
> I assume you mean rv/for-next ? The one that includes all changes as of
> yesterday.

I meant I apply this series on top of ftrace/for-next. But that one is
close enough.

> Thanks for all the details, but I still can't reproduce nor understand
> what can be triggering the issue.
> 
> I tried enabling sts and setting panic as the reactor (to avoid missing
> it with all the rubbish that gets printed on the dmesg) and run
> testall. Still cannot see the error.

Welcome to the "but it works on my machine" camp. I was there 2 weeks ago,
it was not fun.

> What might help would be to see the trace with irq_enable and
> irq_disable around the error, something like (not tested):
> 
>   trace-cmd stream -e irq_enable -e irq_disable -e error_sts -e
> irq_handler_entry -- sh testall | grep -B 10 error

I do not have trace-cmd in the riscv image, but I do have perf. I will give
it a try.

> The problem here is not when the error occurs, but a couple of events
> earlier (where I possibly miss something that looks like an interrupt).

I just accidentally hit this error again, not on riscv but on x86, while
doing something unrelated. Let me figure out a minimal way to reproduce it.

Nam
