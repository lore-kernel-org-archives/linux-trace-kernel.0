Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A672634;
	Tue, 29 Jul 2025 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765831; cv=none; b=uQi25OYRL5ODGvH8LTJaGj8Csb3J1ucG236KQQJLj8x97Y/HasFu5mkrIJCidLfWQJZGApTC4MlGIbHcK6rJfq0q9mCed/Q2Us8zeMXe1vKkGhqTemedr/IqSd5uYHBn96gcSG97b3EafaGZZvvHm/XYls29E51r7d/mPhXHujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765831; c=relaxed/simple;
	bh=Z0ZzA396novqGTVhi+5o3sVuNn3H9kjNqsdd+VDTuL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vCvq4bXMtwRtRgt8VS+ZjV3xg9HMymBckKyx5DtyM5I4MszNGkhNgOpUN4bZTIqGJul5s5MDUClHVq0jphIYJVRk37Uhu3hEV2rF7dxCEFAuRMSnchQNByyy24cNxNM/FnKJWIgwicQPEz/Ea7Fg7nSBvqXDhduDLU0x/U6oH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwvyPm5T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwvyPm5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B64C4CEEF;
	Tue, 29 Jul 2025 05:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753765829;
	bh=Z0ZzA396novqGTVhi+5o3sVuNn3H9kjNqsdd+VDTuL4=;
	h=From:To:Cc:Subject:Date:From;
	b=QwvyPm5TFn8hBKNxKZJOF47ftryrqf/tmw4AF06HLJMBjkIRIDST6lrC7yANDpWOT
	 ZGrJZJkP3wOpRWUh3GuzJXcyR1KP2Ku2ToCSJaoT/7aG8wVtPp9vKOAsIHdX8FZePy
	 IL34imedWidPnlRwYLB7Jk2FCuccJHZ0KwHB5wH7nozOu0s7b/G3LRvpSd83/yBYo9
	 +fI/G9TpC/saYGEGoJFoUU7JAo+3fZwxZ5S1TyFUc7sQZpoY8rCyrl8+tUei+FPjYV
	 Sf96ULaiIJb+ARvJhcyvA+wlk2dQgRW/DVTRLKHPpGwt3wHebNgOGfq2nUXrdVQ3d1
	 Klu2HKSqeazmA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 0/1] tracing: Fix an event field filter issue
Date: Tue, 29 Jul 2025 14:10:26 +0900
Message-ID:  <175376582586.1688759.2122686728240441891.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
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

Here is the 5th version of series to fix the tracing event filter
because of __attribute__.

The previous version is here;
https://lore.kernel.org/all/175333238644.2267214.1835493691667067597.stgit@mhiramat.tok.corp.google.com/

This version fixes some code according to Steve's comments.
Especially, to avoid strstr(), run sanitize_field_type() first. This
also, simplifies the error handling. If failed to allocate memory,
return immediately, but if there is any wrong string etc, it just
skips the field.

This removes the __attribute__ from the event format type string,
which can cause issues with parsing (detecting the string type).

Thank you,


---

Masami Hiramatsu (Google) (1):
      tracing: Remove "__attribute__()" from the type field of event format


 kernel/trace/trace.c        |   28 ++++++---
 kernel/trace/trace.h        |    4 +
 kernel/trace/trace_events.c |  128 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 127 insertions(+), 33 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
