Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1BB18FDDB;
	Sun, 19 Oct 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760896019; cv=none; b=AlK6LnFGx0yxhdyoJ6PTboWM/P3vvo7b8wPUdl3aAYjy2zUHPiQtSLwXDkSu9gBODe874Q5v5N8urvWQm6FLFnOvBq7ECt4LzxFYsRmLPTjClnVD2jbVyU7poYnbhHG7qL1+KtM1N8TsjOEt6BPLR8mlfYL0jfkV8znAszxvch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760896019; c=relaxed/simple;
	bh=iBrjG+mJpNWJvcAM9eoZJjaPCJi7C0ctS5AIbIXK6QE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBrN/AQcm7d+eZxvzATvDs+VtT2zBlJbWRE2/uYuX4zXd9xoXv1XPKORVzB6Hs0kFawh/j9qGFrQVgUgrCQJDSg4TkogVmfn/Kjlszj9gZiumj5kpfnvxBKAD1HQYXJ4BjA/bJVt6bgQA7e4fHRomIsK22uqHD8lib0i5bfAGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6946613B6F8;
	Sun, 19 Oct 2025 17:46:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id D81F520015;
	Sun, 19 Oct 2025 17:46:47 +0000 (UTC)
Date: Sun, 19 Oct 2025 13:46:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: Allow tracer to add more than 32
 options
Message-ID: <20251019134646.6d6f683d@batman.local.home>
In-Reply-To: <20251018000130.aa69bd5b6670715b1c52d387@kernel.org>
References: <175918528341.65920.10238038992631012350.stgit@devnote2>
	<175918529300.65920.15856373929947126262.stgit@devnote2>
	<20251015172020.5966beaf@gandalf.local.home>
	<20251018000130.aa69bd5b6670715b1c52d387@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4nky5dtycpti38in66aecbg6ctrdkbkt
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D81F520015
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xTXzLG1bigaj/8ief4UXLMYw1TgiDtqI=
X-HE-Tag: 1760896007-974800
X-HE-Meta: U2FsdGVkX18Rq9DtklkLlXJJaE4ju4AQ85IvNzblxh6lj6yjIHV3wnzXOqzqcvF0TfoCRckQsZcHtI9X1gSvoox0gwSxGPWFk+bcK92ZahMOcCrS9JHkcYQGLyMAJvaBnms1Clc66K5hK/I+BliUIHzKD4ZRKKQ6mg+FfoJCOo0VCjPRPr/7PJbOWpsHkcpiJ7EcTeF6MRVMDsF3ektyZDP+ltbbj3HOvMQ2STsUWzaDNfAqnRQ9vZAXe34Jgyfn5HCgUvb8XGgbJ1ONRBTzOllQdJNkfhyUhxSF5ZjhugL7xvCr2MEJZS9xN7IkHy/wYFsI4ldAnSh7zldxe0kp1eZBQ+IihPnrxvTp6YUu+Oqd2/NTjzUMJ3lA2PTkdsPOmjR+GRrMYZgT6Ac7r7gmwA==

On Sat, 18 Oct 2025 00:01:30 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 15 Oct 2025 17:20:20 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> I could not find any other enum64 usage, so I doubt it is
> available. (Does it depend on compiler?)
> It seems C23 standard support it...

Bah, I thought I saw it used, but it appears it's BPF that does
something special.


> 
> > 
> > Not to mention, using const u64 requires saving these numbers in an address
> > and referencing them, instead of doing it inlined in text. That is, using
> > u64 instead of enum64 is both slower and wastes more memory.  
> 
> Yeah, I expected that the compiler could easily optimize correctly, but
> maybe not?

I doubt it. The values are exported to be allowed to be used in other
files, so I doubt it can optimize it.

The only thing I can think of is to unravel the enum into a bunch of
#defines, that have the bit shifts.

-- Steve
