Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026883;
	b=lnB1wW9MQpzMefKlyp7B7o92qzpTPlhDy1uFdxdGiXNYq6b3u6BL1O3lM15POwu5DSR5
	 qeJ4f/566LvFryYCgmnHBPUgEsA7UGN64kh7RlVqeCEx3U1CYxh51C+tKWD+oZE4fw2SB
	 P1hOXa+LPSA4NbXEBZ11mRyXCi7g6EMwVkXV8qZrBn5JNJ037nJqMHhvEKZWWQya+pwQT
	 koAEEJwG9UgPDjJziPxlP+67SX85sc8YK+/wV74yGI7uAJCtNLeaSxeKg8bzepfKgF782
	 Gbeqz+LzIKGxoJAiR1CrV6DqqfPqvX3xoXxPOt6Rqn36Q9ev9JN2rHZcryV5mJoHf0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026883;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=V5uRR0fGp6Mv5MkEfq++LiSH5VSoFNbj1ogiDg+BVL8=;
	b=ZTNJNBDgF6jzzpzjoSYzSOm/5XLgI53uV/t0IKkyGNJBIRz0p0ui5WdXjtz7OxpuMrCU
	 ImKpIdxG+s1C5jkBmad7IpJx6mwuq/M0PlXO31ASjgdcoNZRPjtw/76cvB8cwKa5RP2+5
	 SoiWpaqQjYygDAh5snwjP0zv5CJXMYJx8a0fw00YzVltkofEwgBd2mNC1+3VVuG3VvojO
	 XrhKcpHGvF5Qe1T8b5VnWXocypgJ1WrxbLAgE73KSzJFcLL5cLSLKQgEbW3Ii40lh1rMO
	 3J175uNBQulQ3RZktpiao87+zbNPDqE3Q4tmu5p4MTIRnY+5Rbt9PoSkNHy7QBWZ3ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=u1LcPahT;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2594606A32C;
	Wed, 18 Nov 2026 18:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2594606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=u1LcPahT
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 55DB5A0866;
	Wed, 18 Nov 2026 18:34:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 7EBAA30;
	Wed, 18 Nov 2026 18:34:34 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:34:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Yifan Zhang <yfzhang23@stu.pku.edu.cn>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing/user_events: validate dynamic cpumask
 size
Message-ID: <20261118133432.47caf6c6@gandalf.local.home>
In-Reply-To: <20261104213929.GA65-beaub@linux.microsoft.com>
References: <179367391951.8187.1770217673912340635@stu.pku.edu.cn>
	<179367391951.8187.4749000539954371762@stu.pku.edu.cn>
	<20261104213929.GA65-beaub@linux.microsoft.com>
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
X-Stat-Signature: inj3q51u48ztu6cbpspy7cjxirg9huq3
X-Rspamd-Queue-Id: 7EBAA30
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/L/GYM1ZreQ9Y5WZnD86syELvVxtWQgq4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=V5uRR0fGp6Mv5MkEfq++LiSH5VSoFNbj1ogiDg+BVL8=; b=u1LcPahTzJ8TzQT7ZAqv66Q/NJGMxQ2Oo/3rbrpbsLHIQwD4obSD0I3fELf1b+qKBlGtRZMDbdfoml3ifOxoj+f9fOIi+V0+sW7t6E9KzEYs2rdcPniOiA4qb4lwAlGGCu6eDLefHXGkimr6KYDT13fm2cYI7mPsgBn7EdCGDQA=
X-HE-Tag: 1795026874-124051
X-HE-Meta: U2FsdGVkX1+fsSbsdzc/vfgkOTzWDC2shMd89wmRa/Aaa4AT/Cn6rY99DvLHfTabFtwvA+pdeVxW0gS9VR/jsmFBs8XxvWMQkFcs+jDvwL25p+AORCM8LLvzHMCFsZ5cJFCsuCgcgSVIRIjWWuY38mgTT3BbATY9E1WqfkWfmBvuS8ibSC8BN3cs7fqE5+6ijDUHGJuW3ss+mIB+kWRZhVKw7V1+6JRwKmxHdALdyX6wE0DufYtBx5fgsSoIkMSkyaytsHHKkUnYavXkTHniEAvIgzJKFig2QluWvdpcGCeM42DSPJ65xnzUDiYjJn7OVDOimoRGimaxVRyr0NABshh5SzLHGYvV

On Wed, 4 Nov 2026 21:39:29 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> 
> Hey Yifan,
> 
> In the V1 there was a repro case where this value was a __data_loc,
> which defines where the actual data (and it's size) is in the payload.
> 
> There isn't a type min-size requirement when __data_loc is used, this
> seems like the bug resides possibly in filter_match_preds for
> __data_loc cases? See comments futher down.
> 
> Steve, do you think this is the case?

Yes, this patch appears to be addressing one of the symptoms of the bug but
not the bug itself. I ran the repro.c from v1 and the format file has this:

name: ue_short_cpumask
ID: 1969
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:__data_loc cpumask_t mask;	offset:8;	size:4;	signed:1;

print fmt: "mask=%llu", REC->mask

The key is the "__data_loc" which means at offset 8, there's a 4 byte
metadata which has the real location of the data and the size of that data.

The bug is real, but this doesn't look like the fix.

-- Steve
