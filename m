Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47726772D;
	Wed,  9 Apr 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212766; cv=none; b=c3dFsMtzbIbTf6KJZheSaSa2PPsrg2pgYDvt8I7qda6An//5mYidmGyurxDIWmGaSMQdDIe2Fku3fQdLxgXONXeagNIyjIQ9NwXIYvUl0pYZCJ6on7BZxaccGVOUVoVHiMnhWLQmIDV0jFX/bh1jN698i5ZfuXKw7JPYpom2/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212766; c=relaxed/simple;
	bh=1cTMcNUOZR0G8ilOHV2oQzN4qri7oZSuiQ5k9Z6bwOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p26zzze0ZIYlslRBSF/N2i1B13or0EyEINkNbx5JjeXvZsXIZiP/mg2zuEftUPZfDz6OPDFlcJ6uAGgesc/U1Fru/0asvn+jeaEh2wnAAxxYOCSjQ0vZG3PFM3tO8GyI3mQ72Iqtz1c9qf+dR/iztx8yVjL2tqSmvZPqPmyVubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ECBC4CEE2;
	Wed,  9 Apr 2025 15:32:45 +0000 (UTC)
Date: Wed, 9 Apr 2025 11:34:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add common_comm to histograms
Message-ID: <20250409113404.5b2085a7@gandalf.local.home>
In-Reply-To: <20250409083244.fe29885ef4f9253977a2bf61@kernel.org>
References: <20250407154912.3c6c6246@gandalf.local.home>
	<20250409083244.fe29885ef4f9253977a2bf61@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 08:32:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> BTW, the string field size must always be MAX_FILTER_STR_VAL (for comparing
> with other string filters, which checks the size at first.)
> Somewhere we should comment it.

I believe that's more of an implementation detail of the underlining
infrastructure. I don't think it matters for the users of the interface. It
may be a limitation in max size.

Is that what you want to comment? That the string held (for all strings)
has a max size defined by the MAX_FILTER_STR_VAL, which currently is 256?

-- Steve
