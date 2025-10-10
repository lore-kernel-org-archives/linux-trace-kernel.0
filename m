Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF317597;
	Fri, 10 Oct 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106227; cv=none; b=fdZY1KcmRRsu+wClCrDoKe+uuGuCMUCqrJP+vf4LQJO8V9NwdCAISaHtFVSTkWcr4VBbOHn+fJaJSGZKtd8HDbSoOfjimcYDWfdnyn2E88lEhLze381+BDrqxXdu+hNWmDNt0eNLUbRWKBnFxHJ6LjH+eY9P8vo5pXJY8XCeq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106227; c=relaxed/simple;
	bh=vC/N7IozNJkARanX5/Ha8AZGYMhKJmuSp0KN3cJmk9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nS6M2xnrWVxWWTibdhmOucqd+Pe4uZA6QKUtmveXaXD9sRbGgx3cFjG2B9x5i+0UKBXTkS2bOIajl++/cJxNVw1lzas6MQBitNpQ9Z3o2T3vij8SseQn6ODrtgCr+3APpx1N7KLJWXxsUhRWkHi2gDuED4e6cbm1YE8S52/HV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzKXwADA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pxduouzo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzKXwADA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pxduouzo"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760106223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VOutbgETX+ROuc8lXZhUEXkf+F2qnmvgorpg8EXYRRk=;
	b=bzKXwADA2IX/HfUYgOVYJVMYa5gyD+CVsBgJsmhN60xyVfPxN0ccpVbKn+4hNZA8f7GrB8
	OFtP883iNNQ4oa7jbeAn8Q+r6roqoVEQ4DummwsLkzpEVSEQgvwx4pPz1KNHMFAGN0bI4i
	Xv4D8ktk7jFQ5bL+ja18XhBIFQmUVKewydHfRtCaZEUtp4Z2JJaht7jLrG5I9Olcem7Azf
	s8kBhDbGQijDYIs1zg6KvexiUrsViOrLOQmr6XjWnZdaDxCYXcCVs7zL2tKJLJ6iQf08UW
	1c8R0E3bX8ay8OpD3XndLG9gAMEcbjmclL3+a/7vz/6BqMwM/itvRoS/3YtwbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760106223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VOutbgETX+ROuc8lXZhUEXkf+F2qnmvgorpg8EXYRRk=;
	b=PxduouzorCoRjzUmQE3nqwB8g7AJrHUOnJRvUGn6EgW1ACPHIsiKdwkaEeZFuE/Jc30X+e
	OwfZgEaLx7mVUcBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 14/20] rv: Add sample hybrid monitors stall
In-Reply-To: <20250919140954.104920-15-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-15-gmonaco@redhat.com>
Date: Fri, 10 Oct 2025 16:23:42 +0200
Message-ID: <87frbqygwh.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +- Name: stall - wakeup in preemptive
                   ^^^^^^^^^^^^^^^^^^^^
                   copy-paste mistake?

> +- Type: per-task hybrid automaton
> +- Author: Gabriele Monaco <gmonaco@redhat.com>
> +
> +Description
> +-----------
> +
> +The stalled task (stall) monitor is a sample per-task timed monitor that checks
> +if tasks are scheduled within a defined threshold after they are ready::
> +
> +                        |
> +                        |
> +                        v
> +                      #==================================#
> +                      H             dequeued             H <+
> +                      #==================================#  |
> +                        |                                   |
> +                        | sched_wakeup;reset(clk)           |
> +                        v                                   |
> +                      +----------------------------------+  |
> +                      |             enqueued             |  |
> +                      |     clk < threshold_jiffies      |  | sched_switch_wait
> +                      +----------------------------------+  |
> +                        |                                   |
> +                        | sched_switch_in                   |
> +    sched_switch_in     v                                   |
> +    sched_wakeup      +----------------------------------+  |
> +  +------------------ |                                  |  |
> +  |                   |             running              |  |
> +  +-----------------> |                                  | -+
> +                      +----------------------------------+

I think this monitor does not detect if a task get preempted, but then
never get scheduled again?

This sample monitor does not have to cover everything obviously, but I'm
curious if I understand it correct.

Nam
