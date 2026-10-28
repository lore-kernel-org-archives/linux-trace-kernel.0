Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196239;
	b=yEkAQjqeqOYg/VQ9e9czIwXlytgyxyIypzqSEpjbcE5fddAJG7vDAyWYW/GUxFTbPo88
	 Z3QKgb8i20gctLqGaTwdyr1PL62QpTIa/tGFT4rTibyKzDWERAoX9ZmrVINROxc4uib2S
	 ODeKyh1PKgQoIlDlG+S55hXifn96vne0ZMW6HycSdCShszt8ImMCl8Ko1xgB5JmSjY4Eu
	 wnVrfGxSQyYZYgSTo9Y+0mPb7QdcCxgKyFZFCDD5ZMbl7nRCsA2isINHUagSeyFU2jD1y
	 o573XsGLN41urroWZUVEknxZd/36GEATHyYlwedGWDEdG8/E14e4+5UCti5URmJxFQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196239;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=FeITB3lTvkD4sD9e7qjlJRHDr/1h1infkSsxqDZY/y8=;
	b=1HLQWH/UNQmNNz09gNB3NghIQ5aK58ISbDKWKP/nzTcFL/crEvAn/TzvcmxZ2Xze4fiC
	 ETAs3XNAVKL6QZ3ltHzHYvflvKpAmnlhVL+hA/bljLIJRGOQlONjWYgQpAaZeOOEC4CUz
	 0rvSKadm5ctBbrV/NAsLCD6W8Tg0zrp7bjKv8IaRhup2NXWCvBFTX6r0pi2xb8cf4aTRl
	 00dZvoljOjvxI0yuv3BJumCrFipm0E3sCm5i/QBZnnRDYNXxtFwPU6VY6w3Me7q5oBL2J
	 1x/3UBCyiPWuD8jW+qSCIkbuqTNnSAUjxacf/W0WMnYVZ5I/tYJQNnSZnaSylrUC7nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=hVOEyjdS;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D00606A31C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 14:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D00606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=hVOEyjdS
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6812E120D1B;
	Wed, 28 Oct 2026 14:03:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id DC5FD20028;
	Wed, 28 Oct 2026 14:03:49 +0000 (UTC)
Date: Wed, 28 Oct 2026 10:03:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/16] tracing/filters: Check for trailing characters
 after newline in filter string
Message-ID: <20261028100348.584836ec@gandalf.local.home>
In-Reply-To: <undine-1793150890261749864-1d389ec021e6edea@undined.local>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
	<179314830681.684037.17927533770192828788.stgit@devnote2>
	<sashiko-outbox-187296@kernel.org>
	<undine-1793150890261749864-1d389ec021e6edea@undined.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xxyci75n75xj4swt458xky36udwp3jx8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: DC5FD20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18BdxyKeneUetF18/88G/lTtKHN+n4EAbE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=FeITB3lTvkD4sD9e7qjlJRHDr/1h1infkSsxqDZY/y8=; b=hVOEyjdS0gMebykgBPPlBr5FUXe38fCEGiiDMRJA5LEgajs+PHvkfLtSkCRylGeJ9Oew30a5j7JW8+0kBPXQZjvoYhgsrUYQWklAOYqRRx2LLDy25Eddw2IRD6j+9T6XLY/BFRPnMkykRM5dQU9mnk7rQY5Nk5ajQ2nDgxF6t4o=
X-HE-Tag: 1793196229-889443
X-HE-Meta: U2FsdGVkX19zLHh/5gyEKm6nnFWAPMhhnrc7/6gnRSgNMBkBNP/unbm//T+Y55PZX0j4Bw5zjfXRToX9NyFn7oyeunyJvSjadMU2HLCAgSTWlwwR3Q1qnqWj/HtXvas2KRt5GfjX77uJPq3Jo0KTizX5uQFPjRY7+vGcuv8GXbfY8kcFQeZCzVvsMGNadNFjVVOXJcX01fXmV8IKVRNqAmKQhKCUBB0UHbeJMfYZscSMLhD2lNJ63Dz5z+ISB8NpQpPuDgZSLYL3PmMtBIjIycUT2pdiL7PB9sDFmdd+4Pf/XRtW9d7/txUcDZfCAGtuTMjinXvyxkjuq5JWmmjtK1ediEMqBzsS

On Wed, 28 Oct 2026 10:28:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hmm, IMHO, there is a bad implementation in __ftrace_set_clr_event_nolock().
> It should make a working copy of the filter string and pass it to
> apply_event_filter(). Or pass the filter string as `const char *`
> so that it is copied in the apply_event_filter() side. The ownership
> of the filter string is not clear here.

I noticed this when I applied the patch.

Yes, the correct solution is to pass in const char *filter to
__ftrace_set_clr_event_nolock() (I was planning on doing this after the
merge window closed). But no, making a copy in
__ftrace_set_clr_event_nolock() is *not* the right solution. There's
nothing in that function that modifies that string to suggest it needs to
make a copy of it.

The correct solution is to pass const char *filter to apply_event_filter()
and have *that* function do the copy. That was my plan to make a patch for.

-- Steve
