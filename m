Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE41C8FC1;
	Tue,  1 Oct 2024 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801977; cv=none; b=iP6IeRNB2ehlLk9xvRcX58AVDs1tduZMjuu1OCIBHHzWA7Gm9uerX0q6iGxvEDuHm81y8g5548j0hvDVh1flhiqSfxPHVTwcUZpa6LiS/ETbEEnIt4ZAjtdUVBRhYt5NNbsoZTFf2dwUArMQU8bHchDc5eyqMWHW+th0f5vFN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801977; c=relaxed/simple;
	bh=4MM5ZFF2d9ZcI0e3920y7EYwxmJ64GRU2cCHyhc/K5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbY14h1EcmJB7OXJWumIEwYQlEdOPeU9bWNrj7CidZUEEim+xDG6/zmkbChQzAYEmhyuOb2Cn9a1y3S9dSdiO4/xSJyNaMkZgNRtEpqPyn+W+5OikeNkFpTkHHUNDQcDsQig2oe+WftGxmuvlyAH1yESgMZASZJy1AJItUj6NTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gySZhkhc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gySZhkhc"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0a950e2f2so4599000a91.2;
        Tue, 01 Oct 2024 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727801975; x=1728406775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftYNTYgyjNPmNwtzVg9cpjdLgYv4+mkspQutc3UcLQU=;
        b=gySZhkhcoJRQ9cgviJqdwumxK1D7Eq5bALaxJygO/wIkINcsLBRjQjW9tY1l7Cui8j
         6grfk6zdY2iYiiujoMAqHdVdrXhdpzrJomv8hzgf76NbnLpd3xIn9TOrCqtzjx1wjeH8
         rqrbaS5qIyZxI9jQ8bVdQ0biKzTgk3dOeV0YCJVQYhqvwVrKHAqfAKBxsWeLl/287XhK
         kBSOIZvpOlN1Qnm8X1JcH5nGpOwDG915uNtYQzi5W5bhi9gfm6M2RtCP38bGFDxVz1mV
         9IS3vLJj/nol8Xu6lbq03ay2qzu2yUgfqxsiLx0JKgAq7oWExMAtPTW72KFMZ5WC/mFS
         D2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801975; x=1728406775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftYNTYgyjNPmNwtzVg9cpjdLgYv4+mkspQutc3UcLQU=;
        b=EvfmOwsrlri29c1AlU6gB61UsZJ6TkVnnxPZqbv5qkfReLrPWVBqp3w8XOUR4g6XPR
         fj5jOk34Zv9yeFlJT3rrDxtjIHVurHmyOzmlID+T3vB+fv8XIQQGqA0UR+Y1/AsbMhrY
         4nORkLAASjpro3Pb9qmGnMDYAP6tQC1cHsNnKH1vrI0I+/fncPK4nJIRGeq2E+tAjJuo
         0yVe/1JXDv222zExu5LUf9hROiXZyZ7TcXjeIfuA2Sip3u5zh6b4IHDjXWdCrCm7fXaF
         sfYhjJjl2zJMdPdVY4+88V85pJfLPxnZpdKwXSeovSiRWwi6BWUwVCfps2/5uh3tef6e
         LjOA==
X-Forwarded-Encrypted: i=1; AJvYcCV91DVNny0xltx4ZucvRKv8zPJjJDgv3WdwkQdyu8tVx/qp0hglAjnAHyyxSmoe2ngEz033zWNHKY3n+hJILjrXmKkC@vger.kernel.org, AJvYcCVosejleQaJ0zQ474zrJv0/jDwG+oQXBZOS3UDbbiDMVq0Qhn6QwHQVYsaJpLybnD6lP0Zd88BBy/PRZfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47PRdGOIoBrJL7QFVmsUHR9g0RhDkfwAdD1NUrTyXKgXQ2C7U
	i6EnIzI1UYw6snwSVpOizmgFgZ/l4Lw+2mrCaO4oWcV++ZXeFIGLB2cIeeQ2guPxOE6ufH73W8W
	47PRzYVfE2Qk5IZgYEi3IqRWK4aQ=
X-Google-Smtp-Source: AGHT+IHnRIPU4MKyfaTHWrqc8Ht+ALcpRExjG7ckILY/sSJ0ZZtGPedSHi3y4arNBNEz8+LvgE67jsFnVZ8dZIFMH6s=
X-Received: by 2002:a17:90a:6808:b0:2e0:adb6:d0ab with SMTP id
 98e67ed59e1d1-2e182cd0eb7mr469698a91.0.1727801975324; Tue, 01 Oct 2024
 09:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001142416.GA13599@redhat.com>
In-Reply-To: <20241001142416.GA13599@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 09:59:22 -0700
Message-ID: <CAEf4BzbTTkRO7fOWSCLvcufFkLXFsPAALaie66CQu5r=aA_Wfw@mail.gmail.com>
Subject: Re: [PATCH 0/2] uprobes: kill xol_area->slot_count
To: Oleg Nesterov <oleg@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 7:24=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Hello,
>
> On top of
>
>         [PATCH 0/7] uprobes: deuglify xol_get_insn_slot/xol_free_insn_slo=
t paths
>         https://lore.kernel.org/all/20240929144201.GA9429@redhat.com/
>
> To me this change looks like a simplification, but perhaps it can
> also be considered as optimization.
>
> Yes, in the contended case xol_get_slot_nr() will be called twice,
> the second time after prepare_to_wait_event(), but I don't think it
> can hurt in the slow path when the caller is likely going to sleep.
>
> Oleg.
> ---
>
>  kernel/events/uprobes.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
>

LGTM, for the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


But I've also been wondering if the kernel already has some sort of
slot allocator that we can utilize here, instead of reimplementing all
this? I'll cc Vlastimil in case he has some good pointers (or can
point to someone else who might know).
