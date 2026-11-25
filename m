Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638233;
	b=D85JqspWX6rwDxLk6fjLaKLBdZBykmanf77wtaOPMjUt6rjRVME0GeUMUbRuyjqWKRlX
	 esVl7sNW04yZeyi1Npazuik14yEmqQhn01GDVNPJ8Q7/8gLRh6gmbeAaomuy8j1/KQp1N
	 JdHlC/lvSxbzVEsHNb0q23xzA5fuuHv+URrzHNjzn0ov3hoTXZ3CNQ45a7RD4zOuo5g8L
	 lRvDQ+F33JcEdKjR+ElVYdneklTdC2g9mebvh8spc8GYv2ljCnk79rBBWcrUp0bah4qv9
	 XdNuPB1KCBbx5psQ86914sIQwYHPCp6qwf2fbAD17zhS0WJwfWGlUztPFOVBr2V426Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638233;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=hKUU2imahZE4B9a0pwQkizpFVuU4ssI550E629F+HU4=;
	b=xbWWL1lFJTT85+KB07LQ5sKzZkS7VanAKHWZpsd5uqndzvxA2fwirxhG9LJk3QBYTagv
	 yVPE8lKRJdCERu3LeUr5H0q9Qg1w+bvdgm3ppRtGAcx5PwhrpNDmv6vSD5wLliLt2WYZY
	 6/pfykdjeRMVzETmrIMpSn4glJC5qKghhVCcTJydgFdqSqUZOCAVsUA12zp0zTQF3MoNM
	 TzapG9yFp92jY7zoAzGe0N278ERf9AniGlo0hmbrZAbLnIdxDX1LmSZuVWbtA9jfGHKHJ
	 CXGLewwgT3GV15sdO1FK4L54HquyQ3hBRg37yUeGzEmH/sYOBONCyvx/48wgLIAcITQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.172
Received: from mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75A606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 20:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D75A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fdrz78OYlKMGHh6IXGtV5XttBhxWpJMlzeekMNBSw3k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795638225; v=1; x=1796243025;
 b=w0DU1h2Iu7iOo5sYgszHSa2bYau5G741zzfxIlhRUY4uRk8oGxMFoJi3sj3Sj8bU1t3mZIeo
 +qhSzLfqJqJybM2BJIFx/c7EQGh9J0GVhY7Rc+S+q7qWFm27v5HJDsbJQ6DHZ4cLyPfEKvwTS3w
 vZ5fmeV8kCyGDXA5HfvDf85E=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 92300b7e95544926;
	Wed, 25 Nov 2026 20:23:44 +0000
X-Mizu-Trace-ID: 92300b7e95544926
X-Migadu-Flow: FLOW_OUT
Message-ID: <4f83adb6-29d7-44d0-8dbc-beb28231a8b5@linux.dev>
Date: Wed, 25 Nov 2026 12:23:39 -0800
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
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 mikeba@sentinelone.com, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Martin Kelly <martin.kelly@crowdstrike.com>,
 Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 tyler.wilson@crowdstrike.com
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <44034fa7-91ab-4777-ba72-0037a6932b56@linux.dev>
 <DN3ZR4IBQUKK.2KZHQUDH3ZRAC@gmail.com>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <DN3ZR4IBQUKK.2KZHQUDH3ZRAC@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 8:02 PM, Alexei Starovoitov wrote:
> On Tue, Nov 24, 2026 at 06:06 PM JP Kobryn (CrowdStrike) <jp.kobryn@linux.dev> wrote:
>> The patch below is a proof of concept scoped only to x86_64 trampolines.
>> It was validated with the bpftrace prog that precedes the patch, along
>> with jited assembly dump to inspect the new private frame API calls.
>> Overhead measured was roughly 60ns, but this was just a first take and I
>> believe it can be optimized especially in the JIT area. If it makes
>> sense, this could be integrated into the series or sent as a follow-up.
> 
> If you want to redesign private stack please take inspiration
> from insert_arena_stack_get(). Much lower overhead and no artificial limits.

Thanks for taking a look. Since it looks like v4 will conditionally disable
preemption for run context entry to exit, this concept does not have to be
tied to this series.

We'll pursue the private stack work separately, but will continue testing
revisions of this series.
