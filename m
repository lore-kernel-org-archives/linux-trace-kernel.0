Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596428;
	b=XAGUpid879lUE7GRoIRgbjR5tN6h+974iiQ17GSF7aLDwGrd70K0NUDVeHiVg/X2cTCM
	 QbR6JnRcuEaR4YInR4T2O4BySP1a6RH4ScaMyQv3Tl5vHRi2IIcD8tZhSHkIy3tiEsC0i
	 trOG88yTNv8JUeUacEvW9sx15xUd3qzT9zaDEgSgED3gyeHcb2ihHhlDBkHSGlIvAl4cd
	 Y9S1eJpzVeVVHMlBwzk4EtZgN/Znk+fBCqXvjUx93CF0Ruwf41w9p8UuuDq8QhmiIzGuz
	 T7RjdDkpzmmJlzmAD7qQN7ml1NEKq31HclmVPJsclu22v9aHDwvy6VatrXsUHnk/Fag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596428;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7u12V9IkOC6OCXkyrR+5JkrF5I55CVZGjObxU6YEcfE=;
	b=NwnbDE8c4TwxlhBsPNXXZC31OteB/sU9VnVO8WTeJY+hJ665Y2FNjIxbdDeqBj4c2VNP
	 qkGEvldnvpdSSgs5arapMWGlrTrXO+x9uQWYNKsf4wnV9Rw6iSuAdVjMVEENsKXkyFYX3
	 8k5/P0WK0dn5u0g1dc8caTUYzZKNZGzh8PMO87Zyogh1smkkAjUeHIZnoL2P0HPKSPv2y
	 +xP4fT55E73qEYH1WWqfDopcdEQjonhRmugI8N61MHLvMq7eO5cXWwuwXadvxWpK/mDhs
	 +KP9EEC3U+DF6IZdMDupGIwCPsTCofQmhUl7QS7hHbZUMw0a9OIUvr0JbocjmMttcgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=drBWN0f6;
	arc=none smtp.remote-ip=95.215.58.134
Received: from mta1.migadu.com (out-134.mta1.migadu.com [95.215.58.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB1606A31D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 15:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71EB1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=drBWN0f6
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+P6E8QMJjylqUM1Utclh5doG1xiwTif64c3j63D7imU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792596425; v=1; x=1793201225;
 b=drBWN0f61iezmAUCy9GyBFw7OcdUaebMKu/KkuGdg5Av9x58dmjth6iJx7SQNuALWismj2Cq
 JGbKemdCPxYcDFA4lPK9AKB0/3l9l4xKkw4Qu3IP4pFyDDgJRVNPTiyRtu6+/v6buRjQBimx2+B
 wqEspHJiY5v5l5YFtkMZ+1BE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 177ceabd93ead9d1;
	Wed, 21 Oct 2026 15:27:05 +0000
X-Mizu-Trace-ID: 177ceabd93ead9d1
X-Migadu-Flow: FLOW_OUT
Message-ID: <d4fc4fcd-3691-4122-8b3e-a75447956255@linux.dev>
Date: Wed, 21 Oct 2026 23:26:53 +0800
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
Subject: Re: [PATCH bpf-next v2 5/6] libbpf: Add bpf_link_create_log API
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
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
 <20261019153628.15912-6-leon.hwang@linux.dev>
 <CAEf4Bzbr46UkiE1sbb+Zwcs0S1ejpKmtTGjNCAkWD-J6FRcPGQ@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzbr46UkiE1sbb+Zwcs0S1ejpKmtTGjNCAkWD-J6FRcPGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/10/21 07:25, Andrii Nakryiko wrote:
> On Mon, Oct 19, 2026 at 8:37 AM Leon Hwang <leon.hwang@linux.dev> wrote:

[...]

>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -484,6 +484,11 @@ LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
>>                                enum bpf_attach_type attach_type,
>>                                const struct bpf_link_create_opts *opts);
>>
>> +LIBBPF_API int bpf_link_create_log(int prog_fd, int target_fd,
>> +                                  enum bpf_attach_type attach_type,
>> +                                  const struct bpf_link_create_opts *opts,
>> +                                  struct bpf_log_opts *log_opts);
> 
> Leon,
> 
> how about instead of adding this new API, we try to repurpose
> bpf_link_create_opts' iter_info to be used as log opts? we have this
> right now:
> 
> union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
> struct bpf_link_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibility */
>         __u32 flags;
>         union bpf_iter_link_info *iter_info;
>         __u32 iter_info_len;
>         __u32 target_btf_id;
>         union {
> 
> 
> that iter_info/iter_info_len is a bit of a legacy before we had
> per-attach type union, what if we add iter section into the union,
> wrap iter_info with union and put log_opts there, mark iter_info
> deprecated or something.
> 
> I'm not sure anyone is actually using iter_info (I didn't find any
> uses in Meta code base, for instance), but we can detect its use by
> checking iter_info_len: if it's non-zero, then iter_info must be a
> real bpf_iter_link_info. so we should be able to detect this just
> fine, the only downside is that you can't use log_opts and iter_info
> simultaneously, but I think that's fine: you can update your code to
> use new iter.info fields instead, if you need log_opts + iter_info.
> 
> WDYT?
> 

IIUC, the struct bpf_link_create_opts will be changed to

struct bpf_link_create_opts {
	size_t sz; /* size of this struct for forward/backward compatibility */
	__u32 flags;
	union {
		union bpf_iter_link_info *iter_info;
		struct bpf_log_opts *log_opts;
	};
	__u32 iter_info_len;
	__u32 target_btf_id;
	union {
		/* ... */
		struct {
			union bpf_iter_link_info *info;
			__u32 len;
		} iter;
	};
};

Thereafter, iter.info is preferred against iter_info. And to keep
backward compatibility, iter_info is used only when iter_info_len is
set. But iter_info_len and iter.len are not allowed to be set at the
same time.

With this change, the bpf_link_create_log API can be dropped.

I'd like to drop the bpf_link_create_log API first, then add iter.info
in the series of log support for iter link_create in the future.

Thanks,
Leon

