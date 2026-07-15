Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967D448CF9;
	Wed, 15 Jul 2026 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115127; cv=none; b=V6TL7TBwwbbRhlJR7Ns8FQYa/H1+yJwBEwqshjxOy1pCRTePrxTK7aaTyDDMvsZBxoGed3FZ1e0bdqPM0XdEu/HVqcVASahlN0nSbJukgN1QWVMzncrUCPZICXCwG6QDEfwVRsLzF6NcEMwYoS5VgpWhzCz2slLCo+Kit3rQPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115127; c=relaxed/simple;
	bh=32bwRbGiFoKa/kPyWmMifNl1tJviYlgTSgsCqTbekCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gWCa1griwD54/zLnxioGaCVBx3MhKKubE4hdwXSEe0pV10CxFnhI/iyEy6cngNe7B+PHoDMx9GsiT6vRm1k4OpdGOi7SvDDOqq9TT041wotwMhLAftmLAU6RQ6d+Mu8QK4mge7en8lLEt/L3NxZfcSc3Ym7N46X1e8rkwZhz8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vt3aBMb5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lWGDGJ9N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vt3aBMb5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lWGDGJ9N"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784115117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32bwRbGiFoKa/kPyWmMifNl1tJviYlgTSgsCqTbekCI=;
	b=vt3aBMb5XiAWOcy7C6Ca8FNuShjZ4/L3igX2sTFqdnlDNDmbhWJOX9X9zXOm1cs5+eGY/v
	n86jwMfz5dzg3xK80D75h71ip3X/S627n/xUm6mqSQog65CW6QEugordfKITXjbEyK1/FU
	5fXDTqkEHY4bryLUUmpke/VLt0OH3eZCjhThkTxwWozRuTd2ycA3TEZMlACdYOBLW5BIjM
	wwlO6cHm5mas3Vss7vGL7E1u5ZBAca+avk3OkVPOwgp37j0/CLGzD1objExjP41GOrpoGG
	R5mYI9Eu5fVyKiRePEdVZZbLqusyZcZThscBTn29tlxBaft0H4pwDJu2usS63A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784115117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32bwRbGiFoKa/kPyWmMifNl1tJviYlgTSgsCqTbekCI=;
	b=lWGDGJ9Nq6CeYl+o0rFe0clOW6QhAHGrg7U4jET7csOiy5RYMztqZld/1PSYeBgFxeDceQ
	4nySk9bCkL9jjkBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Juri
 Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v3 4/5] sched: Add task enqueue/dequeue trace points
In-Reply-To: <cac78b0340121da7691ba8ffab8b7ed8350977a9.camel@redhat.com>
References: <cover.1754900299.git.namcao@linutronix.de>
 <918fe0f29a94e49db05c4f63a8a210dda9b90925.1754900299.git.namcao@linutronix.de>
 <61d904e5dc673d398c20bc4359e0f9b16ef4fde4.camel@redhat.com>
 <20260714121145.1e73c05e@gandalf.local.home>
 <cac78b0340121da7691ba8ffab8b7ed8350977a9.camel@redhat.com>
Date: Wed, 15 Jul 2026 13:31:55 +0200
Message-ID: <87qzl4lc9g.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Yes, but since I'm planning to rebase the patches requiring it on other changes
> I held this back. I will likely send everything for the next development cycle
> after merging those new dependencies.
>
> An Ack is surely welcome also now but not urgent.

I forgot that this exists.

Searching my mail box again, Peter had some comments, but in the v2
thread and not this one.

So let me revise and send v4.

Nam
