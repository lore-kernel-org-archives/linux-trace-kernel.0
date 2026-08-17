Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA23B5847;
	Mon, 17 Aug 2026 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954710; cv=none; b=sZYejOcLznNuZp1FqbGpl0K0FHRAe1yoSm+JLypK/x7sn+SYPTUwrcX+fdvscrNdmqRmLzo9mEd9onV9m24K8AbcJpaxccqpVI48Z/bowpSmM1LQUyGX1ieY/UYUBJGLc4JoN009eaiSjX1697wuI/fgnkM1cz1YINQs28Lzczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954710; c=relaxed/simple;
	bh=YEEpwUMimRh09+8+7URT5jzCzBTpVYKzhoDNjGfHha8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWIGRhD9F332ABwm1w7ZRXUc2Gvrg93XgJL0BAn/WU7+NWkr7ML5hJz74rcRmkl55IweNeMLWSL3Oa40nIFBzFumibBYjfMSX/f0g/V9aFRlYzwoMr2zktWpSOZ+v8tlpx3QJkHKhmUWPndoAmAp8whQXmWxh1f0bve5xgo7e/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d7BmosjF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3vZcBgbq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d7BmosjF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3vZcBgbq"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786954701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEEpwUMimRh09+8+7URT5jzCzBTpVYKzhoDNjGfHha8=;
	b=d7BmosjFK5jSKXdunsd1cYIK8aakYnI9AlXfMCRz6+EtW9hoytZD29SsVbIOObOyLGW43f
	3u68KY+1GNTyCxRXM3OE9i6+DHXmXC7P5b8NSve7nw85yCCKoiSKlCIMPnNnTBddJDsbK/
	wshJRTkADFBoAf9K96HlY5homB6cn94fNSlVOy+Vu804r5i+PDMth//By2TLtmBG7bWi71
	Mw/EThoKW/ba5RVeVyWhHkTGLguSXmZYmP0+skQ+h522oJQsfgb7yZe5xwnRBZo/vBkIDz
	Hb2pexhk09JLaXTlRYDIWm/GS0RACOxIcfeyk9A5mzSZMUMQswccc9+QE0RU8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786954701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEEpwUMimRh09+8+7URT5jzCzBTpVYKzhoDNjGfHha8=;
	b=3vZcBgbq5OZHFTo+FeXoRgFUBWaOkZJd+63iG8/VtU3/RsPX/yJ3TZfSQ6+obcH7mEEJ0Z
	kpH+miOhbsYjvUBg==
To: Gabriele Monaco <gmonaco@redhat.com>, wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v3 1/4] rv/reactors: use context-sensitive lockdep wait
 type in rv_react()
In-Reply-To: <38decc4f7ef5b6f03b37705c7e97f22a7e40d7e2.camel@redhat.com>
References: <cover.1786294920.git.wen.yang@linux.dev>
 <26526e555baa5118325b2383e9f7f0f8f9b6a199.1786294920.git.wen.yang@linux.dev>
 <38decc4f7ef5b6f03b37705c7e97f22a7e40d7e2.camel@redhat.com>
Date: Mon, 17 Aug 2026 10:18:20 +0200
Message-ID: <87zeylnos3.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gabriele Monaco <gmonaco@redhat.com> writes:

> On Mon, 2026-08-10 at 01:10 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>=20
>> Reactors must not explicitly take locks, so they should comply with
>> LD_WAIT_FREE.=C2=A0 However, reactor callbacks can run with preemption
>> enabled on any kernel (not just PREEMPT_RT).=C2=A0 If a timer interrupt
>> fires during the callback, the interrupt exit path schedules and
>> acquires rq->__lock (LD_WAIT_SPIN) while the lockdep override map that
>> declared LD_WAIT_FREE is still held, triggering a spurious
>> "Invalid wait context" warning:
...
> Anyway, I'd appreciate comments/acks from the other folks in the loop

Sorry, I do not know enough about lockdep to comment on this.

FWIW, I would rather just use LD_WAIT_SPIN and keep things
simple. Context-sensitive code paths "feels wrong" to me. Spinning
should either be allowed or forbidden. Making it dynamic "feels like" it
will bring further complications down the road.

But that's just my intuition.

Nam
