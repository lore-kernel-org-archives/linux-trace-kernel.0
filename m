Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B836C5B2;
	Thu, 19 Mar 2026 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911534; cv=none; b=TyZK4O34mdlD31vWgkNUWRQq+cYRuAnajmPQp5tFAOQuqAZsw7AdKR3GglQY21ESJENFhiEmEzTE8SdIG4ZDHHVDyBgnqn88sQrqdx+eEeB1/GE4A7UWDGvIXZAmn8Iw5caJQ6OG5+mpcmKHYm6MSTYWDUFoSdG3NPUizoM1AC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911534; c=relaxed/simple;
	bh=6hQmBCcDuly8QfGGzjTLB2bfvujQULdoTNflDGX4oWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/u5cy4avHFij7wKLxa0bI1YmQ3Z+Bo/HeclLonzD5M0jhSO3zVPjVgjjR6M76tOXFkm8k2YZJUP73M0hAhcXPOok1c6hR5N39kVHwB92Nls74tsAn4jR3rtyFFU9iH1hCZqIYOPJ2xESCoQj01xIc1aD03EHYHtTpotfkXj2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDTPPX6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDTPPX6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F8CC2BC87;
	Thu, 19 Mar 2026 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773911533;
	bh=6hQmBCcDuly8QfGGzjTLB2bfvujQULdoTNflDGX4oWY=;
	h=From:To:Cc:Subject:Date:From;
	b=QDTPPX6L63qD3PCLmFhwJJbIY5/xZGQzTZHR4ilB/eOENU3WKihuK2QqXpMl/CRcs
	 Gh85rNN5b9EMTCxDXaZUvWJQknkhsBO0DXUp4Rua8D8dUK5xxWYIFYWSR77GaUFVcO
	 V8l92cSTH+2B7C7BP+Qx6Ni6klKwjIPglk7LUSJQsG7iC/zmw/5ltKPXKyQBFIi3M8
	 RilCvxYuW1VqHwPl48cAUWUqwakCdIZPLTzszrLha7IcLvuA7nhSZxKKZMlMEGxv9Q
	 M7zeUKlJudZLywwVTHtM8aKie27+Aw70+TmzN+Jfw7z7hLuu0lZivvrX39lavxw2er
	 2TZ32aYF1F51A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v11 0/5] ring-buffer: Making persistent ring buffers robust
Date: Thu, 19 Mar 2026 18:12:08 +0900
Message-ID:  <177391152793.193994.8986943289250629418.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
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

Here is the 11th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/linux-trace-kernel/177374017536.2358053.12341235939816794384.stgit@mhiramat.tok.corp.google.com/

In this version, I updated [2/5] to do nothing by default since
flush_cache_vmap() does nothing on x86 but it can cause deadlock on
some architectures via on_each_cpu(), because other CPUs will be
stoppped when panic notifier is called.
Also update typo in [3/5], and fix to reset timestamp when invalid
whole ring buffer and skip pages which has invalid "timestamp"
instead of invalidating all ring buffers.

Thank you,

---

Masami Hiramatsu (Google) (5):
      ring-buffer: Fix to update per-subbuf entries of persistent ring buffer
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
      ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
      ring-buffer: Add persistent ring buffer selftest


 0 files changed

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
