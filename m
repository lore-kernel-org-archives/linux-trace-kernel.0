Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960866;
	b=j7l524gcmEUFW9CEl+IzeqDN+IKSav036a7zCzebNcgHj2MDO3pfCJVXjRdAOEoTej/y
	 8vCc02vH7qggBGHyIntjcxPl3Az/rf+TiI5yk8CjHrqyZvc99iG5Xdc2rJQz2H8UT8g6t
	 NwMWmIdMTO2ju7DeshxKfggxoXVA+ABhND/gHChKqPezlao7VqYC/jziNB1iWHOCtOstT
	 8eeb730WTSh3mdM3OZ3H+/qT5qBB5GhgV7+mpR/BwOh9jiMWzmXHVkTZnv3/eL/ZmdM2w
	 f3oMW62lIBfG/Z7wLgpqeW+JHxRelQRayuk9WKZ9oT/IaiX9IYjYKYmPpyIEUAEA5YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960866;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=TFcxM17CmPlOTx5Urg6Gr4ksMavPG1x2HB79v3ZHR44=;
	b=lQiJVnkzGR/EjhbyFaAVa2wlcHd49XUdTHOd1A4qFEn82OvwGE6+F8mhUk0j3GH0XOWR
	 dW7qzmdOND+ya5f67yo0WnnjUcNMs1V3Oa5QeOoEEzAdvcqtIpdP1fkzzihHx2w3bxGTg
	 Qpo/9FA+vHEIGuYQOVlYQ9zCyNJIORA9H/159QzVH21zKPRqCEiezW0JVuQ7cT3mrDK1z
	 zMmzoVzhUDaXWpVbiNrReiDrZwktGbLD8v44K0TspCv+vu4YCyPlnUbyfBEZn/TPlsw2p
	 Ml+YmAxuq2eAk9rxRNSi+gb/tUF+GYGqixLe7S9tRSLXW0+zVHRVhvGISbXjeHhb44Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=EjyUm3M+;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9B606A31C;
	Wed, 18 Nov 2026 00:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2E9B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=EjyUm3M+
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 527361605C1;
	Wed, 18 Nov 2026 00:14:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 8FE8620031;
	Wed, 18 Nov 2026 00:14:22 +0000 (UTC)
Date: Tue, 17 Nov 2026 19:14:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 06/15] tracing/filters: Fix quoted operand parsing in
 function event filter
Message-ID: <20261117191421.41cc174c@gandalf.local.home>
In-Reply-To: <179323790096.740114.15868280894145147902.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
	<179323790096.740114.15868280894145147902.stgit@devnote2>
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
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8FE8620031
X-Stat-Signature: b86dbrj1nnfigzqpqrp6k8czzxsa4wpo
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19d/wRQ0Vm1jSTMkE5sNCqaG0sUArxinoE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=TFcxM17CmPlOTx5Urg6Gr4ksMavPG1x2HB79v3ZHR44=; b=EjyUm3M+hLK8SOHg+jhaLPTz7FcKFpylM/e1N1YihbBdXbHlbZmbV34DISsl3umsxC0XN4vdncVJXiV/gH3yzkcdbHl7PnDo92WnQNywvTDLR2bsd+Mk8QfHBXUaiafILlFnDEVi7vmZ7a53nyKMXrYq7M8Cc6GVY+O41qTPpwQ=
X-HE-Tag: 1794960862-465448
X-HE-Meta: U2FsdGVkX1+OYMbhZiYD5feZTudFWsKo0eYqiMnr6MyrNEHdPlwcDosMqO5jc7y3y47MjNfKN3Zn6MkcJQj3bVTc12RStvEwKKqkDnPtpxJqv3BUAUkdofKYEX3lJtF/cs0nItBaQABKicqS9nPD/W10W3aLGMshWiQMkBzbh+QGNfpLU2QdJbVGJeRDnPmpYinpEw3WRfeLBAYc5doDGEQeg2+uU/F2cMmLK5YFDsmvVxt72Hnd0CwHpoTEundSBufQOenYgAt376bu8ILspjoPpcmkgN0fiBlvPph7mH2DcEqkHPkCgSnCkNd7tBeWMSTmFBnY42WY0YKcnbwCS+LcTeps3BN7

On Thu, 29 Oct 2026 10:38:21 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In parse_pred(), when parsing a quoted operand for function events (e.g.
> ip == "schedule"):
> 1. The loop 'for (i++; str[i]; i++)' breaks when str[i] matches the
>    closing quote, but 'i' is never incremented past the closing quote.
>    As a result, parse_pred() returns 'i' pointing at the closing quote,
>    causing the caller predicate_parse() to immediately re-parse the
>    closing quote as the start of the next token and fail with
>    FILT_ERR_TOO_MANY_PREDS.
> 2. If the closing quote is missing (e.g. ip == "schedule), the loop stops
>    at the NUL terminator without reporting an error.
> 3. The loop started with 'i++', which was intended to skip the opening
>    quote, but also unconditionally skipped the first character of unquoted
>    function operands.

Can you show actual examples of setting filters that fail with the above
issues. Something I can test and see that what was fixed, and that it was
indeed fixed.

Thanks,

-- Steve
