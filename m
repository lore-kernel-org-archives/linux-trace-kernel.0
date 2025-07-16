Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E61953BB;
	Wed, 16 Jul 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666634; cv=none; b=VgAhm7oxzYgOdj2w15aAH0aK0CZBT5KFc3v4TUpLnqIxPyOz22vY0IOgTMbBKSoJ9uSdfNlQJN7yCzVOmj5sMFIsIpMWljF+F2KWzpAkfUqO3HeC9ecvAfpaCFZVj/LAvwuXd86nsMuiZIaoOc/gERd7scFoj+ivKEm44DKScKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666634; c=relaxed/simple;
	bh=b+QdQ5SK2xW2CtWZsAAc1a1FORR2+a3qO5TLAGltyp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzKhFRnRnHeQ7zPK4nJcQFDn4iVLaOrrkGx3flzTN55F9qnF+em90nax6j/wzG6KBbJRnZ/xes1lQ4aDaL8g/46a1SS60EHY5/vu8IZCfF6nSnuJhr1YvkNIAcrCRgsmEO+mxTlqc63bqG8ZiOWiH83Y++FwboR3f9NH7+W5Pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RoXKe4Yh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RoXKe4Yh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l48/StNB/4Lsn/VT95PigzRA39+WnL2ci89FjY7vSZ0=; b=RoXKe4YhwxF9cuYtHiZXMFrVDc
	me/Jcoo18NjDSvxtCD5wlUaDdOfFW7Cgx6u8XXPwPEArN8DLo7dNOLsL8okHkWNk2QawETxR5Hufp
	H+VW/phZlDwc4IPHynECmesGb0DQFmJ/DTGyQABgj6/Ls5QFWKZEzMm4S6tf1vc5wZSD8neSArqMw
	8dJ8hONCAUgOq+x+NGf818ukAAgkIH4Ndm8TA0TvjNJBs9lzxQMnrO8C18/twd9n+0EUT+euvrwyD
	UpUtxp2SUMM5LvRA6799mzpTEJ+DXN4ppjv/ND82sKh9hz5EWcmjQqRZnGmmdzXxR3P+8yc++YUQ0
	PEH+FDYQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc0ea-0000000GRIG-1gsv;
	Wed, 16 Jul 2025 11:50:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D9DC6300186; Wed, 16 Jul 2025 13:50:27 +0200 (CEST)
Date: Wed, 16 Jul 2025 13:50:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
Message-ID: <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-2-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:18AM +0200, Gabriele Monaco wrote:
> Currently, the userspace RV tool skips trace events triggered by the RV
> tool itself, this can be changed by passing the parameter -s, which sets
> the variable config_my_pid to 0 (instead of the tool's PID).
> The current condition for per-task monitors (config_has_id) does not
> check that config_my_pid isn't 0 to skip. In case we pass -s, we show
> events triggered by RV but don't show those triggered by idle (PID 0).
> 
> Fix the condition to account this scenario.

The distinction between !my_pid and has_id is that you can in fact trace
pid-0 if you want?

> Fixes: 6d60f89691fc ("tools/rv: Add in-kernel monitor interface")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  tools/verification/rv/src/in_kernel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
> index c0dcee795c0de..72b03bae021cd 100644
> --- a/tools/verification/rv/src/in_kernel.c
> +++ b/tools/verification/rv/src/in_kernel.c
> @@ -429,7 +429,7 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
>  
>  	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
>  
> -	if (config_has_id && (config_my_pid == id))
> +	if (config_my_pid && config_has_id && (config_my_pid == id))
>  		return 0;
>  	else if (config_my_pid && (config_my_pid == pid))
>  		return 0;
> -- 
> 2.50.1
> 
