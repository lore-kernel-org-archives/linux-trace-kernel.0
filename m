Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11492188591
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557124; cv=none; b=jutUE0kOap6qKAM9ecdD+Co4+1EOKyFAghuHJVEg+ZwO0h/mfCLBEwH9uvzpTMQfnm6JrCXTQl5F5ote8q4LMndTE5FeHCdN6pVY5WZJUKCjonTPo95Ro56P9n4iFEurQ6Tout/cQDhAGPtzfFOLWwJ/ANBHgn07Wo7+QqUmR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557124; c=relaxed/simple;
	bh=iqPKUKL9ELh3ItkoROVJPLFbP84xRrkUj8+Scx+N17c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQGYwFWwL3CD3yEm2rf9YqHGUEgfizcoegLFWA+kCa54Ui/m4BQncmDkvdQj3QfjubaJXfJx0OKKwjk5f1lP7UQEy2t1HlWwvcj0s4fCOSW11n5BsjX5USeyn8bAfWL8I++isyt7f/U0zOMqoT+tsAsa5G1TlvGOsFM7/kaEXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lo37MXTH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lo37MXTH"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa549d9dffdso233456366b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732557120; x=1733161920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xXLqvBkzwwQHV9WjuiXet8nTMU/3s9BgOxGDDiZ4odc=;
        b=Lo37MXTHjOhsCyohUqIcZdBQzvrgMO6437c8Iwiit8DyWSVQThL/aMBuE+s2QxNA3n
         yScV/Ash5CP8VOw0t3FNafYcTgWa2urJsxrmq+d0RFCLiHa/e69ojL78pUQm6x7y8Wfk
         Af4VqgNOyHw53Nbh0nMO2kNrglV7334NwQwPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732557120; x=1733161920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXLqvBkzwwQHV9WjuiXet8nTMU/3s9BgOxGDDiZ4odc=;
        b=oatYxzv/k7DKSH7VrY1btrt5ii6MgLVQee/ka4/BdtmErpgKhp6b6A4mpgZuAuOs+O
         Y513wE7D6W4u0+UoWB9lVxUjzqYyNVesHv/PAgmpqK0+WHXCUhskAubqQqPrUCDB6AKt
         DmFxzlXuvVBILeKNqo76GAAGtjhjlR+Vt/ZsX1N6uRRnHWyx8SdtMaPut578kUq4siAP
         xOLGEEEbxig/qj6hP62th56LQqyyEcfvOyOyD/rvKbx7PsWycp3yAVWLWzB9a/Rwrkry
         Lt3UbnofrZnQLoMNqSh76Kt30Z5ZUCEskpHh7qavMniXJU+iQPCBLNWvSjXaXoMh0m2r
         xxsw==
X-Forwarded-Encrypted: i=1; AJvYcCXe9pGc94DOZ8F+4GgF/WmNYub/G/hNso5GjrExsG5lsVJiVIn0A/d7VVVWqURISg9hkuxoTk5jEa3xuRWHkH4yHBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwucPO85S0xF+dT07GtpY8Vy+kTralpAhOCcIp9R6BSj61XOUhy
	FmtECQGItaT3w3quoGWGZUXSBkjtOFhjnDQxarRHxrGcoK2fRkyvdJ3cw66j9mK3YTseFtlFG8e
	rGxRJxg==
X-Gm-Gg: ASbGncs9WvpADzZ9VYg7ktIvRQPHXlDGeeZ/x1OBr2qhDMCNhLE71eiKaSKjQQa7GoW
	lwY+C+Q+S7QQ/H74BNYeYBpBmMc4D5Zq6mCBAn1l+HB5nTOOFelO50Xa4KQxqwSqMI1a84+yY4S
	TXeLxX8v5PbpBBoPsth1v/GHdPJCnJw5pBEJdKUPYdqgommUw/6YshtlYzvuZ7Akkg9LDQu14bv
	V1A13ev6ITZndT7A3rFi9fcGdEWhkWIJlZGjagKQh3H/aRVZjwYFT4OONiAhEdSXyooFBk0w1NQ
	LsQUQUH15UhLs6BB2e7cKus4
X-Google-Smtp-Source: AGHT+IGzvmQrd3wHX7Wpg1i+dO27tjFG341NKBB70GRMMNTW9ez9J+W89a/zWlltPhD1aGPb3UDEyQ==
X-Received: by 2002:a17:906:31d4:b0:aa5:2a57:1779 with SMTP id a640c23a62f3a-aa52a57182cmr1053625166b.59.1732557120367;
        Mon, 25 Nov 2024 09:52:00 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b29b38csm490766866b.34.2024.11.25.09.52.00
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 09:52:00 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cffb4ff85eso6503197a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:52:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkEB+oPxunF6UWnqYiYZ1EPhM9qu1frwAok5psqXrS8YONA12+d8KIAb/n9+qa8DEjE+F0IjoHB94svLC5IfGEsOc=@vger.kernel.org
X-Received: by 2002:a17:906:18a2:b0:aa5:3b5c:f640 with SMTP id
 a640c23a62f3a-aa53b5cffafmr703474466b.54.1732557119666; Mon, 25 Nov 2024
 09:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com> <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com> <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
In-Reply-To: <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 09:51:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
Message-ID: <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 07:35, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> At one point I had a version that did:
>         if (0)
> label: ;
>         else
>                 for (....)

Well, that is impressively ugly.

> but it is goto-jumping back in the code

I'm not sure why you think *that* is a problem. It does look like it
avoids the dangling else issue, which seems to be the more immediate
problem.

(Of course, "immediate" is all very relative - the use-case that
triggered this is going away anyway and being replaced by a regular
'guard()').

That said, I have a "lovely" suggestion. Instead of the "if(0)+goto"
games, I think you can just do this:

  #define scoped_guard(_name, args...)                                   \
         for (CLASS(_name, scope)(args), *_once = (void *)1; _once &&    \
              (__guard_ptr(_name)(&scope) || !__is_cond_ptr(_name));     \
              _once = NULL)

which avoids the whole UNIQUE_NAME on the label too.

Yeah, yeah, if somebody has nested uses of scoped_guard(), they will
have shadowing of the "_once" variable and extrawarn enables -Wshadow.

But dammit, that isn't actually an error, and I think -Wshadow is bad
for these situations. Nested temporary variables in macros shouldn't
warn. Oh well.

Is there a way to shut up -Wshadow on a per-variable basis? My
google-fu is too weak.

Did I test the above macro? Don't be silly. All my code works on first
try. Except when it doesn't.

          Linus
