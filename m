Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2A155389
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704003; cv=none; b=bvMCotwtQIFQP9KfW6vHNlN90Q5C8724N44f0wODIs8DFNTO/n6Lbgod+7Dm6+F2mXZm2QVvmK1tZR5Y6SxN8on/tVgFrPS7apPfqnF+ABqi5wuNsblgnkTLoNopFVXxJOJu8zqbeqvCia4D8/yoVtlR4qYzbo4WyRlo5Igiij4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704003; c=relaxed/simple;
	bh=YAhRCQad9Fl4phrqCGjZO+vojAEemq5NZZJCL/La2hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAS4EipNsCDQS9xUSO7RncZ0RYrLhwV7sWmmy2ViH5dK6T6xuSRSMbwrmJcoIfvKt8XCUVl01yx9AsjWU2lG45bWiTqDlMir0Xl8KH6N44JtrtmQUyuBlyr6w42zFD8YLCcdOhmiKYXGaykaNpJtUpBAJ0ENmwY2e6+zgFND7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGf4ZUE/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGf4ZUE/"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fc1f1748a3so2976609a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732704001; x=1733308801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YAhRCQad9Fl4phrqCGjZO+vojAEemq5NZZJCL/La2hw=;
        b=UGf4ZUE/azqXHvTxRc+yubhctdHB7I2hvkktyNjktSw/VqL2rcOWCx/xxeMAgtv1ff
         /zUmJrR3SKsazMNpEYSlDHL0yeIj+FEfnKFAAgwdLwEl+OGtSqU79YvbfenajnPRlih8
         RVQ6BaMzEBegpcCyYf6yz2mYrtfwA5kIs7/1oCMJitqgYu33/yyiptVwWQKRT0h20DTh
         Z8vWZ4ejLp6cqszhMs70soLauF8kadhrMUt2/qMY7dtDFOCv10EhXZBS8Ro1ABLMANU0
         Wab0AjESvFm/KnpOxU2SC9KDkGwZrDs0jB5OY25kb/rjkXgFS1bdmk3RC6DPX9BpP1hi
         55/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732704001; x=1733308801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAhRCQad9Fl4phrqCGjZO+vojAEemq5NZZJCL/La2hw=;
        b=sAaaa5bS/tK/mzojnb6GBwcxYDsrOlwqYxrRnBHCwhI13Gco7LFPAwN+V1l6TJjoIy
         LBCSuSbBKsyRMrfAwLJy9T7XsJY3kgZjNz9pKBaAunXlMLS7UG9eOju1KTCCVqH504fN
         AY02e/qFa/VWpnsCupA4hWZS1gENIRCfFHeJ8pY+922KsvAHxk9R//u0oZqbaeLq7BVv
         WNL0Kb0RSa2g+jGSzc2rhOYYom5ihdbIWi2ix51780KP2RcXZyeXedxO1FjgQBxMEv2p
         2vFX8gOhjLcU1/7UJNy92Afn9RLUmleP7ksN4x3b6V57s5bYEWSugWuV5F/Mhw9+wNkT
         Fs0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWngz9MNceMwTZaJfi9ip5gDivM7YvNbmHXpkpbSpDgqv4h5Bnu4vhwSbniUHzscyJjJrDZKgr8FEhQcCEKTk5rWLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHoRHfL4tecbCm6oReEBoye6J+a1kH/5ZmU/7ig8AUdLCagwto
	nLRs9jx5gODGXubGuQK6X5UXvNsRUImEquxiioApnb7UCgu85ciCSXW7V/ozywMWoB9eg2VbhKp
	TrX73y/jTrguWIzla5dNW4Fqm3m7uu+4VYT4N
X-Gm-Gg: ASbGncsceSLKyR61221NDJdkPyp9uUTq0aKT9JEq34lA/e8GqA06cWKbQX7J5yiFHKF
	OtpQu7CmaBF5PHbZUGSGbjHqEhBK+hSt93rUvUdVHb9PcmnxXd49OlzzErT2Q
X-Google-Smtp-Source: AGHT+IHPgg7jOSb4n1FJaK9z+pT3P/39rZh85gc71gfy/mp5/MtBFS3bSZy7ijgI60+hE3Uvgxy8QvoOG7YZhKKkocg=
X-Received: by 2002:a05:6a21:99a6:b0:1dc:154c:365 with SMTP id
 adf61e73a8af0-1e0e0aa746cmr3992920637.4.1732704000763; Wed, 27 Nov 2024
 02:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126165414.1378338-1-elver@google.com> <CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 27 Nov 2024 11:39:24 +0100
Message-ID: <CANpmjNNm7szX_9D9z2iYr4xyN57th0WMOmiipTCYYkSo-Z6rLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Improve bpf_probe_write_user() warning message
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nikola Grcevski <nikola.grcevski@grafana.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 22:32, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
[...]
> should we just drop this warning altogether? After all, we can call

I'm in favour.

> crash_kexec() without any warnings, if we have the right capabilities.
> bpf_probe_write_user() is much less destructive and at worst will
> cause memory corruption within a single process (assuming
> CAP_SYS_ADMIN, of course). If yes, I think we should drop
> bpf_get_probe_write_proto() function altogether and refactor
> bpf_tracing_func_proto() to have
> bpf_token_capable(CAP_SYS_ADMIN)-guarded section, just like
> bpf_base_func_proto() has.

Let me do that too. But as a separate patch 2/2 as it simplifies
backporting the removal of the warning to older kernels.
