Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792FF20E021;
	Mon,  3 Feb 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738603179; cv=none; b=ry4TWbgBnrECgYYwMtAIAVQQL+9k7FqQfnBDn+IMEptIhb0bftU5SaDAdV4S7+xbU3FsPf7SXb0x0IrkZzKETRGbfio3ipmVo6+eY8AAfA7vom5hI6tkNlpIFcc5cWNLErD74pZU3JI4vCPn1cw3vWco0EpSQo3nWRPZXXSY8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738603179; c=relaxed/simple;
	bh=9ddDHAlmkDDQvFTbBwYjNamqwT2RbMmBB9a8ti2CriE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULhcCb1bZMbIKt3BWvpa2iFc+Xh4i8AFHJ0xB+S4uwcKW+q/CS1ikvCModJSWTV5/940GE1i6yKlhrDNCb0Pvm44Lv6VyI1KS6T9vsI2FJwo1k0ourSlNfF4QVreMSyezteWoWQWMEsUpPwMTAiCCtlkwUryvRQdcYMdY5uu/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE5CC4CED2;
	Mon,  3 Feb 2025 17:19:36 +0000 (UTC)
Date: Mon, 3 Feb 2025 12:20:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Ben Segall
 <bsegall@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Peter Zijlstra
 <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon
 <will@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] tracing: Use preempt_model_str().
Message-ID: <20250203122011.739231e9@gandalf.local.home>
In-Reply-To: <20250203141632.440554-10-bigeasy@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
	<20250203141632.440554-10-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 15:16:32 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Use preempt_model_str() instead of manually conducting the preemption
> model.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/trace/trace.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
