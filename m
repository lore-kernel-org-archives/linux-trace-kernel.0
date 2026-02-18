Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3522116E0;
	Wed, 18 Feb 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428789; cv=none; b=aKBsxAsT2QlJO8oG/VbAa1uApF+rPNxV5KE6cPyjVfI4S6Sw1l+7kgsI6oAUjDAJEzdo+fhY0u/zc3kzzUqo+z5TyS/Zu2LeyhLhaIENRY+j5/IqA6Qw05TlCVms41CYszD2FNwCxOK8WoyxUpuNj6Bq2DI+Km4wecgUkiylcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428789; c=relaxed/simple;
	bh=M7xKMl0LhvVG1nadriIHcjEBeJzbZ6ZWMTqr4CSeaLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glET8vD9iNpyU9R3kGO3Fk4PndGQAQey+61/xOpRn1CVBi/+i4RRcv3mYQmHSSj20WUps63KzQJgREjc3foeutGscITgago/Xletea8qwIrrFnlQPXT5aTABbd5NqiiG/ysxWQ6s/R3AhCugNvo+aRg41rMjf9Q3kv9n8p0KRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iSUxjPwE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iSUxjPwE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=trAx6nnQ45IUid9unJVJ8G0EUg+oFCF06T1BqiyBkjI=; b=iSUxjPwEP2bSY1KV2Xyyn9trNE
	tSqzfqK27NqbvY4c1aaaxbwNHTSXzLp/IVmYr0/pZDcLGKfM0F/l3gHuYYvLd3t6CEjg9iP8+Z4O3
	iSTxOQ2nSrEDsjv17PNg2S1ZdEfHJAoGClNylN45Dvd/L7w+8/Yz/z2nESBvzMyMb3vc+V6jMP88w
	Ype8AC2Sg9G2zseqBN6rZZ6eqx3YGiIsW8ePMKm1pDJdHESD79YKIRgDpufDsOIzw/+xAh1bomKat
	7YwyZCtluq54Gcws2LiHTlS42QpabWoR3gp/751EfdrLFKJpWL1wuVGyv4bzg6iGXJ269+On9i/r+
	2D+UOhyw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsjXh-00000006DHw-2WFH;
	Wed, 18 Feb 2026 15:32:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4E656300B40; Wed, 18 Feb 2026 16:32:44 +0100 (CET)
Date: Wed, 18 Feb 2026 16:32:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Elly I. Esparza" <ellyesparza8@gmail.com>,
	linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 1/2] x86: Prevent syscall hooking
Message-ID: <20260218153244.GG1282955@noisy.programming.kicks-ass.net>
References: <20260218144735.24307-1-ellyesparza8@gmail.com>
 <0c5396b5-f084-4ade-adc9-029037031eea@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5396b5-f084-4ade-adc9-029037031eea@intel.com>

On Wed, Feb 18, 2026 at 07:18:25AM -0800, Dave Hansen wrote:
> ... adding kprobes folks and Kees to cc
> 
> On 2/18/26 06:47, Elly I. Esparza wrote:
> > Kprobes can be used by rootkits to find the address of x64_sys_call(),
> > x32_sys_call() and ia32_sys_call(). This in turn allows for the rootkits
> > to find an specific syscall handler and hook it.
> > 
> > Add x64_sys_call(), x32_sys_call() and ia32_sys_call() to the kprobes
> > blacklist.
> I'm an occasional, but not super regular kprobes user. Is this going to
> hurt folks who are legitimately probing the syscall dispatch functions?
> 
> I'm a bit worried that the rootkits will just move on to something else
> and this will become a never ending game of whack-a-mole where half the
> kernel needs NOKPROBE_SYMBOL(). ;)

So I really think this should be noinstr; pretty much all the code here
is noinstr already, so why not include the syscall dispatch.

Better still, noinstr ensures the spectre-v1 mitigation actually works.
