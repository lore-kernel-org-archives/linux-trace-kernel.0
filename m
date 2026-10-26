Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027224;
	b=QfGwzPmrLZZ0HTq6QNAS02SfoaXPiCEnNa2GkSjnYtvK1Yq4RjCGCheoWZKIgR1emAdT
	 qpCCpKw9nDfalkpIvV1tUDf3C/NzhGyzZD8KfCowZjZHnEmh8QG1dU5Nc47Lu5FEI3fMp
	 FoxN6wlkGte/1rMoXLYhJv0dbY1yr5SuTNjsJdnAjQk3g8sEGWEgd/cX33xf/c2hbMyO9
	 C4yAcBthpxszGUNOlsmJI4E3JKsBKENh0ooCVrrzkUg8NqI4gbIoUGuXgNi8kfiRi4llt
	 c23iA8AvKv8mRZJRDLQT+RIokOsrXFUwR6OImaZcy/TK/+I0xUndXSr58vhU8bxS8BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027224;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=J0h2FhD1/ZqD4NmuBs6+MD7h5IX24/kXFYvf/GTy2DY=;
	b=fOfKpC7pQPVfW3FMtnBOJS6CjS8zaLaS/6jc8Pztl4ThfPjOFHBYGQZqeJJEGJZavrME
	 iLHqsgNEBjWaNiZTDtFR8wRdHH26t4Rqp8xMalcvc56bbjocCBB3tIHY3HyKt85cT4Bkg
	 3pEOkbz/CnHF0pxwA9eYjgDtnm6hCTAyU0AI+W0AHOR7VHFNiZp6Ij1XEMk9h92X02TlF
	 qN1y2MweuD7qnlNF0DALcAZGJlrQy9Nll4+33TZj7xZiDsNqkDxPmr+oHN2zQfh8f3oq6
	 NH04z/Bo7y2tAJN4KTa87Wg0azNH6FCY/BCe0GV9j56QzQf0LBq2LRUoiWULwc+EMlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U1jWtkhE;
	arc=none smtp.remote-ip=91.218.175.100
Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC0606A31B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 15:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9AC0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U1jWtkhE
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kiILAlyer4KDpB0b5u3nzcUamLQxdEs4r06HO3T5veo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793027221; v=1; x=1793632021;
 b=U1jWtkhEvPVicrPfdsHIpVLOXo72c7aLMno8krFfUvbgKnzQsQpIlLhKe3tWUCA4k/pcRgwN
 qErXJJ4YbcFpURTDKybz1aMWxpjWl0W3BHrLy0z/i5nPS7cZc4kBHMa7M0k/VJ3qs7NRUf3T0cZ
 7lu0GyCuVUrxV99CeJ12NyK8=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 873537cec047169a;
	Mon, 26 Oct 2026 15:07:00 +0000
X-Mizu-Trace-ID: 873537cec047169a
X-Migadu-Flow: FLOW_OUT
Message-ID: <f971dbdc-cc00-42fc-8989-5e6460f88c22@linux.dev>
Date: Mon, 26 Oct 2026 23:06:51 +0800
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
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add syscall common attrs support for
 xdp link_create
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
References: <20261024153608.58569-1-leon.hwang@linux.dev>
 <20261024153608.58569-3-leon.hwang@linux.dev>
 <DMDIVEW7P9QN.1TB58XDPD7V3A@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DMDIVEW7P9QN.1TB58XDPD7V3A@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/25 09:19, Alexei Starovoitov wrote:
> On Sat, Oct 24, 2026 at 08:36 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>> Instead of passing bpf log or extack to bpf_xdp_link_attach(), pass an
>> errmsg pointer to receive the kstrdup() error msg, because
> 
> [...]
> 
>> 2) passing extack will access underlying driver string out of dev_put()
>>    guard, which will crash kernel when the device is unloaded
>>    concurrently.
> 
> Netlink does exactly that.
> rtnl_setlink() looks up the dev with __dev_get_by_index(), so no refcnt,
> do_setlink() -> dev_change_xdp_fd(dev, extack, ...) calls into the same
> drivers that set the same strings, rtnl is unlocked, and only then
> netlink_rcv_skb() -> netlink_ack() does strlen(extack->_msg).
> All extack users work this way. kstrdup() in one of them fixes nothing.

Oops, I was overthinking about it when self-reviewing the patch. Failed
to verify the describing crash issue just now. I should verify my review
when self-reviewing.

> 
> Instead of patches 1 and 2:
> 

Will change like this.

> 
> I'm think I gave this suggestion earlier. Why did you go with strdup()?
> 

Sorry for my overthinking. Will verify my review to my patches in the
future.

Thanks,
Leon

