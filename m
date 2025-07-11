Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4E21F12F4;
	Fri, 11 Jul 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231513; cv=none; b=CoLSI/K+V7p+7Ui9h/6SqEeP7wkmuSG0sQq1IDyiEqOKA31PvcslURvXfjtFaxzCkL2i5+m6fv8JDC+F3wgZemVCjjjKD5WNYJbNCiHp0r6cobCXc39NZr5X9Fu3MeSXxR+lfSYjyhw8IZ3b2GRHUsgbIjyCfGYMCL4aO0xp7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231513; c=relaxed/simple;
	bh=XCQDtVN9LtuP1CdLg9Wd8GX4n9nfD20nhOK6SsaQ+FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uOuBk+x+/ptn2B/NfuRZk3bjB83ukuircc/f0luZs0oOndUIZfhtxdnaStz31HJ+ZeO33LWBOgulbhJO3Hy1MnjZe551WJ+UPJPHdAu7I0V7aH4jED+c9ODdx48Im3jbc7nGJZdtykxzEh8VwyegwYQwvxtpmCjk+NBlY7fXw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr7QcpSE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr7QcpSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F5FC4CEED;
	Fri, 11 Jul 2025 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752231513;
	bh=XCQDtVN9LtuP1CdLg9Wd8GX4n9nfD20nhOK6SsaQ+FQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fr7QcpSEd077FKsibhDqnwwBg5UzvBg78VYhuwpbn16J5Ucdd+WnsVejTozpQcXDl
	 ZUWrO5+MZGsb/EOE8gKKbQ7KAbGeaQutulz3G0IiGyLT8w5nt5ccxD++BnlSEE55CW
	 Z/BZeEwzsONWDP0YcFbykajiI71dHOnOjI2C6P9S88DLkyqdGfWQbim6uheAV3GG5c
	 8fgkfKpHgVzK6433DT9YkrhhEAHakhkYb6oE/+aX9wMb9RCF9RlU49nmGRL6+jGfnl
	 gVapRMU8WYaDqZXmPCFz1172A60qmMj1ZF/F1+WKfRzJfdWZURBw1z0RUnxmHw78C6
	 H6RWJr44WbTGA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] tracing: Fix an event field filter issue
Date: Fri, 11 Jul 2025 19:58:28 +0900
Message-ID:  <175223150823.2878276.5814683250353215724.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 2nd version of series to fix the tracing event filter
because of __attribute__.

The previous version is here;

https://lore.kernel.org/all/175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com/

This version merges previous [1/2] and [2/2] into [1/1] patch and
fix memory leak if CONFIG_TRACE_EVAL_MAP_FILE=y.

This removes the __attribute__ from the event format type string,
which can cause issues with parsing (detecting the string
type).

Thank you,


---

Masami Hiramatsu (Google) (1):
      tracing: Remove "__attribute__()" from the type field of event format


 kernel/trace/trace.h        |    1 +
 kernel/trace/trace_events.c |   74 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 8 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
