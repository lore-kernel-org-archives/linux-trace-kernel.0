Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E935227;
	Wed, 16 Apr 2025 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768093; cv=none; b=DH0o9pdSIKQ/+9jft6FNDYU8VVJeresGpeV+pbFPRdIkeFOvFTDchHS0gDpgvcIazS12hcGbXh8asVjRfbsOiJbPeAPUw3oitD9UJgZsTnq871y1/1d6kvXVeu5PbUEtn6QbJEhudwVfJHQwxQebvtwl11uHHVWXpiVW9UcGf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768093; c=relaxed/simple;
	bh=LmRYGZfdjzKD+GNeB7ijBk/znXqeRMAfPREUU9oAlno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX2JcuJln1rOblgGv6Ouy9F4JJbXeneTrT3FWDeyUkwOE3CUBEl5GeAD/F1zfeQ+Q2XDT7epT9WY9lDu6lBcDIlCfsAcUgrQh3nuvj078zY6nQFk0ScPKcvukBdytJcXxAaoe4lWDh0mgOTCfRYieqes3HXTlFzHs0s9qrC7WWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn8sCCRK; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn8sCCRK"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-70565ccf3bcso39707667b3.0;
        Tue, 15 Apr 2025 18:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744768091; x=1745372891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqLmF3Z6t3I+6keU46Rahz1Y3IvBRd9Ly3KaUnN+N7o=;
        b=Wn8sCCRK9EOLtICz88DpWRUB0/2LdwnOtzagFKWCL7qbHJUeefHtEgPNaSWRjgZZ6D
         U9GbTr0ElmsptOB6Q6T7RQwvdxvdHNE4Ls51y1rlejIErSlo02uN9LRXhxB31QHNGJjp
         fzG0g6IUVMGNSv5B78wvUSlro3idjotntqSl5ZP++7r5TkA8gE3Vw+rZOPCqi7gm7feR
         aoSZiwHCDhn5XFqVNLYic0jKcWRWkWDlT86KpGsQR58WjrCiHxmNScgzdcnx1hG3G9+m
         Cmfqabq1aGHaWAbRnZaTu23NkrYJltXyrQEUdS+U5Ndmoy8VxYzEUjMJ7OexTshSF7ft
         TjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744768091; x=1745372891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqLmF3Z6t3I+6keU46Rahz1Y3IvBRd9Ly3KaUnN+N7o=;
        b=U2wXEY+Ksk3O9LUyYb/8HAeHnnoxNDmoFKbQ8TyWlWf1T4mbwbQ1w55DPu6SAX3tsO
         HKcT4io27WPK3eROkrg3wtT87wPr1O1B++VUjVWP0WgWSvUBtwC+j1+ipV+as8sQ/E9U
         b1gEsJZAEjUe+uc+YPforl+cHvK59c4S7/l55peQkJBwKf6E/8kr1FPUMZxAcETr7GJU
         7nt3UCpfirW44QVx+csNC5EFJIQe02455dGrXcjuv7rbN2OtiD4M4xsONVKAimKt2ueU
         KQpSh3urUAYCyz0lHWZdWNl7eAKu8zqwOScZ7iQjVWPazadJdzlk58s4uMfGMKbz7njO
         sc/A==
X-Forwarded-Encrypted: i=1; AJvYcCUaeBVqo1lAso58LdAZa8t+IS5h14ybAIHU5ZSN/Sa4KqCTDeMQVAcTschvKjo6AkrH6U6cllc6UwMgPFw=@vger.kernel.org, AJvYcCWH/mCmMmkije0EbPd8K2rAD8EOYCtOAcSCVEXfojHCxvNPsTBsgsTPS4scIUyzaIOSUnXS1Khl0RAPQL3Iaxfw35RR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0k7awKN8UgXO+ZfHEiAx1hkJVIonlYox6sg8rNtN+HtIHK+m
	c678PHyqi8/ey9aMDAf8FVdfdSlXhfE1CdlHLTLVHU2WTyugbtjUGUdspFobMB6hHa5z1Fk20XG
	U7alIYZ//qMp/EgeAPX57ZVV6xY3j/u9k23A=
X-Gm-Gg: ASbGncvC140fLYIyx+/53MaP4CxwCJRTOHiVqXBHJMveZYgdH/Au4RQyj7NJkqh7wS7
	IOcvb9alCRHZfz7SYo/z+5o9InjZ+kn/LmqOASin4wm63U3P1ZBPLxD0Z+tICkVJdr/LTXGbZXi
	oxhLKmeg8NC+rhPU+GmIuNAg==
X-Google-Smtp-Source: AGHT+IH6C4g81eZKeTeUb9hCFSy4U/5I3cBEhngWsJsQqyVX/TxQ+f+/ZVXpEgAzRxOjX2mWC8EQzFip8VeewplAl20=
X-Received: by 2002:a05:690c:6c0a:b0:700:a6a1:66ae with SMTP id
 00721157ae682-706b32a622dmr1004437b3.16.1744768090833; Tue, 15 Apr 2025
 18:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415112750.1477339-1-guoj17@chinatelecom.cn> <20250415074633.3cf7546d@gandalf.local.home>
In-Reply-To: <20250415074633.3cf7546d@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 16 Apr 2025 09:45:54 +0800
X-Gm-Features: ATxdqUGoxV7-FrLDOfL0otb9nTJnPoreiefCjKG7AC-p9lj_cIcVamgdmnzlrjE
Message-ID: <CADxym3bjjp8edgbpAct0GKno3NGLxs2Pd0hod94r7u_2jGUC5w@mail.gmail.com>
Subject: Re: [PATCH] ftrace: make ftrace_location() more accurate
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jin Guo <guoj17@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 7:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 15 Apr 2025 19:27:50 +0800
> Jin Guo <menglong8.dong@gmail.com> wrote:
>
> > The function ftrace_location is used to lookup the ftrace location with=
 an
> > ip. However, the result that it returns can be wrong in some case.
> >
> > Let's image that we have the following kallsyms:
> >
> >   ffffffff812c35f0 T sys_ni_syscall
> >   ffffffff812c38b0 W __pfx___x64_sys_io_pgetevents_time32
> >   ffffffff812c38c0 W __x64_sys_io_pgetevents_time32
>
> Have you tried the latest kernel? because on x86, weak functions that are
> not used should no longer be in the ftrace table. That is, you should nev=
er
> see __ftrace_invalid_addres_* anymore.
>
> See https://lore.kernel.org/all/20250218195918.255228630@goodmis.org/
>
> That was just added this merge window, which would make your patch obsole=
te.

Hi, Steve

you are right, I haven't updated my code in over a month, and
the latest kernel works fine.

>
> -- Steve
