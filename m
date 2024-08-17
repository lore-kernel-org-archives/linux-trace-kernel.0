Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8088BE8
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Aug 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912003; cv=none; b=LKhC9PvJHXhFWjphcz9l7Y1mxGd9BIT1cDjNACPH/oki30ET4qfe/gm8h2E+EgFp2uL6qo8pcncvi7rh4py4vBFSrAmHFuhM1S8kkkQxwZ2jajYZGcpZAUhrCUj+i4astowSvkr5VN4ax6j5vtQlc0lf0po6m7EyH950/mXOlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912003; c=relaxed/simple;
	bh=9dkMY8jFzFQfn6EKGYFPV4tiA60zbFODArOLJ5YzeIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCg7J6qi7DlSiGu+H+sOkvOXBWLo+36vxCKUb3MdQKhk+cMMgzkTsOC/ia9TxEln98+wsHC0wmU2SdA4jLkvOBJl7ICDlZYZq8Eqor2PsQDUG9Q0pJQd7VXDyau8Ry7POlL9DVTgar8VUNFPEKZTHlkR0Kx8K2HuTVErwdU1MHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MGX4RmWe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MGX4RmWe"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37198a6da58so1089159f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Aug 2024 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723911999; x=1724516799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=MGX4RmWezwlCBP/5oE47a8Mb750ikLW7ITLf3BYDp0a3qpipFAowooHLbj91B4slgD
         ojO7XMWv/R1bgoN/oewxQCPfaNAWr5C4mYbh6bGHKzgu9n6FnFQ6f47QD7Od3jyhkVUy
         2RNpzmEYrbA0l4dl7/p9NqlTgxf9rdWRt6Z7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723911999; x=1724516799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=ikd1rbDs8d+vJXsvu/ZViqtGBeRtX8x+Lk6lawc/ktuwG7+g7sNutxVRtTR/yrxwmZ
         CV2qVQVKdm404kxyBTphA2kOy7nYKgXKUsEjq78NheunhLOEUZbJGeWqsETwF2y4ISes
         E8ZrjiYKcaY7X4EkzCIKavU1UmBmtW4hWjaZwijfXwmj69sphN3fKRkNqoejtcdAmfhv
         0DsvedagiA/heLSIb/ZjeZlwaFexKHrlTsUOTY50Ov1vRg2VmWZ/izCaUSbUGxf+LbTP
         me/Xi1eN0ghaZqAfBh98jwu2wLn4LwbmT+gWwges6/vMwkHu0B8dqr1FOjsA6gdF8QVa
         GeHw==
X-Forwarded-Encrypted: i=1; AJvYcCWNZdNNKOoFvw7kseUK92WfGp7obYM/MBuQotiMgaUYRmzLZ8QO6XxTqehvum/cqzVli+/9hHRq3aXF4mauUr3Fuq28gnysJS72kN9fwrQjQ7S5
X-Gm-Message-State: AOJu0YyIC1404xSTC1mOflTG+8+QBf8fHJjNS8KUc6bI3ZOlvjWNxAJO
	cfE4/CTEdPwBuRUXzW8L3wbY76jmHlNesvWqkIyFoaHqWiA+AHzVvsdNeLiNKo+4127OITnDtDI
	wmsl/wg==
X-Google-Smtp-Source: AGHT+IFN35krX7o/Dd3bBuVgJSyik/UGu5IuMSQbpI+mh3hGiH2zvuiB42LWthe/PLRCZQj6zukKRw==
X-Received: by 2002:a5d:4682:0:b0:368:5042:25f3 with SMTP id ffacd0b85a97d-37194652c1dmr5226561f8f.34.1723911999244;
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cf0eesm417200366b.52.2024.08.17.09.26.38
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a83856c6f51so130344866b.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Aug 2024 09:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAA9HqA9FjlL0dt53jtJq36uF2dURvzHmukIAs4eLGkhla9zrcsrOm2rhdsVtJPHaBrYOx76nVH8DczrtGfXgO1V2bSCbHt+6Lb6nJ4Pb98u8A
X-Received: by 2002:a05:6402:278b:b0:5a1:b6d8:b561 with SMTP id
 4fb4d7f45d1cf-5beca527ec4mr6027442a12.9.1723911998605; Sat, 17 Aug 2024
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
In-Reply-To: <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Aug 2024 09:26:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
To: Alejandro Colomar <alx@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, justinstitt@google.com, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 01:48, Alejandro Colomar <alx@kernel.org> wrote:
>
> I would compact the above to:
>
>         len = strlen(s);
>         buf = kmalloc_track_caller(len + 1, gfp);
>         if (buf)
>                 strcpy(mempcpy(buf, s, len), "");

No, we're not doing this kind of horror.

If _FORTIFY_SOURCE has problems with a simple "memcpy and add NUL",
then _FORTIFY_SOURCE needs to be fixed.

We don't replace a "buf[len] = 0" with strcpy(,""). Yes, compilers may
simplify it, but dammit, it's an unreadable incomprehensible mess to
humans, and humans still matter a LOT more.

                Linus
