Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F20B1D9346;
	Tue,  7 Jan 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250609; cv=none; b=klOqN6+DkuOeqp3z78xNmNdCV/eAXuTV/YBXCteEz85Phvt5JMAA1B4Zcl+6CPySUNuvlEGQNdvt48eQsKOMc6nRNqIhucY2D1ujxhFr4ZxKkITwLgs7eZQX4C+NLU2rbqANbAYYo3C7LkjeM+TV9NC1vJ5FVVD8lJNrueWYn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250609; c=relaxed/simple;
	bh=LcsWMBXLABq5h47xHHHrrpWps4V62YndTCWN00qSgto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tDc2Qv6PZbiccJdwuFCmRFqw6EIzp9KFlEBM90GhNRAiSshb3PRsb1xaz7doBQyRj7Jis6dr1ym5pwkYIYAeWF0Aiyt/6MECG0Lzx4DJ5RXrAr5JO9pKhQgUAwatZl+nrQAbvk7u40Ks6LpTJYYEm+E4h5WsjVD3RuD5WXhhZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn2c0j4C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn2c0j4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0285C4CED6;
	Tue,  7 Jan 2025 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250608;
	bh=LcsWMBXLABq5h47xHHHrrpWps4V62YndTCWN00qSgto=;
	h=From:To:Cc:Subject:Date:From;
	b=Gn2c0j4C4GfEZcFcVAQqDLnOVFvgSQPXF7U8Fox+3wUrRErhrphMOqC/Fb+z2C+/Q
	 zKmds8Oerx+rOReSFzj1JBjuctD2R9syatB8VAdCMTe2WVX7QdubiyIkUBQwMMZEw8
	 BEiUpPTlsXIFVnYuXIMBLGwww26Gl5PfW5LLh1M/s50GZ/xS5DmkqdIg7A8nYOHlWl
	 OChiNOEccnr9Za4zZ9eKcLdOM3BwBP3LxzWtOAhZytC+MeBQ89nghwIdzTFdU504JW
	 ihGpvGb7+Dwt7I5Rgwpdyzmm4qpf7CzQNTjKGnvyvuIfktoeasnd8eLI9TJA+Cnp2O
	 q111fM38qObYw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] tracing/probes: Cleanup with guard and __free for kprobe and fprobe
Date: Tue,  7 Jan 2025 20:50:03 +0900
Message-ID: <173625060316.1375434.11048027439794595989.stgit@devnote2>
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

Here is the 3rd version of the series to fix and cleanup probe events in
ftrace with __free(). I resend this without dynevent and argv_free
parts because it has been sent by Steve[1]. And I updated the version
tag.

In this version, I fixed some issues[5/7] and update DEFINE_FREE() tag
name to specify freeing function name so that reader can understand it
easily[2/7].
Also, I added trace_fprobe cleanup with free[7/7].

Thanks,

---

Masami Hiramatsu (Google) (5):
      tracing/kprobes: Fix to free objects when failed to copy a symbol
      tracing: Use __free() in trace_probe for cleanup
      tracing: Use __free() for kprobe events to cleanup
      tracing/kprobes: Simplify __trace_kprobe_create() by removing gotos
      tracing: Adopt __free() and guard() for trace_fprobe.c


 kernel/trace/trace_fprobe.c |  129 +++++++++++++++++++-----------------------
 kernel/trace/trace_kprobe.c |  133 ++++++++++++++++++++++---------------------
 kernel/trace/trace_probe.c  |   52 ++++++-----------
 3 files changed, 145 insertions(+), 169 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
