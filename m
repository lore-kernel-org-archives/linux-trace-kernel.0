Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5AF19755B;
	Tue, 20 Jan 2026 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871363; cv=none; b=bN2EFInJsxGtYoLnRrDHV5Ewo8Uj0TF+6Kp5YTwMq/FicHwxJJ0ZNFTkBnwrum0/LqQXsbhFcAwn++R8zy2+9nGIx611QgssQco7IpRksJ+m1DdvED6MmpSiGvQ5ptlKWpo7H62HSP3jVnLRJ1h5Ro63nrTeHlk15Y1IE+DEkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871363; c=relaxed/simple;
	bh=aUYgHSf+Ykg3c4stTD+2nquv+r2MqQ8YzOLLK/oLYvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZCvypV0ycjuIoy5rAP7gLQQtI8BTd/fqfvR2D+aIwS1MsvBb/zDNNvGlFVvYGBas+7PV9WHv1C2bs6LtWEhXf1AKVJyaMk+0OI1uIG1UHE2M9CbRybwpO0cpbPJVwQwtDrzDHFrNOT3xhEuO3iTHBLCjM4cegboYlHBqw1IIZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SACkl8e4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SACkl8e4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D99C116C6;
	Tue, 20 Jan 2026 01:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768871362;
	bh=aUYgHSf+Ykg3c4stTD+2nquv+r2MqQ8YzOLLK/oLYvo=;
	h=From:To:Cc:Subject:Date:From;
	b=SACkl8e4P3cmOOT6Ii9tVL3MvIXXR/KQLyDNOpCMZ81nq3y3TxCiCJZiqfcp+M/2C
	 qXrRg6g13Gi+FGrx47Dm1AucESWa12OreHQss96DWEMm6p8mCC8ybcp8LkD+KH39RW
	 m5EgUS1tRn7nqvuNEZWwIb9/lNNAcOjC9ybRJRRN5C1t5qPUTd3nYrl5zRRGYNTWZg
	 LwnZ87+JhveuLJjVfiQKQrZTQiCojTDg5iaW0V3T49DUINtgPFo/iFkXSiGl5LrpRC
	 RN+aSqlQAw0eggUoOEX8Txrs380bXjklXzEKnx5zA0Sd4udIUnct1Q2ECkaEfr6I3I
	 DBO5ydTvwkzQg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] tracing: Remove backup instance after read all
Date: Tue, 20 Jan 2026 10:09:16 +0900
Message-ID:  <176887135615.578403.6988045330349053692.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
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

Here is the 4th version of the series to improve backup instances of
the persistent ring buffer. The previous version is here:

https://lore.kernel.org/all/176828713313.2161268.62228177827727824.stgit@mhiramat.tok.corp.google.com/

In this version, I added new fix [1/4] to reset last_boot_info when
the ring buffer is reset. [2/4] is updated to allow resetting the
readonly ring buffer via trace file. And [4/4] is adding a section
for the backup instance to `debugging.rst`.

Since backup instances are a kind of snapshot of the persistent
ring buffer, it should be readonly. And if it is readonly
there is no reason to keep it after reading all data via trace_pipe
because the data has been consumed. But user should be able to remove
the readonly instance by rmdir or truncating `trace` file.

Thus, [2/3] makes backup instances readonly (not able to write any
events, cleanup trace, change buffer size). Also, [3/3] removes the
backup instance after consuming all data via trace_pipe.
With this improvements, even if we makes a backup instance (using
the same amount of memory of the persistent ring buffer), it will
be removed after reading the data automatically.

---

Masami Hiramatsu (Google) (4):
      tracing: Reset last_boot_info if ring buffer is reset
      tracing: Make the backup instance non-reusable
      tracing: Remove the backup instance automatically after read
      tracing/Documentation: Add a section about backup instance


 Documentation/trace/debugging.rst |   19 ++++
 kernel/trace/trace.c              |  164 ++++++++++++++++++++++++++++++-------
 kernel/trace/trace.h              |   14 +++
 kernel/trace/trace_boot.c         |    5 +
 kernel/trace/trace_events.c       |   68 +++++++++------
 5 files changed, 212 insertions(+), 58 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
