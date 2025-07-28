Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762D273D84;
	Mon, 28 Jul 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718285; cv=none; b=SMc3pVKA7JFk0bweOvTuEsqVKmjkV3vMmaxDApCIObMDAqXoHqSDRbdon5b1Qe0L0J2/vEpD7uu56drVUUxcTDpx+sZoNw6X4queQPSMWRJNdXbGAzUGK3Huk270Fnnc/VRfcGbFiPLRSkpDmS63Wtx7EAvOsYMxVJq7jjqFiE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718285; c=relaxed/simple;
	bh=f1UEggSNXzgb3Eo4hbbz6GNNcIWPvAtB57wHx3RtvVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZAe8sOYHY9UPo+duJX2Cny+K7WiSoxOPp0Et3rLacKCyzFQDKP249g7UrhVKgWjbLdwqAPssZp5u0ahtEYIA4JzO3/P8jIt116yiqZUF0LBBd73LPuQiQEdLjKItRRRtnJMdSTGQ3W0Wq05wh/whGfHzg4QjbN2IePzIrX/pwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMKm/YkZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YtHeT/ZU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMKm/YkZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YtHeT/ZU"
Date: Mon, 28 Jul 2025 17:58:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753718281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpsxSu73SWhAWuzpH+ljmRiUcvfjXN+Xo0DIDiJtFUA=;
	b=SMKm/YkZvyvT0WBHN53Qsy51q/vKiYHHQwaEPTTzgPY+kE2owwlJA3cd+Pbfo4NbuA7p1A
	5bpUm9kid8WTyT04u9BQKuMLCFjkFzwD4XlTU5z71Bk8XJtkHJ+Dn3Z7hsDU120Y7y3JQF
	JU2QOF2nWtlnHvCQ+OFoNKUL7HJPDzR+hORrdLCO3vijMAw4TQc+Cuiy3KdeWm9aCdpHBj
	D36Igy/TtFE83sNjmMUhbPhIdJg5kuS5q3rcPy/rv6/J+vqzB+TRJxlXBwBPmiPP4aoteQ
	26bYMpIeT3+M6qg7t9UlQB+Wr28iN/dY1ZNiwC6oL1Zqw3CFKfvRByfuy4i7ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753718281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpsxSu73SWhAWuzpH+ljmRiUcvfjXN+Xo0DIDiJtFUA=;
	b=YtHeT/ZUj6uc9Q+wHhElD72JCI7pu5+BSwgepswihdY3rK0rB1I2hKx9u4L/qESm+borjd
	jpr5vowdKWDsGHAA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 9/9] rv: Add opid per-cpu monitor
Message-ID: <20250728155800.x-f_sSuD@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-10-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135022.255578-10-gmonaco@redhat.com>

On Mon, Jul 28, 2025 at 03:50:21PM +0200, Gabriele Monaco wrote:
> Add a per-cpu monitor as part of the sched model:
> * opid: operations with preemption and irq disabled
>     Monitor to ensure wakeup and need_resched occur with irq and
>     preemption disabled or in irq handlers.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

The monitor implementation looks fine:
Acked-by: Nam Cao <namcao@linutronix.de>

And on x86 and riscv64:
Tested-by: Nam Cao <namcao@linutronix.de>
