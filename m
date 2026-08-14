Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125C3B14DB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671704; cv=none; b=dJJSRK0NAsc1fDi0mBSrCa2NXNcNLH+UKnHUprd1QtruGtamwIgq9o8RtmoP9RSgMtyLTAL9dtWVMrSbMXmXyPTrUyEsGWZ/eNsI3JWPKlAC/dqDwWbRUsUky6WozQl8hmA6rARHU8Pipp5LTgvzLKIowMkJdglE4818e+JDCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671704; c=relaxed/simple;
	bh=M/9ayKx80TaFqutomOKpzrW7mWIj13d5OTjwco0Hv6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2wzZ/vQiHfji3La2nnoGY78IR/P8/6pDvdnx43gRh+3yk7stUF6cyvcwsY9dn+ECvS3kcr222np9U5ls+NROXObw+/774y/z3XJHig2vQmBZd7fgmuox9BAdaKlgBZiGB9wCu84V8S52PTj1msorOKoQSg1GyRK9B0vGdqH4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=eh9i47yO; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="eh9i47yO"
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 6CDFEC02E2;
	Fri, 14 Aug 2026 01:41:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id C1FDC20012;
	Fri, 14 Aug 2026 01:41:39 +0000 (UTC)
Date: Thu, 13 Aug 2026 21:41:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Vincent Donnefort"
 <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] ring-buffer: Make nr_pages unsigned int
Message-ID: <20260813214156.64d0b21a@gandalf.local.home>
In-Reply-To: <20260813135526.EF9CF1F000E9@smtp.kernel.org>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-11-vdonnefort@google.com>
	<20260813135526.EF9CF1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C1FDC20012
X-Stat-Signature: q7bnxxfbceryxj1yc84g97bqhwwkrqw9
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//iqr9QAyMR42e2ahwwQjlbQZQRHp+00M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=qe1ho3kO21h2TZsjPjyUZ4pXkloXv4KRNTZjTKlUGuo=; b=eh9i47yOT6S1vN9yKboDPve6xpU2ucXzNiNLAC4rUjhjoCD16nnT9wxdo7dxRH9l06iAZoBqCczS6kwA6T/MbvQxBnUQdfmvVpZH3SmAXJ1rkA0eftPeY61Hy9KuYlz7UhXjLc683g4qq8SBdR42XPBzR1mvYJo0mNTG/Q2OLUk=
X-HE-Tag: 1786671699-142958
X-HE-Meta: U2FsdGVkX19jPUTpFqC56zsdCRX0jGJryHda47cVDDyc5LiVt2MfjpaGGo7VN28M0WuGA5hffprMzLhokzj1JstOaN3a0dbTVqEH0wiNgCZLHh+t5JW6GzyHC4Wnkh0mTIaH2KIayes5pFOroyv/XTUdGbon43p22l/GDqCLRb7Wu5G6akhzqeEhqaM4SlSra+1ZaI/uV3XLeIwY2tyb1kuQZ0glZM3drifnIYAV9GX0u6whPSVXxykuVHpolv+ZUXr/S+NcFN+yCTIaEkfnhX22KoddkIQpZIpwYPPk8KndQ4FBNSOP1L2dw8U/I4BkpayEVIeEcaDcyX/dLNweaSEiyWhTmU3f

On Thu, 13 Aug 2026 13:55:26 +0000
sashiko-bot@kernel.org wrote:

> > @@ -3264,7 +3263,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
> >  			int cpu_id)
> >  {
> >  	struct ring_buffer_per_cpu *cpu_buffer;
> > -	unsigned long nr_pages;
> > +	unsigned int nr_pages;  
> 
> [Severity: Critical]
> If a huge value is written to buffer_size_kb, could the unsigned
> difference between nr_pages and cpu_buffer->nr_pages overflow when
> assigned to the now 32-bit signed cpu_buffer->nr_pages_to_update?

I agree. I never wanted to limit the size of the ring buffer. If anything,
I would want to make all references to nr_pages to be long. Otherwise we
are capping the size of the ring buffer to 8 terabytes per CPU. Yeah, that
may sound huge, but believe me, in the not so distant future, it may be
desirable.

I'm fine with keeping persistent memory and even special case mappings
limited to MAX_INT pages. But not the ring buffer as a whole.

-- Steve
