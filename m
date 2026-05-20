Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A43FCB22;
	Wed, 20 May 2026 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303003; cv=none; b=SamlYo/KVHAv96xc3z7Qz+ejXmrdyRLg3w/r6i1AbDq0RiuYeSMaj1qMaQv8bwws7nMu7/24L38XnedRCp3S5FbQYNtJeF2tgozFHD+5irHdkU0pPbKpkr9uVmPZ+tfHkzKPL/jMJQUypIVyfIdfYlaPTgsdpQtEAgicR5WY6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303003; c=relaxed/simple;
	bh=R+TejpyOH+v7NTuuyHksiFjJE0TxZL3NYBUQPrRI5EM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=dZqgYUD1nghB7PIOb7H2iFJB9mValxxGbvBh7gZRJt55T9FEcPKt581HfGiiS6gYvnoUYYB2V5Kfq8Bpis8oLq/v5yAAB0MZDYWp1IML4Q8pZuHtJ67d5bJCGZ7tMR6ZDurN3JPvkIZ1WDwqEszR6UtXnpTFl6kxBHgPcgLLn1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoLSb/ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoLSb/ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790321F000E9;
	Wed, 20 May 2026 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302997;
	bh=MKIMaizKZSyh06GZngdd5lYTxfjyF9IEuPNl48AJkpk=;
	h=Date:From:To:Cc:Subject;
	b=IoLSb/veqVHr+UZi6ZhtRQlZ5j8YD6/YBk5oiWUTWoSGgYESzGIt1rLtfZqnCEsZ/
	 PMyedmZ3/iF0IuDs/D4bVn8xp4XnxoWnve9z6pZUUXShYNCMDlU9dbEdd0NmWpvvVU
	 Ax4qab5akqhun97gLL9UsGQDRO77zbW2oRn8k1KDTmpGMKw+HVSjYta5GgQcMl23Z+
	 f8ieDpBdXQyTOezRSjx55XrFU6cM5/QhVfuIUSJfMo2J8xwyU5PkB1c4XGVZPeRcMz
	 J6FBRg0V+lG3pIb/KV5vHG1hunPR8tjNOR3WRKyPUeMyITudIchFX/F+ChjTmrXZmo
	 aUxrdPWFJ+f6Q==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wPlzl-00000004qQK-03p4;
	Wed, 20 May 2026 14:50:17 -0400
Message-ID: <20260520184938.749337513@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 20 May 2026 14:49:38 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v20 00/10] ring-buffer: Making persistent ring buffers robust
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Here is the 20th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

 https://lore.kernel.org/all/177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com/

None of the patches from the 19th version was changed. Only patches were
added to it in this version. All of Masami's patches were in version 19,
and all my patches are new to version 20. The reason I'm including
Masami's patches with mine is so that Sashiko can handle all of them
in one go.

I moved patch 1 from v19 to my urgent branch as it was marked as
fix for stable.

The patches I added:

- Fix an invalid sub-buffer in the iterator (added TBD fixes tag)
  I didn't want to fold the patch into the patch that was fixed
  as it was written by Masami.

- Have the dropped buffers be persistent across boots. Masami's patches
  cleared the detection of lost subbuffers on boot up and the next
  boot would not show them. If the persistent ring buffer isn't cleared
  it should report the same info on subsequent boots.

- Show [LOST EVENTS] in persistent trace file where a subbuffer was
  reset due to being invalid.

- Show [LOST EVENTS] in the persistent trace_pipe file as well.

Masami Hiramatsu (Google) (6):
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
      ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
      ring-buffer: Add persistent ring buffer invalid-page inject test
      ring-buffer: Show commit numbers in buffer_meta file
      ring-buffer: Cleanup persistent ring buffer validation
      ring-buffer: Cleanup buffer_data_page related code

Steven Rostedt (4):
      ring-buffer: Skip invalid sub-buffers for iterator
      ring-buffer: Have dropped subbuffers be persistent across reboots
      ring-buffer: Show persistent buffer dropped events in trace file
      ring-buffer: Show persistent buffer dropped events in trace_pipe file

----
 include/linux/ring_buffer.h |   1 +
 kernel/trace/Kconfig        |  34 +++
 kernel/trace/ring_buffer.c  | 538 +++++++++++++++++++++++++++++---------------
 kernel/trace/trace.c        |   4 +
 4 files changed, 397 insertions(+), 180 deletions(-)
