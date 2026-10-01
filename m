Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59E4973A3
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856253; cv=none; b=Id/gm6EJEgIgv7hMa0PCqFA8uCEyLJTpTiPVOEBTAx0XDbD6UNJVHd56V9jQrOOrc+ucHYiiMGJGfdI++bPr7oI/H/ajZuvxgv+2NP+Xxh34vQpUlzWHLFs7YcYClwcH506m16jxs16BInLx7mYYavI6Ie+3iPLYF9eW1zeZc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856253; c=relaxed/simple;
	bh=4I7/KZ3g/9mCKgy+n10MfTFeq13T275rS8jDFBktRuc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A+7L70njArY+MdKlSRnWpE6jNPglyw86lIyUb4wZufWHqvRnpcs5b/TRIkP3bM70AC16WhlhlbAs7W20ovpqb3u4lj5uFDzKUmnU2JLmYj60cj9jYSjdmEiP9dKJ+DzISqR6JZRxcCLV8FSNM+F7tRe/7giVOOcZ5Dtp/0KzJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=Qnjik6Eo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JI9Z674g; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="Qnjik6Eo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JI9Z674g"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E2809EC01C0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 08:04:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 01 Oct 2026 08:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790856250;
	 x=1790942650; bh=6UWLu5si3yGCJqlqj+eqqNhnqstObYV5Wm+YPXYZ1cs=; b=
	Qnjik6EoUII6Hr0xhA3cAN268sAX+Ml9HVHOEyzmS0f/XShsNsiT8kLMICqVjQae
	1tY58Kn6U8JEnhSujpktJCNM18XnrJ4sPp3wnwFsURwIPjVSiQcTKHnT924vH3CP
	mNG1aYOApCRAOl6kOEDCWf8dPTKEbErYFj7VMKrL1UNFVV2ShKjOME0375sePSQi
	C2WujMFmoC239CzE5tX7bYAW4Q4mdtWX17lCMJhCkQ3beqlbB4tP8TPn3F9u0iDS
	h7b0yeHSRz4GCeXSsG9kfJk/3IlWuf04GhHws5rKkmiktF5jPHCiApux2OHdiH0z
	gj5lH1AGn5GgNJeSn4Kprw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790856250; x=
	1790942650; bh=6UWLu5si3yGCJqlqj+eqqNhnqstObYV5Wm+YPXYZ1cs=; b=J
	I9Z674gptfoAYuBcfj9WVX3xaBTiwnboOjBu/nkyELzOK6+CnrHwBgkoZGmTvlDr
	BhatZ/gZeaSBKC9L8X+t5n7sNWIMfwIFEzo8RJbnCjOLzCXGkfe/Ff78W2mWckzr
	YwFFlw072feIVBGYVqq0avr5I7ydX80ZOhj+OOIOsJFx6PfMI42ONiSc11pweAiA
	7A3eWza3XwYQ52Uw2XM+WjXZMM9NmWRM2ZnmCwLmXHXIP2YUy6+H83r+XRQAtGho
	V2C0h2gRN41Ve2TtB5+93wwu1rbbx5T793fXJce/h9MrfKI4IeweKZno9wBlHBwS
	aUvNSrYUongfmLbrXz0yQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790856250; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:AfedxEb50T0plYfuU5nOd8ivyEyGBPBqaeoO/CwscDNDeWd
	iOWVb/ugry4bhwYgCOSPxpppmD93cL8E+RQaE+RBbyu55oj8jUNpVSxyvTpMLE8J
	yctQrgthED6oeOKmXx3piDi+pYvrxQIz5Dq8od/r3fgalolAC0v1PcBQcm5nHEOv
	GjPIpV0PXamxuLeNLvDOqNzhd+HD0uq8GnwbfmDksl+SdAtIEVDg5X2eeFWMxwsu
	vlLLA9htnjuoqfqihMzhPSdjAI3G6qjNwn2z/gdA3C53frqXOZ40Wr0RqxIA3tRe
	b5NQA2LgXLeKSyaTPhFBGHqhiuDaw20Q61+XufA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wpzNw29RJpsfe2lSopqWVk5Vmu7PXu6aZtdLPwNM8vI=:4I7/KZ3g/9mCKgy+n10MfTFeq13T275rS8jDFBktRuc=;
X-ME-Sender: <xms:Oky-ag4h-7eKnyojHIZoZK-_gMmkf97dOCrEAJy0rgoN5R_kpVg9Fw>
    <xme:Oky-ahLfPbfyqxxzRKKVzQXb3LCeLiLlu-SRYBnS3v3DBfBliEOFvOcFswL6cBTMZ
    LN7P05TQbk9_Q-C4Jz2hakmLG5ryHpOW29bi2aw8KiUkme5mq0qBAtB>
X-ME-Received: <xmr:Oky-aiQbufZN5E08EOgQJE1rVrlNGu_iB_jd9Ne1uSicXg08L-NjykOmZnH4Pni7X5XjE-Jk2f3IPD-UKsFkc2R9>
X-ME-Proxy-Cause: dmFkZTGme5cLZ8yVN7bc1wzaeeTfQ92zY1t23sQSj/XRKWj6MfPH/SAWv/s/cAGdVm8ttt
    YXCjcb8nkXZDt1V5Tycavxzx1Kr2NMGK9ar+z58E9m7n2sElEcG3C/0HcIyg9jCDF7cROX
    b2Lsi/pllCSMahdyTgTtIxr/yACN4HCXY3yC7jaIXD7uD6nqT6BUlZPPWODp134uT6YjAp
    kE9iA/wX9JOkNQ+54P25Q+fbDZvyNcvFwvdxJquAahN1fwQuh9qnJtlGBmMQIafkBguJMb
    JIVkkyqZqeArelbiK5+6WszNapp9qGTVx6U4iNYiymfCXSMIXP/CFPo65aKoCsHTSLejC3
    7KLF0WYwhuZbXUccGnhMREKpxmGWZZpOugDShZovMxlpHiOmm5+NwJSq9LjFaJqX/SF1fD
    1Q0IjRpAytiUr2mAgTzsgeEVE0bH/x6Kt9v97yia8CGsTvuE48RIeIRAdJr32C6OU3y0sC
    kDn89tJV7/ixIWPDgfq9cgL2HRQQk68Af8gy9GsJVrXJwzPbFBW5tFysGydFc8BhoRzVr0
    rwt12uTt0v3PnFm5Qk8bgurT0pDNgevhbTAThEMxxVCmC8yqrrt/9+01iKR/YL/qk5eK5w
    fXqOeQc235bOliwYrWLbszQiIPIr74Twz/A6DNYzHPgadjO2xOYsZfTi3K7A
X-ME-Proxy: <xmx:Oky-asq9NBVdWIk0QkpDXrFGU2lzpVQyAbSFM6ey4dZEn4biYAmeUg>
    <xmx:Oky-aoaTfL-VCOMkzNVsbLvQ7Syc5RuOxIj7Z1xq8jS6qn45QH6wlg>
    <xmx:Oky-avSCIIQhFy93rjm0qFxIcfGAa-FRy-3ZV9EU_ud-9htGL9PDWg>
    <xmx:Oky-aufggtFkCbAI-aYX87JOwH1HO9Wq1WQ_yaBVniCjpgRWkt8j-Q>
    <xmx:Oky-asAPI8RdBX8qfLUP3QJHWwqb1PbSvsr8tW4PPY2QitCqXcHCreOy>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 08:04:06 -0400 (EDT)
Date: Thu, 01 Oct 2026 21:04:03 +0900 (JST)
Message-Id: <20261001.210403.2208685315788982617.tomo@flapping.org>
To: aliceryhl@google.com, ojeda@kernel.org
Cc: tomo@flapping.org, rostedt@goodmis.org, gary@garyguo.net,
 a.hindborg@kernel.org, acourbot@nvidia.com, bjorn3_gh@protonmail.com,
 boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com,
 lossin@kernel.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 fujita.tomonori@gmail.com
Subject: Re: [PATCH v2] rust: add mark_used macro
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <ar4-kOdIs7z6zG6k@google.com>
References: <20260909120210.2488674-1-tomo@flapping.org>
	<20260930.185028.532667902450882259.tomo@flapping.org>
	<ar4-kOdIs7z6zG6k@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 11:05:52 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Sep 30, 2026 at 06:50:28PM +0900, FUJITA Tomonori wrote:
>> > diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
>> > index c6e80aa99e8e..29d2d2d0aca8 100644
>> > --- a/rust/kernel/tracepoint.rs
>> > +++ b/rust/kernel/tracepoint.rs
>> > @@ -38,9 +38,7 @@ macro_rules! declare_trace {
>> >  
>> >              #[cfg(not(CONFIG_TRACEPOINTS))]
>> >              {
>> > -                // If tracepoints are disabled, insert a trivial use of each argument
>> > -                // to avoid unused argument warnings.
>> > -                $( let _unused = $argname; )*
>> > +                $crate::mark_used!($($argname),*);
>> >              }
>> >          }
>> >      )*}
>> > 
>> 
>> Gentle ping. Could you take a look at the tracepoint.rs part? If it
>> looks fine, I think it is easiest to take the patch through the Rust
>> tree.
> 
> Why are we adding this macro?
> 
> I think it's better to prefer avoiding macros if we can. The current
> code is familiar to people who know Rust idioms, and now you are
> replacing it with a kernel-specific macro that such people will not be
> familiar with.

The macro was suggested by Miguel:

https://lore.kernel.org/rust-for-linux/CANiq72nWcqd3aSKdPqOSRRQBuwWNW-s2EOscYszQ9kSbmrKxcw@mail.gmail.com/

I think you also have a point.

Miguel, what do you think?
