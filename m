Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D36AA7;
	Tue, 28 Jan 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080402; cv=none; b=or7GAP/XO33EgEMvzzbHuEaOWVTXsicMI94gp8Cxq1w4BL/XC9SHMgD/XM9tA6VZT6VaaDT67jv7+u0RcSJSa+Drp+5q1V2SHZf8NTK/bGZCEzVss6vnHt70YtQnvuT7tgcs835+kPg0ewGPXsSfgfIUi97GlH+eUqJW+0BZrlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080402; c=relaxed/simple;
	bh=K0bf70dQIAtekM70+iQ05WA3WSiYjJtL/rQtY10cL8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGtma2UrOSkvyqsM3cTQBX1Qpphr63y5FaZrRsCy8ylh2vARE/3eBFphuOKfZe4ndAaIEqD1BmUugcQTVaOUEQw4J+nzxarHeGaEwK5NthmJtlKgQn+hcBJXzttlnATTytIWCOYyMgwJX/vYcAYL+Rnjm3d9jo1AiE+8rGRg3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02B2C4CED3;
	Tue, 28 Jan 2025 16:06:40 +0000 (UTC)
Date: Tue, 28 Jan 2025 11:07:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] tracing: Introduce "rel_stack" option
Message-ID: <20250128110700.741e68cd@gandalf.local.home>
In-Reply-To: <173807863557.1525539.14465198884840039000.stgit@mhiramat.roam.corp.google.com>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<173807863557.1525539.14465198884840039000.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 00:37:15 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the relative offset stacktrace requires a special module loading
> events to decode binary, it should be an optional for normal use case.
> User can enable this feature via `options/relative-stacktrace`.
> 

Let's make this an entirely new event and not based on an option. Reason
being, there's no way for libtraceevent to know which this is. We could
even have a mixture of these in the trace.

Instead of an option, we can add a new trigger: stacktrace_rel that will do
a relative stack trace. And the event can be kernel_stack_rel

Then it can be enabled via:

  echo 'stacktrace_rel if prev_state & 3' > events/sched/sched_switch/trigger

-- Steve
