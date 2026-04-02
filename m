Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69D2D978C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110400; cv=none; b=GdypjZaroSD2mBVj43mr4eoXtiCJ6iEy0lC13wXeeNrniOdA5yMbWbedK9YnDYA57GF+XDuucqANgzgnLV+yWnNzZO64l6VOc383XtKvmc8RLsqAaWbWFpEqvQgGdvMKv3++vTP+lbMFITJN+BCE12cNvW1f8V1TekpKxMszbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110400; c=relaxed/simple;
	bh=xwROnB8ZHZwreos1FVUWmA9xvD2L+dNOy4XxTaASs7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCFr6uADOAwZf4HboHLFljLDfKwUXZ99OTXSrpit0DLKQSJlZvkKc66W/osEDh9VtdS3f+6911vXUxY0Jiaog24pgHE6V7cuzcchmuxoty41h9PiDxa+HutetkQ/tovQO8jtGG2VUWXViKpAf/F4NTxxXHdn7i8WJDzO4BqMKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DvR7wtzy; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DvR7wtzy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775110396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlihXvEHaOsXUwuLdGN3XtJu9WHJhoFdD4aqE/VGw5M=;
	b=DvR7wtzyf7HLbiFsO7vzzGV8m5fC3jA8QrDm2YzRIg7luXJU0cnp/yqmgPntYqWrIMwddZ
	T5VSLSDM60q0Q+n2oMk9U01rKE2AxcCDYtlndMEVKr6naQ2JiL1n5pzu94N1/xh3Rz3JcW
	iPFGswgGY3MWmSA2lzRruITkKkUS/tE=
From: Leon Hwang <leon.hwang@linux.dev>
To: menglong8.dong@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	jiang.biao@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
Date: Thu,  2 Apr 2026 14:12:51 +0800
Message-ID: <20260402061251.273705-1-leon.hwang@linux.dev>
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 18, 2025 at 08:36:28PM +0800, Menglong Dong wrote:
>For now, the bpf trampoline is called by the "call" instruction. However,
>it break the RSB and introduce extra overhead in x86_64 arch.
>
>For example, we hook the function "foo" with fexit, the call and return
>logic will be like this:
>  call foo -> call trampoline -> call foo-body ->
>  return foo-body -> return foo
>
>As we can see above, there are 3 call, but 2 return, which break the RSB
>balance. We can pseudo a "return" here, but it's not the best choice,
>as it will still cause once RSB miss:
>  call foo -> call trampoline -> call foo-body ->
>  return foo-body -> return dummy -> return foo
>
>The "return dummy" doesn't pair the "call trampoline", which can also
>cause the RSB miss.
>
>Therefore, we introduce the "jmp" mode for bpf trampoline, as advised by
>Alexei in [1]. And the logic will become this:
>  call foo -> jmp trampoline -> call foo-body ->
>  return foo-body -> return foo
>
>As we can see above, the RSB is totally balanced after this series.
>

Hi, this is a late footnote for this optimization.

As this optimization landed in the 6.19 kernel, the function graph feature
of bpfsnoop [1] cannot work because of the missing tracee's FP/IP for
fexit.

Before this optimization,

caller
-> call icmp_rcv                caller IP/FP
   -> call trampoline           icmp_rcv IP/FP
      -> call icmp_rcv body     trampoline IP/FP
      <- return to trampoline
   <- return to caller

After this optimization,

caller
-> call icmp_rcv                caller IP/FP
   -> jump to trampoline
      -> call icmp_rcv body     trampoline IP/FP
      <- return to trampoline
   <- return to caller

As a result, the function call stack entry for icmp_rcv has gone.

It can be confirmed by bpf_get_stack*() helpers.

$ sudo bpfsnoop -k icmp_rcv --output-stack -v

In 6.14,

0xffff8000802bda44:bpfsnoop_fn+0x6a4
0xffff8000802bda44:bpfsnoop_fn+0x6a4
0xffff8000802bd064:bpf_trampoline_6442573163+0xa4
0xffffc7825c984df0:icmp_rcv+0x8
0xffffc7825c91bcb8:ip_protocol_deliver_rcu+0x48
0xffffc7825c91bfd4:ip_local_deliver_finish+0x8c
0xffffc7825c91c0d0:ip_local_deliver+0x88

In 6.19,

0xffffffffc0209069:bpfsnoop_fn+0x449
0xffffffffc01ef2a4:bpf_trampoline_6442568724+0x64
0xffffffffb1085cda:ip_protocol_deliver_rcu+0x1ea
0xffffffffb1085d96:ip_local_deliver_finish+0x86
0xffffffffb1085e95:ip_local_deliver+0x65

So, it would surprise users who care about the tracee entry.

[1] https://github.com/bpfsnoop/bpfsnoop

Thanks,
Leon

[...]
