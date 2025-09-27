Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D483CC7;
	Sat, 27 Sep 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984210; cv=none; b=qi2z8WqipSwdb6aCrG2XM1NHbLEFlwRDs7FsTnncV9bP1LPoiNG8y7rXe2dH5jloFXZH0oP+5o/JPBjaSJAQg+JgfQ8+AszfKydfi7rbA6TfjQnpyntc1a/+i8HNXQgOjn+8lbCdQrKhNxmOb9faBy+HGUaVDRNfqO9U62Vv20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984210; c=relaxed/simple;
	bh=unmQv9dviNq5zyc/2wlXItxpxotjSpAiLoTFF3vuoHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKMeYu1t9wyPqP7IRqyvjyseNMPfvLVBDS3EhWeurMzxMpAwyM1/5iO1EsZ21CGzrBOZhlBjf0QInqWGukkXA1W2LMRfkIfJ5k68i88r07jTAqa93k15oXlq9b4U5+/X4DuoVeQGhIfz338gIf7IB1v/jpspcf7IGk/y1EOYK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8bgZ3Xd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8bgZ3Xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8652C4CEE7;
	Sat, 27 Sep 2025 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758984209;
	bh=unmQv9dviNq5zyc/2wlXItxpxotjSpAiLoTFF3vuoHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l8bgZ3Xd6GuXZ6B/Gv5ASRBluOFuABbUts2bvraidjbOFemSsviMk43CGB23v11xk
	 m5VBdw3NLmpthEPgEBsqTGIxhnQsRd4xqn8ErRe5T7rVSG86y0KObc6tM62u9LoI8J
	 vHRD+AwwR022sEBgBkj1/sEOcVIDZMEf55UThK6/O277OcNj2fKPZz5+lR5isNaUHl
	 xoocS+FOIO9ZWmy9Ekxia1k/m3C2NBaAV1X/1bDYSxxnqHqLtbolc0uGDS0yDFw1jK
	 wQYkNtkTzdollIPlfRnlmqhLV0ItxAuZ5KqZ7X2O9xmWpZnmhyV5bziWe78TzIgxXc
	 OEM9b0r50I65Q==
Date: Sat, 27 Sep 2025 10:43:21 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, Takaya
 Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Douglas
 Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH v2 3/8] tracing: Have syscall trace events read user
 space string
Message-ID: <20250927104321.50c71086@batman.local.home>
In-Reply-To: <20250925071545.578e3643@batman.local.home>
References: <20250923130457.901085554@kernel.org>
	<20250923130713.936188500@kernel.org>
	<20250925072609.GU4067720@noisy.programming.kicks-ass.net>
	<20250925071545.578e3643@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 07:15:45 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> I have yet to cause the retry path under stress tests. I had to insert
> a msleep() for testing purposes to make sure it worked.

I wanted to update on this. My stress test wasn't stressing enough. So
I took a "cp-mmap" program I had that did this:

        map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, ifd, 0);
        if (map == MAP_FAILED)
                exit(-1);
        ofd = open(argv[2], O_WRONLY | O_TRUNC | O_CREAT, 0644);
        if (ofd < 0)
                exit(-1);
        do {
                r = write(ofd, map + w, st.st_size - w);
                if (r < 0)
                        exit(-1);
                w += r;
        } while (w < st.st_size);


Where it mmaps the source file and then writes that. This would most
definitely fault at every write. Then I ran this while tracing
sys_entry_write() and an added trace_printk() in the goto again block:

 # mkdir /tmp/dump
 # for f in `find /usr/bin/ ` ; do n=`basename $f`; ./cp-mmap $f /tmp/dump/$n & done

And this did cause triggering:

 12771 writes where it triggered the again loop 1635 times.

Thus, it triggered 12% of the time under a very intensive stress.
That's still faster than allocation, not to mention if one is tracing
both system calls and allocations, it will start to dirty the trace.

-- Steve
