Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD656A359
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X4nPzm6F"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso11827118a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702585976; x=1703190776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2BdSCgUChjTXVvCDYH0x028T7FO0mEYayRY84Xmsbc=;
        b=X4nPzm6FYrn6oYdiaRd9NKlkU78rNhH2qMFVcxn1ybaD6FHt9C4cd5zf3TJxn7/Z5/
         igdasLnn1teTQGI1rK2+6bmR8XBM5jzNCpfWvoV6KuQkR/yYyXYeAToe2405nDOIpe4c
         V75JMvz9xgiQQno6JrtTECQMlbKhqllbT41k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585976; x=1703190776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2BdSCgUChjTXVvCDYH0x028T7FO0mEYayRY84Xmsbc=;
        b=asroc0NkXtE/EnDtpw/Z9PFEpfegOGZBIxFxeZnSAudyxPjrLOKoMch/Dqm3BodyxB
         6LpKfOGDwc/scRd0LOmtecpOSudLxIqIc+Ldmp0tIygoTZI6lG7nUqgs8MriSHBGHttu
         PunQ3AYTZLJX0kxHn1M6J5BtJRquiEzbss5cAj0hNp76ZV/sWziwVbQR2d3X2ubf8qMd
         WFpkh1U1A0d9Tk9e4NqWAbVR9ha6q2fUbLR8lkvvZAAHuz3uoOeczoTxm5UvZzIUvkbX
         f7pBbpCCmYIPM5Xadn1VHcMuO7KEdpt7HEj1FZLiWwQQmk4M3fpxjE8sWXNhgZy5G2G8
         94SA==
X-Gm-Message-State: AOJu0YwC7p9+5PO5k0Il2ZbIYX9zLmk6czLWMkebb/DCVwhnvNJZn7V0
	E156UnhJ2MZRDm434OoVLX1BCPEgFqV7tlCFuRuEMtK5
X-Google-Smtp-Source: AGHT+IGTIcQ90ZIbI35s8pgdrthTeDYRXVfWa6YHKm/qxLDMOuBNN/ay3elLNOIY5x6rX+ttJEZJIA==
X-Received: by 2002:a05:6402:1e87:b0:54d:9782:c3db with SMTP id f7-20020a0564021e8700b0054d9782c3dbmr5304039edf.84.1702585976380;
        Thu, 14 Dec 2023 12:32:56 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id el13-20020a056402360d00b005527de2aecfsm764878edb.42.2023.12.14.12.32.55
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:32:55 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1f0616a15bso983404266b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:32:55 -0800 (PST)
X-Received: by 2002:a17:906:d8cd:b0:a19:a19b:78bb with SMTP id
 re13-20020a170906d8cd00b00a19a19b78bbmr4577583ejb.126.1702585975559; Thu, 14
 Dec 2023 12:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125433.03091e5e@gandalf.local.home> <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
 <20231214151911.2df9f845@gandalf.local.home> <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
In-Reply-To: <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:32:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHf48o15sugNeZkzNy2sJ2XUjaJLUWskTB0FnrnFGDeA@mail.gmail.com>
Message-ID: <CAHk-=wjHf48o15sugNeZkzNy2sJ2XUjaJLUWskTB0FnrnFGDeA@mail.gmail.com>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Linux Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 12:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Read my email. Don't do random x86-centric things. We have that
>
>   #ifndef system_has_cmpxchg64
>       #define system_has_cmpxchg64() false
>   #endif
>
> which should work.

And again, by "should work" I mean that it would disable this entirely
on things like arm32 until the arm people decide they care. But at
least it won't use an unsafe non-working 64-bit cmpxchg.

And no, for 6.7, only fix reported bugs. No big reorgs at all,
particularly for something that likely has never been hit by any user
and sounds like this all just came out of discussion.

              Linus
