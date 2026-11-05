Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887638;
	b=b6G4L/rDyPPijG5LiMnGCpjJpkORd0nnZ3ntFzXpD4dvhuYO3nGmExJuCbaWCFz/FkVR
	 fA7N68pau2ShluYRSJghkY1DSXTjO+9RdICAMQllsEXxH78RPLTrsoyy7aBTWxpFDTYm8
	 bSctYq5V7XbWQq89zWWhrSasuAaaSidxbJHr5BVF9/N7D3sQSOlx1EL0G3PT9VsgkN9/X
	 ZCbJRABn2V5nLSsiS4tHQF20VK9pgzHwZtfFE1dP1wAc1DiXjrDnT2/AANeSj9qkFcllS
	 r4zSbJTc02rFAV6F6FykxLYri9D56+42lpQIr+c+LAs4IEglGmJODYiCzeeSPEE56eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887638;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=Utls/voivKi+vOuiVuSzZkWsQ+D1Jb0FNwOt2/GW5DQ=;
	b=m6q5aqNKRAehewIZP7IcZZGNp3+nG6gWRe3LaNX8Nez35u1GyACTJwBV8ZLdo5PdUvip
	 P4itTTtMu+ByzoPH7GPWhS9W++/B7r6k9UVUtUhWpChfIPXvRXfbwJRQ7kfVOVpMzQyem
	 7aM6nr4bHzRjNjInfEgo7pf/KNVo5ZD05Qf2olFZXThgRfAE7/grIDqToL7/O1eDinqNv
	 HGNVPJy2GBlq2bED3cZiO4/8nH2K2M2gI2NayUlXvv2rftSyPuf1brHBJmJ3OE8bZtMx2
	 zLt7iNpRuyMClin3rGl2TlqozDWNbwRluDMtCOKcadgk2MLzvJnoFBRYkfZvZOoGmSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=UmEpDNnc;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFA606A326;
	Thu,  5 Nov 2026 14:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64EFA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=UmEpDNnc
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2D87B160A01;
	Thu,  5 Nov 2026 14:07:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 2828A6000C;
	Thu,  5 Nov 2026 14:07:08 +0000 (UTC)
Date: Thu, 5 Nov 2026 09:07:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ring-buffer: Skip time delta validation for the
 counter clock
Message-ID: <20261105090706.19ed0e07@gandalf.local.home>
In-Reply-To: <CADZg-m0FeLntAS6XxE-kc74vwH-jAh+jXT68qnVwXuHZNUHzfA@mail.gmail.com>
References: <CADZg-m04iG5kCZ5-yh=Vz_ysYjVDGSYn3je4_-8AzWWfiC-bXQ@mail.gmail.com>
	<CADZg-m0FeLntAS6XxE-kc74vwH-jAh+jXT68qnVwXuHZNUHzfA@mail.gmail.com>
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
X-Rspamd-Server: rspamout06
X-Stat-Signature: br9t7qdek5pz77odheo55xarxjukw1eb
X-Rspamd-Queue-Id: 2828A6000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19m525yaZt+H6oGT1CRSKAne1XcflCJr5E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Utls/voivKi+vOuiVuSzZkWsQ+D1Jb0FNwOt2/GW5DQ=; b=UmEpDNncah1cps5RUnv6BgwixwT3Oc76JhZxj9cNfkv3zTwkF6M9s2B3EuNKt1yrp9j5AO1ND6uI0Qaamql9toycoDei7UP3vLwzZfIip/f8nM74NmikfLK5rJB88voThbnFlDky2Q2YKD0wldFvNw6vvIQu9NmtFed3Yvcc7FE=
X-HE-Tag: 1793887628-646376
X-HE-Meta: U2FsdGVkX1/v+RTy4pn4UivDt2OggKZ9IvuicZWGOYMuvZoMPPygV8iOsx+7Sho5F4Amu/FLqFWe8do4ZL8eYsZSTy1GgM1DKbMW27PojUF4vBAuTGtBzCAfS4arVmjjpOOiZDKgwhpuTsBgbYP0/CYuSejwJ10ubIvRZYuqy574rZkFTB6+ykZEyeGUrirZjy4LbxWBUdQXLrlVyNDoKRcnYOfliC5PfNBhWhfGouzJzETDsMJh3mP2ej8NEx6Z/1wIAQL3eli+yYK/2B/yrdZLckBXnpZ2qQSSYCiXNY7RTFFG52v+j0kc0P/D7ZYmvae8s3CYMZ4zLPVcIjxCZ09wqvvNbtUpRbDp5JwYIeNmF5NBmXWc6jB+mmhyQX2aaX1klIvJsAnHOIh+Voe6OBzenCBM2Q1Dm88Txq3ApSLKupVeKNQBgs6w/P4e9rzF1RvJ8wCSGNVR8JU77sNkpiXRxySqJIdsrQHj/zanzvIJlciVy6nbTInjJUhgkhDXfFrOFErsyts=

On Wed, 4 Nov 2026 14:42:00 -0800
Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com> wrote:

> The counter trace clock increments on every read. Time delta validation
> assumes that the clock values read while reserving and checking an event
> can be reconciled with the deltas stored in the page. With the counter
> clock, this assumption can fail for an intact ring buffer and report a
> spurious TIME DOES NOT MATCH warning.
> 
> Skip time delta validation while the buffer uses trace_clock_counter().
> Clock selection already resets the buffer, so events recorded under a
> previous clock are not retained for this check. Recording and reading
> counter-clock events are unchanged.
> 
> Link: https://lists.openwall.net/linux-kernel/2026/09/20/1283

Nit, the above should be a lore link, but thanks for doing my todo ;-)

-- Steve

> Reported-by: syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=eb74dca0d1eb3ec227a7
> Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
> ---
