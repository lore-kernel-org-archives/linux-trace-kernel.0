Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33903750B9;
	Thu, 12 Mar 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326314; cv=none; b=EKcjuzN4D7BsLOMEJvQsNTnsoyXl0ogqB92HeKjvRaI1yRih4nl0oLAMl0X2GjO7aaxl+Nl48uFddGB1GeVgCDUPXZizNToEaDhihRYohZO2KTqr1Pgwk4Id3JV7ei7LyAnBkQnRLcu+TBlfEOw0uqALq4DYGbi9FHminmhXoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326314; c=relaxed/simple;
	bh=vUpB5nldNO77Dstdoq9dDaN3GUglFuy78D0FmwbjUN0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oLW5+MRpziyZcxBY5POWgUpe7xH5YOpK9GO9XLKfgHnCmh2dwyzHQuQKy4mHVxQ9XpYiRtLnwLynoVjV0moLdge8GRDayXAZBBKiFNLIZWKvhjzi+SlOcxQJHmUqNMJLN6EWyR6TmJoLaXUw+ghRieZREGhI6c+YCj0y5Wi4sWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=V8gv1zGz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfWeUxNr; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="V8gv1zGz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfWeUxNr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D97727A01A4;
	Thu, 12 Mar 2026 10:38:31 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 10:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773326311;
	 x=1773412711; bh=gHuDgU1eIXyv3StiPZXkirCvdh4bXAfqnu6WgY0UdrU=; b=
	V8gv1zGzQxlb9fX8sruz4727lmnKQMsBc8VpBnecVlJTCN/a61i3+wOJ/OnsFIeZ
	Y4NTlP8Xel5LfM7CJTKA4SNxMlFS4w6u2t6NhWpgnqkTE2EskZOE4ZSOVsxjN61N
	YacM6TwyD7kscrYTrkunL7g9f10eQ81Vmwn14Yn+m5yixHFS4wNlsiTcZyMKphGX
	h7Vlocjtb/SZpiyCFQjX1IEakfR3IY1D75Xqj429/CqY4ANKgAVppYdM21NGP1HH
	VHfTW3yUalcIfAviNU8hsiYrgYc1yjviIaC3t854q7Pz1/xK7d1J1lveigE5nQMs
	cXfyg4iRPRD0gRkmR6DscQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773326311; x=
	1773412711; bh=gHuDgU1eIXyv3StiPZXkirCvdh4bXAfqnu6WgY0UdrU=; b=m
	fWeUxNrg14LyLmlK8EbVoKF7JtEZXG3CF9FMpJeUir2e71sGWmcoztAwXC4hm/eZ
	V+YqNFu1Q0s58viOvSUNeFW7j88ejB7PKJvsLzRn3VQm3PDS8ncbKYLjkTJFlCRD
	Of9n/vuJOtp7JbORRIsj3aWLm0V2LxGQvrqKOsRRJIzOTAfTtq3JWqjd04Qjzohi
	GsAv5ZHT3bbXBQ9PHH6PrRTHEPsPGaPndpyVIy0wEjeN44UFqkXhis5RiW5M9LXf
	N131QJygvIfe/MgYxMBF/UnUzACeIkWdJHGay6RtFebrdffiEHve1obiEK00nHET
	izdFYWm8Y8dutPrSFct7g==
X-ME-Sender: <xms:58-yaZ4CbgOAY6jt1Nz8bIbOEsb8n-VeZPqvp8aqjRCbAdZZTOSIew>
    <xme:58-yaRvlZ5WIK_mneT0UKpm5GsAwEmsvT28K2r07FXe4c4BjdtUvh4KCmXgoc9ZlF
    90dbpFGfz0lkg40l6E13CI1oVGcZ2ITOa4ihm_YLd55qncxyls6_LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrthgrlhhinh
    drmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguvghs
    nhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehrohhsthgvughtse
    hgohhoughmihhsrdhorhhgpdhrtghpthhtohepvhguohhnnhgvfhhorhhtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgriieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehouhhpthhonheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:58-yaTfDXKCaXERsTKxDHxsIrlSmfGaZQIQpZ62bhomEkgUZ4yd7kA>
    <xmx:58-yaVFbez4TxsC3KnNonXbbPcvdbhFlnMe71tAS6agu9erGv1o3UQ>
    <xmx:58-yaZjCB6vh_7cuN9wnmGjd4R8NA-owkWu2EYZDosIuRgLPqoBEIw>
    <xmx:58-yaZ3Vc7ztwPB83unAH_0LlYLXr4YBuCmqqOw4PdbnAcNfflSlcQ>
    <xmx:58-yaco540U2IqBn6x5vZK3QCB5TNFQxo-ByM45Mm6Ck0xWmnfRzVncL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18B2B700065; Thu, 12 Mar 2026 10:38:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ajxbhlt1HaRc
Date: Thu, 12 Mar 2026 15:37:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vincent Donnefort" <vdonnefort@google.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Marc Zyngier" <maz@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Oliver Upton" <oupton@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Message-Id: <d4fa3ee4-22ed-4ba3-afa3-4fe7a22b226c@app.fastmail.com>
In-Reply-To: <abLCSk4ZZv1h6xFq@google.com>
References: <20260312123601.625063-1-arnd@kernel.org>
 <20260312123601.625063-2-arnd@kernel.org> <abLCSk4ZZv1h6xFq@google.com>
Subject: Re: [PATCH 2/3] tracing: add more symbols to whitelist
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 12, 2026, at 14:40, Vincent Donnefort wrote:
> On Thu, Mar 12, 2026 at 01:35:43PM +0100, Arnd Bergmann wrote:
>> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile

>> +UNDEFINED_ALLOWLIST += ftrace_likely_update __hwasan_load __hwasan_store __hwasan_tag_memory
>> +UNDEFINED_ALLOWLIST += warn_bogus_irq_restore warn_slowpath_fmt __stack_chk_guard
 
>
> Thanks for the patch.
>
> Most of those ones are covered here
> https://lore.kernel.org/all/20260312113535.2213350-1-vdonnefort@google.com/.
>
> This should fix allmodconfig.

The ones I see in that patch look entirely different from the ones
I found.

> For the ones not covered, I'm working on a follow-up patch using a different
> approach which should fix them. I'll be able to share it today or tomorrow. Not
> sure if we want to take this temporarily?

I can wait, my randconfig setup has my patch applied locally for now,
but I've only fixed the ones I saw on three architectures with gcc-16.0.1,
while Nathan's list seems to be mostly for clang specific symbols.

A lot of them also don't show up in allmodconfig builds, only after a
larger number of randconfig configurations.

      Arnd
