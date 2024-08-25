Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10E2F5A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724605281; cv=none; b=KW4uT0GAZ8BRMcyPYDV/XWzHMdi52exU/1RZFkhJOZdeRtWUhsHMctblCv4Sgf7uNKCHNUyEV6nPv1NUxjmXE1DdTo8vCNgIMS5+dAtzED0nVBJJLRGo8R5vlMMtU0LJ6K5y6j2RTwaK3A6CbXYZlUSkmLOcKKcZakfrCWdoQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724605281; c=relaxed/simple;
	bh=Xv3hW5NO4nk6bd87Lk/aAw04TD8pzP4OdNhf51nvEuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP/jjp/jNqbc0OZABAE1tWiT+RrtP0nk25l3mUemZWHbUaiFHl5CImiMp5iigWXDpYH4LcmtpH2DUfzfBKD/nwE0TWQn7KHYQRj5CELgqf+wydjJyMeztchd+68+Lkyzbe8jmLhDy2XlUzdM/dDxwSCsZ/LVy969VIoKegwp6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RomeXe02; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RomeXe02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724605278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xv3hW5NO4nk6bd87Lk/aAw04TD8pzP4OdNhf51nvEuE=;
	b=RomeXe02pSMOzM0OQuiDrf1+4plUDbg2vU5o7gfv/wZlJyhqp7NBvl5dgHabkpP1eZ/Mqu
	af8MudjYrewoqaSqAb0P0M3AKj5Vt+kbAK2+MtIB0z4qRYeUAjJiLYtf20EMyVfO0O9tZw
	RO3mOjYPOGNRqhHnNe2/zZej/INOG0U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-RZttRMc6NfmQSYk1kgztGQ-1; Sun,
 25 Aug 2024 13:01:14 -0400
X-MC-Unique: RZttRMc6NfmQSYk1kgztGQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC7C71955BF7;
	Sun, 25 Aug 2024 17:01:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D2DCF1955DC8;
	Sun, 25 Aug 2024 17:01:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 25 Aug 2024 19:01:04 +0200 (CEST)
Date: Sun, 25 Aug 2024 19:00:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Jordan Rome <linux@jordanrome.com>, ajor@meta.com,
	Tianyi Liu <i.pear@outlook.com>, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240825170057.GA3906@redhat.com>
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240824024439.a37c41bab87dbdf3d0486846@kernel.org>
 <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/23, Andrii Nakryiko wrote:
>
> This is a bit confusing, because even if the kernel-side uretprobe
> handler doesn't do the filtering by itself, uprobe subsystem shouldn't
> install breakpoints on processes which don't have uretprobe requested
> for (unless I'm missing something, of course).

Yes, but in this case uprobe_register/apply will install breakpoints
on both tasks, with PID1 and PID2.

> It still needs to be fixed

Agreed,

> like you do in your patch,

Not sure...

> more, we probably need a similar UPROBE_HANDLER_REMOVE handling in
> handle_uretprobe_chain() to clean up breakpoint for processes which
> don't have uretprobe attached anymore (but I think that's a separate
> follow up).

Probably yes... but yes, this is another issue.

Oleg.

