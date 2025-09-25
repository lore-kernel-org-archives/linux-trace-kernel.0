Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F9226D04;
	Thu, 25 Sep 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798953; cv=none; b=FCEUg6LUZShPe8S0tc2xJHwqX3GyIjhyt605thrl7VKTAhHFKUxkqfm08KpGzJZerhAoCa/BTtszgMEYUduuNz9Yq9xW/o6x/YNY1bz1ALfcNe7J7aKynt5hu/CkWsQz8b3aSbH6K3tbayr9GZmoe6QoaSTFGR6ZL6T11DEqmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798953; c=relaxed/simple;
	bh=C+zYjk27+rSALkWGwsqlKEo6pAEFQbQCAjr+1qLyZT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5r4L1SHVDrDYCps8YTE5B7JPq8tlGbcJyTD+5FZ7ATAosWd0+P0jvaSlxB4fTNO0F7L2GfhgobDDt815mQs++U9j68OIYs6MjkBoT7f4xqY5CCa2aStwLKkrhaaZ8hKaVCO+eG4+6XWL4BKCshOTK3w18j5wo5pvKcEZUmaEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/mH9WLj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/mH9WLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9A2C4CEF0;
	Thu, 25 Sep 2025 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758798953;
	bh=C+zYjk27+rSALkWGwsqlKEo6pAEFQbQCAjr+1qLyZT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/mH9WLjOUb4fgyiesNPrLVNDLkMm2J/muYrdY28m+jUv+BA31YIOFvcVEzXi2ygf
	 mfWJnt+Xo4S1Wu5KWKw8tRonyI26Zm7q0Qgy4X81lT/ZCk2HEPwmIm6tcicqvYZ2Sn
	 ZVtcUuerSlr4pxCvw97d/bN+vCc97l7d2YRza7g0iwuydCsS8HZU6ndGq6HDqNt+nL
	 +/JeRmfN3fcl1HS9GJ0e7J4UDGlFprGoyBnP2ItUGm7sux0lcM+banj94LzgjgdX22
	 UduHTphvcihtjA9yD91OxKSChjhQ1xBZVZfklGsCROYTOMXPnfweZmYezKE67nJF/k
	 e1gb/BD+MUFqg==
Date: Thu, 25 Sep 2025 07:15:45 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, Takaya
 Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Douglas
 Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH v2 3/8] tracing: Have syscall trace events read user
 space string
Message-ID: <20250925071545.578e3643@batman.local.home>
In-Reply-To: <20250925072609.GU4067720@noisy.programming.kicks-ass.net>
References: <20250923130457.901085554@kernel.org>
	<20250923130713.936188500@kernel.org>
	<20250925072609.GU4067720@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 09:26:09 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> And you can't just allocate memory and not bother with the
> migrate_disable() and retry stuff because?

Because tracing is supposed to be as non-intrusive as possible. I
rather not call into the allocation system from a trace point. I'm not
sure what side effects that may cause either.

I have yet to cause the retry path under stress tests. I had to insert
a msleep() for testing purposes to make sure it worked.

-- Steve
