Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE52BDC28;
	Thu, 18 Jun 2026 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789047; cv=none; b=W2EompqoJAvKc3tG+0yQTTNFp40Zr+2tbmE1BiFsEOjqwMsau7ZmJ3IK77L2YIL/3ZjJZ4B2ZBF5/gfeYjfsk4AlxgiAlnz9EUsbFw2b65C6SaDq2AUIWdGnNE4M/qRLqTtR/8JA0KPqgC0Mxp9z8jHs8i9eD/VJ8Tx0KacLCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789047; c=relaxed/simple;
	bh=6b0wxlvLuBUC6cVgFXTa3EXfEIljcSpLEmdjpoRCQ+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cepsaBqsDZbyGQXzWtY9AxaJ56Gp5t38SB6jDU7IQNro6Y7R3SvoFWKVlRegXf67Q0yQcriEu2qOT9FrXzEM4Osru/eSfU+klIiKO4VQrx9x5ilMwj63v3sGLtt4c491IgbF6ZwzwuymDmtFsHpgyzktpPtIfZAe4629F4oBS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSXrdP/Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvM8QL+B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSXrdP/Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvM8QL+B"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781789044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIgUZaDPjftaCuMCI9RgucFIBdYvkJk/aGPMmH8L/8A=;
	b=zSXrdP/ZrZYjRnzMfxWYLGKvt+3hcpUnSTbO7q7uWPGYhn4uDaUixR6l4BpVSZh6e69gqK
	wxV4Mg4As7LXxdeuvKiKCv6xn/4Zku7UJ8IommF7MfgnNcaFfFCdDBu5AcE5qu0YPn0OzY
	lIzjUn6jcdufG9XC8AwHsEqSTLdWX6IY30HLQXO3ixEz+3FxQxc09Io0Bf4sMkOQGUicyZ
	AQ6rnM13kp63Prd5dRqe5pVxwClBBVURUDHJyToLuVE8OyE8tMpQaHKD8kl2zXm805wusY
	hy8Vn5W0/+Ac2SQtkqKwJ300QdmTo6eG2sIDvCKtSM8CYj8yDl6HrWfG87lEUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781789044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIgUZaDPjftaCuMCI9RgucFIBdYvkJk/aGPMmH8L/8A=;
	b=jvM8QL+Bfxj7FrBaDx/3P0JsfytM6OWIGJo1KbdTzMc4sQa1/zeihjAqKAKJUN8LEzCj+C
	S71Y9KrPUlI2BrAQ==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/13] verification/rvgen: Delete __parse_constraint()
In-Reply-To: <9035cc5b83dda3a8ec06e8488fba62ceb7431123.camel@redhat.com>
References: <cover.1780908661.git.namcao@linutronix.de>
 <8d9b9068a5dde8256edd7debe7aab33e15a7fc51.1780908661.git.namcao@linutronix.de>
 <e3f63618b48dba9299c88bfffeae14b71717fa77.camel@redhat.com>
 <87tsr1mqrj.fsf@yellow.woof>
 <9035cc5b83dda3a8ec06e8488fba62ceb7431123.camel@redhat.com>
Date: Thu, 18 Jun 2026 15:24:03 +0200
Message-ID: <87fr2kdlsc.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Yeah, I don't see it explicitly mandated in the theory, but the
> description (from the sources) states:
>
>   The value of a clock thus denotes the amount of time that has been  
> elapsed since its last reset
>
> But it also says (emphasis added by me):
>
>   Clocks /can/ be reset to zero after which they start increasing ...
>
> Nowhere it says clocks /must/ be reset, their value simply won't make
> sense (according to the definition).
>
> Now in our implementation we may have some automatic reset when the
> monitor starts (I'm planning that to avoid invalid states), which could
> make explicit resets superfluous in some cases.

Reseting the clocks on monitor start sounds sensible.

> Let's leave that to the user for now and skip this check.

Thanks,
Nam
