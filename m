Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433DD1DC1AB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644847; cv=none; b=AKte0jvn0oEYHOlJKBP2AND+PejDqDhuux1mbsEcX3RT3Uf1RF5qWymHrxEjfrjdLY8s/QuyhLYcugIT8eeYZWLcQLYZ433mHwOCZ6krs1+PMMer2R7baW+mJ3LAJ+NtN118+HU1GYOdr4Rzmn6f3ihJB8WqroAUsIEGOFA79ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644847; c=relaxed/simple;
	bh=4wpJhlYdPmaupiMAB3djRyWBKlzCNM61MqWp9mDP/DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHZZOpVxdtcJugIRnFTa1W2hahg7z+zcP3N+CEqKu+ro8SXAIMvBgl+tFhx6nn7wOOC6z/xoddmAmHNIpHywXiUORk3wIELX2O23e7fT78M6L8+z1yJDQ64kHcwOcKWkfXVL2SlVRcP3P4qGkOVMlI8oQrQPaGiUp9l2Y0J4+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gXpmrlNF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gXpmrlNF"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53defd5663bso164147e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732644843; x=1733249643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNamshPaCUTPte8AHmdb3Dr6lmIGJc8Mesv/4U+ExVM=;
        b=gXpmrlNFkianj/fnpR1Rbp7gzfbBxwA7QjUMA79XltjeBlFMK0d9db9T8EtuBi8A4/
         vhDg5sATpOtRpglvuN8hYEk2Pf2Qwl3YbsWY0t+F8y2YfgjIG5BxTCwJe3fY+1ie8B1f
         FtCwIdA1rmm+id4ebuqnoQy8YpH7gvYqgQcjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644843; x=1733249643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNamshPaCUTPte8AHmdb3Dr6lmIGJc8Mesv/4U+ExVM=;
        b=B6gvunD8tQtX+HTUp0wLXgcAf6LiYfMWaKNmMhaNlKWB4V3ApiMe8DjlZeKLu5wZsg
         8WLjh9LD8H20gm3mHIpP2yyW+qheaQKkP4NInSjMcnupfyMfu81jBo0xK/53HGhEolEO
         p6+w0ekWdmWnPnbjzIIS+Rr1nhqZ4PjxYTY/FcWPAGpxjxm3AJczbZDXoe3F3D2SybrI
         bD30f8bo3m2jqgL4zBpi8xqTUjGeyapqL31U4/kfxB8K1+sCLjAZAWW+FdYV0i7WGpCB
         wnqlnBi1wBhtkF0G8bQLLVYOFUIegGcBGjDlfsNCEgWgowI3yeW1MObTypEqchM1I5xY
         2whA==
X-Forwarded-Encrypted: i=1; AJvYcCWRQFAdBAG+YCkNdRJtHTCDfpDZArvml9u8sMpJDYtiMVUADfM2Cq/6J4SJXtGTNA/S+6OB4FPO97DFBWhOHwhmNFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAWAL+00DrMhbT0fkwjEz6ZA2tYztwqF1m3elRV12oukm/i4lF
	rLjS3LaLsNdPaFS1PUb8+1DRmbWdp41uoDW1CutrnO9FibfzqmSSV+fNmigcLT5o0bOzhE9BJ2q
	7Sq4=
X-Gm-Gg: ASbGnctjGxqYikPF9wH4WK1kP3wOAsXM1bb8pf0GLxmJC7KnfGKNy+QtI+kw6NxWBsg
	ltff37Ivjvq2LdmoSNBN/FbjrOk116yLrTvDjc094+n8ym7NGQVOOmL4EooBHLujJN+WrClkKLF
	kgNPWxJ7mAyRGwLFhUMUEMpzmNi4+PGvy/9fgsr26M1jGyKYtYRJ2UD8V/e5+jiVYQbNYSbTOOe
	u8Rh+zBBjkpDbotzx42RDMnUkOIuOsJ5LVBW7MKjJ7xIqdSK4gTqBeYJTzYyn4io0znKg1HIV3C
	sgDYPdl+HTmB4OI7jBUD/sYB
X-Google-Smtp-Source: AGHT+IG7yjjJiyFkMHzfwRN2gdZzMXE/+NKtFTNZUlYVG373/V8Bk2lCt9578O887QdFPycOiTKWpg==
X-Received: by 2002:a05:6512:20cb:b0:53d:eef6:bb6a with SMTP id 2adb3069b0e04-53df01148a9mr6978e87.54.1732644843160;
        Tue, 26 Nov 2024 10:14:03 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24456b2sm2043169e87.56.2024.11.26.10.14.00
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 10:14:01 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53defd5663bso164067e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:14:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZ+B4oqTSTmLjt1RWFvR3qc9Glr+OOwN5IbZEK8wa8sVzz/HnpqUuI8SVDdS9sR680AQOF4ibeeDmsNz0T05uVMAk=@vger.kernel.org
X-Received: by 2002:a05:6512:baa:b0:53d:a95d:982f with SMTP id
 2adb3069b0e04-53df00c78a9mr44040e87.5.1732644840155; Tue, 26 Nov 2024
 10:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com> <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com> <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com> <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
 <20241126084556.GI38837@noisy.programming.kicks-ass.net>
In-Reply-To: <20241126084556.GI38837@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 10:13:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
Message-ID: <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, 
	linux-trace-kernel@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 00:46, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Using that (old) form results in:
>
>     error: control reaches end of non-void function [-Werror=return-type]

Ahh. Annoying, but yeah.

> Except of course, now we get that dangling-else warning, there is no
> winning this :-/

Well, was there any actual problem with the "jump backwards" version?
Przemek implied some problem, but ..

> So I merged that patch because of the compilers getting less confused
> and better code-gen, but if you prefer the old one we can definitely go
> back.

Oh, I'm not in any way trying to force that "_once" variable kind of
pattern. I didn't realize it had had that other compiler confusion
issue.

         Linus
