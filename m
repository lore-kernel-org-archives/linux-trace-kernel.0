Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDA33D4F3;
	Fri, 27 Mar 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643065; cv=none; b=c0wtP3NnJUlXNHhlNUqNXfSAMn43pZRiDrYwcg4fW2kd1yYbTmyS7uKaVJx8bgW1/4asrVQnA3OHVVAKuKKK4RXObYgAo0hsw7YDRpMaICgeqf7ELasfQbkJuYRJZGWHZW4etSiKXd4kxElR3odivBc1K8FXoLrs4JecCezapZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643065; c=relaxed/simple;
	bh=Bhb1LLjTVC34dkPA1WEoxYXKQlyP22wtU/y+DxfEHq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErKZmC8swTTykUYUUKqNIsKxZmQqAmEe5WujnPa/fR88xHunKnAAkR7ObEymWsElP0i2HdKY8o9wHWaZbCJuHsb6SUktRMgoF1fTvuYyBZ9o38KHpKs1y+glJ2NoCofNDXbp5ETPj1vpOcRlZbITaVRwu7j81d4iXhEkb3Rt6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id C4A7C8DF3D;
	Fri, 27 Mar 2026 20:24:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 2A9A632;
	Fri, 27 Mar 2026 20:24:20 +0000 (UTC)
Date: Fri, 27 Mar 2026 16:25:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v13 4/4] ring-buffer: Add persistent ring buffer
 selftest
Message-ID: <20260327162508.6cac690c@gandalf.local.home>
In-Reply-To: <177440552560.1529621.1405976992959650354.stgit@mhiramat.tok.corp.google.com>
References: <177440549083.1529621.15486836623498328967.stgit@mhiramat.tok.corp.google.com>
	<177440552560.1529621.1405976992959650354.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jpw7xi94mbhisszhcicrbhrhsmy3rxfh
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2A9A632
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DJ1uB7Gb54AKsTjkRNce835wOAJVhDjE=
X-HE-Tag: 1774643060-910451
X-HE-Meta: U2FsdGVkX198T3FGypbrfMrqRAhjNNL+gXPNK3/iTls//d8U/S3H2QGc1aor3x5NNRi1Br+Db8SFKgnmcw01SJZ/RbY8YDio203Ff1ZEKylN+QWy497oHIl/Wr6zMCZ5U/t4gukwzAkMQGNEM1fqL2GnLe1fQZMXDoSehEtLK2HlDemUlSggHQ90Kns1HD/m2Zh5jjWK33ptKAlVYbuChpKWqS001Zpdz+QwkR2NmJkp2Uv9CXnVPXDgYYl4jUWxAOhKQ+M7sorpxHh6huSz4u8uxcDG7zXFWWv5LswpqA0UQ4SsjgaeONUas8r/iP3BLdcbUae0Lewz32fZ1xX0pwAMDIeS66Tk

On Wed, 25 Mar 2026 11:25:25 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a self-destractive test for the persistent ring buffer. This
> will invalidate some sub-buffer pages in the persistent ring buffer
> when kernel gets panic, and check whether the number of detected
> invalid pages and the total entry_bytes are the same as record
> after reboot.
> 
> This can ensure the kernel correctly recover partially corrupted
> persistent ring buffer when boot.
> 
> The test only runs on the persistent ring buffer whose name is
> "ptracingtest". And user has to fill it up with events before
> kernel panics.
> 
> To run the test, enable CONFIG_RING_BUFFER_PERSISTENT_SELFTEST

I think a more appropriate config name would be:

  CONFIG_PERSISTENT_RING_BUFFER_ERROR_INJECT

as that's what it is doing as it is only testing error injection and not
the persistent ring buffer.

> and you have to setup the kernel cmdline;
> 
>  reserve_mem=20M:2M:trace trace_instance=ptracingtest^traceoff@trace
>  panic=1
> 
> And run following commands after the 1st boot;
> 
>  cd /sys/kernel/tracing/instances/ptracingtest
>  echo 1 > tracing_on
>  echo 1 > events/enable
>  sleep 3
>  echo c > /proc/sysrq-trigger

These instructions should probably be in the CONFIG help message.

> 
> After panic message, the kernel will reboot and run the verification
> on the persistent ring buffer, e.g.
> 
>  Ring buffer meta [2] invalid buffer page detected
>  Ring buffer meta [2] is from previous boot! (318 pages discarded)
>  Ring buffer testing [2] invalid pages: PASSED (318/318)
>  Ring buffer testing [2] entry_bytes: PASSED (1300476/1300476)

BTW, when I tested this, I got the above on the first boot, but if I
rebooted normally without re-enabling the persistent ring buffer, I would
get on the next boot:


[    0.966510] Ring buffer meta [2] is from previous boot! (0 pages discarded)
[    0.971338]  #2
[    1.003431] Ring buffer meta [3] is from previous boot! (0 pages discarded)
[    1.007737]  #3
[    1.039091] Ring buffer meta [4] is from previous boot! (0 pages discarded)
[    1.043181] Ring buffer testing [4] invalid pages: FAILED (0/1597)
[    1.044660] Ring buffer testing [4] entry_bytes: PASSED (6512464/6512464)
[    1.047829]  #4
[    1.079811] Ring buffer meta [5] is from previous boot! (0 pages discarded)
[    1.083728]  #5
[    1.116764] Ring buffer meta [6] is from previous boot! (0 pages discarded)
[    1.120846]  #6
[    1.156502] Ring buffer meta [7] is from previous boot! (0 pages discarded)
[    1.160857]  #7

I'll start testing the previous 3 patches and may add them to next.

Also, I noticed that there's nothing that reads the RB_MISSING as I thought
it might. I'll have to look into how to pass that info to the trace output.

-- Steve
