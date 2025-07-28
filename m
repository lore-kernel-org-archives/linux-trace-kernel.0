Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105A1B4223;
	Mon, 28 Jul 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718579; cv=none; b=F1Jji3thwxFcXsHrHA0iK2RGP32eu2q/1HusqkUskNY051bZuwyxE3QHDF/rMxTvscNSpwnQPuigHBXfBOCCiOcUbXMNBm7VcUa0+kaU/9KCfO8jfXxJqe9O8UbMHn4fFd7Ftf1sSclzJ/Lr4Yf9PY4Z9oj5MINtzYSmo7E21D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718579; c=relaxed/simple;
	bh=z3927KF6F7SOGPsHOpZC80nRYXP55EShbpHg20Y+ND4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVsMUdVCbJ+tdleyKV+aQ9lwLO2u3c6XAvHBc0KpckDcuaDDGNjj2zKsj3p23uA854LessrNAaAImWTS/Gddb8Q/2Ppwohe0wKBiOo33D+gna7N0UTNItl+C5qBSVWX5m/WAMzWIaIclBfqITfxnZfeiJYiGSWzsjTDfMIw9iD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LduWdqBU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b04X7HrA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LduWdqBU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b04X7HrA"
Date: Mon, 28 Jul 2025 18:02:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753718575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsqX5syA6psCKix2w9fNPFDrZdu9VJhXIYb8N+BAcV4=;
	b=LduWdqBUrYbxqMr5k5TIPmbFpohZgnT/btPfXshG4ZbGSvaDAiveT7l2tRSiVoegolWRq4
	26AEF52h3xFx26Y5Tb5YYzrjaqeuLWOrqJADkZrzI8X0Vnu5TJr/g/RDvatxZN+brFFtpO
	GQdk4OxFIoxsg8hg6bqNnxdOEvyiFz4moRlYCWWmchWRrI3/CaKqd7KsUzfxTrY7yAmbyF
	TH799VFrHRO+ImelL00AZi+rSkI3uYyIkvk4XQy4dwCXHxjTuy+oOtW3KExWAzzGUD67+F
	l83NcWDe4mgHK5k2ZiUgV51DF3eTjPIwQbrFBWuDv5z3DHZjsQ/D29Bb0krhEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753718575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsqX5syA6psCKix2w9fNPFDrZdu9VJhXIYb8N+BAcV4=;
	b=b04X7HrAuyOvwZbpJSqJ47PoHa2Cp7/JZ5bWVjeQp7nOGcDDw+mNgRZjB1KOmG1QNlMj1O
	SAY4OhKLwYZcXgCA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 6/9] sched: Adapt sched tracepoints for RV task model
Message-ID: <20250728160253.vqgYegmG@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-7-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135022.255578-7-gmonaco@redhat.com>

On Mon, Jul 28, 2025 at 03:50:18PM +0200, Gabriele Monaco wrote:
> Add the following tracepoint:
> * sched_set_need_resched(tsk, cpu, tif)
>     Called when a task is set the need resched [lazy] flag
> 
> Remove the unused ip parameter from sched_entry and sched_exit and alter
> sched_entry to have a value of preempt consistent with the one used in
> sched_switch.
> 
> Also adapt all monitors using sched_{entry,exit} to avoid breaking build.

Does it make sense to split this patch into two, one for
sched_set_need_resched and another for sched_{entry,exit}?

Nam
