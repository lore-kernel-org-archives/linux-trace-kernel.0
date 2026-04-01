Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1E31A570;
	Wed,  1 Apr 2026 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067404; cv=none; b=HShppgzpD5b+6G5OaYvXQp7Hsinxx+HlKCKdHWa4H4GRoTK1pGVK28ijJUiURtfrgUGxlo8dLlR98hhX5uB9JwRBJfBNg2tzTwB/ZIG0N7LpTOzB4Qzb0odTINxj73dihfC0HrJgTi7sW+4XLjs4wKW6ME1g5o76PZIISiArYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067404; c=relaxed/simple;
	bh=r9J4DJAe9kKlGNZ/+Gkw4i879XuWHsXNeN4l6qJPCr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4BWjm0N42BfgcnZN0Q/9bvE9Lx2r8wz+MN91zbDR4jBUJwqj+0Q5LOWCphJTpzNS2GSE6jdSTKZZ/gqtdw/S0r8+OoXUm/gEfTuv6t9UexrB/Uaahl3XVtyySGWHZo15QbOSiB4ePl2wRFBW3jg7etzP/GBJY2/Ij1uYj6qkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k60/B8vx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k60/B8vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37FDC4CEF7;
	Wed,  1 Apr 2026 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775067404;
	bh=r9J4DJAe9kKlGNZ/+Gkw4i879XuWHsXNeN4l6qJPCr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k60/B8vx4HrKNnAlkT91HDHgS8azth3gy6sPKEu4ZSytB5VkN6eqJdjejTJY7W6q0
	 VubL2oIxZU0A5NbJ1d4vew53EW2iTAgaAkz43yFPo7TV2RcvLr+fG/IXV2YzfheBWm
	 hiBG1b5ElgUd9EwdUL6pEd8hHVqW1CPoHa0rSmRdOEcbQ3H6HWpQei4zE2/vJBVuwz
	 nxrfaYbuxEMaiUdj7E/o+OyxLSiBQlS6/6ukh4O8mLqsLRrpDWB4y5M1oozWYIYD+n
	 QH2Vv9FVb/EDpKxrRCdq0bezYKZMiUKeA7VUnvP4sHGyqpLsteeqwM7FBgpR6moe5M
	 fvFwH8fj4Du/g==
Date: Wed, 1 Apr 2026 14:17:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Brian Geffon <bgeffon@google.com>, John
 Stultz <jstultz@google.com>, Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v3 1/3] tracing: Have futex syscall trace event show
 specific user data
Message-ID: <20260401141742.58068600@gandalf.local.home>
In-Reply-To: <CAP-5=fWxhLrMTwteTedGVeUg8uz=xzF+_3Q4qFnxB=TaKR9D8w@mail.gmail.com>
References: <20260331181349.062575155@kernel.org>
	<20260331181432.995263521@kernel.org>
	<CAP-5=fWxhLrMTwteTedGVeUg8uz=xzF+_3Q4qFnxB=TaKR9D8w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 11:07:07 -0700
Ian Rogers <irogers@google.com> wrote:

> nit: Would this read better if `val` were also hex?
> futex_requeue_p-3248    [001] .....  2101.068970: sys_futex(uaddr:
> 0x7f859072f990 (0xcb2), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, val:
> 0xcb2)
> The val matching the value in uaddr is the condition necessary for the
> futex to sleep.

Good point. I can update that in v4.

-- Steve
