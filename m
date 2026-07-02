Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744F4A3405;
	Thu,  2 Jul 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999830; cv=none; b=jVGujYMqU7iAqJnGNZDxeiZXzFrno1Rm6sv0rinCQSH/3bFvp35LNPc0omcW7A2B2ET7cFIFdX85gBAmm5YfaEK51A4bJ9mOUHdOBAN2Hsjc1ifrsIZL+aBO2XEYFL52GXRkCzdwuOclUXFDPqi8sGPOdc37St7iJPWRe4peIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999830; c=relaxed/simple;
	bh=TP7K/DxWYbdvNJTYXzA+j33g1nDaCcmwl7hIoE6slJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lzMEJiTQYSDspZQXEtcjGUCN1aPbmnzn6TJ9stVjKGFi0MwUPsd3/IYWWOPi46Qf4bmpuqtTTEc9fJelwVVNkHVOJ0La4Yr//ZWjG7wDSUQT9uEB9R4A2r+ryIr8Htd3rwgqh6akOG5EH9nsp+DM1+S33SIp8dS4lwqgCljxogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iErcKG2I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eawHCbH2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iErcKG2I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eawHCbH2"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782999826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TP7K/DxWYbdvNJTYXzA+j33g1nDaCcmwl7hIoE6slJ0=;
	b=iErcKG2I78bkJ0wIw3uqfaqvhsmMbEvEkQGssABogpbykeSkl5SILrDGbqLTls7quDj72r
	OWs0Xke+hd8pn/ykH75fhwEpvAum6TaSJT+LQlrGXhavMyxStGSTp+njOx6QoIlJL4p9s8
	iADJ+YLzdPj3jmQR90KG8VJ57Hyjkla1mZXUgHsgwjX8guVsFYHKa1VKOpAVEPXfivoeON
	W8HrO23S2aRczi6oAF6D3rs0mL1U86xHb+hzmIjNopnIBD0K6sYw3lYRkBQCDO2osIWL4L
	CZypDB3fPq4ggs2spTOGSTdVmZRcEV3o/RlNlbyrpjPyiMMEfl0cu4K+2UpIzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782999826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TP7K/DxWYbdvNJTYXzA+j33g1nDaCcmwl7hIoE6slJ0=;
	b=eawHCbH20GwH1Fha5TOVsMSApDFOjVCDfroo35azov4iCT3piOzNzdkhj+6rXOfWkdejM2
	wumxi1OC7pWzm6AQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 01/17] rv: Use generic rv_this for the rv_monitor
 variable in LTL
In-Reply-To: <20260625121440.116317-2-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-2-gmonaco@redhat.com>
Date: Thu, 02 Jul 2026 15:43:45 +0200
Message-ID: <8733y1jylq.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Align the rv_monitor variable name in LTL to the generic rv_this as it
> is already done for DA/HA monitors. This improves consistency and eases
> assumptions across model classes.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
