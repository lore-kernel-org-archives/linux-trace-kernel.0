Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372E361945
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890642; cv=none; b=clmxG9BAdtILdc9nmmakiYXO+F49YV9eSrjfV4nokAZovJK2GTiSYu9rcDil929HsNXTAclj9/37WkjdkSapYwv3qcCOTvOMiGbEx9u5XW2nGnh/HJlGPvNRdo5Zsf0go9hCfTP+IXpOnyNRmuNX64qzkUTyt1nrDlYsIN87QyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890642; c=relaxed/simple;
	bh=XskUUS3t1YGfQbeYAVWsWXcHQo8zgnpmckTLiFplbpM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AFah1S0X2uEZPIk1Ijb+uFLqQYrSNm6Wbkp61Bq9EHhUnihmCpkUSs7AzGhyuQb3YECuLYiFhrvsK7bsaYN3jhy58bQQH05wowUcGwD8XoPZsqErJwM1HRZu3IHycDsO6tdSZrxwU2eLH69F1TVbOJOJxSwmOySSFD8j5RIm7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=JkZj6/Ys; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MsLrtuAL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="JkZj6/Ys";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MsLrtuAL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6756B1400173
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 17:37:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 17:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790890638;
	 x=1790977038; bh=nj1jVmefdUSzapJyW7ajTxvn5kGuH8IBpwN1LN2wSEg=; b=
	JkZj6/YscBr5LPanRsANXIT2mpoAAW3d4T1+2lDdFvq/hIy8U+MqyTDPiuQ0Ufrs
	FTNelgUBLj1C5vIlwjA3pWsaTh1CdLVs6OHH0eZtmUH/EuuHMLg381i5UniWYQsO
	tlD9JF9KP5ui7bdf0zRjcqcm6oMIKec/RxK54Uo3y1GiOo0ow90ctscc9BfRQADA
	6xtcUfnTuR8ElwXPjW0iPIUAvG7LFmHoO2AjSr3Aje32DYBOn6D/vpdpdgCcrMg2
	c5jBWvriM7dSxLI/wWzQ6P2+BazDIbdPibVSC4KL5QGpdZb9ua9PeJqyilF/3joe
	ITDVqQQSLfiA9M3ALSEnHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790890638; x=
	1790977038; bh=nj1jVmefdUSzapJyW7ajTxvn5kGuH8IBpwN1LN2wSEg=; b=M
	sLrtuALqdYJA7v1Sdi2kJ82nthvBoOgMQlP7BISf1X69K0fHrF+7rr+4OIwOXULq
	TInakTiqOsLEff7XQ7TfEOxrquUoX5ESl2AjK4b1pheqH1ZL1tQwgq6VMf87hbHn
	Hnxy/Lb5uIAkroVKHSkhEMgfBB1kmdI4PVoy73jfEQ6pOwuI1mJiPCjOG6tQ2Rh1
	GZfFZHNziG8KdDObhTeb+8EMgmXwNoSRNyG/kQ9/Um3pxfG0JuXhog1GL76yKygV
	n6itswspf2KSDakErGv1Hmwlj+bCzHh/u9FTZEjWQBuOp0cx8+PlLhDHaoZYkBBi
	jYD9ezjeROYZJCuyS9aeA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790890638; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Y7I2r4EqROgBkBcymiH/8fwVV672i0EqPIogFKoHdXZvt4q
	FO2O9bDGAsh4Tj1QclpAwYnupjWANy/1B0qe4CZmaLt6bd7e/pzaG4dJtersDbn3
	m+wugXbORovqIN0iBR5WUplkTQafFpKEiM+by7UZIXPh2Ro0AwTaOpBaq4fgJ/cX
	6dfvH9ccfHwzWS7X7t4qVdCGe8+AZjWSks1JDFsL+ppfjBLu0WJpq29go3HRdIUR
	s4sM0NChLI/QO9yF7+K5AGsuF/v3zqKLNF2MLqzCgh/PndkvP1Zz6tcaBX6DBkkV
	kmx5rSZ5Ye0WzpWlvSH2sv97eOXdyZr4wGDc7TA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DKUPyUYKiS9nqYMPmOUUl5y30ZN8E7KFHgZYrzXiK00=:XskUUS3t1YGfQbeYAVWsWXcHQo8zgnpmckTLiFplbpM=;
X-ME-Sender: <xms:jtK-ahD7xFXmG4MbYU0pNiUklDTZzMukMYVnvfTNnmHdQ7WWGzIT6Q>
    <xme:jtK-at4voiQvFtDklaBkSvXJl0ntni06-SUnbU6iNP8SleOVP69IE9MmWJH639idy
    CHYxVh2QEa7kxhBc1R7uRUBE1r4iAsrqM1vyRqJGJuQLN7ic6XhNVM>
X-ME-Received: <xmr:jtK-aomOI3DW6SBXl7bFuNtBoeAHpqsXhqHLRlWERJevLl_t0RDttg1MXt8ScK3-J5oayjvZvBDiFrRCyF4-_bIO>
X-ME-Proxy-Cause: dmFkZTGA/28tFsG2eG+vuhLM16qjGd2rDFqBq+c1CObnxw0wpOTXVdwSGc+lRcqH8KiQrF
    Cn40jBq7dEgZcnYN3bvpwXMpBqwTLDSjflemcjMVmn1P5r1PvxxFzEUeBU+PzGdjgptNE+
    5m/KDgW+XOr8t0brUTMTuKrJLqVnkHZsYembJIvzsYxIGlvBd5ZZFLFWGhOLN/1Yw2GGWJ
    v1L6EmlcL6OASwLcEFhIW/95kedFK52vjx2G0drLOayVlZr24xfO+1MPNmF3+uPeM82ue9
    JU8smIGQnl1nPPnTQUb9DGs/A0ovmNswC0oUM9Mc9KxBAK46YTn51XTw6KB9cm601qxqQa
    Ggv3HYAXPRdsIVh55yf9Ik6IAEK8L8yNRgz7zSi0xbrz6AcPF6Dr5JE7B+Bq9b8JJNosIq
    xNfWg3xQHb+MOPj05sRg8a/s0R8ivVsw/ZUK3duXW1TXb1w1UOMoGqAOWI0bD9LaU+SucU
    PkOS7p5bnRH6C3uv00gS2dtzEdyWUF/Qp5sBKo3qMrAJr0Sk3jNsJ7hqo3/9/yFAa5wWZu
    cY/rkQigDZR3cioNzqfZUKkG+NM6v3UMNq9lfTqJXIsvPTwgBzx1p4rTgl61AWjb9x0jv7
    pSYkIm4tQF8Sqv+KJEzdOkY0H8p4ToWVsnli1pzaLVo+wl4oIBR+3gq8QTHw
X-ME-Proxy: <xmx:jtK-au5c2qU1HFM0QPCmE8hlHCYXnXwdnORL2-m9aL3mkle5DyBqoA>
    <xmx:jtK-auWGqeZquKB4nwLixekWCwrpAUN_Qq-7tmchVrBKrBNfxcP2-Q>
    <xmx:jtK-aq_hikB_XB5MqAXvSAEja9OLgo_jKBk37gxO2-NCSxyCnIIqJg>
    <xmx:jtK-ajhf848vsf7jY6c0I4pDeRKWl4BPvLfw-Q0ZwUw_qQRpJ_RZMg>
    <xmx:jtK-aly7ryLI5q4Yf7NEDoKGF15JnfnIgcwSIfZfK730SVC0ppTJYbcp>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 17:37:14 -0400 (EDT)
Date: Fri, 02 Oct 2026 06:37:11 +0900 (JST)
Message-Id: <20261002.063711.2115045889604804375.tomo@flapping.org>
To: miguel.ojeda.sandonis@gmail.com
Cc: tomo@flapping.org, aliceryhl@google.com, ojeda@kernel.org,
 rostedt@goodmis.org, gary@garyguo.net, a.hindborg@kernel.org,
 acourbot@nvidia.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, daniel.almeida@collabora.com, lossin@kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, tamird@kernel.org,
 tmgross@umich.edu, work@onurozkan.dev, linux-trace-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH v2] rust: add mark_used macro
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <CANiq72kZyRQR-cxYKGKLHu7CkyOGAy6KrV2PegFSnM7eHizbhA@mail.gmail.com>
References: <ar4-kOdIs7z6zG6k@google.com>
	<20261001.210403.2208685315788982617.tomo@flapping.org>
	<CANiq72kZyRQR-cxYKGKLHu7CkyOGAy6KrV2PegFSnM7eHizbhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 15:02:40 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Thu, Oct 1, 2026 at 2:04 PM FUJITA Tomonori <tomo@flapping.org> wrote:
>>
>> Miguel, what do you think?
> 
> I suggested it due to seeing the multi-line combination of `if false`
> and `_ = ...`, and the fact that we will probably want to reuse the
> combination in other macros. It makes the concept more explicit,
> easier to grep, and follows other cases we have created for similar
> things like this (e.g. `static_assert!`).
> 
> Having said that, I do prefer using plain language instead of macros
> where possible/reasonable, i.e. I don't like introducing macros and
> more concepts in general just for the sake of it. On the other hand,
> sometimes language features aren't the best spellings to be honest
> (like the `const _` "abuse") and some people prefer abbreviations
> (like the discussion on `SZ_*` constants).
> 
> Either way is fine, obviously.

Thanks, I'll drop it.
