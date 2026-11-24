Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501567;
	b=Ved051dL4rQHP9AR0kFW49Xb/fLbH1EefElAjwNVGafIoiA3HfClnkYuNCa8QES3woLn
	 yuK1I+iyVmm6f3aMJ47DtfMvCTS/aBbGTFvundHPyzpyd8IYV15lq8QrEoYG9HzmLY3OR
	 NsTbbzo+6ko1ZAzgn0wlK552Hs2F++tqzeXQbHkhheo8fdDxvOaS8+Gt4avuYhZtTakA4
	 4fwEwastgdZpAJe5AJnPiHD399hG3IfWY36obawwxrxUAAjegcEt+sR7iq3IKpPcrwFzW
	 o3MMPMdVmj94aM9uKENBAyvkGlf8VK9zPLJ3QQuWH7KqmAMMmFor6RotUbrRAPkrB4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501567;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=449gIxytb/HnDdGvFu4T1xW9ukKcixFJk9Iaz+yC4MQ=;
	b=gp4HO4NRAv/UPxD6nB624WqqBTvAELlo7WS027CmQtxnBN9UTWIv1C1Fle2XnBkju0HV
	 SfjqzmcCf2w3dT5ylPeXEPGItCgwBY0Q294YHj6BYCKFwZdeTW5D90dC8Cx+qvnqID90/
	 pG0u5qoIvrxnBFyPcfvDFAZ2X/NaODdtvOifC505yQ9HF80w+xxpyE/IaK8Az0qfR2IzO
	 zOkHcS6EGwfpUNmjFUehZrlylyTfqUPpMlbRk4iVfBmYoP/kPe8XQg8fnkJHoF1mOMaXp
	 abBO78v+ItY7CsdP4ItmsKj2rtYq/UdJxbh60Qlu+K97otd+kAUyUBB5GQ+yvGwuhuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YiY8PMaG;
	arc=none smtp.remote-ip=95.215.58.249
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C29B606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 06:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C29B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YiY8PMaG
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0ckwT1MNxjCaUKr8B7kPL7bLosNZahWjCYvLItqr8CY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795501563; v=1; x=1796106363;
 b=YiY8PMaG7++Ddb0Ee2gLc0tCXOFupKJxrViHjNQbiRerL32gCCK0orcnLxhnkdUoWQYpYPmL
 pDEfSSDR3HxImIkpEDnvf+EdMTBhZ5JKmamM7HZJu3BQ7MyZ2W7zbVivpP4dRLlapGntm64aAEB
 HUGqCcDo6Ju8dFKibQwo1gvc=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 588e070f590522ee;
	Tue, 24 Nov 2026 06:26:03 +0000
X-Mizu-Trace-ID: 588e070f590522ee
X-Migadu-Flow: FLOW_OUT
Message-ID: <2d330be7-3d8a-40e7-a5f5-3a24c7e434e3@linux.dev>
Date: Tue, 24 Nov 2026 14:25:54 +0800
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
Subject: Re: [PATCH bpf-next v3 0/9] bpf: Add log support for tracing
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
References: <20261123152743.19629-1-leon.hwang@linux.dev>
 <DN308UHY5QHQ.8CJOFGAHVVTR@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DN308UHY5QHQ.8CJOFGAHVVTR@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/26 08:12, Alexei Starovoitov wrote:
> On Mon, Nov 23, 2026 at 07:27 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>  .../selftests/bpf/prog_tests/cgroup_link.c    | 324 ++++++++
>>  .../selftests/bpf/prog_tests/iter_link.c      | 156 ++++
>>  .../selftests/bpf/prog_tests/tracing_link.c   | 741 ++++++++++++++++++
>>  .../selftests/bpf/progs/tracing_link_ctx.c    |  17 +
>>  .../selftests/bpf/progs/tracing_link_multi.c  |  36 +
>>  .../selftests/bpf/test_kmods/bpf_testmod.c    |   5 +
> 
> 1279 lines of selftests for log messages ?
> This is way too much.
> 
> pw-bot: cr
> 
> One row per attach path is enough. It checks that the log gets there.
> The base kernel leaves the log empty, so all four rows fail on it.
> Something like this:

Okay, will update the selftests like this.

Thanks,
Leon

> [...]
