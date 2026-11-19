Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048705;
	b=iVlmt9atgNAbOo810YxG6bdruRJqwfpK9xt7CgGT00VovfL5lXdUy2YH5Razwat/1hGJ
	 czsjLEKXwCI3m/YsXOGfC9SUCBriyMLvWu2CJiTNSRE6LyJToKkmtUCGvCQI1tBt9/3LJ
	 pMgSgrNS4bE3P/VN0kZ2K/MhI2kAm3eXYNVvq7FF15eWb9APgHKHmejzuvYg/n1RJ74yY
	 1rxAc6C95Jij9O8zyo7NMm8A8m1EuG/LBk812EdkUSpSau3eaydiHtkeot8+lPApm9npL
	 d9gRtB/S/UEdkLNwiMqWx6JVTdD3MR8rDvhA7TKjFBN+CCGdtMBsMynKno2u0DpjbgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048705;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=N1POxbt56sF4jbe2Eeu5fNrJ+OFnFsQaza3/NDrV5QM=;
	b=MRi7EnOlv2/nN1K3ypRz+Lz/uHRIL9J8a+BZMd8qYVaEP1d2CZ4IpojlW0HsrFmXWNXF
	 2AuQqZJUnfqYoHhv2aanBCsS/9rFrR6WyGlNN3YTlyyBL6IuEMFqpYDRVhjPLhUPKF8WT
	 spauZj9zZoIer9U7BujiSszE0g8KjtyB+m+IqFQOZpLgnRW5Gd8927yVJf/9bwzeg9g/v
	 WmuRLN/Q4+ilb5aCFrdMqDbCZSizKtmkfueJEphmTx11c81wRyirGHeer0BzP02+mv8OS
	 nfiUXwoI9exle1tmLOIDpQMKU9pjBTxMHWDGnlzet0EWEkn+BY72eHMjEiSh/fRBY0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoktxTQA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63680606A320;
	Thu, 19 Nov 2026 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoktxTQA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01631F000C4;
	Thu, 19 Nov 2026 00:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795048705;
	bh=N1POxbt56sF4jbe2Eeu5fNrJ+OFnFsQaza3/NDrV5QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FoktxTQA05uv9fO3RKcATxzsOru63mls6QH9MOCOzPqv4TEWuTVG4wR3oNJFdG/OL
	 c0Dz6T/+nOjBuJKITtFMIlbCYKq40pNFA6I7xj0u5/1iWj0iIdVaJtLpfI3tk8nczY
	 oBqllzD/0NeYzi/kzl+N9g1G9sLbKREYlmiBy7WEcrT8hxGy8F/ogqQT/PwDHTxh/k
	 8VPb9IWTI5TvURDoD2HMSJRd8ss7V+IvWojmrOe6NAbCm54XnIyMd2d4pu5eEyFQEj
	 KVtFfapUVy3vmRtbgv+uGyuFZ4HHiPfX6f5ryhFNO8Z1VmU+KKh6uS5qVMtX0lYbn+
	 UQivPi3mZJfdg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 06/15] tracing/filters: Fix quoted operand parsing in function event filter
Date: Thu, 19 Nov 2026 09:38:21 +0900
Message-ID: <undine-1795048701823215055-2066a0c9c680e81e@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261117191421.41cc174c@gandalf.local.home>
References: <179323784538.740114.15323117974242744566.stgit@devnote2> <179323790096.740114.15868280894145147902.stgit@devnote2> <20261117191421.41cc174c@gandalf.local.home>
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
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 19:14:21 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 29 Oct 2026 10:38:21 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In parse_pred(), when parsing a quoted operand for function events (e.g.
> > ip == "schedule"):
> > 1. The loop 'for (i++; str[i]; i++)' breaks when str[i] matches the
> >    closing quote, but 'i' is never incremented past the closing quote.
> >    As a result, parse_pred() returns 'i' pointing at the closing quote,
> >    causing the caller predicate_parse() to immediately re-parse the
> >    closing quote as the start of the next token and fail with
> >    FILT_ERR_TOO_MANY_PREDS.
> > 2. If the closing quote is missing (e.g. ip == "schedule), the loop stops
> >    at the NUL terminator without reporting an error.
> > 3. The loop started with 'i++', which was intended to skip the opening
> >    quote, but also unconditionally skipped the first character of unquoted
> >    function operands.
> 
> Can you show actual examples of setting filters that fail with the above
> issues. Something I can test and see that what was fixed, and that it was
> indeed fixed.

For this issue, we need to use "perf record" to reproduce it. It seems
that expected behavior [1], only perf can set filter to
ftrace:funtion event. From the tracefs, ftrace:function event does
not have filter .

/sys/kernel/tracing # ls events/ftrace/function/
format  hist    id

But perf (perf_event_open + ioctl(PERF_EVENT_IOC_SET_FILTER)) can
set the filter to ftrace:function event e.g.

perf record -e ftrace:function --filter 'ip == "schedule"' -a -- sleep 1

This should succeed, but it fails without this patch because parse_pred()
stops at the closing "(double quote). 

failed to set filter "ip == "schedule"" on event ftrace:function: Operation not permitted

With this patch, the perf succeeds to run.


[1] commit 80765597bc58 ("tracing: Rewrite filter logic to be simpler and
faster")
-----
	} else if (ftrace_event_is_function(call)) {
		/*
		 * Perf does things different with function events.
		 * It only allows an "ip" field, and expects a string.
		 * But the string does not need to be surrounded by quotes.
		 * If it is a string, the assigned function as a nop,
		 * (perf doesn't use it) and grab everything.
		 */
-----

Thanks,

> 
> Thanks,
> 
> -- Steve
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

