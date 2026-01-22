Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F548A2D6;
	Thu, 22 Jan 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096691; cv=none; b=iIAUyjCGZDf2BFvHVPIzj9I4u5o1NHj8i50KCyh3oWvkCR2nuHWe8mPUA1bRNsPXvA1Rndyx99EJeOTD6uGj1+jgGyB6s7lSLYJJJKlvtIZoy5r5bZ+7I73As49FU6tamgJy9Q3ckAGlY9Wxx5r55iQ2MNdXO0dbB58y6lf9HfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096691; c=relaxed/simple;
	bh=Ws2N0l/T1drmEqmREepQXK4Ozp7+rN79/2HvZbvA4lo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YB/ufoSKgTQQRXq4B/9tV6FDoc3Kc60MW129yvLKu0SRMZEY5iNPrZucKVOAhbFHa7TRI1qZseGAU21qV7xp+LILz5IAXwnPFy2lp4WpKxT7CqAkQZ5iYYk9obEZ9NoXHRDjhbjHFPug2t4Q0VCh6VhdQRbW6ZE/kLLmDfZT3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mv2A4b6F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=djF0deag; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mv2A4b6F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="djF0deag"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769096664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ws2N0l/T1drmEqmREepQXK4Ozp7+rN79/2HvZbvA4lo=;
	b=mv2A4b6FxIImGvPkj5YXjWSX5WQn16qCl3uMev9bmbIExfLBQYeTuUrCqzw0/SqZ/NanKO
	Fmi8KNpe0CPlFRjuRBiZuLYlDVbsSzCYHPFlpcdl2QqAkJZci21CFp4WN4bs5eqZgnRJqh
	GFi1aQe7FLbLy3JOJm7TKMPnVnKMmzpF0/1zFA0nbsS/ruI+ZBPO1Ei2zhsfdZXEon7kwN
	E7jCBTFBiGVnBSmHWNsnz8xMKeaB8m+aKoJZP7m3YgQ1abLdB3WVQo3OM0FyAKkvTI+3o/
	JssjWuzMYvIN/QoAawayy7TfqCT83GFIGgUjajK2Brehv83gbaRcskvM6L+AQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769096664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ws2N0l/T1drmEqmREepQXK4Ozp7+rN79/2HvZbvA4lo=;
	b=djF0deag4oyVivAILf2guG4Mdnuk+yJ837Wi+aRrOHcQYc1qLrNBcS/nFze5EwxVKFgChO
	J3zVQ3QVbyfos9Cw==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 24/26] rv/rvgen: make monitor arguments required in rvgen
In-Reply-To: <20260119205601.105821-25-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-25-wander@redhat.com>
Date: Thu, 22 Jan 2026 16:44:23 +0100
Message-ID: <87zf65hctk.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:

> Add required=True to the monitor subcommand arguments for class, spec,
> and monitor_type in rvgen. These arguments are essential for monitor
> generation and attempting to run without them would cause AttributeError
> exceptions later in the code when the script tries to access them.
>
> Making these arguments explicitly required provides clearer error
> messages to users at parse time rather than cryptic exceptions during
> execution. This improves the user experience by catching missing
> arguments early with helpful usage information.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
