Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E166176238;
	Thu, 28 May 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981980; cv=none; b=AXRLQHMHyTe7yHB9R0e/KVB/HKhEpnes06g2HSO73r6KYLyKWGs8CdcjV18KByGvBTD1DLPkXnBh3tnSh5HCxz0LfmLWk3eQQ4YuO6D3KZP90i9W/01qQkezraZpZcbntx74uWWQ/0FOaNTpMsW9h24G7MawcvJJESVlBvyirKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981980; c=relaxed/simple;
	bh=+o2Hc8YeeZk2OBqSunVLK3ZlXkUhRWzRlHpCULCXVdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWAL9rKSQuYcN5QxyIQ3+xubI88NGmZps7BrDLwprrXznh9g1NWFNwrq8eTHA8SD/PY/3cQQ5FCL2V8eQy7nBw5dmnC0HS/IZ0Xn+u70pTQ5p0ItYi4d1j9Z4JcJK5dvneGnHr2vLNSLZOU29wsPK+0UADCzuu6hJuZ4g6l6Rn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVNHS9UY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVNHS9UY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DA51F000E9;
	Thu, 28 May 2026 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981980;
	bh=y13gZBrauZClI/LnpHzESdSsqoIHcU/xV/nHk5Mpz5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cVNHS9UYkjGJJzzdl4OOBaUP6bf5Zkw2asBjB/Uxa39MU0sgC7cKyonji21HjS+kV
	 0yeZdiIK0Nh8ddG3nIbGsGk+WjUC2oc1tCScvIs07Hiik6gYVIFqcfcQknkNP0u+4d
	 KPheS7O3g0rV2sudgQkwytpAuEHtYAHy7pf18oDz5CnZlGPeefnwXAPFQTnB+DR8Rr
	 /TbKUO5d58MiVD/c90ClFugRWcsnYPz3Z/pjG+XOgmc/IOMq8Hn+FUqldMZUwU5QE1
	 oIiKNM6lxq6TpIyTEvytzy8vCQ5sMgxon3U8Vchl4YYs1nc23xCI85MyyQP1mcTrp1
	 xANMevd0QaLzA==
Date: Thu, 28 May 2026 11:26:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v21 8/9] ring-buffer: Show persistent buffer dropped
 events in trace file
Message-ID: <20260528112655.0b71b71f@gandalf.local.home>
In-Reply-To: <20260529001500.14178455a046a5cbc6180861@kernel.org>
References: <20260522170857.263969486@kernel.org>
	<20260522171052.006276604@kernel.org>
	<20260526140609.28faf45d9d347e5d748e7cf1@kernel.org>
	<20260526134116.11e1db99@gandalf.local.home>
	<20260527124721.d05102c2f45e6c5bb5fbe476@kernel.org>
	<20260527093507.00ac35d8@gandalf.local.home>
	<20260529001500.14178455a046a5cbc6180861@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 00:15:00 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Yeah, the relationship between the persistent ring buffer (which is mapped)
> and the RB_MISSED_EVENTS is a bit unclear.

I'm going to pull these patches into the ring-buffer for-next branch and
start testing it. If they pass, I'll push them up to the linux-trace repo.

I'll send out this patch on top of it.

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 910f6b3adf74..5de6f352249a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1929,6 +1929,12 @@ static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
 	 */
 	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
 		local_set(&bpage->entries, 0);
+		/*
+		 * Note, the RB_MISSED_EVENTS is only set inside the main write
+		 * buffer by this verification logic. The normal ring buffer
+		 * has this bit set when the page is read and passed to the
+		 * consumers.
+		 */
 		local_set(&dpage->commit, RB_MISSED_EVENTS);
 		dpage->time_stamp = prev_ts ? prev_ts : next_ts;
 		ret = -1;
@@ -7232,6 +7238,14 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 			local_add(RB_MISSED_STORED, &dpage->commit);
 			size += sizeof(missed_events);
 		}
+		/*
+		 * Note, for the persistent ring buffer, the RB_MISSED_EVENTS
+		 * may have been set in the main buffer via the verification code.
+		 * But here, dpage is a copy of that page and has not yet had
+		 * the RB_MISSED_EVENTS set. As for the normal buffers,
+		 * the main write buffer does not set these bits and it needs
+		 * to be set here.
+		 */
 		local_add(RB_MISSED_EVENTS, &dpage->commit);
 	}
 


-- Steve
