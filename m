Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8C27AC4C;
	Fri, 17 Jul 2026 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311351; cv=none; b=SPvCCvcWaa3BPq2dwimNdgksr1xFg5AMjILyCqk96A7ElOlfSXtdzd6hK5d3/GWiTPxOclNmzV6LCqd/8cyn/RI+XnLiIDO2ju9KukeuqZ4cnjo1TY4Bk57+ytrgL4jzzGcBYz3wASen0M9t1N0xljOR0aJuKrBeH0LqHtDvqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311351; c=relaxed/simple;
	bh=aSKqQHa1hbjG9wagAdbwUWBIVUC9N1X3DDpkv/mobUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlYLk3C7sVOxX1mgz4kw4Nfi7dofwb0J1UymWqHcvGjSEx6PkLn6DG3uWfCuMwh5+HMa6+j62OqYTidn6hPR7Ff2BjIrrlHMO++M9bL2I5UEG8rtWic5ZO0ty0wg07Qs3KwhAFIoR5asVuYvIXqdikGABn92ttmY8oxou0Vk+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpsVp0/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpsVp0/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCA81F000E9;
	Fri, 17 Jul 2026 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311349;
	bh=GM8XgJPuC0Ev5/1OuEMW/A2d9miobDTO2o5BWv8n0IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DpsVp0/B7CvDOm/EczaR3ECpnGc3wPmRScJQJZ4ykPQvne2i4AhxNf/lUvc23c2zC
	 ekcwFAvgnzwNNs07L64QKu38SZJTYpgcjkwjo2UuKJ53vKPbUVxGOS/1u1w/vgULJE
	 73O43ZoP2jDdYt2NJCGwgf+h5uJX9KSadA3TtLTdT8BlQ1k45YiT+Vqe2TIFArG+KR
	 L2smxsrMbqeUyRGu4GG1BnKJg0EY3AvbysDKIMNH4pSl4KEC8qVZvDZItOUUmSNagH
	 0z0h/tTX0HR9uO0kjh5ArcyZBGRnX6hxGD1wI3SPOloJb32bTOsP5QSNl63TRUDStC
	 GIkNwPhM8k4EA==
Date: Fri, 17 Jul 2026 19:02:23 +0100
From: Will Deacon <will@kernel.org>
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Pu Hu <hupu@transsion.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Jiazi Li <jiazi.li@transsion.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"naveen@kernel.org" <naveen@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Message-ID: <alpuL10h7-OK2hFb@willie-the-truck>
References: <20260710063242.228714-1-hupu@transsion.com>
 <20260710063242.228714-3-hupu@transsion.com>
 <aljbf_RmOd9U2KDT@willie-the-truck>
 <0f049d38-b7f6-47f0-a410-95ad2aee7fd4@transsion.com>
 <alj2uxE1M8mcMBhA@willie-the-truck>
 <e0e800f5-a6f8-48ae-b55c-5c3d928bf234@transsion.com>
 <aloLb0j8sg0usmAF@willie-the-truck>
 <be182a18-4cea-445d-a319-1ed3a6c17598@transsion.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be182a18-4cea-445d-a319-1ed3a6c17598@transsion.com>

On Fri, Jul 17, 2026 at 11:31:31AM +0000, Hongyan Xia wrote:
> On 7/17/2026 7:01 PM, Will Deacon wrote:
> > Thanks. So perf is run synchronously from the debug exception entry path,
> 
> Yes, exactly.
> 
> > rather than because of a second exception taking place. Got it. But then
> > it sounds like we should really make the debug exception handling path (at
> > least, the part that runs for handling the kprobe step) noinstr to avoid
> > getting into this state to begin with. Is that practical?
> 
> Not sure about making the whole path noinstr (@Masami might have a 
> better opinion on this than me). Personally I don't mind either 
> disallowing it or making it correct.
> 
> But it might be a good idea not to diverge too much between ISAs. This 
> patch is pretty much mirroring what the x86 side handles this situation.

Ok, so how about this. I'll take these fixes for now, but let's try to
make these paths noinstr in the future? That's a much bigger job, but I
do worry that we're going to otherwise end up adding special logic every
time we run into an unexpected re-entrant case.

Will
