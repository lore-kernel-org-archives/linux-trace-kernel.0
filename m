Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55D2566D4;
	Thu,  1 May 2025 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746133111; cv=none; b=EF1w0doPs953zOkEiVm/JoOM1XKiAsxHyv8ueiNnm//yf7SIBrtDFzFN0+Jg0CkUiLROHj1L2jKZDwB0EQK2HnLlBj1dmMCkXgi8FZZeC+7SS0EbAE11JGlnGKnegoSVrWf6JaWNSSJPUSYa1wRDsNs89GpcpS36MBk6bUebdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746133111; c=relaxed/simple;
	bh=HiCZst0N+366zY/MiEosh0BMKE8Foeyd2ZLwbIUHNgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4xDvfoDYxR+NMMYnK2E/Eor+Hi5OSyUpN+bHnagSs8AmvLPx5FDpRejxVUhK9nWmupz69O2MNTLmxn5z3Olh8O9WMCljL3CUwt7Z9QBaKzXIbvZBMZ8CQJZfcOU2Kr2SP560ufjP7QjiRbbJt19Ape3hfHLSlDMoz1sJosX36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3883FC4CEE3;
	Thu,  1 May 2025 20:58:30 +0000 (UTC)
Date: Thu, 1 May 2025 16:58:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Cacheux <paulcacheux@gmail.com>
Cc: Paul Cacheux via B4 Relay  <devnull+paulcacheux.gmail.com@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers 
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix race when creating trace probe log error
 message
Message-ID: <20250501165836.3b943e44@gandalf.local.home>
In-Reply-To: <0b13bbd0001c41ca1866ccf58f6e9de6ca2c24d9.camel@gmail.com>
References: <20250422-fix-trace-probe-log-race-v1-1-d2728d42cacb@gmail.com>
	<20250501154503.2308f177@gandalf.local.home>
	<0b13bbd0001c41ca1866ccf58f6e9de6ca2c24d9.camel@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 May 2025 22:56:44 +0200
Paul Cacheux <paulcacheux@gmail.com> wrote:

> Just to double check, what you are suggesting here is to include a
> mutex in the shared trace_probe_log entry, and to lock it in all
> accessors functions (trace_probe_log_{init,set_index,clear,err})?

Yep!

-- Steve
