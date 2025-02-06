Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC71EA7F6;
	Thu,  6 Feb 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850038; cv=none; b=o6dfU7E6dG/Ju+S7ifLhpql/aRCHdg8AvhkWduGwvXMz1O7HyQ8QrKeRMfTqgznNB3CjfFo1zNj3KGcP+NbicF9AcQa12UYEbghMgOPi6f0vYPs8mPwXBF5BxF5ZVF1c1tdm0EyLqhO2jRXzd9/ciJRr+Bv6QT0OT0EKDanV5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850038; c=relaxed/simple;
	bh=RIg4iOaqEgFYPkW2inMxoFeA8rI0uIk8n+pQO4qC1J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al0TJ6dm7064NT/pg3ZYA2GahPm7ae2Qcl9frLV8NNyuBk7pHYUxlmZiVhEXadlcA7hnAEPk2lp9YKKYbw/wLkrMZbu415yUzW/3SLRBPyKprKBXz8f1YrwNTPwbrSI5vA8futDTizF34Eegzbul8eT9bhmC36n8doGL8kNenbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pzwTHOiw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iTyIeh7N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pzwTHOiw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iTyIeh7N"
Date: Thu, 6 Feb 2025 14:53:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738850035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5OhWPAu4aphIzD7xlFqULoTdQ1d9FLpBhL4JzORAtrE=;
	b=pzwTHOiw0eZL5YDmeqk51vz9SLKgEg85QZWTqMPS1jHY0dwDmSWRFIl4awVJf1+3JTqD1c
	EGbeNjBzmXsaL/ZBpZkb85ozSbbD0JPbF4NwdRakdpHOeDrP8LImCCi1Uqvieo15WRkXVJ
	UioM7O2jzD6wS8TQx+k5r4O46ML0VN+lhZZ8lV/Qg84z5w0HE0fSYIVmCHODc9fmmdwRF4
	cW/8zakoTdOfZTue0x0Paz0+yDG1C/rUfQJkcUR+UXEpuezhP6gyKk0YiotiWEdSdUpJn7
	9QyXU6SJX7aYAQ8rIuNt0Mf5/s2b4pXAMvUHzxsn2SVw/Q9Ic0QJlCdfgu7CEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738850035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5OhWPAu4aphIzD7xlFqULoTdQ1d9FLpBhL4JzORAtrE=;
	b=iTyIeh7Njzn/4TjYMIJNO4dZZ06HQrrqMMFtJMLkWxziMGXg5Pcp1QHiud1ezdWMm5fhIE
	oUSv4/bv/q0c5iDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
	Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, daniel.wagner@suse.com,
	Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250206135353.i1tp4vDv@linutronix.de>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
 <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
 <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
 <20250206134408.lD_POjuG@linutronix.de>
 <20250206134859.GP7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206134859.GP7145@noisy.programming.kicks-ass.net>

On 2025-02-06 14:48:59 [+0100], Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 02:44:08PM +0100, Sebastian Andrzej Siewior wrote:
> > SCHED_OTHER vs SCHED_OTHER after all. But please don't delay a wakeup of
> > SCHED_FIFO/ RR/ DL because of this LAZY hint.
> 
> Thing will get delayed if interrupts are disabled or kernel has
> preemption disabled too. So as long as we ensure hint crap is of equal
> order, nothing cares if you do.
> 
> If you can't tell the difference between task does hint crap in
> userspace and task is in the middle of syscall, you can't tell the
> difference.

I can tell the difference if I see a trace where an interrupt fires,
performs a wakeup and the SCHED_OTHER task remains on CPU while the task
SCHED_FIFO task sits on the runqueue until a timer fires.

Sebastian
