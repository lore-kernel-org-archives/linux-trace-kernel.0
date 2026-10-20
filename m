Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792472112;
	b=x7X7tU3QAWtF9hUYktj2zY1HCrrTE1KZd7oUQm20GFY8qjn/j3AHArQAO8bpiPFgOnK+
	 fzXIByUOFCPB+BQWHrHm4jfGmNqcjOq0FreR/jmWR7h8/toPPGluZGBi2jQhqoVO1fUl5
	 V1B7oSpwNsge7EWy2YKcIdRHbz/7lYf4iUsS0pvJkULZp1SQGPA7mrcAWliH0n9T1MKDa
	 xMG4Oe6SUkIFD44zBOmQS3w+pGaNTvvE/uL+qouDkUuHq6BSes67OLPytGRVVkNKAuYqE
	 V/vSyhTjDx2yA7Kik8sX6DVwuc0/OdHqJKS99c4G0N8JCGlYVrZxSrQcvXnkhKATxyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792472112;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=JWmybeGplPkSTpFTj85ztkArMWjjQyueHRK8ugu3OPQ=;
	b=IHEEkwwPovcIXbRj5pl42XDd5e3QIK3OxHbyHs0jDsfg8NS6eE95OFga+CrQHx1q7SH+
	 KBZFs41vBRMrm5ZlnCxlecdXEPdjIRSwIekGB8MyTq9aYAN53em7AfENyC3ZgyXOkSkTM
	 37yug3LtxHxxEKqaSBDdQPCMs7BvWSpBcF/HrghQ08/l9NTYFe/5H/zqUtGMeHJuFVJgL
	 mLbNLUudKhTO1uHmrajJHYaXVzwGmCkvVOUpNkWjuPTCrpbOEKyg4MWDF3OV17PlL6nfv
	 T2Ulw75vzRD9+zyqAqELAHhLoJSLHNDvXO6+DM129LBjnLhTPcVpN18jNXXZ8HeUHWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pYPQDFJY;
	arc=none smtp.remote-ip=91.218.175.65
Received: from mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6A606A31B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 04:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12E6A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pYPQDFJY
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LFjs2kFiCzLrj4HtSUdWz5JO/YUmh3RAwrRfcIouXUQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792472110; v=1; x=1793076910;
 b=pYPQDFJYfrzPleAofKS5KnSdbyCmhgQF/zuXOdC7B2nciw5r+BgeEEjuSbIHfG1aAallQ0b4
 hE5LFR4FbQmrr79Mb0iu47YUHgo1TwgDDB6wuRgweREPTae1tiIa4rUTysjX2eKxTzcleqxGz5I
 pt5Y+VIw4Blf3tJH4DOQuaOA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da4906023b4f5813;
	Tue, 20 Oct 2026 04:55:04 +0000
X-Mizu-Trace-ID: da4906023b4f5813
X-Migadu-Flow: FLOW_OUT
Message-ID: <2d307dae-41b7-45cb-a35d-6cbfb09cde04@linux.dev>
Date: Tue, 20 Oct 2026 12:54:56 +0800
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
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add syscall common attrs support for
 link_create
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Masashi Honma <masashi.honma@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261019153628.15912-1-leon.hwang@linux.dev>
 <20261019153628.15912-2-leon.hwang@linux.dev>
 <DM9282PWYQD9.21LDVIJ8824AL@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DM9282PWYQD9.21LDVIJ8824AL@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/26 03:25, Alexei Starovoitov wrote:
> On Mon, Oct 19, 2026 at 08:36 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>> +	ret = bpf_log_attr_report_size(&attr_log, 0);
>> +	if (ret)
>> +		goto put_prog;
> 
> can we drop bpf_log_attr_report_size() ?
> Nothing is logged when the attach succeeds, so there is no size to
> report, and libbpf zeroes attr_common, so log_true_size reads 0 anyway.
> Finalizing only when ret < 0 already keeps -EFAULT away from a live link.
> Then no need for the 2nd write, the log.c refactoring and the put_prog
> label.

Sounds reasonable to me.

Besides libbpf, other BPF loaders, e.g. cilium/ebpf, also need to zero
attr_common before calling the BPF syscall.

> 
> Something like this (compile tested only):

Will change like this.

Thanks,
Leon

> [...]

