Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340A290F;
	Thu,  9 Jan 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432972; cv=none; b=kl5c+KZanWnPLZcZMmYH1g5ai4FaWMdyCc2l7rpSH+krCY0YxX7t7PPLDbe1waUWB8jOHQHYXEDHfKh1mKnawjOVoB/UwZMFTbKySUB6w/AmE9VvfTuJEkql6RXFQPXJBXBlxfJC6zfm9YetIdB1tJdQCV+kuZwwDJD4WO+Sd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432972; c=relaxed/simple;
	bh=+M+c6PdW4ZrwzQSozMqxukP7yabHhgSkHk2iGR/FR5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vji3Fdh+XMHJ5p76NVB8ihOLbyVJhSdCjHPx/rcxT4DMEVQ9JKjnkb71XLxm6kycMXDFU1IDblDYYuR70pStldmWIvsy/Pb5ZQ76rMk4OAobSzG4d7ZLubIMzXO2AhGfia7rJz1b4Kr0RCknhJg/9E09IitYdJ+gxeoj9sJEwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od2I0vIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od2I0vIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FFCC4CED2;
	Thu,  9 Jan 2025 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736432971;
	bh=+M+c6PdW4ZrwzQSozMqxukP7yabHhgSkHk2iGR/FR5k=;
	h=From:To:Cc:Subject:Date:From;
	b=od2I0vIkVyrrB5g4swq/Fp7r3cv/ApYrb4ghMzjduJUt8WW3YuHSj1QmCOPcYShJL
	 hr2uhuXzLRMqP0oQKxTDY23yHx90pQoPTTpAzs+akYCZuAicPsCy4eW2TlLcb6cuhF
	 j+We9+3v7Log4C7dgMpa1GRCFnP+iZXgcGPbADWqlTP9WJeSAqwRowND35wmbH8ydd
	 UlvMJHHzDHYZUtlMuiwWu2Eg29hgp+ETFyfNqzaJeXxcLeql4n4XcMfeFEd80CdVSM
	 TzgVSmxw7STE24HNBbUICxcgO3eijW/1IczpX80aV3XbXnlmHKMlKBXW+AtkWXu91m
	 kDRS8aLQDkXEg==
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
Subject: [PATCH v6 0/5] tracing/probes: Cleanup with guard and __free for kprobe and fprobe
Date: Thu,  9 Jan 2025 23:29:26 +0900
Message-ID: <173643296599.1514810.1580554610685712071.stgit@devnote2>
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

Here is the 6th version of the series to fix and cleanup probe events in
ftrace with __free(). The previous series is here;

https://lore.kernel.org/all/173630223453.1453474.6442447279377996686.stgit@devnote2/

In this version, I updated [4/5] and [5/5] according to the comment from Steve.

Thanks,

---

Masami Hiramatsu (Google) (5):
      tracing/kprobes: Fix to free objects when failed to copy a symbol
      tracing: Use __free() in trace_probe for cleanup
      tracing: Use __free() for kprobe events to cleanup
      tracing/kprobes: Simplify __trace_kprobe_create() by removing gotos
      tracing: Adopt __free() and guard() for trace_fprobe.c


 kernel/trace/trace_fprobe.c |  130 ++++++++++++++++++++-----------------------
 kernel/trace/trace_kprobe.c |  131 +++++++++++++++++++++----------------------
 kernel/trace/trace_probe.c  |   51 ++++++-----------
 3 files changed, 143 insertions(+), 169 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
