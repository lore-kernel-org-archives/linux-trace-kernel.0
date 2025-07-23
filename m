Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88C1F1909
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310018; cv=none; b=XGT84LiM5TwfBBNF3So29vt/AT5QpiS+8epqQPLYN65taZ3/pV+m0sZqeCm2ElNXXyLt1yVci3G9/UNMiihY1f2R0tbUIgFgM4F7tXlWDilrmL/2vJDtVCqUAimenRrUub+GfPc/ID2kZYy+WyYV212s1t1i3dr8BtDXf3lmjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310018; c=relaxed/simple;
	bh=yrn43/Dd88jzmaaVGTzLoak7dGeibPTUtixV/XrA3fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6YSukNY1CP3OWvCT4knKUXdvd9QDlqiHXUweLSYkfKZdEdW7JsQ5KpcQSMSJHghho5VQu4+lTBC8bS1pgj4Uqv6EA7oGqJjiia1TK9Udhbp8pQOzxtcmlyXf5nwQY/syaHEFHSykYMmC/l6DCOTHucUwMf2ayGQQUfDSnqWsbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IttUzCCH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IttUzCCH"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0c4945c76so48586666b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753310015; x=1753914815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3GqWWXpnYm25spaRnX4CYYgsNtz3In17QSKaRJKdgA=;
        b=IttUzCCHi1qN6llPqSB4mCeLaPEHCJ1YkTq3Q8EKlPZv7IbnERTWbgxIRO8C57K8ES
         krtNzWNS83krzAsht7vd9wH9k0ddWvLv/prGz4O8cgxec/ZXontgwBqysbXGziH5eUsJ
         WUxYaCMVCkGkRYKWXZGEIPmwatFzJossbDCNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310015; x=1753914815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3GqWWXpnYm25spaRnX4CYYgsNtz3In17QSKaRJKdgA=;
        b=dCh/PxfJMcaOvoo0NmY2HQgoEwx8R5NtUhaAo9eBupK1boaih8BfQiw8n0eW2qNokg
         /q3OfjhWIJ9273ZTA8yZ6K+UCcHfkEw9Eq5cjHEGsdkDKC8PAw4/yObcuWUXn1s78In7
         VxroekFTu6ugGKutWuCTXYZmrWBoVKedpCjwrIuS/M0rz8Wq5vCizWjZPAvvXcsejDD/
         8WQYd/v1OFFLx9hWlsnJ6SHCvoE2GWFzXwhaG5FbGwulGPl3eBclzYAK5ZrMMngEBUVM
         9yoM3UnLVHW+QzfKg48YnBC5m196r/Tl5Mnonis5t529PpkPXHowlupQ5A5KWKm4vG8U
         Agxw==
X-Forwarded-Encrypted: i=1; AJvYcCUPNUBdaJVr3RS47bnaeum1mJCaFCdP6GPNTs1iEvWsZePHo0piYefmcEm6zsv63eXTml3DYVqDTbOfanGM/nNkuiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqxCGKdyTR9chWqfyb9WcP3DnUeoHdj8JRh0w5vXYMNYt+7qh
	6BCN0gxkQOr/wAr/U9/VPwQztrlozFZmALn88KzHDI50D6WgEBxThDXJthKoKRJQJcTd00Kdygr
	L0W0jRZw=
X-Gm-Gg: ASbGncvXvvnIBmbl9i87UCcORPM7r91EkjzpKZdXjzljP39GwsoPVaeoAGqVIZN+S6u
	n1ozrQ3iYHl0K/7ABVKsxDc4gHluy6VSo6sv6fOsifVjxn6KWaiGW9D+YrKiJTzIwcXx+R1WrFw
	dVkfmIVX/BOHiRbT1/m01WoDJH0IZ8CBh/qExLNG3rggkHSTTTNYZjDuc6kfZAhqVDzvlDDkz/j
	xizoDms+Mts58aa/1irNsRrIn+vmvMLATIHCr2vpfYKRnZfTgttxSeQ0tAA2HSe8R4dMGOVW2hb
	HPArKuVJRlH0BYllDBRYz+a0JyGNUsRDfY/U0MMLlA8PaSr2SzScPfnb8QuMIlIkEEuaf+IIZVP
	9cjFJ9MvDpNY05rCaLIQYB3f6AUdQuZH1VaaJjfqK6lw/knw7XjZdJOF/uHgyru1SVRgJhHnK
X-Google-Smtp-Source: AGHT+IG3TOq8N1WizU8Wni3ZeRM9ssP3gnWi6gcR/6KxxbMVazR5DTG3Qs/rNZtvPYBxXISNO9TDrg==
X-Received: by 2002:a17:907:9411:b0:ae0:da16:f550 with SMTP id a640c23a62f3a-af2f8e51447mr450034366b.49.1753310014615;
        Wed, 23 Jul 2025 15:33:34 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f44f1absm16874566b.65.2025.07.23.15.33.33
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 15:33:33 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso738532a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:33:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRTUwNUYUu0Sf8KGmCZMyzBDEcbNy63ni8g/tnvNslmykoGMTqiiBZp8BY/rNSZ/r4+lGbZT0iY6JBDK/Bw+Kee/Y=@vger.kernel.org
X-Received: by 2002:a05:6402:3096:b0:612:c966:4464 with SMTP id
 4fb4d7f45d1cf-6149b596940mr3270676a12.25.1753310012644; Wed, 23 Jul 2025
 15:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723194141.617125835@kernel.org> <20250723194211.768813368@kernel.org>
 <CAHk-=wgbAruRX=xFVGevggtRpHNYyMVwgNYYJgYg5hMuU6ASGQ@mail.gmail.com> <20250723182701.195a5ddf@gandalf.local.home>
In-Reply-To: <20250723182701.195a5ddf@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Jul 2025 15:33:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQA+kGVKaUqSGenXVZHaPFkuojb7MgJKVetsXZnLMFuQ@mail.gmail.com>
X-Gm-Features: Ac12FXyMftZ3rEphBYdwOs1gj8AFlxDMI37MidwdrkgzW5H2-qOMpERJA1z_XSQ
Message-ID: <CAHk-=wgQA+kGVKaUqSGenXVZHaPFkuojb7MgJKVetsXZnLMFuQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] tracing: sorttable: Add a tracepoint verification
 check at build time
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Jul 2025 at 15:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> You mean to also get rid of the TRACEPOINT_VERIFY_USED config?

Both of them, I think.

> But this will require that I change how it's done, as it doesn't look like
> it's available when sorttable.c is used.
>
> Looks like it will require a separate application to search the vmlinux.o
> instead of the vmlinux (which sorttable does).
>
> I could probably take some of the sorttable.c elf parsing and move that
> into a header that would share the code.

Hmm. Why not just make sorttable then use vmlinux.o?

No need to do it twice. Can't you just work on the original object
file before re-linking?

                 Linus
