Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDA36C0D6;
	Wed, 17 Jun 2026 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694763; cv=none; b=bnuGHUggEBXRLhD1iR8mJLN0vNYGnakhZ8x4JlDXliWfOhkCMcCXZxShzPMcSLVwZhHaffPrGU3lzn2RgZ7eYrp0BUgTKVNP/mgj73wNZ0wDWD7vDLEjMOy/h0yJi5HIzrrE/cbxqyFAzheSD3uuyj5UZTA69XAbDl5HXwTMbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694763; c=relaxed/simple;
	bh=ZzDVW4Jd65iWYgnGdDU/w3naKyTs/lSI6bOs5Mi7M90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NU+1hWgH7Q2lCgwpfqLXREyv9lim0We+hFg7Acsie8Ql1K4ohGGi6eqZxEtJFMPUXD9H78CnG1dN1A/z2jyQ7YCNbUkSdUOifNQrgnV5yzIhw9igFF4oScAPcGyxPxh8ncEuxqvLAFJydS/HXjB5bgmEo2QBEXZfDcA22kBLC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nGb18fBO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jLRwvmaY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nGb18fBO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jLRwvmaY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781694760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4t8+T1yRrBOQjUvdhsOoZq+/WHOAfqCuRm0bqeei9w=;
	b=nGb18fBO1eRVt2hO55TFAs7TuQAXlJ13MYqSf8cjYVUy0guDz2KsLOM8vaPpDJJresAPln
	udzXN3acQ2/EtUBNplwF+f8/FEICxYoitP5SjuCdvZRu2VxaAQDDhP2uafAjeFXb430qDD
	B+SuQ8eZdebQ2nE6Lh6au+h11iUqbLG4Iwu/kStnm974matR8jWHlw8BVUHgOOgb7avHJ1
	SglhXBLTllBsgYA+SHC9dhKWyGG9uz3HEzOPY2p8UVFYoQRF6rzSDvFCfvqMtRrU8jcRU3
	9yOGNZ8hTV/FcJ+AeB9KW5msuAl77pfxcC/BiBGWwCtiE7gQXwS/6L73S7YbSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781694760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4t8+T1yRrBOQjUvdhsOoZq+/WHOAfqCuRm0bqeei9w=;
	b=jLRwvmaY+ME5VMLSJrsrscOQjtX7Sgg4/ZGaYyk50MVHYlTcCE2uSmzVbQmFcXereldI+8
	U4bcicWeB003TaBw==
To: wen.yang@linux.dev, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Wen
 Yang <wen.yang@linux.dev>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 1/3] rv/reactors: fix lockdep "Invalid wait context" in
 rv_react()
In-Reply-To: <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
 <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
Date: Wed, 17 Jun 2026 13:12:40 +0200
Message-ID: <87o6h9mndj.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

wen.yang@linux.dev writes:
> The DEFINE_WAIT_OVERRIDE_MAP() macro creates a lockdep map with
> wait_type_inner = LD_WAIT_CONFIG, which inherits the outer context's
> wait type.  When rv_react() is called from a LD_WAIT_FREE context
> (e.g., a KUnit test with busy-wait), and the reactor callback triggers
> a timer interrupt during the busy-loop,

I am confused by the last sentence. How can reactor callback triggers a
timer interrupt?

Do you mean a timer interrupt happens in the middle of the reactor
callback? And this only happens sporadically, right?

> the interrupt exit path attempts
> to schedule (preempt_schedule_irq -> __schedule -> rq->__lock), which is
> LD_WAIT_SPIN.  Lockdep then reports:
>
>     [ BUG: Invalid wait context ]
>     context-{5:5}
>     1 lock held by kunit_try_catch/209:
>      #0: rv_react_map-wait-type-override at rv_react+0x9d/0xf0
>
> The wait_type_override map allowed the outer LD_WAIT_FREE to propagate
> inward, but scheduling from an interrupt is LD_WAIT_SPIN, violating the
> constraint.
>
> Fix by explicitly setting wait_type_inner = LD_WAIT_SPIN, which is the
> tightest constraint rv_react() callbacks must satisfy: they may not
> sleep (LD_WAIT_SLEEP) or use mutexes, but can use spinlocks and be
> interrupted. This matches the documented LD_WAIT_FREE constraint.

These concepts are new to me. Let me do some studying before reviewing.

Nam
