Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255720E715;
	Mon, 28 Jul 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718172; cv=none; b=mKh2vqbuJ5DqXi98DEtkmtNFsMzZnbyZ+1/YoBZIwBEah/n+LlUJvMzOIs9Tg64r0gfOmikp3KEM0Z0g5SkzuMjpY2Yx/je3qcVGbGDv0eKb4WAS62ca35T+gI1INpgzgF82YVMA/eIuBHLWAs6Cjr9denlM1mSE6Z3EHTjVTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718172; c=relaxed/simple;
	bh=eP5YR4wwkoU17304IgDaCr6T7Xe+V0gnNL65hs/fKY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDFFI8eDdFRfYL8LoS4aoWb4z8p7QfDffBcls6CvgHp4pJxT4eb3C0nblOATCcwGpCwkLPC98QfMGDqfVy6uZ7sLvrUkM1vMbcJbUTQVqh91RYSAIQM7R0XDC2BSyQA7yDvBddyGRxEp3ZWaLBDzkwFIm23xgQO7phLVLyScC7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4rqv9TB0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pc7uoGYG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4rqv9TB0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pc7uoGYG"
Date: Mon, 28 Jul 2025 17:56:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753718167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0Fn8WoqCj24JnRrCMkS261YNvDXIgPw0xyUb3AFnYs=;
	b=4rqv9TB0jHXOx5Eh5BC9nPRigevRxJwY828DDMa7pa7dfXASZ4el0R02IXpZxU4JDsbxtN
	OOUEAGVAwlfYBvpxYwCUCIDI5kuWIQmBklvXcCBXrCMoZoW2Zq1lmivycml7H9JlFBo8SP
	4WfWFrHfhmV2DmY/rxQhJHExe9FRmmTdHn1MUP/rilwy1G8K9nMrjmOmQTqMC3GRujOVYl
	p7wDhoPxQPW38+kCYZvydfHv9UaEIyYFFSwrXo15nH+07pJtPbHvND2fw37aO8YPFBoUmd
	6JbG1G+hcGGULHA+qSt1/4b3SBXIUCh7y80zPhYU2WbQi2ehh82vkgyNNynAwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753718167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0Fn8WoqCj24JnRrCMkS261YNvDXIgPw0xyUb3AFnYs=;
	b=pc7uoGYGanZ8HJefYiECl1C62K1ZD1wBA5Zd1hb2s91BP4G9R9/7QwpSg9MZ9//RSNVk/y
	/pIn6YUVCBJ5aTCw==
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
Subject: Re: [PATCH v5 8/9] rv: Add nrp and sssw per-task monitors
Message-ID: <20250728155606.OgP3pyhD@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135022.255578-9-gmonaco@redhat.com>

On Mon, Jul 28, 2025 at 03:50:20PM +0200, Gabriele Monaco wrote:
> Add 2 per-task monitors as part of the sched model:
> 
> * nrp: need-resched preempts
>     Monitor to ensure preemption requires need resched.
> * sssw: set state sleep and wakeup
>     Monitor to ensure sched_set_state to sleepable leads to sleeping and
>     sleeping tasks require wakeup.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

I can't comment on the model, but the monitor implementation looks okay. I
ran the two monitors on x86, powerpc64, riscv64 and didn't see anything
suspicious:

Acked-by: Nam Cao <namcao@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de>
