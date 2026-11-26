Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657649;
	b=XNAV5zjiS84bdoZkWG1EWROOlJhUh+uuZuxMMpgBsboquPVrZY653JmRedWAg7HD+/or
	 AlQQm1R4CDlaxcrOEUfLgfr7LlFhgv29V0vy2Enic/OMklLNRj7WhuRWJbbp5LTP2u6JI
	 0fRUTFAoD69rgG3tsiEI0D6L04eDjtMx8FkImRCIyPJIZAFoy4qAK/FReKpPQWAuVFTJu
	 qNtyWMaqUfyYst85R9pT40kFzLOhEpRM26nvPd09zzuFtUc4VMyfhVJM43h96bK74I4hK
	 1joTUat/BMzy02rJ1EHJjjYl8IgHfanMogS+XfS1qHiV08Jrs3B6ttgIovOuoGYXhYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657649;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=9pSoGA0FKgybkC+5W6ehrJyA9Ds4tlrBQ8bhP15p+dQ=;
	b=thmo9gArJEJN1128ezDBv2NESr35aJ5ovAQZPRMBd3N4AdTLAK/6TaON2eAZ4jmsxMDE
	 U+Yfkgw3l6rlkSHn/6D2yjtNPOl7qukZ0YKFl6PRxdyBpcS5qhVVGd8Ge++HeAzZsM7zt
	 IIgQrSXo4Z6W8xLIhx4jW6+LGwKEHEyJLK5/kkBoonEKqrRrZ2iXyCKEuMn6pg3sgLEBw
	 MgY1IROjDMmgqc3CtBDyZV+9aYHHPu7f6OzxdtDazjOw2YstNaz81Ko3Pq1W9PWD8tOOz
	 WGXCjvBd/7+74HhcTprkWJL32gLyBbhgd0Maidkg1wx5W/27Z0Oa+L3r3SR6JNcUKyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=3U+fUPGX;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768E606A31E;
	Thu, 26 Nov 2026 01:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1768E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=3U+fUPGX
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B50748022B;
	Thu, 26 Nov 2026 01:47:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id E65A32E;
	Thu, 26 Nov 2026 01:47:18 +0000 (UTC)
Date: Wed, 25 Nov 2026 20:47:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 15/15] selftests/ftrace: Add event filter syntax
 check test case
Message-ID: <20261125204717.260e01cf@robin>
In-Reply-To: <179323798449.740114.5416715723328926616.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
	<179323798449.740114.5416715723328926616.stgit@devnote2>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Queue-Id: E65A32E
X-Stat-Signature: ygsi43z5rtkjdzb85kmbigep5k6wsaok
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/5kGPTTv1YJg3M6gt8AiU2JDJeCpz1o5o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=9pSoGA0FKgybkC+5W6ehrJyA9Ds4tlrBQ8bhP15p+dQ=; b=3U+fUPGXCzdyI64OMpciwBcG2RNdKBY1QGL117mH41t8WD8ZoeQ/XVrQ6EKQEIiJAAXRt5daMcNmyG49RM86F9PMwQa3m/sgCCHfLHa1iaqA3GVr8NPz4zQ6EO5f2UzjV61DQ9A74A6nMsd2n5EQMw0DvoihVSlbpGwEx4D0a/c=
X-HE-Tag: 1795657638-91179
X-HE-Meta: U2FsdGVkX18elQPnQSUv2kb8GzgfKs6fS5Buo1kblyqjOj9sqyvJxe9FRvcC9xTZE+ytheo29FGZVZ1OtR+opo0QsONjPz1VB46k2bnFGMuyyJ56v4NOIGbs94cnDaJvOK732I7oURcRRA7IWVi8NGkhchoMg6aH6MOgCcw/ZoGZWYQrqgjoN6H3M3A1Vz893aJHI/fGJt6IBfh7s/xYKQi86W5S/hT9ddk1RmLPOHS5xuaLLx93A7btEjlfNTleTzzrDsr0qbUePF1oL1/J/AfIeIzLso2ZrRVeLf0SvuwkbGLmgVf8cko6iMNfnWhrt86QpsOPMseu9aDA4CeUkDOUJyMGA1gW3HCWmGQTf39WcXCetMfcuA==

On Thu, 29 Oct 2026 10:39:44 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a new ftracetest test case (filter-syntax-check.tc) to verify valid
> event filter expressions, error_log caret reporting for malformed filter
> expressions (empty filters, missing fields, unbalanced parentheses and
> quotes, dangling logical operators, invalid fields/values/cpulists),
> newline truncation on multi-line filter input, and error returns on
> invalid subsystem filters.
> 

I added this and it fails on a kernel with this series, so I'm removing it.

-- Steve
