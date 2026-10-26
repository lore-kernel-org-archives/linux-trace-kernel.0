Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043618;
	b=ID0MmWXY5XHK5H5wKktKa+0aPOY07umW5DvBNi3UkAKvzbjOGZ7AJrK2Kp9PakIKqzuT
	 AmgjigE6DjsSapzSPkWXnz1ADvESLtX0qnXc0UjIOermF2zuK832WQE+owsfoZyYaiJsz
	 uHzKkCf4S0+KJVcp5DuHEJHDfajjGpDlbNAtNbpVjRT0iSxsUho7xTRqi8Bk4oXwQDWQa
	 zUZekGqyr43oW0yBWH7VhYvSV5CN4oryfWsyBnBSHcNW0z1BO+BrztQWhIMoUMn/QrQUO
	 yqQeJDepFcYy6/x1Rlu21CkWFNpfNvWVoFWxvmeESNYmO0Mqxdsgg1EA8piM+X+B7hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043618;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=PDSSmLHMXxPmsr020cNYPfn2DiyVMYpKQJWU5sCcgVI=;
	b=sfhbTKkwjA81eyvmvteuLMSTd2UOizaoWpoRnIPiPokXvh8+hwAuvSSkoiwEjZBstDe1
	 u0yc4LOUMFAMlADIhMULhemwQXQqZPPIOIDlenuOYDdebh7EPYyEzznxZN2YfNE1j7u+v
	 fRKgXNOhmgqy+umUC5DPzb2ty0J1ca/gyFrMkN4j3/KCFbgSXghcWCCq0DMQ9r4Qcqemq
	 UtneGAcNeLXBwFte7acD7wYJ0dFNtj3H9Rnj3SLAE+TSwTIDcYNq1pqKXtv2biV1mEfGB
	 V0i5TB0SPH0N/N5Rws3DszkO66aJbti1i+/v6QhAGj3kL8onSYFF/gwSJD8jy+X+Bxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=WPAztoNj;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DD606A323;
	Mon, 26 Oct 2026 19:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 238DD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=WPAztoNj
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 92A2F12086C;
	Mon, 26 Oct 2026 19:40:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id C819530;
	Mon, 26 Oct 2026 19:40:14 +0000 (UTC)
Date: Mon, 26 Oct 2026 15:40:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/10] tracing/filters: Report parse error on all
 -EINVAL paths in filter parsing
Message-ID: <20261026154013.70598e93@gandalf.local.home>
In-Reply-To: <179285917054.466249.6580828464905931113.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
	<179285917054.466249.6580828464905931113.stgit@devnote2>
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
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C819530
X-Stat-Signature: t535pa9wd76h3n86eyxcn4rzkkey1t7a
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19YiGV4EBQ5XP13rbOy1E7Ps+GBvY4AkRc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PDSSmLHMXxPmsr020cNYPfn2DiyVMYpKQJWU5sCcgVI=; b=WPAztoNjx8vMNtls979Kw0suFaB2zq6UH8tvWDM0CAvcO5Krl77xi8/mWbY3wLCDMJ1/N7g6UOI8Cn+IcrHNR9zXyiefTSywRIARI9oo+8OCkbsY3MJmbtox8WcG/TSMdrUeJoxw8oTpTOFgknlbsHJT8OyOdf74L0RcqzPN4dw=
X-HE-Tag: 1793043614-289953
X-HE-Meta: U2FsdGVkX1+3ZfLJviU9nB/ZePQ1z0a6jeiLj7EamLjwX/KNZrOsaSsWrAQsuLA1S7wS8v397/XtftFLzIVz6WcL+R9WOhkhfLoTW1QmN/RTTFKiUcLnA1vO0N5gJ+oMrwsC5Z1Pff0Hx6QBdOG5frr4UPhv9TLF+fiairIEmfVuLWDT7aGSV+be1dEgprsXY5bSttXKE4ipmKZ+xH9rpm5VXGT1UR6Zkzw/oSWmmQEPMtpo/lth0IFV2pxONTl+bDslLaEvUhYVwwQO5Se8UVM0vHbO2Ubzx+dwYUM8hMh03ABX00HkbUMteh0xcvQJDt7lqD0QHmKiuEWESh3k3lS5mbqcL5T8

On Sun, 25 Oct 2026 01:26:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Several error paths in filter parsing return -EINVAL (or -1) without
> calling parse_error() to set pe->lasterr:
> 
> 1. In parse_pred(), when an invalid token is encountered where a field name
>    is expected (e.g., "common_pid == 1 || (common_pid == 2 && )"), len is 0
>    and it returns -1 without calling parse_error().
> 2. In process_preds(), when !nr_preds (e.g., empty or whitespace-only
>    filter), it returns -EINVAL before predicate_parse() can set
>    FILT_ERR_NO_FILTER.
> 3. In predicate_parse(), when op_stack overflows or the jump target check
>    fails, it returns -EINVAL without calling parse_error().
> 
> Because pe->lasterr remains 0 on these paths, append_filter_err() falls
> back to printing an uninformative "Error: (0)" instead of reporting the
> diagnostic and error position.
> 
> Call parse_error() with the appropriate error code on all of these paths.
> 
> Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

This is more of a cleanup than fixes. You can keep the "fixes" tag but
remove the stable. It's not that important to backport. Sure, the stable
folks may backport it anyway, but I use the stable tag for what I feel is
important to backport.

-- Steve
