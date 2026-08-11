Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956212D2394;
	Tue, 11 Aug 2026 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461725; cv=none; b=hI+l5Uq7RaokyUUQfTZ00QAnVWsJr4ABBnD3zPK60h5qaz181WISLie6EEmgOJwNi1qgvHqwElmZxeyawe0Bqo5SQoNASZNp9nIuuBa01vBxateBgwUzq92HwatGHrivrhz98CI09MdEcXwXlFqSyIoFdbn0VMk7lbImDEDxloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461725; c=relaxed/simple;
	bh=vVE9y9cCKcFwem35mTNufGZ/diCYzcfwT4GFMD51vno=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mpd40P2OfOlvkA71ylsDj0vxV7tMpqe9oJUUzzoZVc9mct/PZJG/LsnybiJOYLsgzHnxtx/BCW9CLuQpuhRovR/q3hJs8j8+JrDbTuIJp8nL8ICvupYvYc3fWH2k6W5E6fm3condruqaAJntXiRA5HulCNRPsB8k/i23M2X6HTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkGTXWAH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkGTXWAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F721F000E9;
	Tue, 11 Aug 2026 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786461724;
	bh=ZulbIDGeRY/v9UKIMAF3m6XF8/7YJcQnNUrCpMowRVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WkGTXWAHtkBN47rzA4/g8S5DyYQMC0dJWkeXOLgLWOyqTKKb3XV19dBwM5PuZiAwM
	 TVqlZbY8OXwecT3bHNnBSNwQVZUIeLxO/xqLxSwde8u6Aom7tMkK0mMPNQREh+gJMg
	 DIkN2CVo4Jcs7fkJbIJvTOzPIQ50xeOvx14r54Ac/kP+5Ij1qoFDQIPISZ7O39ZvTI
	 OPU5mUBPqEuxoitr+sDqxGq5awhe8DobE6JNqem4ow0opHs7aRCo1teWECHV6nh+5i
	 A1qtcxjvg2rGyMUGA0mqIxsKRzeC07dUPMXQxV67A4sUCjFL93Ti7bxs+48mIwYYj3
	 Ea8DVbobsgi6A==
Date: Wed, 12 Aug 2026 00:22:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/4] selftests/ftrace: Add a boottime tracing test
 framework
Message-Id: <20260812002200.62f0ec6171bbeccb147b9f22@kernel.org>
In-Reply-To: <20260810105300.1aed1c7d@gandalf.local.home>
References: <178635442508.380779.3709136256425432083.stgit@devnote2>
	<20260810105300.1aed1c7d@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:53:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 10 Aug 2026 18:33:45 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > This series adds a boottime tracing test framework to selftests/ftrace.
> > This is based on v3 series[1] of the boot-time trace (via bootconfig)
> > testing script.
> > 
> > [1] https://lore.kernel.org/all/178613904128.259829.16130019979800943264.stgit@devnote2/
> > 
> > The new run_boottime_test.sh can run tests not only for boottime trace
> > but also other kernel cmdline tracing options, including persistent
> > ring buffer and its backup.
> > This makes it possible to easily detect regression bugs in the kernel
> > boot trace options.
> > 
> > Here is an example of the test output.
> > -----
> > TAP version 13
> > 1..14
> > ok 1 01-kprobe
> > ok 2 02-synth
> > ok 3 03-eprobe
> > ok 4 04-fprobe
> > ok 5 05-tprobe
> > ok 6 06-instance
> > ok 7 cmdline-01-ftrace
> > ok 8 cmdline-02-trace-event
> > ok 9 cmdline-03-trace-buf-size
> > ok 10 cmdline-04-trace-options
> > ok 11 cmdline-05-trace-clock
> > ok 12 cmdline-06-trace-instance
> > ok 13 persistent-01-reserve-mem
> > ok 14 persistent-02-backup-instance
> > # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0
> > -----
> 
> Just to understand this better. This series creates a small ramdisk and
> runs qemu on a given kernel to boot in qemu and test, right?

Yes, that's right.

> 
> Can you add the examples you have in the documentation patch to the cover
> letter. That will market more exactly what you are doing.

OK, let me update the series with the explanation.

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
