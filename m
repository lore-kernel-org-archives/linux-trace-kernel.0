Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD223816A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774016; cv=none; b=J6jBYPfLvOjht0/d1RDUuMdo6qlblB3cy2BRY5v/WH4UnJRk3P7iJa4ecgiqF3mKjPSpVLcMsuteTDNavtbWGJzCz6Zyw++fuuQ79AI27ASS+p5JS9yH15SSjqMzwmYWjJDYguKM/mwi6CmVYwWwCVXNxyDX1auFdqJcWsgjzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774016; c=relaxed/simple;
	bh=44EQK6dLj/vVJbnQAMaOqI2VKfynAQswxAG+H2Hgwh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCHfCBSgUpa66aQ2xvB/03dM+tcgl0C5ezhC0Dtd8JeWzjh0iLrQcih0hBHUOXcw/aDAdhT7W+jKV5k07F3R5g822SWKrQM47nN+AVvQnsIzyZVkozlQS+AGwFryMQ8kwoqoVnT4cqci21e6pqZ7g7NnHgflqHnib1oIlDD5pyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ggsYQF7s; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ggsYQF7s"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e9d633b78so729838566b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759774011; x=1760378811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O1YMJ+aXl7EdGap3QzraeXgeu0wLn2f5cQEayrv43cM=;
        b=ggsYQF7sQKUoU82e/h81XzhjaT2uUNsTw7CQScO+tnPYzAuRS4dCQc5ik1vgT09lDv
         E4suAVNuOE6gQkzYJNpLWAkh7dQqIE+FKE3ODB2X4XYi7AYKWTuQajNhlNb0hLby9zBs
         HfO6j5kFpJPifLP2DAcbNSSw8EIkeZr1o5H2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759774011; x=1760378811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1YMJ+aXl7EdGap3QzraeXgeu0wLn2f5cQEayrv43cM=;
        b=nFKWQnPFf/fW5Q4R4MgYYvGN0V4/kLG7n/2UC7Eb9mOgBZsTRMmAOzW05sjVy4oMzS
         AeF10XVU1K5srBXZT+3Kzbif/Xeq9Ngf0ntRsQlpK5lvDOSgzacj/l8wfSJchEZq2WH6
         +R1xnykRKbnKuzcXT7v2QVWJPJMvRqxqsnYw+WxGCwlMHbR0XuS5CK6P+GSluoRYruDs
         wjBfXCHk9ToWoCyrOfPZlmBZpCznI3Xu+8DNgAEhamYlqnJM82hf64sqqPZFLXzHDkp+
         pnm1xknQfQaBx+Y7IJ8m5eP9q7Qba6ZPORJ2Igh72Z1fHNoMeTRG7nYKkwz21wKO5XrZ
         WQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUnjHjx1/qWIlfr0TJV3YM8HnQ5zvi4LrFS+umGX5jfh62N4uHF0cnJEr5AA1hr94zCcnUfuWfCGGroN4W2qxLR+c4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7ffJjk8imXG6ebCct7VxUAU5xJRuDnoswCfdY261DDHUFFjy
	xzTLvfwVsoW/CBw3wUO6CbqhVfZPOtyZSIn/EXsg9Pvb3NxJdgjE8yonLOEhp7CM/01Dmcy9RN+
	DeT9o6fY=
X-Gm-Gg: ASbGncuqpmi2rtiQydgEypngJlZGJUfNWbYu2cJ6QgtKyWlq53iLcOOE1FSCWYrEE6E
	H2aBKl8ngADfaS5MKZ1dss4Jhox95k2NC3mb3+3HJlNd4yEr3quqjDh8immMJJs6NmLrBnjd6Av
	BW/ZxjLz9MBrlyjfNcmuoHEdj8s4Mmm9vpltj9FeI+TSVWa30vEmJVfAuJsdf3JLtBJuwf1k7UR
	F7NmMR+ne/PM39ealGegGPn3K17teslzlvUxNX7PGnWjRcbgDVXi1K6JfuXbRJKMMlVFLQuqKuV
	Lu/fH+SFyjqZoFMlkOfBaICSL71RoePDGq1bAQURQ2rh5u/77/V6K5xzkXn0N/M7fXKiDsCyQJA
	sbmy7J8ag+qBxHX0LuZfcWBe3mUqTgBILImbEX74CUGh7N8yggdybyn76P4iH7Nqms/HgsvBYBJ
	bl8BbnZAVu3OkWjNjaMlzq
X-Google-Smtp-Source: AGHT+IErvUYhnGxQokdVO5S3uIVqPArptYrJAGOOlI6GL5iAQHPUVgAaBpS2YfZFZ6CTjLkEmaYdbQ==
X-Received: by 2002:a17:907:cf8b:b0:b19:f444:5bc8 with SMTP id a640c23a62f3a-b4f437309damr69870766b.31.1759774011303;
        Mon, 06 Oct 2025 11:06:51 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa040sm1187897666b.20.2025.10.06.11.06.49
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 11:06:49 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso12146599a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:06:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGDXX9tdwWyvzH/ViQnTOnB+bjyfDTRAQaXc813BBhDmL3d2RGUIYpHx9VRngJeKKYSfFt9PrbLya1iH24GBiFSq8=@vger.kernel.org
X-Received: by 2002:aa7:d996:0:b0:62f:9091:ff30 with SMTP id
 4fb4d7f45d1cf-639ba74c4dbmr516017a12.3.1759774008962; Mon, 06 Oct 2025
 11:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175974403177.1372080.12078001360837326466.stgit@devnote2>
In-Reply-To: <175974403177.1372080.12078001360837326466.stgit@devnote2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 11:06:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whv_JYJCh48wj7vOZmAB2aLdeCXQQHeKqZKuS1+Dunbhg@mail.gmail.com>
X-Gm-Features: AS18NWBuOR09k1xaNmGZuydmVihgjXT_rrOWnCxozUoDIf387AUt-qXMBUx4cgQ
Message-ID: <CAHk-=whv_JYJCh48wj7vOZmAB2aLdeCXQQHeKqZKuS1+Dunbhg@mail.gmail.com>
Subject: Re: [PATCH] tracing: wprobe: Fix to use IS_ERR_PCPU() for per-cpu pointer
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 02:47, Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
>         tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
> -       if (IS_ERR((void * __force)tw->bp_event)) {
> +       if (IS_ERR_PCPU((void * __force)tw->bp_event)) {
>                 int ret = PTR_ERR((void * __force)tw->bp_event);

No, this is still entirely wrong.

That casts are *WRONG*. They should not exist. And they will cause
compiler errors, because you are casting fundamentally different
pointer types.

They don't just point to different types, they aren't even in the same
address space!

Stop adding random casts. They are a sign of type errors, and as long
as they are there, the code is buggy.

And no, it's not just that IS_ERR() that was wrong. That PTR_ERR()
won't work on a percpu pointer either.

No more of this randomness, please.

               Linus
