Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547266;
	b=CsJYGf6G/UAyvI2AsZmodzJg9LzEwJzF5AWSNUI2/LAgWWiZ1YqTmtaSTFDABXHLNjKc
	 T191bKGtfFg0GOqvIJTyTOwXtG3LeDCrA9YS6tclga37qLcl8vDk+/T8jjFYROmQrJQru
	 9dJE/CRkjUi00+IvwSvGVDL1NExP7lT/w2f9vbdRgWiBUmGF5TK4qlXcZusSfoltvkUZc
	 n2/5RlVahEnMsXsqBxA1Pp/7RDrGENsCX5vohBCfuVWWVJCkBleLygW9liFSE5pAJ+OZg
	 DcvXBsJiOdAzxq9F0SD8UPEb9mPOS2ttVztoz6JfeFbzQskeyn/Ncejkszrj3hLVp+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547266;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=2hvsQ2s+JmeC1O4RxfSoWmDQJ01X3ndusdsZNhaRzvY=;
	b=xjA9PC7XW3NtjtYoPrxz5kxZnQbw/1b+AmSi0PQf3o8prZh+fWCy1Mwqw9IbAMxjZxeF
	 3zzI1rjdaEU7OpO4ItYikOebRon0Efo1V/AOBYeLCSP/XpQTzMtUN/ztjA07ciWmQ0RZV
	 BVgzPLgd8st6uZKHubC0lmlrY1atmiWDX/kF60UGOyjDFuQbaHsN40lz6s7sOYf49mujI
	 uN0B9AfNRwL2cKBVTDEFmKNz5Up5embu+PIny9Pq4xD/bKO7sMhezDW3lTfN/npo5yW/S
	 q5X+FBO6hT8Ri6R4Xls5gZPDvk8tEkm/wnJLYJyLdRVa2Nw+I8C15iUQrYWmvd8fYSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="Zluu/EFq";
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59FC606A31E;
	Tue, 24 Nov 2026 19:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D59FC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Zluu/EFq
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5886D120C6D;
	Tue, 24 Nov 2026 19:07:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 6DD3F2002C;
	Tue, 24 Nov 2026 19:07:36 +0000 (UTC)
Date: Tue, 24 Nov 2026 14:07:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 06/15] tracing/filters: Fix quoted operand parsing in
 function event filter
Message-ID: <20261124140734.65f7c57b@gandalf.local.home>
In-Reply-To: <undine-1795048701823215055-2066a0c9c680e81e@undined.local>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
	<179323790096.740114.15868280894145147902.stgit@devnote2>
	<20261117191421.41cc174c@gandalf.local.home>
	<undine-1795048701823215055-2066a0c9c680e81e@undined.local>
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
X-Rspamd-Queue-Id: 6DD3F2002C
X-Stat-Signature: 3id4qze1yjbq3obs73j4y9abjcbq1fjb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+9ezuQCN/o8BTizhDxixwXOI4E2GMTmIk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2hvsQ2s+JmeC1O4RxfSoWmDQJ01X3ndusdsZNhaRzvY=; b=Zluu/EFqYtHqV5wzct1naS2/mEzCIHVhbu1tHeC/p8mC33K35lehvDD1lCDfGsko+oqVOuaSgK2s0dsP+2CtK5JXCob8uobwKyJ4u15sZRJO7/EKF0dUgTi2CLTHZykSDeHbThj4IGZx2mWvDsSb6ogy6EL9nunyJ8BQ4uNs3U8=
X-HE-Tag: 1795547256-243944
X-HE-Meta: U2FsdGVkX1934XH8xZfhz4L4nUsjadgjpkAUamuTs242LvDIVzh1fabQxko9Qa++ADtWxWti05M1VvYcyzbpNyGNdxl4tqULsDc9w09mHeZ1KTjTHj7FZN0x2urS1FHGncinqe3MNYDvCCSiEI723XBOBZh5ESdzSCvD4HcTPxjvxd2/9+gWcADUz0FI4c4zb7jSchJWnKN2wF7rS8etiW4OT3hq8sGgFnE+Ax889NzGZdxhLdqA3v0AvHNeQu1rOLRlnjJZD7W/MHcnlblZvXm7AudkfBEvRBLycOVB+hW8OxNw5+fMydzbvkeJnUvEf1w815aDkykx3E+Avtg+aSEQuyWmEm63

On Thu, 19 Nov 2026 09:38:21 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> For this issue, we need to use "perf record" to reproduce it. It seems
> that expected behavior [1], only perf can set filter to
> ftrace:funtion event. From the tracefs, ftrace:function event does
> not have filter .
> 
> /sys/kernel/tracing # ls events/ftrace/function/
> format  hist    id
> 
> But perf (perf_event_open + ioctl(PERF_EVENT_IOC_SET_FILTER)) can
> set the filter to ftrace:function event e.g.
> 
> perf record -e ftrace:function --filter 'ip == "schedule"' -a -- sleep 1
> 
> This should succeed, but it fails without this patch because parse_pred()
> stops at the closing "(double quote). 
> 
> failed to set filter "ip == "schedule"" on event ftrace:function: Operation not permitted
> 
> With this patch, the perf succeeds to run.

Ah this is filter logic that can only be hit by perf. That's because it
does magic to have the function event's ip field to be automatically
treated as functions.

OK.

-- Steve
