Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7657D3E4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651546; cv=none; b=gh/HWERhhwnQcaYa1dxXe0/MkqprtMI0FTZMixPBMYSjkJxZ1HZg09g4rkcrCj777elXei6NUCs0vUbvze1FRW+vaSw5Btyhj8vwLQ+GwTLpS7l1CW4bUp0KqTs3KWIbO3WMTq0PCe8Sa1YtGiW5UUjytaXLHabJAI2UfNg4dfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651546; c=relaxed/simple;
	bh=+qk4vgKPY6g/M0jnFj6arXo9HY1VFRhgbxgqYyNRIGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeldLi/S6OaQP2li8Xo0gU/O3SO6BbBTmYaXUUr2piZpXwwON8vcQlDowkyEX1vPqUGkumNWTU+cVcja+ePR8oIqRSLlh5R4S9gD35kx22+MLbBCkZJcyr6fU0+YM0oggTpbBEM3khEIufXleOWnskvHKSE5B4ppPO+y+x34JAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DCtrMZ7b; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DCtrMZ7b"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso465038a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706651542; x=1707256342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z/besbXOlWgDfiLFxKbwW3KTuDEF1myzGGPgRYrtdjU=;
        b=DCtrMZ7bDmdjTtllWpRZ2+7nKAB2lObHXYuNPzu2HexW1SwamGtKyFCLTquLgJTWze
         WtWHyPNuJ0r6T16e+MB+2k34o3UNwY1jPaOPcRYnJaP2mGLHMs9KwuPdvix7m1DEw9W/
         aZiDc98W/IowygrbijqDFifkTe5oa4XmxgBy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651542; x=1707256342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/besbXOlWgDfiLFxKbwW3KTuDEF1myzGGPgRYrtdjU=;
        b=pym7wlDfrE6N66dZGkOACfibo6P2ubMame9+4k+8ptDFrnm0PkGZeaJs6eipX1JMGL
         Hk823tKjo29qQj/KlpJUecqnxKh0XUwOWGsttlD/mSW4MpHZjdbdlE9J/9nKc+6uNQIx
         CNdZWReL1xACe6y4eAynEpN15IWLkQKzw2fRUfAaXl4mZ7iZFZUVbiAswyFySPgFRpZe
         f/0nD6QTNmebYVffgIxkoK+6VU9pS44dUyHn7RJ4WfVs/XhP2gbnthXo9UTQHETc9PbX
         wl6i3A/Za2I5i5iCC4YuNCwEQbJ2na2U2p3vm11kZqip+x6549todsNIM5ZChn3saz73
         3WTA==
X-Gm-Message-State: AOJu0YwCKWZ0sbgjYmxCGdxeV3YNkgU1PtDn2iuzKmN05FeE/hnPKP5J
	Y8Gtxo4Pk0jEXHhw2qak8aoY/GWp3e/zBiZI80wAfCU+J+UxXGJvr3hZPRC04aKJPgzhWOGu4hZ
	WXUia2g==
X-Google-Smtp-Source: AGHT+IFdcQ62eRyu2o5Ek7CQ4NGvQsjj+Ymr1sDas/zYlrOD5auXTNxGIY64OUN02QGbzx6rWKHEig==
X-Received: by 2002:a17:906:1353:b0:a35:6669:9fe with SMTP id x19-20020a170906135300b00a35666909femr2496604ejb.32.1706651542775;
        Tue, 30 Jan 2024 13:52:22 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ty24-20020a170907c71800b00a3628e91119sm1009064ejc.180.2024.01.30.13.52.22
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 13:52:22 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f7b91ce4fso151447a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:52:22 -0800 (PST)
X-Received: by 2002:a50:ee12:0:b0:55f:2ef8:7fec with SMTP id
 g18-20020a50ee12000000b0055f2ef87fecmr2373087eds.21.1706651541820; Tue, 30
 Jan 2024 13:52:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
In-Reply-To: <20240130155550.4881d558@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 13:52:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
Message-ID: <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 12:55, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm going to be putting back the ei->name pointer as the above actually
> adds more memory usage.

I did it mainly because I hate having multiple different allocation
sites that then have to do that kref_init() etc individually, and once
there was a single site the "name" thing really looked lik ean obvious
simplification.

That said, I think you're confused about the memory usage.

Sure, 'kstrdup_const()' optimizes away the allocation for static
constant strings, but what it does *not* do is to optimize away the
pointer.

In contrast, allocating them together gets rid of the pointer itself,
because now the name is just an offset in the structure.

And the pointer is 8 bytes right there.

So allocating the string _with_ the ei will always save at least 8 bytes.

So whenever the string is less than that in length it's *always* a win.

And even when it's not an absolute win, it will take advantage of the
kmalloc() quantized sizes too, and generally not be a loss even with
longer names.

So I'm pretty sure you are simply entirely wrong on the memory usage.
Not counting the size of the pointer is overlooking a big piece of the
puzzle.

Btw, you can look at name lengths in tracefs with something stupid like this:

    find . | sed 's:^.*/::' | tr -c '\n' . | sort | uniq -c

and you will see that (at least in my case) names of lengths 1..7 are
dominating it all:

      1 .
   2189 ..
     34 ...
   2229 ....
    207 .....
   6833 ......
   2211 .......

with the rest being insignificant in comparison.

The reason? There's a *lot* of those 'filter' and 'enable' and 'id'
files. All of which are better off without a 'const char *name' taking
8 bytes.

              Linus
