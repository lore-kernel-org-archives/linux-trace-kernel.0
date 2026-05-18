Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F43CF02B;
	Mon, 18 May 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093777; cv=none; b=pb53buIP+JXFWwbU+AL8CEGH5Ks1Su9OdX8EqFfRpdd/sZWpzvWfA4fEejIun9yU2aj8E9ZEiljGbTtwtR/ocoR18Ks5qqWWI0AGwQkSFMLgTG5OAWyBZjqkXNAcnttYCDEBMhit+C79f6odQYZwuEZXLMuehaJyzS7oRBTaCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093777; c=relaxed/simple;
	bh=N70htYt6mBO8hnTO/93rOgmTtYy/hLblqAH9AH9cd/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B9AB8OqSpqBJfpyfMfZ6FlkpSbbHLVG8GnW3dZZUQYLe3Ubz5kdOVUOd7byqV/RL1GlDRTh8v5Ljo5u/ubmW3U+Md33S5I5fHhI7JxfxuVs8TETUQeoizjZNqGmztvZtSbE6GtwO/m5rGj3HzEuBhKn7hYuUYT/9V4E3xSNSwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E5SWFrWK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6UDLJGzU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E5SWFrWK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6UDLJGzU"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779093775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N70htYt6mBO8hnTO/93rOgmTtYy/hLblqAH9AH9cd/o=;
	b=E5SWFrWKbOqpZyOlh1F/r5OpevF840XvAxzzJxUB9qGaWvAhhf8VStr3HW1lCrcHX4u0GB
	O5QAKGXv2mmhQY8IufimR+HtxbNNWiQKvbVYCgiDqzrBZQ+bC18IDEKMRHBZyfkn86e48m
	I0b/nw3O4/1h4TGU6samqgy0FR8Y0+YLjVY+yRrBlytFBjY+ELalnine7bYT5CbOiiW7Tz
	nIGHr5Bi4IBtWDCnbX07M5IraXHfxNI+EHl4f+IuK3xBCtr1mYC//tDJUy4+R783kB4xwv
	HvLmUwd3Y6iMSXuAR5uv9qgsmkkogW/EfhW29aM27MToGnT+vLQe+9QnYojk5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779093775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N70htYt6mBO8hnTO/93rOgmTtYy/hLblqAH9AH9cd/o=;
	b=6UDLJGzUQKAakGVD2JW5LUx9JSB0I3CcgkUV+bVfTcQNRfnYBiY+HqWOJ/x2P/fWv8dtJg
	3KDxPMLZtrNDD/AQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 04/14] tools/rv: Fix cleanup after failed trace setup
In-Reply-To: <20260514152055.229162-5-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-5-gmonaco@redhat.com>
Date: Mon, 18 May 2026 10:42:54 +0200
Message-ID: <871pf985wx.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> Currently if ikm_setup_trace_instance() fails, the tool returns without
> any cleanup, if rv was called with both -t and -r, this means the
> reactor is not going to be cleared.
>
> Jump to the cleanup label to restore the reactor if necessary.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
