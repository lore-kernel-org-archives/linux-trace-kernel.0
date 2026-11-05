Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887944;
	b=jbvJuezn99nvhS3iBbdYTCFU2KMZIuxZYPykQmUeujW4VVYG6bt7ZLDUC9W7NYq/cgfd
	 UJ6owJVcqrl/zVysw/aXvtfLUzsJYDGCoJFUxDWbO5k0kfPA3kx9EE7+UUt6QC+QqAZaU
	 0bsz8NbQwUysZiJeTOlCVBw/1Ps5lVMGAX4/F+Ak8lZFPkkzBxFUPdis4OujwOMSjCWc6
	 7whez2+l6hmprq0Hno2nO1Ot6ct9r2p3Cl/dwK9IqRGvGl7P1dcNS3t2hKGz1N1ELBRYP
	 kIMMnoxHAYsHiPSQWAJnYSGeZJSC1B+MdukDgH9J4Rbl5X6W58aBGLkC4v0L1Tok83w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887944;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=ZuyZA80OhXsTCt9eMx+qhWTC4yMPIt4JU/oWRmBa8MY=;
	b=K1YyZ1ZXNIJY0U0UUSePj7E0nw/8zyNtFktWoOn03KNCqwvS4btMBs+YHQiKkM25flFY
	 qGA8SASi+b1nY+R78qpLL2rm/NUo1HXmuDR3Ls/z5hbDLi2W4FCv+xDFkVjC7VBqkVlk8
	 IlLS4nWsla5Osaz8nnWo/b0/i/EQvh5UUsGX1YiFrDQDevU4NR/TaWEzuaU2E4cdzqosI
	 +ZGxS2cojpQ0sFJmANVtcTeHknRyJCwryrkg9DyJO8V1WE2W0onacKvPyfurHudM7Bggg
	 IsRLu/3PyBvKcyjUICZozRIypPYYdQXY+yqRz3wBUosqsmFjHm1L1o0hGUs+pOIQJgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=CoEvBoFU;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D5606A31B;
	Thu,  5 Nov 2026 14:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F30D5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=CoEvBoFU
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 8CC92C0A0F;
	Thu,  5 Nov 2026 14:12:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id A0FA617;
	Thu,  5 Nov 2026 14:12:17 +0000 (UTC)
Date: Thu, 5 Nov 2026 09:12:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ilya Maximets
 <i.maximets@ovn.org>, Matthieu Baerts <matttbe@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, Adrian Moreno <amorenoz@redhat.com>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH v7 0/4] tracing: improve symbolic printing
Message-ID: <20261105091216.7b91db5a@gandalf.local.home>
In-Reply-To: <20260922110955.363677-6-johannes@sipsolutions.net>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A0FA617
X-Stat-Signature: 9993ajdnkirqqfjgyiomy5txnkn16gat
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX191ERUTatcYnoDmb5aynzKQhqeeWSoD2RY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ZuyZA80OhXsTCt9eMx+qhWTC4yMPIt4JU/oWRmBa8MY=; b=CoEvBoFUueQ3s0mIEHKt46mqrflONFVjmmGg+zX6vv/BfOfO8LdoAL4s3r2saFOQLG8D6fxNi2pc9U6aBgQLyEKkxyzMEdmBOQXPfwVBsTMLwAOnnNGceL5vlHEToRsYXZD99dUWQWA6MpjLsDzYG0fOcodpoy7/lnnfQWybRpo=
X-HE-Tag: 1793887937-685124
X-HE-Meta: U2FsdGVkX1/3Wbpykymbkbb57VjYh0s2galJtG36rRIQW8TFwF+7E1IJjuw5NQAe25/iGWZNNQkyWT+a8422ISmZr96XK0nrAaQEFQ31qsZFoK0bMu8VBRYn6VvL73Iw7iM4mAs1x7vNeYUjyjDL3c/1373Vt3UVfuGBr/aheInp1BwjeQU4qskhLGjIZGxpuN+otXBJyaLAJMwU6vzQo+EBFJb7W1XoOglfKzxERKt0tKBVJ/xeoz5nURvKfDVGujYLXLVXYpN//WLEhk/vitnw4QDZ/T+mJ5xxRO8fWuMWQYYJurNrpktl9UUR14fwSJm2i229vjqGi5htXXN/jNCATliHKrTLZR9dxCLPnqYqpd0721dllAu7XYl6dDQKXFCyDNzz0Bkbs5xaOdHP9A==

On Tue, 22 Sep 2026 13:08:39 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> Hi,
> 
> Resend with the selftests and the two sashiko findings.

Hi Johannes,

Could you also add code in the samples/trace_events directory. Perhaps add
a new event?

This will make it easier to understand exactly how to add new __print_sym()s.

FYI, this series did pass all my tests.

Thanks,

-- Steve


> 
> v2 was:
>  - rebased on 6.9-rc1
>  - always search for __print_sym() and get rid of the DYNPRINT flag
>    and associated code; I think ideally we'll just remove the older
>    __print_symbolic() entirely
>  - use ':' as the separator instead of "//" since that makes searching
>    for it much easier and it's still not a valid char in an identifier
>  - fix RCU
> 
> v3:
>  - fix #undef issues
>  - fix drop_monitor default
>  - rebase on linux-trace/for-next (there were no conflicts)
>  - move net patches to 3/4
>  - clarify symbol name matching logic (and remove ")" from it)
> 
> v4:
>  - fix non-module build and possibly dynamic event handling
> 
> v5: (https://lore.kernel.org/all/20240614081956.19832-6-johannes@sipsolutions.net/)
>  - fix build warning in non-module build
> 
> v6: (https://lore.kernel.org/linux-trace-kernel/20260921101538.97286-6-johannes@sipsolutions.net/)
>  - rebase
>  - fix nit from Paolo (I hope, I don't remember changing it
>    but it looks fixed!)
>  - fix crash due to wrong data placement
> 
> v7: (this version)
>  - update ovs selftest
>  - don't ifdef drop_reason_lookup() prototype
>  - fix section alignment
> 
> 
> To recap, it's annoying to have
> 
>  irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:  ...  reason: 0x20000
> 
> and much nicer to see
> 
>  irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:  ...  reason: RX_DROP_MONITOR
> 
> but this doesn't work now because __print_symbolic() can only
> deal with a hard-coded list (which is actually really big.)
> 
> So here's __print_sym() which doesn't build the list into the
> kernel image, but creates it at runtime. For userspace, it
> will look the same as __print_symbolic() (it literally shows
> __print_symbolic() to userspace) so no changes are needed,
> but the actual list of values exposed to userspace in there
> is built dynamically. For SKB drop reasons, this then has all
> the reasons known when userspace queries the trace format.
> 
> I guess patches 3/4 should go through net-next, so not sure
> how to handle this patch series. Or perhaps, as this will likely
> not cause conflicts (in fact I've been rebasing it for years now),
> go through tracing anyway with an Ack from netdev? But I can
> also just wait for the trace patch(es) to land and resubmit the
> net patches after. Assuming this looks good at all :-)
> 
> Thanks,
> johannes

