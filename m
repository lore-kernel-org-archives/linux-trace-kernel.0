Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD46314D3F;
	Thu, 22 Jan 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096044; cv=none; b=EcKkn23Z9i3PoOr5pNzSDrPt5WqHpTGGqz/Ul+JbJAfqOxMOy0I7vQltLTe31sdTqiiFKScvShYKYKUz4v304cTPpviArpuY6YqXLlnJ2yDXrI7GMGE0968MfRxO92L6TZrTE10iyzTFcZnQDBYqHzlws74qv8IPXfkKN8U6e80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096044; c=relaxed/simple;
	bh=IZRurR/nx2K02EpPyXwgnplF1N2v/rWhb49tM8bqnyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptRoqo2TLKEBGclkTnEgMl6ADu3SS2c2Z8iI1Uy4hauz08T3YT4/LAjQDkQpQ+IJsy5/BANWZLtOz13skwl7LisDgESPZdQo/HYQdPTXAi7Ls8Zl0J7he4VvEu55KnS6db7b+sruoYsPlPGAJfluIrhT7k9gtTRVn9wdR/XRzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FFrfAP7b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROz8t533; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FFrfAP7b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROz8t533"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769096036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/IysMrstJdEqOP6OyoXrOZGiFAkuRZFl4iZBjV4olWw=;
	b=FFrfAP7bZ/60mfB8/VJoGCcfOqcdDZcZ7ODjW8wDt3oZB0jlUw+FQI9hujgdDDpI3M2Hd0
	pY2eUB4TQeMuAYywo2ZAqpJ3N9dn1a3RppDMEtqW0NHKs6kHu7YHu+vsz9RymB0Mnwvb/1
	843UA5fn9TqShCQB8NvMPvr3FnKwJcqi1BH6I4+RMT5Bwk1K3Iudq0Fvp9HTjNtHXnHnKr
	I3EsfWowAl9155VwRhTW0cE59HEwT3iTdqxlXpMkWvcN6AhXtCoL5WZLfQtJ4iOnlC4qXg
	3SD+wckH6F78F32GPFOK6R12VlvVgGQjsTLA0D6Uft7SEhS64BIzoIgmTloIIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769096036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/IysMrstJdEqOP6OyoXrOZGiFAkuRZFl4iZBjV4olWw=;
	b=ROz8t533ocSbPhiou7vEt3EVvfLtLnytAqYqjf5yh6Bq+Dc+PQ4S0v0M8MUfdbyZMzuYFo
	jvw32exkBIviCsBg==
To: Gabriele Monaco <gmonaco@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/26] rv/rvgen: add abstract method stubs to Container
 class
In-Reply-To: <69298b5dcfda02051c5c1fe995efc333f980664f.camel@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-20-wander@redhat.com>
 <69298b5dcfda02051c5c1fe995efc333f980664f.camel@redhat.com>
Date: Thu, 22 Jan 2026 16:33:56 +0100
Message-ID: <878qdpirvf.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
>> The Container class extends RVGenerator but was missing implementations
>> for several abstract methods decorated with @not_implemented in the base
>> class. This could lead to NotImplementedError exceptions if code paths
>> attempt to call these methods on Container instances.
>> 
>> Add empty-string returning stub implementations for
>> fill_tracepoint_handlers_skel,
>> fill_tracepoint_attach_probe, fill_tracepoint_detach_helper, and
>> fill_monitor_class_type. These empty returns are semantically correct
>> since Container is a grouping mechanism for organizing monitors, not an
>> actual monitor that generates tracepoint-specific C code.
>> 
>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>> ---
>
> Just like the previous patch, the NotImplementedError here highlights a weakness
> in the design we should improve instead of cover.
> If all those fillers don't make sense for containers, we should instead move
> them to Monitor and leave RVGenerator alone.

Agree.

Nam
