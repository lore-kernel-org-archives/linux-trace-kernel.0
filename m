Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043532;
	b=2j8lScdmTmODhSd4OgsJPM68cc79d9Y7D61G5mZec4V2T+iaeqqj1B9v2D8BEExSPPSY
	 GVN9nw4WljXq9Fz0BnbZ+a+ut3emng6JIN6P61CmIxonr3Se4D7+0ZkbA7+wvPDp1AAF1
	 VD1AUo/91YnFY2XqwzaFcp1RosCTA3GUsjlj0N3+L4up1GbJnHs28QVJ8WqCuELQ/g9R9
	 u9iCW7UBDO/C/f6v8GKeUmGhK8KQxIBNh0LCnT4KZw/+mJJNCUnBMJcjoD9Q0v8xBJ1/F
	 3X0iSLHgw7k2DBTbGa/jLJkZYjPjN9a6YKDQU1zxsHt1Qkbc3lT1PvKpcWnqpvuce2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043532;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=IG6lC5VmLeqP65oSAtdAx1VbFAtk7d9g8bHTWsFni2o=;
	b=2Iy4pKuUXqn95FV7or6f7v+vzs96GbSQAUbcPt7KG4ldSFU0vd63Mv+YEzf1B7hTf2Oj
	 BVEmXHM02PTdToUS518HLz1Xx8VkLXnp6aU17/21mhwfjdiUjNdAY4CPU1PahvtFW0WAb
	 O7+b/nhvt2HTfMyZnD8rrNBXoiweIBvu8WR1X4qBV9aLpr0KpC4Tv4hwKVnYncbL6zeXw
	 0Hb8HeOjDqU3vavLaHGWD0BHTcJsiuKY1uIu8elXvI4o9UHWg9lBUrBLucYhynkX01cOD
	 vaPJ4mbV1+5uC8NjrgECo8OtpJZKf6QPvTp7BPR9hqPvPSQ8/jQEkyt6AzTgHqwJJIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ozFpx+Tn;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60A606A31A;
	Mon, 26 Oct 2026 19:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D60A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ozFpx+Tn
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 97AC3120860;
	Mon, 26 Oct 2026 19:38:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id B9CF420013;
	Mon, 26 Oct 2026 19:38:47 +0000 (UTC)
Date: Mon, 26 Oct 2026 15:38:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/10] tracing/filters: Handle out-of-range CPU for
 OP_NE in cpumask comparison
Message-ID: <20261026153846.672c760e@gandalf.local.home>
In-Reply-To: <179285916115.466249.16061782430177051612.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
	<179285916115.466249.16061782430177051612.stgit@devnote2>
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
X-Rspamd-Server: rspamout06
X-Stat-Signature: 64t3e63arizw83rcbc5fx5s75m9wrc9d
X-Rspamd-Queue-Id: B9CF420013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18EbIdT0THeRj4MNb530kbySwriKu0IMtI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=IG6lC5VmLeqP65oSAtdAx1VbFAtk7d9g8bHTWsFni2o=; b=ozFpx+Tn95HddNuk6ZaCvSoh43etYOsqebLGMZVg+4agvzInce5r/nN7WfNVJGS5YVwUsoaDPKt4HAmaTQEkT8mVvOqJiWRRAbfXTOK0fSyMzdW4R0mbLTZEoyAQBb0UBHsxizGeOVJVR7P3fE/SjoNAkRz8H1Fyjiot3sZ4Ang=
X-HE-Tag: 1793043527-359451
X-HE-Meta: U2FsdGVkX1+ADCmTBohVlg/PkjfzLah0vItZkBRMDzproUuHADahppCw+HPRpzy8Pm2UEfwxrBq90944zVeIRbrEHo/EIu0ZiX/NMwYwNtDngv4XlcUzI7JZpfSgLTmpiT3xwMdsmhThdD5OEJ0Xo2ocg8IPTNxPr2Q0P35Ot86ykFYYOLeUvCbid4ubF82C9lbAM3DsQBXEjYgjpPFoo4Jc4F1CBezvv+iMRBumH6QuCdgXMvb+4h0v7seRzKIEPeaWbbN8iLwJM3clkoxr4okbfW/Si3B4KmIHAFIuIB75n3Y4OyJAdwUnBcuSLwGT1/piS3aXPFjiAAFM52jNWGFNMOWO+38j

On Sun, 25 Oct 2026 01:26:01 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In filter_pred_##size##_cpumask(), if the event's scalar CPU value is
> out of range (cpu >= nr_cpu_ids), it unconditionally returns 0.
> 
> However, if the predicate operation is OP_NE (e.g., field != CPUS{0,1}),
> an out-of-range CPU cannot match any valid CPU in the user-provided
> cpumask and the condition is satisfied. Returning 0 produces a false
> negative.
> 
> Return "pred->op == OP_NE" instead of 0 when cpu >= nr_cpu_ids.
> 
> Fixes: 3cbec9d7b93d ("tracing/filters: Enable filtering a scalar field by a cpumask")
> Cc: stable@vger.kernel.org

BTW, a lot of these are just "stupid input produces stupid results" and I
personally feel it doesn't deserve a stable tag. I don't even think it
deserves the "fixes" tag.

Now if the stupid input were to produce a crash or warning, then that's
different.

-- Steve


> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_filter.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 69da95f42541..d9aeeec4ed91 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -762,7 +762,7 @@ static int filter_pred_##size##_cpumask(struct filter_pred *pred, void *event)	\
>  	unsigned int cpu = *addr;						\
>  										\
>  	if (cpu >= nr_cpu_ids)							\
> -		return 0;							\
> +		return pred->op == OP_NE;					\
>  										\
>  	return do_filter_scalar_cpumask(pred->op, cpu, pred->mask);		\
>  }

