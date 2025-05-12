Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0B172BD5;
	Mon, 12 May 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058572; cv=none; b=dGZxejHKNz2da3jAa6q/qRTa8wYtsSHAHvkBz9lBTHEqfI8Q4eHmggHASKAsAoWG5JfrbiZCmHpaXQcB/IRQF76hDAt8YyssfyWs6/5V4YAbqTW8WTJyRgHdj8AgfTk71ojm2+Xq+H9piXpRA748UEq2x6xwS7YL+EO0bmcUm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058572; c=relaxed/simple;
	bh=3f2mVS4Mc59O2nnOm0Xi9wqIANmD+N3zePum+PiJL8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGiiUHV6IJ98/XVIJkDhrEyTIvWU7OAZXeuX7XbG8VY0oKJLovPtya0uBhH2+XIzciP2YEIanGiQHRO+e3z5ZwNHswLv5frDsVyypTQ6sDucyDHmKTMofx9rF/182v5SMenauM7stHSEubPOq6fsNef3IuHcx7t4zOrQtQyfWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E652C4CEE7;
	Mon, 12 May 2025 14:02:51 +0000 (UTC)
Date: Mon, 12 May 2025 10:03:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Paul Cacheux <paulcacheux@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probes: Fix a possible race in trace_probe_log
 APIs
Message-ID: <20250512100313.4040c35b@gandalf.local.home>
In-Reply-To: <20250512092442.32527a9e0dca2aeabcd07bf3@kernel.org>
References: <174684868120.551552.3068655787654268804.stgit@devnote2>
	<20250512092442.32527a9e0dca2aeabcd07bf3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 09:24:42 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> BTW, this fixes the problem introduced by commit ab105a4fb894
> ("tracing: Use tracing error_log with probe events"). However,
> this patch can be applied after commit d262271d0483 
> ("tracing/dynevent: Delegate parsing to create function").
> 
> Thus, before that commit, we may need another way to fix
> this issue. (e.g. introduce a different mutex.)
> Anyway, to record the correct fixes;

The method is if this depends on other commits, then those other commits
need to be backported too.

-- Steve


> 
> Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe events")

