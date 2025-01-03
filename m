Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE971C07ED;
	Fri,  3 Jan 2025 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945291; cv=none; b=bQCp5LZhHvDYBTQfhdFWQt7nqRKvBu08/5mD9bD/NFI7sfYQuXbqOUl0Ftz8ep+pYk5mMLyhQLKmp4phF85cOuN0PWtID4HHBL0mUx+Y9Vtd/l3u/V5I14TIrg8u+JrPIY7K5C3RAdeCXBdYvqmBjBMLFGSM21EmiwOU9ZLjl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945291; c=relaxed/simple;
	bh=H7DFl9atQy/zuX7UnU3bVDtlzCsl98Lp7nyF8oIMqUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=grQWDlKbGOkMp5fFwxVMtI9XZoKAEszc7tiAKR+d2CM21rm/G+xQ5BqzkSKQAlzWUbXIvvpjy81iGGOdjZxD+z9uC6aoocW5hX5WyvLZ99Z9fWSS3fAsbUISsZUXRAhRvti87thEOI8VRv+m4hoERPFIp6hIhvnj9rhNg7tTkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTtPA+Fg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTtPA+Fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219DEC4CEDD;
	Fri,  3 Jan 2025 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735945291;
	bh=H7DFl9atQy/zuX7UnU3bVDtlzCsl98Lp7nyF8oIMqUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RTtPA+Fg+N4XdrbAAhuMAo76O9VrcnGwlA/a/SynyRLnaB3C7ZL3+JY/+ynvDt24V
	 AlwblCyVMMPu9oXKg6VeOmKhBuIbCDQZPvoaeYyWV+FflkrtZ3wnfJlYpUQqrCPtcK
	 dC27NJiyoIn1tfFk6Q0mNr1tcR9IrpJ5ntxCkIlO2io4yPcVEsinFjWkR3tweLEX8V
	 4CxZ+jMcQ4bbpvdyu/xC52AuWDPXi2xvFEbAdd+8UrHHVp9GbV7AjODK+HvV6hIu3Q
	 X1kwXMr0seVjvhK3qoZmWub2lautxBzmaTu5F8rx5qzvZz9izpwb7fOl3TazPG2qgW
	 Q2vyqlq8/JwJw==
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
Subject: [PATCH 0/6] kprobes: jump label: Cleanup with guard and __free
Date: Sat,  4 Jan 2025 08:01:25 +0900
Message-ID: <173594528527.1055889.2175884987203674189.stgit@devnote2>
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

Here is a series of patches to fix and cleanup probe events in ftrace with __free().

Thanks,

---

Masami Hiramatsu (Google) (6):
      tracing/kprobes: Fix to free objects when failed to copy a symbol
      Provide __free(argv) for argv_split() users
      tracing: Use __free() for argv in dynevent
      tracing: Use __free() in trace_probe for cleanup
      tracing: Use __free() for kprobe events to cleanup
      tracing/kprobes: Simplify __trace_kprobe_create() by removing gotos


 include/linux/string.h        |    2 +
 kernel/trace/trace_dynevent.c |   47 ++++++----------
 kernel/trace/trace_kprobe.c   |  123 +++++++++++++++++++----------------------
 kernel/trace/trace_probe.c    |   52 ++++++-----------
 4 files changed, 97 insertions(+), 127 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
