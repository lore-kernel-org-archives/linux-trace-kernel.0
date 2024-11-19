Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28678C76
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033031; cv=none; b=RIYcaMyPGdKozs0c0bGFhg5vwhjo0aDUdB3LiuAVS+I9uV/uhd7xIoBThUIlX9JM/hc+LVPyk9WJLusauv791Bk4aWu6bt6JDs88+pMNe+b8S81ksIPLL3xV57cGB3bAMHL6T9TYPDBO3H3wZzMge85gV0cHNrH06qk0lsHuZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033031; c=relaxed/simple;
	bh=xU7F4q064/t9jwH8AiA3jJzufiaFkLBYIfi1rgztlQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XD4BPloqEM6JxCQeKMKwVrpcTBR1nq4rqYP8z8GT8mIc4swmK570VupSFvQRBHNFg6iiRSyw2uzZG8Cdwq5litLtf80Ks9nGA+EbSPKRqpErvtIPXirn9XAIspn4epydcUjYa6AHyOIH5okguu9HXFAhILh26bOQv1m4loue9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUXuPkmB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUXuPkmB"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382456c6597so750808f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732033028; x=1732637828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xU7F4q064/t9jwH8AiA3jJzufiaFkLBYIfi1rgztlQM=;
        b=PUXuPkmBqUAPR0Mf1/XaMhqoyj2WPHVJ1jZkIJkw3DNM5kbhgoAH++7DFZfoL36MDK
         TNV+x7rKboqF0oTts6/hklR23TmJMoCusCYNbZUctWbpFp6Ify4U416cq1AcHYQ9d1EN
         DJb5UC0Zp1FSA3nEn12aJeTtnJvhK7mEuEpn/xTTNPDm/muFBxk0xfQ7nvYaW0Uj/H5Y
         f0ZGmpBIdZV5eNpvxcCe0XlJZwop93WDqNNKsvNoQbXfqyfHJ2BUfC16myvG8x94FZkG
         4q30PVdcBnV6ICZb6a/fmmLjGcqrhrP5uh3vc1rDZb6DJqKOsh9b229Ywl5kKu2ffn0+
         pQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732033028; x=1732637828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xU7F4q064/t9jwH8AiA3jJzufiaFkLBYIfi1rgztlQM=;
        b=l2Gn9IlM5adOW4gSNlUq0j79pTXJkfctvuL7VU35eaOvhU1+3TwZhTJ7odNd2wnFfC
         JTjWM+Znd1r7E65CUkjKzdvXM5KXOouRnbc35GS8hvt22Xq+8/S3UVI9VRWJM9GBPlyd
         t5dA4HyZ2DlWBY5I9gopX0T4Tj8p2xZRncnfb6ia5iSiBaPZjgxWuKqC5x5dH9+KWqQH
         4Kyx2M4wcDgbDDMNuyh11mIhgvG4Uf58Mlo1HQz5vjz2Ga0ZowDxusF4zqVOt1xJDc3F
         ylI0obqHOMKNo2zZ/oshGNrirQx9aAtTWHGfYkGRVU5YrG+dVUrbrji6G0XrugGpOPwU
         F9kg==
X-Forwarded-Encrypted: i=1; AJvYcCUjoxyeVVz8paYskX6CXf6letTmYn8AS2jUIUsy2fm/31O51cQKzPc/1POf8ZyJFoq/7wtz1IEXTE0BqwPvZHAh0bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqVZPgGsNrdQN+xI4fRTd2f1OrDbFeqiVZ0A2tF2Vmu36tNFZV
	YgcwnWd7F0DFGzXy6e1t6JJvsJeCzhq9J/U98O6Z/X7JxcebTf042U5AUIWZ+54hOf5ny5z7A85
	A9kEk8xSvU7V3LJOZpgNmtH2fy1/mXMbfZiph
X-Google-Smtp-Source: AGHT+IHeJo3V7wJJFfwpY49tM4mVU3oAwW6jdJvCY6m9eyWiNbjbeW+SS3nUQpL5R0658p3QQFee3SY7GASk6j+KCcA=
X-Received: by 2002:a5d:47ab:0:b0:382:3789:191c with SMTP id
 ffacd0b85a97d-38237891a14mr9706608f8f.7.1732033028152; Tue, 19 Nov 2024
 08:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411181440.qEdcuyh6-lkp@intel.com> <20241118202727.73646-1-aliceryhl@google.com>
 <20241118182818.7717993c@gandalf.local.home> <CAH5fLgjBpz7bPvanupPSsJx3fjLAa7g7nMjLgSxjEde_KDGV2w@mail.gmail.com>
 <20241119101233.19005043@gandalf.local.home> <CAH5fLgiyWDiDFAJO-LDj_ZdRjSnqh-j7vw7URLUm8ZHiFKfGXw@mail.gmail.com>
 <20241119105347.32cbd654@gandalf.local.home>
In-Reply-To: <20241119105347.32cbd654@gandalf.local.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 19 Nov 2024 17:16:56 +0100
Message-ID: <CAH5fLgj0xHFLH8CCno568KtiQd9uD2G8Gek60mRLF98FZn0H2A@mail.gmail.com>
Subject: Re: [PATCH RESEND] jump_label: rust: pass a mut ptr to `static_key_count`
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lkp@intel.com, boqun.feng@gmail.com, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, ojeda@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:53=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 19 Nov 2024 16:31:40 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > > Would you be able to create some simple code to do that? If you add
> > > something in the rust sample code, I'll add it to the ftrace selftest=
s.
> >
> > Sure, I'll submit a sample which does that for the 6.14 cycle.
>
> Is it because you don't have time this week or is it because you think it=
's
> just too late to add code during the merge window? If it's the former, th=
en
> sure, we can wait. But if you want to wait just because we are in the mer=
ge
> window, you don't need to. For things that add testing, it's OK to send
> even this late in the game. What I and many should not accept, is any
> active development on the kernel itself. Adding a sample module to be abl=
e
> to test if things are working properly does not fall under that category.
>
> The reason I ask, is I feel nervous about sending code to Linus that I
> personally do not test. It's not a show stopper. I'll still send your
> patches without or without this change. Before I send a pull request to
> Linus, I like to run one last smoke test on the code, and that's when I
> discovered I don't really have any tests to test your code.

Mostly because of the merge window, though also because waiting would
let me use things landing in 6.13 through other maintainer trees; this
would let me have the sample declare a miscdevice. But what I can
submit now is this: create a Rust file that exposes a function which
just triggers a tracepoint, and then I can call that function from C
somewhere in the ftrace selftests, and then afterwards the C code
could assert that the tracepoint got triggered. Is there an existing
ftrace test that I can look at to base my work on?

Alice
