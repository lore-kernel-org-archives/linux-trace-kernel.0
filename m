Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060C38655E;
	Mon,  1 Jun 2026 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300689; cv=none; b=DSjClQy5+74+sqAK+DJRHjPf/jAbyMkCViQKdGk6Y1LiCYBWRGWlsYMhEt0rJQ4bnnPQtWuYpMUsZXPI44PS5xHmJHsn36YVfX1dogZLIjvFpibiT8+7nCY+shLQ/jT08bHTe3knH72Z7xMFSL2RTN5l9r2RS50M2bmCGWp8ktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300689; c=relaxed/simple;
	bh=3GknxfUIVHfKMbOlfAYCI4E7Oj4owrPRFpkVdV+WX88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SIG0n7Pma/gvmat9qlaInjkoi+Rw7CNaOSTYxBXL/lAj155zId3Q6dHoBXEoYzQ4rY35wmWGvMlXw8xoZgdny+yW1NC2YBjtdlWlJ/1DHepcJgxMfv47wMYH+vKW8tH8gHODNW6NoNzsBioM1obtk/URn6SsCC4gcDr+OhvIObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jStZpRPH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T0zPf6Ip; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jStZpRPH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T0zPf6Ip"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780300686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GknxfUIVHfKMbOlfAYCI4E7Oj4owrPRFpkVdV+WX88=;
	b=jStZpRPHiravkzez4mO+m8mOOO4lcz00MbprddZbXzmDEW25aF70eDMzHMQL2ZwylUK8mJ
	nM3DdDO2pXs8PMP9w5pdGUmvvAyT99fElRrcPebtP5GbR3Qit2oV3dvjTI5RxUZCwCTs5f
	6zAIs+Lvb4MOW4TwyMFPRQzzOKucyU9DZolGz63yyj8Qyj55kgB/P5tGGxGY34CObb6kKh
	Og3K0RqPbQcfN7asbnfCeMyzP2Obm3pp346qbazE2H1dUOlTXgSxTXdWA1Zbib5ka0Fgp5
	dPeCR9a7KK3PzmtJd4Ou7XLR1XRarEOTqNjfNINE5kAETsvthIx4GNUryIkIew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780300686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GknxfUIVHfKMbOlfAYCI4E7Oj4owrPRFpkVdV+WX88=;
	b=T0zPf6IpC9CUQ4AYkB81KF7MatYJTEFhsObpzDIrjYrfTxW+Hyqi1N4t8cVZD5Wh4HPEms
	hAhzFS5Yhwnv0yBg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 07/13] rv: Add automatic cleanup handlers for
 per-task HA monitors
In-Reply-To: <20260530141652.58084-8-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-8-gmonaco@redhat.com>
Date: Mon, 01 Jun 2026 09:58:06 +0200
Message-ID: <87y0gywv3l.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Hybrid automata monitors may start timers, depending on the model, these
> may remain active on an exiting task and cause false positives or even
> access freed memory.
>
> Add an enable/disable hook in the HA code, currently only populated by
> the per-task handler for registration and deregistration.
> This hooks to the sched_process_exit event and ensures the timer is
> stopped for every exiting task. The handler is enabled automatically but
> may be disabled, for instance if the monitor uses the event for another
> purpose (but should still manually ensure timers are stopped).
>
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
