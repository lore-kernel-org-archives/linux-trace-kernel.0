Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966941;
	b=NQJqliNx35SQJIxFR+vhRCX829O/6q0MHyQN5kTs5wAXpHCTF1+OoOZWmTQefGPlmvm4
	 bzr+Skk4HPTvUqHZIGfBt8F8+x4yG6DPUzj27KTP8HnsgZX7pf+pv2tbU8m2obfFuWhOp
	 27Pbyr6WF5nCUMEmauzM0ndi2FpKlk4YnTJmsBPUWIfEte3rWaHFo2QBT6RxZGPPAi9LX
	 +59BJvP9iyKapMvnueC28jTc66bJktcJo8WCgGEp3VS5QpWIcZlEtm0xTp75LDyrwTp/P
	 fLAXlUkdah0JgxUGltvSmThAk5R6lM2B5XKS2YTa0A47Ud2mDDJegW1eLoHwuEkWhCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966941;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=n6+eDFFvL/Wsk0eeysYpdGNLwTPv8Y7kp0pCYvn78f0=;
	b=MHjza2JIbEmOjoXdDr2kf7QcxMMyyD1UfcFNbwSHgCsShIyUu/Ic9tq2IjUjdGSoYQRk
	 goGio7qbIiFGJjZqxzuyfFMr76k6CA999myOyC8ZyEU9EtAPD/pwViuR/Vj1Gunnqwhtf
	 holWK8vQT6FPHirgNV8OEAIrK3LRaRvbeVBNjWB4M3IeNbojoZobIJA9KcaK+31fmCC1J
	 19JJNsjBL58Hpmf9beTpo3DYE7+2/H+9ljFyYIgcTjF2Mz0CVeOsmZD5PTfnGzYrT7q3h
	 3x/49f046MBMzHzGBAmOkzhkvht/UmmYu0sacTNnZiI24Az4xQn3VEivnU/qefg4tSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GgIYDdkN;
	arc=none smtp.remote-ip=95.215.58.119
Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217CC606A882
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 01:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 217CC606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GgIYDdkN
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=inCj9hgFOM+3wUeyAcIWcO42wDOsOp5Vk/7hHTYE1G8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794966938; v=1; x=1795571738;
 b=GgIYDdkN89LjuVdl5y8CJdY0zGpkAa8UTyK6HGJFRvf99H8IWLM7mkVZsmfh+Eg3cgfUDG9x
 WdZR1txON9onqNfbhIEmx6STjl2UXJUGQfWkoNvDfNWDs13QGX6I+IVmeLLTTvKndio+lzR+4Yo
 pAYRcctm4kqK/9yL9LXBJqMs=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0ae421e0b46adfb2;
	Wed, 18 Nov 2026 01:55:23 +0000
X-Mizu-Trace-ID: 0ae421e0b46adfb2
X-Migadu-Flow: FLOW_OUT
Message-ID: <8922213b-d734-4f43-9648-97b3fce1cfc6@linux.dev>
Date: Wed, 18 Nov 2026 09:55:17 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Add log support for tracing
 link_create
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261114150610.84507-1-leon.hwang@linux.dev>
 <20261114150610.84507-2-leon.hwang@linux.dev>
 <DMX8G01GB597.2KEEFI12YK9V0@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DMX8G01GB597.2KEEFI12YK9V0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/26 13:22, Alexei Starovoitov wrote:
> On Sat, Nov 14, 2026 at 07:06 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> 
> tldr: pls use uapi names where possible:
> 
>> +		bpf_log(log, "tgt_prog_fd and btf_id must be both set or both unset.\n");
> 
> The uapi fields are target_fd and target_btf_id.
> tgt_prog_fd and btf_id are arguments of this function.
> Patches 2, 3 and 4 say target_fd for the same field.
> 
>> +			bpf_log(log, "Only allow re-attach for tracing and lsm progs.\n");
> 
> I think this one misleads. A freplace prog can re-attach.
> It has to pass target_fd and target_btf_id.
> The comment above the check says so.
> 
>> +			bpf_log(log, "Invalid attach_btf.\n");
> 
> attach_btf is a field of bpf_prog_aux. The user never set it.
> NULL means that the prog was loaded with attach_prog_fd.
> Such a prog can't re-attach at all.
> 
>> +		bpf_log(log, "Invalid kprobe_write_ctx.\n");
> 
> Another bit of bpf_prog_aux.
> The rule is that both progs write to pt_regs, or none.
> 
>> +			bpf_log(log, "Invalid tracing attach_type.\n");
> 
> LSM progs get here too.

Ack. Will update the log messages.

Thanks,
Leon

> [...]

