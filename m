Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BB2EA464;
	Tue,  2 Sep 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805334; cv=none; b=Ckh2s6ELMs82n8fdAjkYBDPbl3gYhR7NudXJQJt2L1bA/US6Xi6N9IewSYW7ONqSyvP6fLhW9raubsk2zvHvwlIRRcDePxjZqLpoKrNN/hetEAFOT3lgp4sA9m3hMhkb7zvbT5hqhv2++cakvI6Vj2b2WhUZDSesKa1uW+qf484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805334; c=relaxed/simple;
	bh=UgZ7SM6IjKlYVPoNsvYYsdE4WyHhu1HRfKxVLXMBlc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoRa0PJQNYaw6rb93UERRCmW4h9gPR30DSWOi/Po9c9s64ZXbDdNBG5+zDWle8EeqXc497FRByPFKDjTNl4tQK2H3DS7WC8R7Ya6n8lagQx6KGaytBtRTAoadIJucq/hA3VAQWfIzA2p2TPBDTiVVCGOv5I/9+DID5m+hqKP2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cy7EZqCl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DsC7PwIa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cy7EZqCl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DsC7PwIa"
Date: Tue, 2 Sep 2025 11:28:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756805330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPk40DGpwHSU4m21RqW9qfSDAsFyA91HOZ7rs5aCHjo=;
	b=cy7EZqClMwK9aE8WnitenUxqgWV3QK0Ztp2YW8GdRzRvNAtg6ZKMqY98CFLq0putMet5L1
	9VvamaHhkwj+9u8w1sHOPgOMxRIUQJ8r+FU2iv5m6UHVr+7odOlWb6OjMlcxH08iSSh3Ol
	AdazapmuI3L5bak+vfGgbzbivozWjHr0E4Rhk55mavtt+BoS8D4QwbOa0oyiRyiK+ywpu5
	K439ARtNdDEaYI18hQof1RMZUWTqmhNIjOwPzNLnYu3Y2ENMLELoF1hj8CNhtQqAo42HMQ
	Nse7wK3f55Xa/0sdiJibq42bKGkxJOV5GXMOg5tMaKqfXzmGxD7JS3EwXJtjpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756805330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPk40DGpwHSU4m21RqW9qfSDAsFyA91HOZ7rs5aCHjo=;
	b=DsC7PwIaQDI9EX65Psc6lC3nN8sAa0icSCJKhFFaoPi0cBSHaUWLHoYB/wb6hoDlvpfhRX
	HUaICHqA7/sHzxAg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 13/17] rv: Convert the opid monitor to a hybrid
 automaton
Message-ID: <20250902092848.tscxe_nR@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-14-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-14-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:08:05PM +0200, Gabriele Monaco wrote:
> +doesn't match a task wakeup and might occur with only interrupts disabled.
> +The interrupt and preemption status are validated by the hybrid automaton
> +constraints when processing the events::
> +
> +   |
> +   |
> +   v
> + #=========#   sched_need_resched;irq_off == 1
> + H         H   sched_waking;irq_off == 1 && preempt_off == 1
> + H   any   H ------------------------------------------------+
> + H         H                                                 |
> + H         H <-----------------------------------------------+
> + #=========#

Yeah, I like this much better. The previous monitor looks like it is easily
broken by any kernel refactoring.

Nam
