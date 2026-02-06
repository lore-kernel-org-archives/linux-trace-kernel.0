Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54128156F20;
	Fri,  6 Feb 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395812; cv=none; b=E1V70/NM+wf5fzIVZkioK5J6d3NJmFbK7euY3oGYXuyWugkfPThLeLC0xGFjdMeeTU37AnJiVlKvHzP2luMx11MV+viI3YXw/8wRIC7DoAwrlaKV2DFMEc911QwrCU47IUz4xQxQ19U5jKT4sCV4Lra8ARrKOk/a1psRJtzxmIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395812; c=relaxed/simple;
	bh=7HbCgdtwA2zHSShOfJESkgwp3oG1at88m27Ser3axB4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=tnjQOrQM38RgKG2SIYMp2uQxEsqjiRogYXIMC0WqiVqcpXbvZOqlf44eM4EMoYGLNI1SzIl07h3+RU+40EoS2bTfBhiRtJm0LcuF4lKP4Pe5rNiTzZ4pHHzNBW/6e6hL/pZ33VlQtiHRYPJB+JYeqrvjPhYjmbYIdXl8jucFWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY2Qr5wQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY2Qr5wQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21ADC116C6;
	Fri,  6 Feb 2026 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770395811;
	bh=7HbCgdtwA2zHSShOfJESkgwp3oG1at88m27Ser3axB4=;
	h=Date:From:To:Cc:Subject:From;
	b=CY2Qr5wQ6TXHPBb4r2ksEh7Yp8rZeHZwVpcnJbci2V546syxO0yGOWTAakB//e7ie
	 hvbqVUKepWltgeBaCFgdkJXLvtsjczS6yzsZr27ag0G6l0co9K4X5rOdct+ViFCelF
	 U5wwGt/KNDOGBN9+6jf66tLxGk7OCX8vuTtcCdUb/F8RUGFG/NzD+ra4gMzDggMEZb
	 i+e62WVTG+IKFwP28KuOebBrq4b6/ZNMRqSH4uMfzdmvAzibH66c8OsGbJRwDtKrhT
	 6W2Eok2iejv9DxcJVXxC+oTwKOVFH85YDy7ub60jTesTY4TLBpIxyEYoBSDvTK0deJ
	 LmGTxBaJSXpHg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voOpm-0000000A1mq-1u3f;
	Fri, 06 Feb 2026 11:37:30 -0500
Message-ID: <20260206163554.153428314@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 11:35:54 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tracing: Clean up snapshot config logic and field name
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

The latency tracers (scheduler, irqsoff, etc) were created when tracing
was first added. These tracers required a "snapshot" buffer that was the
same size as the ring buffer being written to. When a new max latency was
hit, the main ring buffer would swap with the snapshot buffer so that the
trace leading up to the latency would be saved in the snapshot buffer (The
snapshot buffer is never written to directly and the data within it can be
viewed without fear of being overwritten).

Later, a new feature was added to allow snapshots to be taken by user
space or even event triggers. This created a "snapshot" file that allowed
users to trigger a snapshot from user space to save the current trace.

The config for this new feature (CONFIG_TRACER_SNAPSHOT) would select the
latency tracer config (CONFIG_TRACER_MAX_LATENCY) as it would need all the
functionality from it as it already existed. But this was incorrect. As
the snapshot feature is really what the latency tracers need and not the
other way around.

Have CONFIG_TRACER_MAX_TRACE select CONFIG_TRACER_SNAPSHOT where the
tracers that needs the max latency buffer selects the TRACE_MAX_TRACE
which will then select TRACER_SNAPSHOT.

Also, go through trace.c and trace.h and make the code that only needs the
TRACER_MAX_TRACE protected by that and the code that always requires the
snapshot to be protected by TRACER_SNAPSHOT.

As this snapshot buffer now has a more generic use case, calling it
"max_buffer" is confusing. Rename it to "snapshot_buffer".


Head SHA1: 5c478bf3c6e04e6699d66a98bc6cabcc8ef5391c


Steven Rostedt (2):
      tracing: Better separate SNAPSHOT and MAX_TRACE options
      tracing: Rename trace_array field max_buffer to snapshot_buffer

----
 kernel/trace/Kconfig          |   8 +--
 kernel/trace/trace.c          | 122 +++++++++++++++++++++---------------------
 kernel/trace/trace.h          |  24 +++++----
 kernel/trace/trace_selftest.c |  10 ++--
 4 files changed, 84 insertions(+), 80 deletions(-)
