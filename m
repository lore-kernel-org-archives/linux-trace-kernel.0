Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355F4502F;
	Sun, 17 May 2026 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003105; cv=none; b=BONTGJjj7aKCTAcWoRWyOmsrPsn/Qf8hXbCqULFa3Lvvjjooojux7ac0kZ7RuCsrqOUZTzwh8ij9G/IVkx5Yxeqryz7VzSBFHuxDSDKdztMwl9iHQ/eFDVXxM20fJVWzoirg5Jjo/1TpgEIAcLywWiAapbvIy47wux+GoyavXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003105; c=relaxed/simple;
	bh=eLVAmwEkqGZrNzEPxjVUhUmimDfkz0G2h0HLUax2jMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JYGK+TAxTKd49kHNa/NHRhLu6xdBaSURmEH0UpRQ2xFSjGdsswLLu2oXxrozHXNAXwsOvg/ud/1Xuh+F/odT9jwRKLPGC00T/zYhnjVlWnD4F+F94lxEl051GpRmM/Xh4/3JrZRnlleu9SSkIsZEZT33yNyTlg82MDe9LqPw5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZOfynfX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZOfynfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10E8C2BCB0;
	Sun, 17 May 2026 07:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779003104;
	bh=eLVAmwEkqGZrNzEPxjVUhUmimDfkz0G2h0HLUax2jMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oZOfynfXt1AFAA2Opzd5vCZJ894e2vVGo0ZLuKop2Jvl594OfYehRlSv3mi9luAn6
	 9DvlbaltqXDxmcGeVAVTxuxqvoU9d4dfgr23VxZv4WoPqPatrlXAzd2E4nMAGR1ra+
	 LAifMLo5B/JyPN5mQg0C4nS3j/T6O3TM3D/qnHUhZcW9Tbk0xHFo53roOOP78VEnFc
	 LVjbV3j93/Hxp2/2EqKRYG7Btasg+Hg768OOnV2QfcaIxWfqtIRYFLgqOMmBbIwLvB
	 8HB1XGr8QusHu21BJQFTeSh4EPoCCK0KGmYKN0A0VZ5KjWTKXXNfYC5tdz0OnrtJPP
	 AVZVNUxYfWPHQ==
From: Thomas Gleixner <tglx@kernel.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Vineeth Pillai <vineeth@bitbyteword.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH v3 10/11] kernel: time, trace: Use trace_call__##name()
 at guarded tracepoint call sites
In-Reply-To: <20260515135959.2238922-1-vineeth@bitbyteword.org>
References: <20260515135959.2238922-1-vineeth@bitbyteword.org>
Date: Sun, 17 May 2026 09:31:41 +0200
Message-ID: <87jyt2xzj6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 15 2026 at 09:59, Vineeth Pillai wrote:
> ---
>  kernel/time/tick-sched.c       | 12 ++++++------
>  kernel/trace/trace_benchmark.c |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)

Please split that into a tick/sched and trace patch so each can be picked
up in the relevant subsystems.

