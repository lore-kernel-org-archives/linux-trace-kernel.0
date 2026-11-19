Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119553;
	b=vYPg9Woa2bD6nKYiONP53IpnlPa7biDKkncZPrOoDHINBnWQOjGCNCMF4OMyw5xC7N7x
	 oFZeA0fRJgxjYwUg7+QgogQQX7+gRx3zPVA5+b4VMjNZdfXOyOMYhmakhtGX+4qPWKUGs
	 qC4GSM3m8d+UgpKYMCDuduLVYM6OYVhSE8zMFqj7K0cmp+SVZqoafdul7yOaCNl8wTWYZ
	 WfIt7gp7yG5PPsZ9l4SD196WZ7ND4DY+JTc6PQLniaHFoMWR/5hRB0kb1ZX/KTCAaoTgz
	 9VR+5ux2IluIi8gmavdrzP9nnYYAAgBgrSr7Txjym/ANVOmnRJTA/uucILL867nk8Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119553;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=LI5H2Ayqlfdi0QAop46uAHg65RMj1BeBk5KVNpL+B1k=;
	b=uCA2AMxJRt+Qe3SJVV9UM73n73KS41ZGDxZ0Jc1MW1hI3BEU4Nn+QQqkVWCBhr++Z3zq
	 9wgPVTde1AmwzWRLT4F/ekCXnDfz66MXns01przB9PMAbhxe+shyh5HkeAfLAe+KuwNjm
	 2mbcYfjeT83B/GPLMVXN6oljF2L9YXhZspaNIe0Q/+yhVsTLHsCOA35SXoTlBkjMh8JXT
	 iMH6DlfFKpvaGrI4E9oM4qhv8rSXFfteJeva7T8IcvOUzW61bSXV0RcuE0xYb/o9rinzF
	 qsTjk3im88poPhsGxchoJZz9du3c3cnOu0z0XNyr3wnrO1ZXXOcsPnk4TG5axpS1JSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=HRY11z7g;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCE606A9D3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 20:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05DCE606A9D3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=HRY11z7g
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id DCB1BA04D7;
	Thu, 19 Nov 2026 20:19:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 40C0320025;
	Thu, 19 Nov 2026 20:19:03 +0000 (UTC)
Date: Thu, 19 Nov 2026 15:19:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dominik Maier <dmnk@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 dmnk+artist@google.com
Subject: Re: [PATCH] tracing: check kallsyms_show_value() for numeric
 addresses in .function filter
Message-ID: <20261119151901.7488cf38@gandalf.local.home>
In-Reply-To: <20261119192233.2664654-1-dmnk@google.com>
References: <20261119192233.2664654-1-dmnk@google.com>
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
X-Rspamd-Queue-Id: 40C0320025
X-Stat-Signature: 58mqq5gbsgkqd3tag7m3nu6xhaoje3k5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/YyCRVQua6bIkUGnkBP8cAzLNEYGgFNwQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=LI5H2Ayqlfdi0QAop46uAHg65RMj1BeBk5KVNpL+B1k=; b=HRY11z7g1gtE93KLAT4yyjV1uTpsq/vzHprmX3nx3jh/FjeMd+Oep7k63dDNRy+QOQxSSbuS6OlF9RZNXpDVeAhhR65llVbUrMvBaYNvSavrkt5QXiN3ssBNUkWYA5/oIh94Eo8ZXb+TDufXr8qjPf0NStMYOZVQcjlo48hdFEI=
X-HE-Tag: 1795119543-913082
X-HE-Meta: U2FsdGVkX18oHeYvd4ySGZOuMHygJ0l1T3yT2YAE84KskCXGmmoP9rqa35tZXHiUqzRa7ThrfnybLS5ByDYCBxT4XsOTzZ6XUKz/gMs0ytb8vSzlahnu3KkNRjTOO3gSRD6kxe9/p8VeE7fsgoLMZ3eoeeJOP/y88s4TRNQNo75P/Uamu1mqCLD4JYZ3HeolVbkAVIzRRwSNzTQlidHKTZfhYiprkj2vHgZ8LDpncPbbXM9E7V0mBbEwN3zuW5aENANTlP3y3Xu6OdNs8uqMeL9F6L8Id/09iuXDJlha6MY+ZLY0w3b1brcERbtxJ9m5jsmzENgTBLHTlVvC7QciNxnX5mB0g0Ld

On Thu, 19 Nov 2026 20:22:33 +0100
Dominik Maier <dmnk@google.com> wrote:

> In parse_pred(), the .function filter modifier accepts either a symbol
> name or a raw numeric kernel address (such as 0xffffffff81000000) and
> resolves it through kallsyms_lookup_size_offset().
> 
> While tracefs defaults to mode 0700, task-scoped counting tracepoint
> events can be opened via perf_event_open() under default
> perf_event_paranoid = 2 and configured via PERF_EVENT_IOC_SET_FILTER.
> Allowing raw numeric addresses in .function predicates without checking
> kallsyms_show_value(current_cred()) lets callers without kallsyms
> address visibility test whether candidate kernel addresses fall within a
> valid symbol despite kptr_restrict.

God I HATE AI!!!

This is a perf bug, it needs to be solved in the perf code. How many times
do I need to keep telling people with AI bots this! I think you are the
third person to send the same patch.

The filter logic can expose kernel addresses. If perf isn't allowed to have
access to that, then it shouldn't be allowed to filter.

-- Steve

