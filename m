Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEA5D471
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709934140; cv=none; b=OQmSxCPhZpqyrU3mNqT77I9saACXJHRamKDkLBAOSTEgejq/Wlgiyi4Ii1wXR2QbX34BZomOoThbxuSfd2hSw8wGvCi5XQoQFWot4ZFiaM3eg4OGOMxQGNt/8Cujiq+PosY46SFjRv5tQB9efZ0jV8jh9RW3brF1n8qCbFx/qRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709934140; c=relaxed/simple;
	bh=CYYr/NajUCCcjsIAOZaIwuy4+0QjCsXxLc8V7MKFSIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAgkwMeT5kaQE16Lr0nyex+BNJhAW3YDynXfzoQF+iFQk/nyX4KUUWKW5oNxAebgGZI1npOPKVBmFQGjA5SIDjvKmMBze4Wji1rXCC2iSXjOeRIF1f0L4VQU5PRuXJc0Z2paPjSdEibqGq2yKfe40V5vajHLUQ77cLDT2K9F9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PPbUiBZG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PPbUiBZG"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a45bdf6e9c2so310117766b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709934137; x=1710538937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZOJX8+ZYX9H0UL4MHKNxLD9n79jC8SKE/Gmx2LAZcI=;
        b=PPbUiBZGnSxxFybsD1YKQ5TJY4gRPjZN5XEiWdIaBjGZ7Gs3xXIFAKXpsoifq8cO+O
         0JMVGI2v9ly+mo3pg+HiqGscn+wcZBYqDhyNRh69C3fuQG1j2K3stSpt2fPGISi9HHH1
         38BrD5WKQKQuC0pkBCHgSpqRLq6IA7NBTKcy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709934137; x=1710538937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZOJX8+ZYX9H0UL4MHKNxLD9n79jC8SKE/Gmx2LAZcI=;
        b=XkZsQ/jWrwrbsnnPKQ6QOf01/4MCSunsW1liCyq4FL+ixaA0ZbmADlBBbqMLcOV5q0
         OJFQl2uH0LV7DYSOvD+CpK9mJUe9N+VknBTeeQjjOmrHbvQz0Q9FmXO12s6wKM1W6JVL
         dFKx0GNR+g962wV5BXf/6KYtQ+tpYr0DUGd77/2yje0FQ6tTfWpJVSVsdkT2K8Ekt6EG
         FrzvFAPP+sReT2fStuK9moSAX9M2X96ovvVMYQb3Uux4Oa+0VybcuIn+xrqRDZvnGD8f
         J2/v5R2FsOwaMP7Ih4lR3ciFfLVslKxbXUUALKOjhZUIkvjZHQ3D7oJmrRy9oQQikPFs
         BzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE1S5QqRQVDgrEMc5S6hMlyYHNwlsIB+a6l0K06VMPALsQ+wWNMkceg3YEbwfMRLQcp5bzm/Ncx+kfqCRY5LdMTqTmBuaiitqSyj/43ODxuC6m
X-Gm-Message-State: AOJu0Yz2Jspc6k0kB+nZkBmBf/Plher0CVMgq/eD6MxUtRN4QOpCUuJG
	8qZw4Qw1/v+cc+XevOuYI82Zo3wl4RNM5kbNCUistCFAAvfALefvRc8Jun3FcKuI5Ne4WVfG/q5
	C/tz6dw==
X-Google-Smtp-Source: AGHT+IEuDnywIbIAcg9zqIqk+P/i5k75ZNgHCok5s8MmMa23OhPGte8yuoUCwwLbznMW2vq41tap6A==
X-Received: by 2002:a17:906:f0cb:b0:a45:446c:6beb with SMTP id dk11-20020a170906f0cb00b00a45446c6bebmr148530ejb.50.1709934136752;
        Fri, 08 Mar 2024 13:42:16 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id rp10-20020a170906d96a00b00a44d66a16efsm196242ejb.2.2024.03.08.13.42.16
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 13:42:16 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a449c5411e1so337837066b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:42:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbdM3uZEHH17g8pfu9o/6VXDKPwNkIAk9SHyYKp2CWbtLPXrxLQLI5Zb6+rJFmh1106OH0SYq5caAKBNqjNFElIMF5WsuPGrs0tYs8YMYt+Ere
X-Received: by 2002:a17:906:f0cb:b0:a45:446c:6beb with SMTP id
 dk11-20020a170906f0cb00b00a45446c6bebmr148512ejb.50.1709934135922; Fri, 08
 Mar 2024 13:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308183816.676883229@goodmis.org> <CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
 <20240308163528.3980c639@gandalf.local.home> <CAHk-=whaVBe14mbW4QWNuywBP_ZvGJYRZ3dbgx9-ebSxnNTXiQ@mail.gmail.com>
In-Reply-To: <CAHk-=whaVBe14mbW4QWNuywBP_ZvGJYRZ3dbgx9-ebSxnNTXiQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Mar 2024 13:41:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWbhhNLCZgb97PP9Bo-XbNNMdPxqr0YRjYWXP5E3a1ug@mail.gmail.com>
Message-ID: <CAHk-=whWbhhNLCZgb97PP9Bo-XbNNMdPxqr0YRjYWXP5E3a1ug@mail.gmail.com>
Subject: Re: [PATCH 0/6] tracing/ring-buffer: Fix wakeup of ring buffer waiters
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joel@joelfernandes.org, linke li <lilinke99@qq.com>, Rabin Vincent <rabin@rab.in>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 13:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the above "complexity" is *literally* just changing the
>
>                   (new = atomic_read_acquire(&my->seq)) != old
>
> condition to
>
>                   should_exit ||
>                   (new = atomic_read_acquire(&my->seq)) != old

.. and obviously you'll need to add the exit condition to the actual
"deal with events" loop too.

                Linus
