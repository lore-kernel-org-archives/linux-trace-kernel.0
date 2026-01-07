Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1D32C957;
	Wed,  7 Jan 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797154; cv=none; b=oUn11hoT0b8wB8soHxC8gvcZzJ9F1kRFas7h/WoNGiscCeBBtWYht25z7w0hb924/ZYP1Tl0AioMR1wi0nGVDUuisPm19tQ3Bc50BaxuwPrx6KIX9utHAD1wFmc1UHje2Mg2n6F9bJmIhSQmjdU91ELCTqm3nIyS9wUXSpEje/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797154; c=relaxed/simple;
	bh=oAfpWJ5QFk8JpVEkED638qvPp4Yxpc5W+WPXAqYXZqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MnTU41QFdo5GXZRzcphaAB2NfXu+ywtPKiIA5SmKvy7HJ/ZFElA70vSOdGOcoLpE2ofJMOIvMgeWHbPDT+TeWJycgXE7itJyu8/ZehbWNb/M8yZOfb9FHxGtVGA4zsrYsk9oorgqtwyck14rKcDQIvy4EN0i9M0tF4nxHVTlN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp6RH1kS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp6RH1kS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AB5C4CEF1;
	Wed,  7 Jan 2026 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767797154;
	bh=oAfpWJ5QFk8JpVEkED638qvPp4Yxpc5W+WPXAqYXZqM=;
	h=From:To:Cc:Subject:Date:From;
	b=Yp6RH1kSBuu/y3HmJEGjCp0Y+DUYvjV9LJvGNnmuFhYTn1QqwSm0Ml9BLuo9E+kXB
	 vVlwYQ01ZdSTWoTTeLwjRIPpSM3+VpwC+3N9zYq9AUopZXXPCk/ev0zMTq0wBAWg1y
	 nYvrjDEOUX1yhTlopS02wdtBvBLxA7eweqVeZ2f37+M6oitQPCiUD14da+Dd6spUXy
	 T4b86xLh7ffb2NpftHxWZet3RRY9spNODUbzSluG0ioTVWSXF4x6g2O60ZnmyNHS+D
	 QsV0ijpZT9unl5gRn76SK51orC/PtHd2bFRCUNnvIHEHxy25R26I0b9A/lE0/Ro3oS
	 8uPkwwOibFtCQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: Remove backup instance after read all
Date: Wed,  7 Jan 2026 23:45:48 +0900
Message-ID:  <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
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

This series of patches improves backup instances of the persistent
ring buffer. Since backup instances are a kind of snapshot of the
persistent ring buffer, it should be readonly. And if it is readonly
there is no reason to keep it after reading all data via trace_pipe
because the data has been consumed.
Thus, [1/2] makes backup instances readonly (not able to write any
events, cleanup trace, change buffer size). Also, [2/2] removes the
backup instance after consuming all data via trace_pipe.
With this improvements, even if we makes a backup instance (using
the same amount of memory of the persistent ring buffer), it will
be removed after reading the data automatically.

---

Masami Hiramatsu (Google) (2):
      tracing: Make the backup instance readonly
      tracing: Add autoremove feature to the backup instance


 kernel/trace/trace.c        |  155 ++++++++++++++++++++++++++++++++++++-------
 kernel/trace/trace.h        |   12 +++
 kernel/trace/trace_events.c |   14 +++-
 3 files changed, 153 insertions(+), 28 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
