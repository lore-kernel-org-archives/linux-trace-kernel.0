Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F85D8E4
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930373; cv=none; b=awowKrW2yreK3jVPN1UPSozkGPtnbes3z0yVBrAPWlh7SR/e0myNnSUH/HyttIc+prdMuUom9FR3+CRJnR3aFbw6FiJjXAyNoO8a2bVhkciXijT7tY7oDeL8BGH/7tDoqZU7qvXN35obYwZUu8RuL+ut2IMJakskErMLgOumzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930373; c=relaxed/simple;
	bh=UogInE1oek8uNz978Fr2Y00YKfvATmfN6x91AoetXLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXleQRpcfpJVK47WdMqyvaVIwdz72rcJXckuU8TKofs71KCRf84KNNGyVIAdFXQB54+F5j2LGfQJtnNOJiOq3QYlO/mHwjXNVivZB9x537F/xK9G4zSBMg/2iLgwIggkrgTFdcvIbdJwY4THvSUBCxv2lie/ektZVSXDMTa9XY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iMmugidR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iMmugidR"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d09cf00214so16816051fa.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Mar 2024 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709930370; x=1710535170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwaztDR+5Lsp5aM9L+iH7awTig0xm/0SM0pTAJYMRCo=;
        b=iMmugidRPati0fJi5ttc8X1czY2yjIi3OPQxOHItscnhTjhmK+Jc77fDEezfuZDIqF
         GIFvKfApf0VLDtQUPa/cnEvrVLUgdzmuDpb+xqJ3xY1kUhvBVqWB6UqQ/4E9HMDSjiSK
         bjPu4YDbhUTOGOZxJraaDcp5u4GeA3HdBA6mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930370; x=1710535170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwaztDR+5Lsp5aM9L+iH7awTig0xm/0SM0pTAJYMRCo=;
        b=MS+4UitR4zwj4SroLb8/cIPEaGMdwNl0OAfZe4QH2gOZhW2qrM9lzGXLPXQIWFRsne
         kPHsh+/1sQWZQWHeX5rLk+DMn7lX+lZwn9KIJlnJZLvMdO+FVtfotmOZZUKMrzWn9DlT
         ryc1gXpzPopfb+uXg3+wxV+JHgRhtxDAEpkhVFyFY+r4A4N7RqUrwKXDPkjy5yCEdrwE
         Pu6foHGpRHtimQ7ZhsSYwZdu1/aSEh9LnTqx6D1Y3pNLZMTCSkCa6dJXqvLhVqbMvixg
         iKotaelvGMSmB39a7nV6axX9kDq1cYAlXJu2C7dWLWDKqTFy5BfJPjVRSe1oD5jL3Ymj
         Qtww==
X-Forwarded-Encrypted: i=1; AJvYcCUCdlD0bOhupcfb8PtrEpYrlpVo9hBqEZBTSvpyffP9DTT8EsxB+BT9QjGCHS1kN5Rxvq88IqIFsjnXwOMEsqgPE3q0KrikqDXTqyG0R5sH2Aza
X-Gm-Message-State: AOJu0YyduwJFhKti9m6yQvAj2F0d3PcZ8MaNAAP+idYEGEOrJpgi4V95
	Vyx7Z5LwIxI2TwMjOLizZdLp7oUIzOYw6g+R4teh7Ikoiuokywm1UoLAvzVRpefutr3BwQzaMj9
	A4YmuZg==
X-Google-Smtp-Source: AGHT+IG/MNwvVCMSwUbN8DREdW11tmU7Ep0PNvsGk7x3Lm5HJCTwGSdMJQF5n8KryaBb184tZ0DZYQ==
X-Received: by 2002:a2e:b994:0:b0:2d3:f821:47f with SMTP id p20-20020a2eb994000000b002d3f821047fmr189713ljp.36.1709930369865;
        Fri, 08 Mar 2024 12:39:29 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id fj10-20020a0564022b8a00b00565af2ea649sm123683edb.14.2024.03.08.12.39.27
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 12:39:27 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44d084bfe1so157556366b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Mar 2024 12:39:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDcUVSAe59autdwTv6laF4irw2daSXEdVYMTC11UUvlV0/NW1C5mZ/9LoK0scNMgAVtelNxHVXPL5+jJ6xPd5dao1Mdml+rg3DyleuYVo3Wrof
X-Received: by 2002:a17:906:4f82:b0:a45:5be1:6e20 with SMTP id
 o2-20020a1709064f8200b00a455be16e20mr91471eju.23.1709930367225; Fri, 08 Mar
 2024 12:39:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308183816.676883229@goodmis.org>
In-Reply-To: <20240308183816.676883229@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Mar 2024 12:39:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
Message-ID: <CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
Subject: Re: [PATCH 0/6] tracing/ring-buffer: Fix wakeup of ring buffer waiters
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joel@joelfernandes.org, linke li <lilinke99@qq.com>, Rabin Vincent <rabin@rab.in>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 10:38, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> A patch was sent to "fix" the wait_index variable that is used to help with
> waking of waiters on the ring buffer. The patch was rejected, but I started
> looking at associated code. Discussing it on IRC with Mathieu Desnoyers
> we discovered a design flaw.

Honestly, all of this seems excessively complicated.

And your new locking shouldn't be necessary if you just do things much
more simply.

Here's what I *think* you should do:

  struct xyz {
        ...
        atomic_t seq;
        struct wait_queue_head seq_wait;
        ...
  };

with the consumer doing something very simple like this:

        int seq = atomic_read_acquire(&my->seq);
        for (;;) {
                .. consume outstanding events ..
                seq = wait_for_seq_change(seq, my);
        }

and the producer being similarly trivial, just having a
"add_seq_event()" at the end:

        ... add whatever event ..
        add_seq_event(my);

And the helper functions for this are really darn simple:

  static inline int wait_for_seq_change(int old, struct xyz *my)
  {
        int new;
        wait_event(my->seq_wait,
                (new = atomic_read_acquire(&my->seq)) != old);
        return new;
  }

  static inline void add_seq_event(struct xyz *my)
  {
        atomic_fetch_inc_release(&my->seq);
        wake_up(&my->seq_wait);
  }

Note how you don't need any new locks, and note how "wait_event()"
will do all the required optimistic stuff for you (ie it will check
that "has seq changed" before even bothering to add itself to the wait
queue etc).

So the above is not only short and sweet, it generates fairly good
code too, and doesn't it look really simple and fairly understandable?

And - AS ALWAYS - the above isn't actually tested in any way, shape or form.

                 Linus
