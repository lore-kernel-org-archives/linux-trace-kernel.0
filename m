Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63F334C3D;
	Tue,  2 Jun 2026 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430596; cv=none; b=ZuD/ZRK8lBVG65eRisfRs68pi97KVVmUDD7GlVgJMuDzMgmlk8/duHNQQOhZOtQK6+y1ytpBAn8JTPuT+pPQyUdF7FlZQHENWFmdTCLaJP3TA5K2SSpefNi6IAgUTG7ox27ihQ2o/FDkWf1xeeoYZgeCnWhuKFIEFku86PFLdow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430596; c=relaxed/simple;
	bh=TFAiqmbHyliLM70LrVPZuqFMdE3EdUnuxHG1Am3kwvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8YVI6+bhsFyx+2qk7ggISLXRZLF7zyLMD9QeLkDIyOVKXGsVPoQJRwXZB2htkm1CXyLDK3GK161kpD3o4GsszRNL62SXqfELLiSq9W5HQdjIebHXVFIWRqAtU6/XYeqjrUieHq9ardGrwh8HojNrMxy/7UVVj11lFsNhnEMl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 607251C0114;
	Tue,  2 Jun 2026 20:03:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 990C620011;
	Tue,  2 Jun 2026 20:03:05 +0000 (UTC)
Date: Tue, 2 Jun 2026 16:03:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sam Moelius <sam.moelius@trailofbits.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Reject tracefs buffer size values that
 overflow bytes
Message-ID: <20260602160304.0b1f2b81@fedora>
In-Reply-To: <20260602184335.1554470-1-sam.moelius@trailofbits.com>
References: <20260602184335.1554470-1-sam.moelius@trailofbits.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 990C620011
X-Rspamd-Server: rspamout01
X-Stat-Signature: 1joiikxsjxsiqg3icz3r5kzi6e8q3ozx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+oQ7PDkjBUGvAMUjfphLMKOx8fC8So9nE=
X-HE-Tag: 1780430585-374936
X-HE-Meta: U2FsdGVkX1+3FzYToPDTmDx9dyevbaqkaS3K6jHjo8E956Lg7PuIRIyQ05S6GtQMHzPjtYrCh18Oopmv/9wPMepEtPVjlfHRA8nOJVh1tuTGDmqTRRCySvICwLihMKcIBB+yv5PROfSkt1xJTlBJrbRSxd0Ps7ewAezsIBOUyqXUYbC2RmBxoiGGyXx740jEgX2B2JOUPcnxJeBrD6PX2PHupmAVtMk+eAP8Ctj78SzuhBHlbScB0CL9y9pspmvA4xRBww1UZxq5mVmBXHeZ2tqYKask+VsjEt81CcKWXWDU+ejlWd05p/yJSd4pEmEZXIEOCtadrAq6T1083dMP304YfztHNSyewkmn7JYcuHUp3BWY6eWMeKFEFqTO1qqv

On Tue,  2 Jun 2026 18:43:34 +0000
Sam Moelius <sam.moelius@trailofbits.com> wrote:

> From: Samuel Moelius <sam.moelius@trailofbits.com>
> 
> `tracing_entries_write()` accepts a `buffer_size_kb` value as
> `unsigned long`, checks only for zero, then shifts left by 10. On
> 64-bit, writing `18014398509481984` KB wraps the byte count to zero
> and the ring buffer resize path accepts it as a tiny buffer instead
> of rejecting an impossible huge size.
> 
> The fix also adds the same pre-scale overflow check to
> `buffer_subbuf_size_write()`.

Honestly, enter stupid values, get stupid results.

I don't think this is necessary. Nothing breaks but the person may get
confused by being confused by the confusing entries they make.

-- Steve
