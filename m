Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711508;
	b=O7KCZXfxoPN486MIhNzgRievCIS86R8aC6XTcSOIAUFQf23fCu033UVUKe0QRxH/OHdA
	 RmofH0P0FicGny8c2FxoYb0NJ/5OqPfDPrCSqSZHq7JlnHQ/FjctcDgaU+chRVh60az8E
	 /VlzYZMDtHiO5KDhJ+Y1wRjg6V/aBU+ZYQDuvKK7IhqzalMJ5vuvkqSGiUuHILxAm7qRz
	 +2hax1uMLfO5hY/m4HssZJ+d6JGieomOCyLqrjW9FHBBhsiw0tuWNL/ydiQmMV+tOG17D
	 XvXHc7auMe/mFgCW2Yhh/AsI1emPoSpgS+ekgZZZgDof1HOE/10+mzgKCu69hpoB0rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711508;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9I/T+92mCLwDcxVPvY9ymibgn2vAE+XoIf4s6heQ4Yo=;
	b=v31zlnpvJXurKj7IXB/TlP5OEMckTob6J1XJsOU5nbVGG6EDh0hXWxDfLKHBocOBN5lJ
	 e/y2HSpJ3bF2eIUBpftdw+pSnQngQ75Ipr0mZ5UXKwh1PYGsX9mBW+jMS45W/XiYSlUQS
	 MgA5qWHJPRz+IhIfdXqMz08Uvgb3JU7T8XHP8/2ZZHq8y8FtLSFw7/4yXB5Hc/pir83f+
	 8rRkihEpaciy67FiKGF/rYm25DbJfW6xeFqkEE4frD5yr4Ga6QNeso4F4CA5Wl9ALHF4H
	 kQ8pfrv04hEyhgQc5Y0k5fcq0QhsgAmnl2nQnvLIkbzOYPycpynpxAL3KOdPzMKDYow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=iDmvkSWG;
	arc=none smtp.remote-ip=109.224.244.18
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89D606A32C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 13:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC89D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=iDmvkSWG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793711505; x=1793970705;
	bh=9I/T+92mCLwDcxVPvY9ymibgn2vAE+XoIf4s6heQ4Yo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iDmvkSWGbSebbNb9mhsLVC1l/jj/+uS4ymaqM2PH6fAAHic5vvEi3Mal1CzA6OuWU
	 xwjy/ivmLILlwYWrZUQblXNyrwRxUaXMloE0YTTfFltKuE7EOvZM0vXtsX1cFpmc00
	 kXg6aSWpF5t+tf3Xgl+xZeJ2tTcvI5RJjfTTuMWreriEdhp8vPzcjmIiSq3QZ2RzHY
	 pgP3jXhu2XQ+PQrN8GcTtP4Sb7LjArWKkFvWqIftgd0d+5RQUAZT/iOAFRU7diDM5A
	 I/A5SFrGOHc/NGeNrm53RURSX/R4X/nnnkYw7fy1WxMnE1R474SHShTmc6frDV+Z6x
	 LuL4koGpppLgg==
Date: Tue, 03 Nov 2026 13:11:41 +0000
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Francesco Nigro <nigro.fra@gmail.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH 0/2] perf: Fix PERF_EVENT_IOC_REFRESH for tracepoints and breakpoints
Message-ID: <20261103131138.765683-1-paolobertinetti200f4@proton.me>
Feedback-ID: 117280896:user:proton
X-Pm-Message-ID: dc2625a0a475188b0f73b308ee07082819d821a4
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series went out twice by mistake. Please ignore this copy and
reply to the first one:

https://lore.kernel.org/r/20261103130732.764081-1-paolobertinetti200f4@prot=
on.me/

Sorry for the noise.

Paolo

