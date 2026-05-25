Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFFB1F3BA2;
	Mon, 25 May 2026 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779670584; cv=none; b=HmgrqXGdd1vXO1h6wuZCxFFxbt3UChcy0wRz3DUDa/+xnUOdWCrmMwpBOVsuqPp3DDKCve0SEj56SJvvdqnkStbdJtQLmdGmreeIHn9MCTw9QiT4XkU145kcWtp3dic/5FckcYllW48/cLoraIF9UcugR12LLNbCZCVgkKcb/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779670584; c=relaxed/simple;
	bh=kWSEsz5/zusy6zyR1e84AJnCRbPa6pNpUvgMGE/NYE4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qrWmL3JCzc14uHsBSGE3I9U/RrzTyqPw1X98tMnzLSFiPo02axtZXJEV+qvkQSZdkuJPjdvUAkw0t3bC8TsrgxROd7m78MHbVpmyE3NEe7ZoCtzc+txCu1LN9omc3mZnwjwlsrRP8Za9tZPNKbGxyfG7ZNy5MkLO0E/1Xy+cKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjWwepuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjWwepuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E15F1F000E9;
	Mon, 25 May 2026 00:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779670582;
	bh=eqWU+SdHL9ZGMrXSyouftQPSh288qp7vXeyLbZSDHPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TjWwepuy1rgf/b2TFtmb+VGytT3Sl6C4mt2N0AdMf6W7dJffR31m4yrYn+GCfdESI
	 gZkKDCNOg5yOmW7QPf0DLNTiPYdwTmNzza9ApTp2r0ysn+9ujQspcUhuRpvSo6H3tF
	 PQ0C7adF3PKQbQ81xgUDKJVbQjt5zddwiRRGmv3+95Njgrr6FdFbndz0TA8xV6EdmO
	 ZLZXstMQ3ZBdvMzpx/nY1YgOXE+pM65fBEjv3ustHhpWk3uYLQvxoxRS7O/wshSqn1
	 GQjKdcHhWAs16n391bptC/PumGg77vgcZNe+3qB13tBCv5BwU+lRKyPLqBkI50dDnV
	 BEM2pTRoVLkIA==
Date: Mon, 25 May 2026 09:56:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yifei Chu <yifeichu24@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing/uprobe: oversized dynamic ustring triggers
 WARN_ON_ONCE panic
Message-Id: <20260525095619.b3b90a09044914743721935e@kernel.org>
In-Reply-To: <CAPJnbgJ3ayTqZvau6x4c5Y0=xsL_hUeDm1mVTKCYAhfGZCL6bg@mail.gmail.com>
References: <CAPJnbgJ3ayTqZvau6x4c5Y0=xsL_hUeDm1mVTKCYAhfGZCL6bg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 24 May 2026 10:44:09 -0400
Yifei Chu <yifeichu24@gmail.com> wrote:

> Hello,
> 
> Short version: I can make trace_uprobe hit WARN_ON_ONCE() by creating an
> uprobe/uretprobe event with several dynamic ustring fetch args. With
> panic_on_warn=1, this becomes a reproducible panic.
> 
> The setup is pretty direct. The reproducers mount tracefs, create a trace
> event with several ustring arguments pointing at a 4095-byte userspace
> string, and then trigger the event. At probe hit time, the dynamic string
> sizes are accumulated and prepare_uprobe_buffer() sees a payload larger
> than MAX_UCB_BUFFER_SIZE/PAGE_SIZE:
> 
> WARN_ON_ONCE(ucb->dsize > MAX_UCB_BUFFER_SIZE)
> 
> I reproduced the same class through both uprobe and uretprobe events.

This should be fixed by [1]

[1] https://lore.kernel.org/all/20260428122302.706610ba@gandalf.local.home/

Thanks,

> 
> Tested environment:
> 
> Linux version 7.0.9, x86_64 QEMU
> gcc 12.3.0, GNU ld 2.38
> Boot args included: panic_on_warn=1 nokaslr console=ttyS0
> 
> Uprobe result:
> 
> WARNING: kernel/trace/trace_uprobe.c:982 at
> prepare_uprobe_buffer.part.0+0x458/0x5b0
> Kernel panic - not syncing: kernel: panic_on_warn set …
> 
> Uretprobe result:
> 
> triggering uretprobe oversized ustring buffer at offset 0x1db0
> WARNING: kernel/trace/trace_uprobe.c:982 at
> prepare_uprobe_buffer.part.0+0x458/0x5b0
> uretprobe_dispatcher+0x328/0x3e0
> Kernel panic - not syncing: kernel: panic_on_warn set …
> 
> I checked current mainline source and still see the runtime WARN path in
> kernel/trace/trace_uprobe.c. I have reproduced the panic on the 7.0.9 QEMU
> build above; I have not yet runtime-tested current mainline.
> 
> My expectation is that oversized user-controlled dynamic trace data should
> be rejected, capped, or dropped before it reaches a WARN invariant. A
> tracefs user should not be able to turn a long string fetch into a kernel
> warning/panic.
> 
> The attached tarball has README files, both C reproducers, and the full
> QEMU logs.
> 
> Thanks,
> Chuyifei


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
