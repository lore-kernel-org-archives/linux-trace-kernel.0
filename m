Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1EC8F5B;
	Mon, 29 Dec 2025 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767048539; cv=none; b=Ymgnb7YPc5n0FqYTxb7XGkyyExB8XSFDzCXaxTdQWmkLEkcTMzPSW5+YkBJN6ftn3DPhYORoNO8pAgJfw6witIm1K7EVHrB6tGfw4hsSFHPX7AM0eRH2mzMrk4eJubEbZgzzJIkXS94WALwpM2g0DwoWiL2osQVGBxqzzIbcHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767048539; c=relaxed/simple;
	bh=B7NG9nFiNNKScW5AjDDmFVww46ldJFJkgPplkrxI/lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPO1BkM3GPU7iG/yhfLiVeiT66ZG4ZFs2+WoWkrrinTm21qFd4ca48nEjgQsUb3ikdczOgjWKw1u1R7Lk4CYn3JVZRfLl0MlSC5IOEMwWxPAKpn7UiwuQ+Mjis6IA5ctlC3ofooJ/LWc+eD4SI4GnhHI2g0HH4dT25f5PMAfJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=Rmdz8oWB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uLAqhLhq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="Rmdz8oWB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uLAqhLhq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 501C614000BB;
	Mon, 29 Dec 2025 17:48:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 29 Dec 2025 17:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767048536;
	 x=1767134936; bh=I+mKgNyt8REBLUFyoNxZmBuNP6m66JdvsPrH0uiJvm0=; b=
	Rmdz8oWBsfmBK0lha0iHDynlknQqVAuZiGeWgjMu6bRb2ojoHt8tls34mCm/4GdD
	yAKUM+6QrvkHjIyPiQxWFEaqlwOKU941fbpGN5Kfc4l+ssZcLZ2MwvCvDu/VJ3Y3
	j2Sd67VU4jSy3PYLoFpwZYwvVRr80wlV8eXe7e0qwrAwXEJSFZv7huDXbfdD6KRw
	oTXbVihfCGHP7OBPcyzqJeLJrf+4gRalwJYjN4djWbkzVpTe3zn/Z3pnLgAQv/BP
	oCX2Zd5qOlzTD/4bnJvvs8331m4bS9Pg+ZSM1Kzp4E6CCvDJORtF199MCSjuxkv4
	p6XKgYye8ih1A2mlihJayA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767048536; x=
	1767134936; bh=I+mKgNyt8REBLUFyoNxZmBuNP6m66JdvsPrH0uiJvm0=; b=u
	LAqhLhqo3PcatnZPbLAy8KzWpW7UH1win1H0OgKjUrJCm/lT4TqfBaRROVPz5uiZ
	xln8OqOSIrmRQV2oYzkh6D4fgWNx47vj/SLzGj63TgnPHNvqfxad9kHC0vX6CFh9
	OSVwhfddgtsbCZuO/yrZuuZ+eckYFPYBRSLAd1NTYkdilLujIvsat/GWLIEUPe8c
	iogCZgImrehEc2aLfOenbT5YdFUWSNV/GY6hDMnDLgS0QbeUqEbIaaYBDl1GSAIs
	lwUgc+1yhqjwDkxIFh/lo6GglfVzzTG6rmHXRg6O2hEf7U0+VGIKab9ulTawlFkb
	CndYdznaMQkomLAudPYdg==
X-ME-Sender: <xms:VwVTaUXxP_xcxH-cfGI9Cy6DlaZaQAOlLakVDv7INIXPFtuCTm0xbA>
    <xme:VwVTadhtJimzxOz8SejqtQEj7s5KfhjANpgodDxysJ_MUTlyLxuC2PXsa6kXdjV60
    R511Qdvm0UiNOPred-rYy9wEjRCWX0gI-8SoHo-7lQfjiSD7Z6IKto>
X-ME-Received: <xmr:VwVTacoErSA7XH_9fiNRO6EHxDdFKP5mFeE9ugpgmZChuFwt292RTY9LXB2dRZSYpv2iQ4Ff>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepufhtvghvvghn
    ucftohhsthgvughtuceoshhtvghvvghnsehrohhsthgvughtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelteehvdekvdfgfffgvefhgfdutdfgueeuvedujeelvdeluddugefhteeg
    tdetgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsthgvvhgvnhesrhhoshhtvgguthdrohhrghdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepohhlshgrjhhirhhisehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtg
    homhdprhgtphhtthhopehirhhoghgvrhhssehgohhoghhlvgdrtghomhdprhgtphhtthho
    pegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrmhhhhihunhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhr
    gh
X-ME-Proxy: <xmx:VwVTaTE80gN6e_ZYJphRkm1B_gKNO4Q-tbuqlTTfBxxxOMC6x8tWkw>
    <xmx:VwVTaR6jykbS8B9hLTycdJe9p71RxsJmuIvWOdSy4mgzOVL1Z2L8ng>
    <xmx:VwVTabdOSA51Wrl4zNUpjWW2TTg3xsyQb0pbtcWD1Biapdw4Rpx1DQ>
    <xmx:VwVTac4m3MEmjEijr6yxQwymNF9LCRzR69l7ThbxIxA9qBPp2krzxQ>
    <xmx:WAVTaVbJ-poVZB8Zn9NTBR9OsCe0_ElKPjDKTnM1_6DsmMX4RcfQf4g_>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 17:48:55 -0500 (EST)
Date: Mon, 29 Dec 2025 17:49:01 -0500
From: Steven Rostedt <steven@rostedt.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Allow perf to read synthetic events
Message-ID: <20251229174901.0e62eab0@gandalf.local.home>
In-Reply-To: <aVG2VoBpFoEEE1gG@krava>
References: <20251217113920.50b56246@gandalf.local.home>
	<aVG2VoBpFoEEE1gG@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Dec 2025 23:59:34 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> hi,
> I don't see the crash, but perf record/script gives me 'FAILED TO PARSE' in perf script:
> 
>   # cd /sys/kernel/tracing
>   # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
>   # echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=common_stacktrace  if prev_state == 2' >> events/sched/sched_switch/trigger
>   # echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(block_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger
>   # echo 1 > events/synthetic/block_lat/enable
> 
>   # perf record -e 'synthetic:block_lat' -a
>   ^C[ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.259 MB perf.data (1 samples) ]
>   # perf script
>   kworker/u33:2-w     244 [000]  1707.836263: synthetic:block_lat: [FAILED TO PARSE] pid=244 delta=21 stack=ARRAY[0b, 00, 00, 00, 00, 00, 00, 00, 1d, 72, 9d, 82, ff, ff, ff, ff, 0d, 7d, 9d, 82, ff, ff, ff, ff, 3d, 3d, 9e, 82, ff, ff, ff, ff, 05, 91, 9d, 82, ff, ff, ff, ff, 40, 7a, 42, 81, ff, ff, ff, ff, 5e, f4, 0c, 82, ff, ff, ff, ff, 43, 8d, 0c, 82, ff, ff, ff, ff, 82, 2d, 89, 81, ff, ff, ff, ff, 9b, 39, 89, 81, ff, ff, ff, ff, a6, 5a, 9c, 82, ff, ff, ff, ff, 2f, 01, 00, 81, ff, ff, ff, ff]
> 
> not sure it's fixed in the latest libtraceevent, mine is
>   libtraceevent-1.8.4-3.fc42.x86_64

Yeah, it's not supported yet by libtraceevent (fails for trace-cmd record
as well). But this should be easily fixed:

 ># trace-cmd list -e block_lat -F --full
 system: synthetic
 name: block_lat
 ID: 1871
 format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:pid_t pid;	offset:8;	size:4;	signed:1;
	field:u64 delta;	offset:16;	size:8;	signed:0;
	field:__data_loc unsigned long[] stack;	offset:24;	size:8;	signed:1;

 print fmt: "pid=%d delta=%llu stack=%s", REC->pid, REC->delta, __get_stacktrace(stack)

Looks like I only need to add "__get_stacktrace()" to the libtraceevent parsing.

Thanks,

-- Steve

