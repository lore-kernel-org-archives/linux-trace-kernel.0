Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446664;
	b=ZqF6tIl1did6Lt8dF6eNSbYpx9k5hXRGILShCfV/gBcca32INqssvLhuXf7Gm4JIl/4S
	 qh3fcqBfqqz962LAYE9+EQHuUGkwxybZSBtfXA61RI9LFPggYUc7Hicm1scG/uWWfz7St
	 LqjpVd68U8bVp1d4ZdVNUc0EafMdL3FWqOkwpqqYUoqGq4k4XW8l46jGObxTMAY0mNJhy
	 awD9D08qrr3eESzu9q8mTixDwRqiwh2tcFe+/qmTQpSNa/HWgJCSIkqfYQTTX8zee47XU
	 nxCITiW5zw4rtlvhZ7peOGNMIooW6DCqUeht3yc5qGnq7UMG8poUzm11RpsfJBLiZtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446664;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8Ykmtahhytsp3A9KXBQzHiI9jKjzeRibnDdGIikAvNs=;
	b=wEFj/qZJSYmUmsYBwvc1joZUIpYANze68NzCn5wjej0kNTa7ukx2MQyJKa5Jx2ATZYMm
	 ipKKOCEOXth5iO72toUbUYqWX8RiVKPOM64eFBTGArCX+iAY0XzL4nWQnAYn8dQz88MnW
	 o3Ltdi0pAw3NkPbaiCcFwA1TNsOsFv8/3J226ls6HHnmQFlf+xM24S326RpB5gMWIHbN2
	 KcJSaBLTg2nZyUkxJITO7DCeHYoCoq5sTV4F6ERG2NEcxT2gQmcVuD+swvz0avzvXgObR
	 4+rNKPvvHnaXmiQC65Xp415KSe1sz6VPlQG4XWP3/lBKOfb6F2YjkQ6gsatxLfbkHig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMRTp5Ib;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCAE606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMRTp5Ib
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E179E1F00A05;
	Thu, 12 Nov 2026 01:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446663;
	bh=8Ykmtahhytsp3A9KXBQzHiI9jKjzeRibnDdGIikAvNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TMRTp5IbSzABGtMFBJpvbXmY7rJ/OH7Bj7Oz/9n2il7jCuzVim5UAIemE5di4y0fn
	 j0BoDydc4M5A3MSbUfcgrEKTD12OLAtbdV2+L0GTpnbTRhcAyxyI2Paxd9mMuNNQo0
	 bLuPgWTH/FH8KgXMoMEg9Hj4GZY5ICceCU+83StjnFBGPzygTFuprZo9xrYntECHYs
	 fkTzEKdKwYKIAbMD1gBAOi+vwftmIyluODWkg8XnnZCOHOhdyUJh5UK+fVPaad3z+y
	 25hE/x+QMz46uDwu7qCtuYKA/9qM6G04DK4+/B3ui/NUbMm+k2u56F3QWuUvX0sXPY
	 5X7zdpkF+2wmw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] tracing/probes: Validate command prefix in kprobe, uprobe, and eprobe
Date: Thu, 12 Nov 2026 10:24:21 +0900
Message-ID: <undine-1794446661417300537-4e515beebdcd7bb3@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-204257@kernel.org>
References: <179418408457.227715.1485179201014819821.stgit@devnote2> <179418418328.227715.10680131052179044845.stgit@devnote2> <sashiko-outbox-204257@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 00:47:27 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Medium] tracing/uprobes: memory leak in __trace_uprobe_create() [1]
> --
> 
> commit d4f1d831d5c45144f78113e0b3ef37e7d6dc9844
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/probes: Validate command prefix in kprobe, uprobe, and eprobe
> 
> This commit validates trailing characters after the command prefix in
> kprobe, uprobe, and eprobe creation, rejecting invalid characters with
> BAD_MAXACT instead of silently ignoring them.
> 
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 14ac52aebe346..3745eb07bd14e 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -616,9 +616,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
> >  		return -E2BIG;
> >  	}
> >  
> > -	if (argv[0][1] == ':')
> > -		event = &argv[0][2];
> > -
> >  	if (!strchr(argv[1], '/'))
> >  		return -ECANCELED;
> >  
> > @@ -631,6 +628,15 @@ static int __trace_uprobe_create(int argc, const char **argv)
> >  	if (!arg || !isdigit(arg[1]))
> >  		return -ECANCELED;
> >  
> > +	if (argv[0][1] != '\0') {
> > +		if (argv[0][1] != ':') {
> > +			trace_probe_log_set_index(0);
> > +			trace_probe_log_err(1, BAD_MAXACT);
> > +			return -EINVAL;
> > +		}
> > +		event = &argv[0][2];
> > +	}
> 
> [Severity: Medium]
> This problem wasn't introduced by this patch, but can __trace_uprobe_create()
> leak tail [1] when generating a default event name?

Ah, indeed. I think we should add __free(kfree) to tail.
Let me add another fix for this issue.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
