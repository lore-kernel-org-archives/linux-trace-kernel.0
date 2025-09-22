Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B582ED14E;
	Mon, 22 Sep 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545166; cv=none; b=OudTRBR7ENK8IbH5iUaJ4zRPlGah5rMRWsKbhSX/PZHGjNsCj47FFBvSRubXNv0+NRpJHroyRxN7hkdL7tE9e1+6ptl/Mftf8HPZGSok1CsBUCy9kUzLfHGnt/Z4hy7ns13+rveJl/uZa2ZLbVYqk8uUcAn+mv42JjqXNFevgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545166; c=relaxed/simple;
	bh=eS/rZv+vOpyuOVbZ/9SxTViYMVghWgK9oBnveD/4L00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gFl3cR6YE2vPy5R6lyW0SeYAqpZyEvsDanZhdIULOScplASKhY3QTexbinLU7RlUICCDdiYkp3XBk1DYOMdZAHXLPzmCKOpPzUHAbEdPPrMsVvaTkPh3Dw0xyTgHZl4uAm5eb9n2S1hBgINosLg9LATbaQu8UK0LTlk7XTgkTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAlpOj76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAlpOj76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88740C4CEF0;
	Mon, 22 Sep 2025 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758545166;
	bh=eS/rZv+vOpyuOVbZ/9SxTViYMVghWgK9oBnveD/4L00=;
	h=From:To:Cc:Subject:Date:From;
	b=ZAlpOj761FaZ5FxaL3jNvnW9rCV2Gs9duRT130unD2EHUAklRM8az+pOp00oGaKWd
	 9hsWbsP+NahpCuJozusmnoZhzM9Rks4Y7pfJ+2z6sMKja7nyPJNTR2ycd2NWsPbCJJ
	 PiLedBb3U1XVh64Kcc0DU2YwyeLiwvv6gxFurluswTU5zMnrMo0C98bb+flsWiZz0O
	 W/o2Srj0o3rJU8r2vjxt4tVvTjKf6h9qwsUDcT/e4NfUJhCo5QyE6fkvM9JkYL7CwV
	 KcJwSXS4ZKuMK9MbIGSacICp3Gj6jg0TVaGtaIrsaODgS9SEBCFR6F/b5G04c2SpVZ
	 I/5D0ylx2Riww==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tracing: Add an option to show symbols in _text+offset for function profiler
Date: Mon, 22 Sep 2025 21:46:02 +0900
Message-ID: <175854516202.353182.1216978967046454932.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

This series implements an option to show symbols in _text+OFFSET
format instead of symbol name in the function profiler.
This is the 2nd version, the 1st one is here;

https://lore.kernel.org/all/175826135058.101165.7219957344129610147.stgit@devnote2/

This version adds a patch to expand the trace_iterator_flag flag
bits to 64 bits [1/2] because there is already 32 flags and no space
to add a new flag. Also, add a dummy TRACE_ITER_PROF_TEXT_OFFSET to
fix a compliation error if CONFIG_FUNCTION_PROFILER=n.

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing: Allow tracer to add more than 32 options
      tracing: Add an option to show symbols in _text+offset for function profiler


 kernel/trace/ftrace.c             |   26 ++++++++++
 kernel/trace/trace.c              |   24 +++++-----
 kernel/trace/trace.h              |   92 +++++++++++++++++++++----------------
 kernel/trace/trace_irqsoff.c      |    2 -
 kernel/trace/trace_sched_wakeup.c |    2 -
 5 files changed, 91 insertions(+), 55 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
