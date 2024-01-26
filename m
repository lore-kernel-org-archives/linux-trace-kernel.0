Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF620320
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296014; cv=none; b=Gw13L7D51+/pZfVa5JFEYAZoXZX+T++G3731N8RzWIrAm6JN9CYfqt4mvfkEJaQHzHI3U9c7ZViG6NCvWXW0VbwaS/DX3OBbQiNs5yFqrK4AgGRlUw6K31TxvdQ46s5H6fTWbUmc+CFrcZ0xGF0OtK86y3+T3zevrLfCfBf7SIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296014; c=relaxed/simple;
	bh=u4QMmyhqfZPexfauxvPU4+cj2+a1AaNdzp8EfyoHBcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B54sMHPgt5jZirKOhCBQWxg4h0PKHgWMz09JKStpaJ+7lRt/Ysfp1e4SDkGmWarGS8aAdVTgnIe8z7xSkhC/IXGgH6O6GT0jHBpcCdaj4Ldmq31bqhnxisxcrGM/Lext+yKn/x5M4qsuSyvneCKl9m8Ddwn75KAQ0NF7VoTQoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cb6c0M8u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cb6c0M8u"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ee8cea674so6526635e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706296011; x=1706900811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1dP7C1f8EQhzrHBctOG/vK1/Bgm4Z5gBZgBjg0ZQiw0=;
        b=cb6c0M8ubZW7HoFcqS3ikmBd69xWIDX3NWURSzf2rVUJTGOo1yj24X8aRCcuJichXM
         XXQh14UkDG3utibOXs7FNERUc/TXm9BGElsuszIlLEsosG7V7AiHgu5Z60uzwjhX6pEp
         eN74UJ8lMUMV9WslrvJGyDN5CYFooLUArHp7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706296011; x=1706900811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dP7C1f8EQhzrHBctOG/vK1/Bgm4Z5gBZgBjg0ZQiw0=;
        b=n1PzNOZ5BMAhD9sU5pEaUHnQ3F3f1lJ1MJ7+S77MV3zFJw2VvV/PhkhvVhPrjulX35
         D8VztZ9IkIuxiVHU1A38WdU4BPBcHuedCv6ITJswQMQRrn6TsZGxQJqY/m9sioE0uA3d
         v6i/91QQSW6BCCNhjMidrun1eGXYJQKK2t6uC0rSzG1pMmelFMF5Eg1tPrOT4Y2l12qb
         xwGDcA+2Vvzs9WOwThWJ4z1kxD6AI+XCczX+IwD0zXWxWTNspRMqnCl8VnaEFPN6WIun
         1fJKgzodB3x0UHUEzqQge6LCFMkgfzRgzojj8yCeh0B/k+bJLiJ/9JPsF9inLHq8IQSy
         7eeg==
X-Gm-Message-State: AOJu0YwkuqqNONjErqg7KlZoAvmQTmao7nznOwzXPHOtyuMYGyCD/J87
	iglY1q2AjFFiKNYaDzwUQ4IFuXzCV5l7Go5lZGqo/ALMvujD+3Czrf76fuxI6dTee5n2tTujTST
	nFo1TOg==
X-Google-Smtp-Source: AGHT+IH9gyu/ZR+oQR9Rax18KA0zU8ZxyYuKWcwo9LCCJtj2QAYpD7x4EccAc34Hes3hQwPrOL1Twg==
X-Received: by 2002:a05:600c:558a:b0:40e:e74b:771b with SMTP id jp10-20020a05600c558a00b0040ee74b771bmr194105wmb.164.1706296010640;
        Fri, 26 Jan 2024 11:06:50 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id rs10-20020a170907036a00b00a316a652c6csm917488ejb.70.2024.01.26.11.06.50
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 11:06:50 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so541175a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:06:50 -0800 (PST)
X-Received: by 2002:a05:6402:1d9c:b0:55c:d7f5:d1e1 with SMTP id
 dk28-20020a0564021d9c00b0055cd7f5d1e1mr89897edb.22.1706296009700; Fri, 26 Jan
 2024 11:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126131837.36dbecc8@gandalf.local.home> <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
 <20240126134141.65139b5e@gandalf.local.home>
In-Reply-To: <20240126134141.65139b5e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 11:06:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTECUZLBgALpvm9zDN8TJCGxyc3VCEXXHMsFNAN+x5Fg@mail.gmail.com>
Message-ID: <CAHk-=wjTECUZLBgALpvm9zDN8TJCGxyc3VCEXXHMsFNAN+x5Fg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Give files a default of PAGE_SIZE size
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 10:41, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Fine, but I still plan on sending you the update to give all files unique
> inode numbers. If it screws up tar, it could possibly screw up something
> else.

Well, that in many ways just regularizes the code, and the dynamic
inode numbers are actually prettier than the odd fixed date-based one
you picked. I assume it's your birthdate (although I don't know what
the directory ino number was).

               Linus
