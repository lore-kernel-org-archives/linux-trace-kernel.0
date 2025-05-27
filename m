Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B9227B83;
	Tue, 27 May 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748338080; cv=none; b=NJRgPYRJXTIIoZAG5sFKorO6oXQaZKdWFL9Bz/l0edZfw+tea+2SHtMgpy+1Mxyyn53OeLU3jZ10aOGBDDMr+1W0mT6yk6iMSr7ELoPah+H13+3F7kZe2latVAUf70FTpRl4gQa571eORptJ9wAe67yMx0NTvUrYFHK2Cmnf5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748338080; c=relaxed/simple;
	bh=dyZxpvhwNjfJ9a7q3MDuTwQ7ipWcRs9o9x41dvRFHZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU+xVm/9FSaLXFV7/fiFAecHggaAg6/BqfQsH2BysKih9GrHGfqLSH3bkQ9zh94OMnwDuigw0DCh7gTzx7Doszjs/FGn3u7mR5cpcu6e8ajCldvnZBAvSy3ozAMe3AL5yNhccJU7arNpDdoQZEzKfL0tXeNQMh13IQyfve/pZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BFtaavXE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3G6PHfN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BFtaavXE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3G6PHfN"
Date: Tue, 27 May 2025 11:27:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748338077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKmfkKueWrSJHwdvFLhig05UKRQO/F1RPbe79/3ELEc=;
	b=BFtaavXELI8AcdVRQWgcGs0FPj4KRN5qAqiGoC7UL9tOFJs1ajcIAgA3mzwjAjixHeTecL
	CtnDItSK8zBQDu9eaMtFawa8z9aaUB+izKPyIi1YpxyIUglTegraojWBD59d46S+7Sk4Sa
	QnwyWPpuYPIauTYHHl64tuxxEi0l7C8feYNPVlupN6oRLJKoFptt3u3so6Hgda5tpRXTPN
	c0UxAirAblQUW80Ddn0i7UOShpEdL3T30xwespjS7kpMMZGTNaFMFGTjAjeDXiblGIuKLJ
	4N55yRT1+Bq18r00TOzLoNBY0Xy/eJwzUuUNCmoxnG253c4pHeRBgHPTLaOWug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748338077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKmfkKueWrSJHwdvFLhig05UKRQO/F1RPbe79/3ELEc=;
	b=a3G6PHfNJm077wOxIL5CZNo1u7m+lbi+pARY6Q4O434ukEYNse+sz1Hce88uVo/IXZRcif
	lCDNcjtpDc0XOdAA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v9 12/22] verification/rvgen: Restructure the classes to
 prepare for LTL inclusion
Message-ID: <20250527092734.BgoHvn6n@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
 <c1dd325f5f8f01dd7c29ff90be22164c17f073a0.1747649899.git.namcao@linutronix.de>
 <1927d98817cd97a70d177e0a3001603ee3e34b35.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1927d98817cd97a70d177e0a3001603ee3e34b35.camel@redhat.com>

On Tue, May 27, 2025 at 11:15:21AM +0200, Gabriele Monaco wrote:
> 
> 
> On Mon, 2025-05-19 at 12:27 +0200, Nam Cao wrote:
> > Both container generation and DA monitor generation is implemented in
> > the
> > class dot2k. That requires some ugly "if is_container ... else ...".
> > If
> > linear temporal logic support is added at the current state, the "if
> > else"
> > chain is longer and uglier.
> > 
> > Furthermore, container generation is irrevelant to .dot files. It is
> > therefore illogical to be implemented in class "dot2k".
> > 
> > Clean it up, restructure the dot2k class into the following class
> > hierarchy:
> > 
> >          (RVGenerator)
> >               /\
> >              /  \
> >             /    \
> >            /      \
> >           /        \
> >     (Container)  (Monitor)
> >                     /\
> >                    /  \
> >                   /    \
> >                  /      \
> >               (dot2k)  [ltl2k] <- intended
> > 
> > This allows a simple and clean integration of LTL.
> > 
> > Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---
> 
> Steve,
> 
> since this series is quite /meaty/ and it seems the later parts require
> a bit more discussion about tracepoints, could we start merging until
> here (1-12/22)?
> I'd be tempted merging also 13 (actual LTL introduction) but perhaps
> keeping it together with the LTL monitors is cleaner.

The x86 patches have been merged through tip tree. My plan is sending the
next version without the merged x86 patches, and without the arm64 patch -
it can be sent separately. Then the whole series can be applied.

I will do it after the merge window.

Best regards,
Nam
