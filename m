Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13901DF973
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660865; cv=none; b=OtH0YDqvqqrCysph42OIWeS8tBXrG5vQ0b9ULln8HcaQEG1Xd7vUMg0bFZ82QMXfNKWTl+HRlyt0MiqcVe7JOae65FmJC6waxbONk1luuff7AHOIYMsZYDa1bizH7rCrNhXz8J4lf+mvJS7HpioRiWr8uj2xab+AYrAxzjyTZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660865; c=relaxed/simple;
	bh=51rqWKa/9fOh6GQVlexs1p8suWSnLeJOxOeaHETGV10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwBJ65Lw+LewDeJklxGNxTH6ceL4Xye4gIhCPqj2bXdhzvLUtGBDuZ+UpFELlQPB5DjlXX91CvjMS4wqbZ0CTUCtO3XbCfY+ywvxYNus0cZeYCQQ3rK/gqqklSrLKtO5b0ufE3GaNAbrlkqH8oq677pPuuO0jtX0bdfHnKbK28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SgAqWW2M; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SgAqWW2M"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso531623566b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732660861; x=1733265661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7pbYi8XVvPynSRXkVpkfjziZ+aTH3WZhoGNDgr1HVmU=;
        b=SgAqWW2MmjSb5YvTAgl14bBpDrJsxoxbkc5YEuc2D8z0GdbJXyuBaVLgQXrNTuZQMR
         XYEXF/rSSpcidB8xVBFi15ENOpszrCxE+fKwr66XOeCslAIxKpVtYc41ibQyMdOKVAV/
         cMjNf4ybIKEXvTiwBiwgiWZD+d1jThuP9YSRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660861; x=1733265661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pbYi8XVvPynSRXkVpkfjziZ+aTH3WZhoGNDgr1HVmU=;
        b=nFkW3kgcLiPMgPBg9DdzyTLCbVJNWvCuAzteGCBRqphj4l+LpFFSnAHlC6QmR71Xrs
         6R+72kZvQRwz8BPGMR8PmSKzLmDcw/36Rf+eHuoZUjhgbsm+mJPkbr3OJGvcG3B8KIeX
         dt3vFYWB7AhNGSBwkkqjvQNbw2DpAn3zsbYdDbNJEzUhrJoq/xv5DqHHK9Pfw7oFqNul
         46DcgO4lO7ls7W74NnM9YgOa6boW963vP5kuOxC/2B5WH6+5KTdz5eEosE+oohN74k/X
         Aw7Y++4h9KHyBfwxUJD+Co93CHvsQFnWIALff7M7/qJumfZ3yIHzuSWIh8XLvssmqAHJ
         rwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwlGvUlaX8AVTcSS/OoEJqQYKa2rfYLAjQD8sPN9/ZJPg33g0bUyh7CaLvuX+rJFSr09m1WgSnm1GozXWwIyWHbOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycmgOHH/ecxG6BlXvxTrtZvUCNXXuIe0uNaylck3IqDnhIQ8Bq
	qRc+tTNmdMHWqPZJda6MO55w77Ydp5Z3XkLrCwcNcJHZ+K6fenoFQgI5pCBBHsymAmcTkrlJkvD
	ZEigk4w==
X-Gm-Gg: ASbGncvP70ZPZmMsinRrWAhWyPo4g/E63s1RN9IB3V5AhkTeOR27gdkKDG5shdcvoxe
	UG8/MBnCSTtUjo/VZTcfWKeJnSTyQ869J18eujErJN5zfPHf3jRJCjQkfTep/kQPESRspILSWcK
	1saUWphzNNuQdpfRE3RoPERpeTPPsDLvaWdu4m0eJOsQJ0f3BA8zoH8xJ6oJ+4akmGFe4bdWROA
	Rfv5cKw2yOlFO9aDBfUYcRYspE7+gukeLA+Pz7o8YF7bF04IpQc2reTlJAOGjCUuGtLlBLA5Eju
	yEyRAT75cAeed7y4zP++gHNf
X-Google-Smtp-Source: AGHT+IFF6WYkMRTOChCBJMpNJnfzo99yM0A7wtWjWzrkfpwvvyWrHt+mTeT90IzT0HB2iZ9lMct1RQ==
X-Received: by 2002:a17:907:7802:b0:a9e:441c:f729 with SMTP id a640c23a62f3a-aa580b2e09dmr68370666b.0.1732660861319;
        Tue, 26 Nov 2024 14:41:01 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5208fd7bdsm585458166b.180.2024.11.26.14.40.59
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 14:41:00 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so998814866b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:40:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUG/al618Rpb8DLpKdxnLeCpnM9a5nSlp2ol3rbNUFeMMMcialAip5Jy86NHnXpYrmi1reSYMQMZ8PXl/8+64RsJc=@vger.kernel.org
X-Received: by 2002:a17:906:3090:b0:aa5:1ce8:e4e0 with SMTP id
 a640c23a62f3a-aa580edfc21mr68092966b.10.1732660859315; Tue, 26 Nov 2024
 14:40:59 -0800 (PST)
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
 <20241126084556.GI38837@noisy.programming.kicks-ass.net> <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
 <Z0Yz6xffDjL6m_KZ@google.com> <42ef4bd2-0436-4a1c-b88c-73101dbbf77a@intel.com>
In-Reply-To: <42ef4bd2-0436-4a1c-b88c-73101dbbf77a@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 14:40:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAesttDd8qj6m9Ns-Xz6+44N4MsOnyROw5YzzhV74W7A@mail.gmail.com>
Message-ID: <CAHk-=wgAesttDd8qj6m9Ns-Xz6+44N4MsOnyROw5YzzhV74W7A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
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

On Tue, 26 Nov 2024 at 14:32, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> BTW shadowing of the goto-label is not a -Wshadow but a -Wfckoff level
> of complain; I have spend a few days to think of something better,
> including abusing of switch and more ugly things, -ENOIDEA

Yeah, I think you need to do that __UNIQUE_ID() thing for labels,
because while you can introduce local labels (see "__label__" use in
the wait macros and a few other places, where we do it) you need to
have a block scope to do that and the goto needs to be inside that
scope, of course.

Which I don't see how to do in this situation.

        Linus
