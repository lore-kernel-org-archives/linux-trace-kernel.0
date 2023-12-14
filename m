Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A05697AB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z3QNh04C"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so1973596a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702583234; x=1703188034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sjcQO6QUwn6LlRQi3EB5uy3LvsThnC1DrE9jgfSqzKY=;
        b=Z3QNh04CazCSd6G4OWax9HDBWX8m2ZnhHXBsMXgxTPvUXFbRq+q0q/NvEDTh03FWh4
         BbHUq8xVt5hXNxcRlkPc7D/rYp9eckL88i6XKKq2QfPqLcP8zHAjJ8tuZl8KzvdxLVre
         aZIEv9ExIETQPGA9RZookHs/Ngh8mZOYTa9mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583234; x=1703188034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjcQO6QUwn6LlRQi3EB5uy3LvsThnC1DrE9jgfSqzKY=;
        b=EAAlOKWyFqGzjn1rJj2My8pED9uL35EdkEdeYla08yuGNUSlr+aCEr6xAUdgrH90Bi
         oKdx5iDX2wKTP3dB3qm2Xmk76kI3/IVrlvZC1l2uTh+DH0whzY8SQlUz6sGLNJalYBGt
         GZsHpUsVefiHksSMiMktY8mr/5LKPSHvvoLkiU8OTB23jKRW9yVXK+m0nF6cGukepmkB
         70UIxlX0j488gTWNVYVvf/whXhOIytZm+dj38btLYThlGDMH6ssA9bCnAJIKJtY1n8Mc
         jd1LJhpZvNBBfnSwBZo8Bagf9Pg9q7eKd2VR/Z9wxT6TM/rtj3JAxWHee4p1h0krYrI6
         DJXw==
X-Gm-Message-State: AOJu0Yxs3KBQlQJWlh66l+A+H0trwCtX1CW6E4C/eh0Ku/abHlD/1AWq
	tF0yKgRp8JKOvNALGJoxiiBKVo18XX2Ci01cbNdWjw==
X-Google-Smtp-Source: AGHT+IGWJfbFH1WqQ1SBs1Evb2xgNZ6TBc+vlp0pKHXptErl1YNDbwVgGXdKN5NPf8oOlKYA/XczTw==
X-Received: by 2002:a17:906:782:b0:a1d:2f59:81a4 with SMTP id l2-20020a170906078200b00a1d2f5981a4mr10756909ejc.62.1702583233833;
        Thu, 14 Dec 2023 11:47:13 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id sa16-20020a1709076d1000b00a1da72b8752sm9773050ejc.212.2023.12.14.11.47.12
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:47:12 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a1ca24776c3so201116966b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:47:12 -0800 (PST)
X-Received: by 2002:a17:906:109c:b0:a1a:5397:b67f with SMTP id
 u28-20020a170906109c00b00a1a5397b67fmr11674986eju.4.1702583232499; Thu, 14
 Dec 2023 11:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125433.03091e5e@gandalf.local.home>
In-Reply-To: <20231214125433.03091e5e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 11:46:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
Message-ID: <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Linux Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 09:53, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +       /*
> +        * For architectures that can not do cmpxchg() in NMI, or require
> +        * disabling interrupts to do 64-bit cmpxchg(), do not allow them
> +        * to record in NMI context.
> +        */
> +       if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
> +            (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64))) &&
> +           unlikely(in_nmi())) {
> +               return NULL;
> +       }

Again, this is COMPLETE GARBAGE.

You're using "ARCH_HAVE_NMI_SAFE_CMPXCHG" to test something that just
isn't what it's about.

Having a NMI-safe cmpxchg does *not* mean that you actualyl have a
NMI-safe 64-bit version.

You can't test it that way.

Stop making random changes that just happen to work on the one machine
you tested it on.

           Linus
