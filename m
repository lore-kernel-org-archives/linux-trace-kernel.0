Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA81CD207
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030315; cv=none; b=HEXeOau9m+sZRWngPR+cgSM+rZuPArhUm2yDB8zsVU7MLIqM1VQm2NaPSsSzTCMOTJ3UsZdUdU0SpJeHNEnsoK04j9FqdwyyST5uUKSZWNOV3GzcQhFstBdfIoLb909n1TZ+ev+DnMrJkDxTka4hsedt0AU7t3vLuFDSXY+zqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030315; c=relaxed/simple;
	bh=nJNfO/bwZyhb4bIR1ODhbOeQ+Qaqt3sJfucPEncnRCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gz7IP8xQt0HrJgswxxlLseW+ADVjkbnY8asPUSZ+bzkg84SM/RSJsCY4YnfE/757FiTPzlWUP6CJjeaXKW47MzlPDGiiadTjzRe7iPIDzQ9BJY34b2Ma4O80WOQqq71JGWUh0MG9A7o23aD0g7qOS1YEOhInr1T7IDgwXJLtlL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9YQDIla; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9YQDIla"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43158625112so31291515e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732030312; x=1732635112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJNfO/bwZyhb4bIR1ODhbOeQ+Qaqt3sJfucPEncnRCI=;
        b=h9YQDIlauycti9msVZDSydkK5VS50sh0iuekT8n+ngjWZNhe6hkef8alnNjoLa4r5s
         hdA0540ShV+YrsleE4tNPVBJaUavrU7uPyHpVsGuQpvwTEk+wbLrJqMYDKvsOSsoOv5X
         hmwngTgDKpb227Y6rjRfsTpRhC1ajLq4iMgNr6jmH+Rau1DqUxHfjMQo5Y7DqFWwOYVQ
         8C7iSMs1xDSpaT61gDbBRgsXC6JHq+ie1r4Ud9UjhmFqTQug2qFoHYeQEMKyfu7eO0OI
         EJ4d1a0Gph14v/17JBU+vc/0PaS6bt55CjFcXS2epj+9QvN1JdCr5Xz9JfJhKkCRGRDj
         pGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030312; x=1732635112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJNfO/bwZyhb4bIR1ODhbOeQ+Qaqt3sJfucPEncnRCI=;
        b=ikry8XTnqM0Ei7Icjdwjp+cpa/5du3SMySE/EZMzhrKifdUBr2xiTuTQZxO6lQhMU/
         Qb8NZ8muC4FK3tosuq/g4dUB98Ocoy8gDHsp9EIPMhuvkqVZQw7yxSpYqeMBrFZr04Ct
         i14v/oooKwz+D67jBGHI6mIIWCxy4vuaz/eI8a9h5rMGzJvKcBuS8aJQauxK7koqoUdR
         0pBW4F5rTS2sBQTVkzj+7CSPY0AlskLgAVgeqsUo/Bx2ZwMo1FPIMx+WlNcEW4pAL3IG
         S8ORXTL/S4lsSsBJBCexfwklpwtY+WsYI64FWc7V3qJ17QTtPkdVXbiFl/+ln5KcYax0
         ESVA==
X-Forwarded-Encrypted: i=1; AJvYcCUFej03avyUUTWSB3MC413UZ/EgR5WsDGEeadk7CC43+9NgMyLvLS5eWDGTjs5R7tVneQHM3WuoIlCLjPTYCatgfY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM13P9ZMba3eHKfKZYRERyy17530Kis57ZmheyIPtE1T3OHn8s
	6FiABNQ6CgTc8c4WQivg6Y7igD+13KrkgFMkz2bnFiW4kwtksWreCAbB8zO+Cka5D79f9GECmsi
	rg8lMKvtY4i9p7Qem4Q3l7tv7E6V7hma/DnYBWkm8nIL3guZxlKKX
X-Google-Smtp-Source: AGHT+IHyc1gfR30/9ccinwyjnWdNj3QQZleX0xPYSYr/TPzZ45QLzWIk4oq4JbY0vFb8hDr91FcbI9kQKzugEZDc7SI=
X-Received: by 2002:a05:600c:1d0b:b0:431:5f3b:6ae4 with SMTP id
 5b1f17b1804b1-432df74ea76mr165756915e9.17.1732030312126; Tue, 19 Nov 2024
 07:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411181440.qEdcuyh6-lkp@intel.com> <20241118202727.73646-1-aliceryhl@google.com>
 <20241118182818.7717993c@gandalf.local.home> <CAH5fLgjBpz7bPvanupPSsJx3fjLAa7g7nMjLgSxjEde_KDGV2w@mail.gmail.com>
 <20241119101233.19005043@gandalf.local.home>
In-Reply-To: <20241119101233.19005043@gandalf.local.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 19 Nov 2024 16:31:40 +0100
Message-ID: <CAH5fLgiyWDiDFAJO-LDj_ZdRjSnqh-j7vw7URLUm8ZHiFKfGXw@mail.gmail.com>
Subject: Re: [PATCH RESEND] jump_label: rust: pass a mut ptr to `static_key_count`
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lkp@intel.com, boqun.feng@gmail.com, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, ojeda@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 19 Nov 2024 09:36:38 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > I've only really used the sample in this series as a build test. The
> > bulk of my testing has occurred by using this tracepoint support in
> > Rust Binder where I have 30 different tracepoints and I've been able
> > to verify that I can enable them and so on there.
>
> Could you modify the sample code to have a tracepoint that I could enable=
.
> I don't use the Rust Binder code so I can't test it. I use the trace_even=
t
> sample code for selftests, and it would also be a good idea to add the ru=
st
> trace event sample to the self tests as well.
>
> Would you be able to create some simple code to do that? If you add
> something in the rust sample code, I'll add it to the ftrace selftests.

Sure, I'll submit a sample which does that for the 6.14 cycle.

Alice
