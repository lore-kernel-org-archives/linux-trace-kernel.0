Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371A184F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661583; cv=none; b=L1IEZbQ4pLsvqm8YZ+tAkRZyZFUE72WafUogG/D3eLPmp37XzXqztwz704Qn/FtQrhTsdFR6wIilVHe2bzXPEaMTPLbwQGSLBN32PryHITFAwHxTUP2EFxFVj6LPqgaaYk6i81Opmhj/JewEF3QOM1Pwn9dq0oa0n18Y4PUj0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661583; c=relaxed/simple;
	bh=J/Af+q/+G5EdzpIALeJ0Em187C5NEmRJQVgUzDKulro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAAEdiuQ/r2zHkXmmxJDMdsXRJqPGfNVF8wgF48vVX4kjujniP26QcQUd9chul4WB1h6eyUqt3i3080ed7ox35iNihc3iE7YA86eoq3RJKvdZex3+zD3ZIrpyEcjX39FaQ/Apoa8cwrEIEjfwDvy2vO0SIG5Aiuu07uwRmgmvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YqnxiY/i; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YqnxiY/i"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d03fde0bd9so40897521fa.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706661579; x=1707266379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9FCNsq83M/0UbPD7GFdEOcSc23GjT8FA+ckKBKN0U0=;
        b=YqnxiY/iXiWnxZnNUQAm6KxVTn9VAe8Yc8YdYTVW9zaptHcrFQZp84/MIsNfiYELqd
         /IGGDHmpDlrECLV+ZNvOOYNW6idRD0NVRRCgrGio2VhaurSK2m0ftM5MuVfhBJITCdX9
         /0OkkjKJ1TCKGO8wQfDyQsRvA09xt+s/nCJuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706661579; x=1707266379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9FCNsq83M/0UbPD7GFdEOcSc23GjT8FA+ckKBKN0U0=;
        b=HlTlmPg8tjCzcyPNCOueNSxrN40F+UIr8umh9uf4GX+tgVSw85P+hqCAlwBcSkynOE
         EwRZAqoxnbkmgi12FHvSbLKxwWnX+vwYB5FNPKaXHQ3RJdmDcXL30OUGoNhcsPn+ECrQ
         qygSuApOSk0a4emxPNn0g8/mnhuCO8gugbH8rHKwQ64Ou+9lpOxk9trIcSH3MmA/4sf1
         KMZM/bCHxzmNMfGP49NG2pDVJJqoywBtGzRHd2S51/PjAlrQ+z5wqT1KGVj5xFAa6HFp
         jHTancnupIiU9KfaxXP34Eg/UniznwQ81lnKuB+3K/gDZBFkuH1f8klEIv5ApnVcba/u
         9S4w==
X-Gm-Message-State: AOJu0Yzu3jbtEJaEY4wTuFHLj9kNrNlAmzFtN70L/Ud4XBukM5UhRwcV
	CW/yVskYBK3/Wrt0jGSETQCSNVTmrTPP7WC2rCs2bvZgk31RgOS3qMwItLt2AXOn8QEGcb05GsC
	c/MF1Og==
X-Google-Smtp-Source: AGHT+IFFD73h4UeTq1nb215ed7dpDLRQ4cXS3EA2jFs7nozkaZyRcRXhT3jI9P/tKFy2SOaBuRQV1g==
X-Received: by 2002:a05:651c:210c:b0:2cd:c811:6a24 with SMTP id a12-20020a05651c210c00b002cdc8116a24mr90092ljq.18.1706661578673;
        Tue, 30 Jan 2024 16:39:38 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056402530f00b005598ec568dbsm5377714edb.59.2024.01.30.16.39.38
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 16:39:38 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so2663165a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:39:38 -0800 (PST)
X-Received: by 2002:a05:6402:3126:b0:55f:3fc1:a8b7 with SMTP id
 dd6-20020a056402312600b0055f3fc1a8b7mr1454edb.7.1706661577815; Tue, 30 Jan
 2024 16:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-3-torvalds@linux-foundation.org> <20240131002346.GN2087318@ZenIV>
In-Reply-To: <20240131002346.GN2087318@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 16:39:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLUwY=eW6_fEuxH+M-Y+1udkZ9yMqdsRwhAYPv78TjkA@mail.gmail.com>
Message-ID: <CAHk-=wiLUwY=eW6_fEuxH+M-Y+1udkZ9yMqdsRwhAYPv78TjkA@mail.gmail.com>
Subject: Re: [PATCH 3/6] tracefs: dentry lookup crapectomy
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 16:23, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jan 30, 2024 at 11:03:52AM -0800, Linus Torvalds wrote:
> >  {
> >       struct eventfs_inode *ei;
> >
> > -     mutex_lock(&eventfs_mutex);
> >       do {
> >               // The parent is stable because we do not do renames
> >               dentry = dentry->d_parent;
> > @@ -247,7 +246,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
> >               }
> >               // Walk upwards until you find the events inode
> >       } while (!ei->is_events);
> > -     mutex_unlock(&eventfs_mutex);
>
> Unless I'm missing something, you've just lost exclusion with
> removals (not that the original hadn't been suspicious in that
> respect - what's to protect ei past that mutex_unlock?

No, the mutex is actually taken up the call chain, and removing it
here is fixing a deadlock.

Ie we have the mutex taken in eventfs_root_lookup(), and then that
goes either through lookup_dir_entry() or lookup_file_dentry(), before
it gets to update_inode_attr().

That series is not very clean, I'm afraid.

          Linus
