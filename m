Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A67278161
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201033; cv=none; b=HaEBYKWobV44F12lg2QTJHvxQN1KBDKLpa+Ii9vHwweRG4RsKOeCK1QiZ6XacW0Mou/ejaIj2L63vWDeVCpzimfyyXBRFZvPvPG3kxIHoyMILKI+91bQ9OhhbaaqEa62BGrBdsa9XhLusPk32EQA1FzKUb+1wQ5oomtrAx8XfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201033; c=relaxed/simple;
	bh=FDXlr7W+/66QOFftaHFQrLT51jF+Ev61+zYZLRFU49U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9VzVJXXNSLb2MK7TBYy0vJQG1FtOYrJBKKitN2xV5VmyoHJM2NH0lRH4S4BZhek+//d5LP4n28sd/O6k7U1+d5R5giOxSB31ibyykIK0V1v4C93+8OVJixwo2fGujrzD9di52lHa4RbZYImeGvWphAvS2wfb8dsRMHaVUMD5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FePCoxXH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FePCoxXH"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so1038085966b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753201029; x=1753805829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MwUpVzSwK6dKQWrESREzqGXoWD+c7JZoygfweu86bO0=;
        b=FePCoxXHflz+Xa7ML6fz5fmq0+45iPmkB6LpMVy0iNI0bKIq8K9ifQC2FSyWqln2x8
         0b2A72nHVRLJNQfUk/e4o+yeDxKDvxTdCh+No98OecloPxPEa4Yht4qneioqbWLU+gzt
         YGf5zZrtRS+iHMRuRwN4uFev/aeyUXP2K46S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201029; x=1753805829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwUpVzSwK6dKQWrESREzqGXoWD+c7JZoygfweu86bO0=;
        b=JgP5tlbSSEqzycgghrpVqinOXN+Y660GDJRYiFKRl8AfMWC9sur2BzDjQfLmPqNQKN
         1ouSeO9CodbOyE5FPyLj05dk2yYwqOOzZngSATWI3d2HJtKAXacRNjYOWP9Nle47Db3c
         kZwcFwPhZLZHbK+298kkExwhwH+I9m3ys5YnX19N8gMQsXd3yIO1+qabw1+vE9XTxjGs
         ajK0oD5ycwQMjBonGCu9NPAYYe97LJfpod7dcxBEqxWC7OOhWeNgQihpuCOQaiIYTUvR
         i0Um6trYroQOyPGQXyI3/8D6vS04H7jjwC8IVLl44Go/ZnEMwYiefnGAA6gPHQritSFF
         6PRA==
X-Forwarded-Encrypted: i=1; AJvYcCXjC1OxlXpSSkIoYLeqhZ/xfnq2QUYNykp3YcozI/Lh3GonJIfHJ9+JxFgoGzi+uis/GffCxOvCUncvcOrxJeTygNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzgZQaX6/RR+Jdd6B51cQZVIY6AC4Fu2LSJklLETRyeCJ02iGs
	HKZweJ3kDex0p+BxjM2KNa69TK+hh4Ys+j0r21deSHt2tKM5OnCPzUUj4MpaPTn4gBtfvK326Wt
	fY11i
X-Gm-Gg: ASbGncsy+gKl94bi16kcPr04GczlB1JiA1giRGQCfv+SZinuAOaIDs6ug5NT+wU2kDq
	hknf8wVWK6T7+TAsB5MTmSMYKV8kbr3vWsEARws7uEqm21YAtuVnl1IBy2K4VWysqtL8oUPznfL
	Gecw9ir5EYDwZmbuv33SsyRfx87remeeKC8uXA0wiE5Cnd31JTK1h4QC0OQ2sCXFP6ZDgeowbQw
	lb2CCvJrDCRVuupgwJIwdWcytfSGG6XyzFVs3Px201gcLaN0+k6iKYvA2ChC1tm9rF4jJPx/S3M
	pBbzcoArjtu+5daKgTbrscf4EvMpweIsu+ymmHw0O6jz6YwLf0tU6gyL/+U5zMu2Sl2zguIbJWj
	HAkQKkVllA0TGq66pL6cM1ejHxdn/+2mcd8mmJ8apPJ1j6sMJLQAQ925UqmL/yOuLxT6ymrf8
X-Google-Smtp-Source: AGHT+IF1lCtUKB2O+TjabIs3uVIP57LCOAE2tChYuJ2OBIvKElNi70NL/UrLZHDX2yQiFkbNUs3CUw==
X-Received: by 2002:a17:907:9450:b0:ad5:74cd:1824 with SMTP id a640c23a62f3a-ae9c9b15e4cmr2709366666b.38.1753201028724;
        Tue, 22 Jul 2025 09:17:08 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79b4c0sm891231266b.8.2025.07.22.09.17.08
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:17:08 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so11560472a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:17:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgEjJIONWj6Va9bHqG87ilxteDUyGAxnwSxYRAqOJSl/YBKl4S61L5R94PU7v9YBTneFVIZiSb3VwRzKJVloD0t9o=@vger.kernel.org
X-Received: by 2002:a05:6402:2111:b0:612:ce8b:8e3a with SMTP id
 4fb4d7f45d1cf-612ce8b93famr14784723a12.18.1753201026121; Tue, 22 Jul 2025
 09:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722152053.343028095@kernel.org> <20250722152157.664260747@kernel.org>
In-Reply-To: <20250722152157.664260747@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 22 Jul 2025 09:16:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihb6KVgU__zfhdHR=-Mqhp6qaAABdu31CJ2ML6MDj0dw@mail.gmail.com>
X-Gm-Features: Ac12FXzcgZHEVpW_XghiBSi-6W6yHtnaI5_N4MXF70P1OCTvgMWBy0XPnjswCTs
Message-ID: <CAHk-=wihb6KVgU__zfhdHR=-Mqhp6qaAABdu31CJ2ML6MDj0dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tracepoints: Add verifier that makes sure all
 defined tracepoints are used
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 08:21, Steven Rostedt <rostedt@kernel.org> wrote:
>
> Add a verifier that injects a pointer to the tracepoint structure in the
> functions that are used and added to a section called __tracepoint_check.
> Then on boot up, iterate over this section and for every tracepoint
> descriptor that is pointed to, update its ".funcs" field to (void *)1, as
> the .funcs field is only set when a tracepoint is registered. At this
> time, no tracepoints should be registered.

Why?

Doing this at runtime seems completely bass-ackwards.

If you want to do this verification, why don't you do it at build-time?

            Linus
