Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F1356771
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713823; cv=pass; b=cHPWIUtEg5Zl9pVYbmFb/y5G/9do9ivUz5C2L/jgPoyUcxl3o6vOJdXWRzQY4V/5cNPNG4AbqEZSt9ueZ4Kkf0JupfYHEEuU+5RozrM0ueOjXgoPq6+emUoe3QAfFu3h/FXseIioBliFQnmf9G+yyXN8CUl2GoEOG919NaI2bjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713823; c=relaxed/simple;
	bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jpc0LCwIZDKd3XbsZESIYyhtYWCyiJTkw/d7h2RUr/9Bm0M/NUIBKu8AbnVmVIjHuNSkwE6KjSJV0HY/Vx29GMo141/qs5ce+Q2ZurVVNS5TRSCZJNja7WW4BSTJVFtD/HOWjNd84sNNbkYeTC4Yk7QTz3/BLCfPB3FybvwSSOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjHPtZQt; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjHPtZQt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666e7c9edso172208a91.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 09:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788713821; cv=none;
        d=google.com; s=arc-20260327;
        b=iWYm7DG699Kdqa4tsgnQLMrdRWvvswoIvUADjA1BEPPLDI3BHydAbSDpc4BUg5Our8
         vTxwn0/N+R0jtd9jozmJRhr12YgBYZI7V0mCtPEvVMmj8wRASfYCdlQxDOuKvUje7dnp
         WbkhqDHtKvNvkc2Gx2lZCQS46kUxDxVSkxOPNssSfsDVuESXrEFOpK4m+WZHVDhO3EHi
         XQEig2fvqrzuiKowH3GSzhtGN5CDS1tbZczw1eeJZHYI//Qx3ZlkRele+f7rSV7vGEwb
         O2xvB2jLj5QPWKcsqO1nMfgPF9YL3HZI+PQAKEc1BfkoE9Y5fWriiONlaOpiXCKvbVUW
         HN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
        fh=8Bh07VZsPaM0isKj4faiqyUuax7AjfAfZE7vnx6M1cw=;
        b=Ga5HHKeb5kkb9DQapezCfTt+nnllpQEfcccVR1LVb58N1iLxiY6KtxLd7u72XAfFZr
         asXpsHQc7NCJsAWnJK0f1FSbq4jnH+EgRWdyLb4tzl5PZP7USbblgeE1XwN/ThXZ3JH5
         K1ply5T8+ta0xtQOUvelxqvblDozIe61h9c70A2T3VpMvX0ST47v+mOMc0d4HvXhNy2W
         uXpvOT0qZX4B1arWtSmc0zPGWj5H1/G39thwzOaaGjp715t0ygoilquzdNMyFsY5HlVw
         pbZhLAGyA6X4JP1oUz1NnC8A4avdkdumfJU4NzSQ3kJ/6yhVk6Pctp9janhV60y2/epD
         N6AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788713821; x=1789318621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
        b=UjHPtZQtZlfn+jMBdsesbKV9hhN0VxB45TUW8NF6jsIj/u6sMjuVZl/S6vNiEMAdHB
         Te+UXjaLTopyZrVKblQ6F2RdO17BiDzp8YSjJWd1LjGv8/lpVMX/mJq6tjMcQBGE+lh3
         gkbl212FSvMq4hzn08kjNsXAWfz8CFVxj8DwBvGDcA2V9pboEq4SigdRgrpS5P3lbPAR
         WaeQlpczdSbYO4EXZkRcm/d2DFhfIccQOCyUcacVGnAtc0aqHvm4nD/lvAQStGw+ys2S
         nEMr3QPCYz3NCaB4lrh+lVRBv1NLXl63CMfDijyK5BqBSV6Pp1fy8GFAFtzsiR1Bm/Qi
         cjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788713821; x=1789318621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLbNWAYKOjUjCxKPAnKQtbCBXntzd3CfPr6hFf0UbZI=;
        b=NeL0nJ6+T8KrYogJhmNPnbeCPSc2oXBEs6m7AvFzZZvGASmZAzau18vQso6aHVASjy
         dNH99JN+4su83azmqdi1AOAebPkZnBaGlvySYRmT80GdVZAxq/tNY/nnoOIIPk2H6lCz
         W3xoprNvPnYDDVwedPq6Gr8ib0fszPk28qSzT02aq4QW/k3ccmdgR856svgbIpC4oRRp
         UAr+b6fj9gaty0YZeNHnxiQMMQ+DGI12meRo5vfNnTgoaHdY9hSRNrnLemzyq0hG/X4O
         OOeWzi5hJk0+lNhTATc3CzZ6P/bg+Obp1TeTJ1vxWmUHWHD9SGTL0mxde1TVxSqgfZlh
         5WVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtwaA6kHVykad26+LzxiT5sJbjPJcqTPBAmR0LpVVtidPGeZkSKVGQ91lwtRNrqkupq7Edrc8cpWQLmSD3lKhaWLA=@vger.kernel.org
X-Gm-Message-State: AFuF++mLNKiZijCdFaEgB2/CTxAT215+iWAU/aB7e2wmvIPN564Bcgde
	zaJmHT5XlCjliw+n5Jpg6gzM0j0lGepIvaPWllBB7ZjfSbnQRItrjDVVx0ypYpJl8lGfPFr+t7U
	ml8y+yHf4B1FPPJT7es4VGHkJmhFjqDA=
X-Gm-Gg: AYBFou2Olo3K1b6ZvuGtASfcxxYdZvRNJnSydqtsoFf34n+pW9xiDh6A3U42VrL8NyW
	7brGiAGexoe/h2oOD8zg0SULiaolpTyWHi6H4JX3ITPGuRdlipO2tjV8Jd+KuyM3h6+3UnHpd2V
	v2Se8LGprdFOAy0aIntSyMJpB5DvanC7JMGy3SikZONx/Zx2qKBRvmyS9oYaKFAygasSst5Rs/u
	aqzqe0hAs5soCDjVkVeyCREsPgB3TmvR9jqomZuw4rFPSafPO49K2Prr1O7QIwdfDk6LNwgmbKJ
	6XzJCKz6+ME1KFjL8JZzUdmJF3JrwPQjGUMIkA46c7XAAuloVMiETuwTgpIqOJEN+XigJ/MhDRG
	UOHcSw0qYDPjZn0B4bI1aIsIcPxOgS6io8edU70fMn0UeY5FtViG0zyPs36xlv5/faZWE083t
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39b3d8377camr12050791a91.6.1788713821151; Sun, 06 Sep 2026
 09:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev> <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 6 Sep 2026 18:56:47 +0200
X-Gm-Features: AcwNN1Vz7OHfpHx7W0dFC3jg8glvxcm1hmRiClFLpwy0F6DpBbL1JHHuwRxDDvo
Message-ID: <CANiq72=xOrSXBBdmrKYfX1=qgF37LRAMzMJd4GJkXaYHMVe9yQ@mail.gmail.com>
Subject: Re: [PATCH RFC 8/8] arm64: ftrace: Allow CALL_OPS on kCFI kernels
 built with Rust
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ben Cressey <ben@cressey.dev>, "Florent Revest (Anthropic)" <florent.revest@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 3:20=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> +# bindgen generates no code, and its libclang may predate the section
> +# argument of -fpatchable-function-entry that a kCFI kernel with CALL_OP=
S
> +# passes on arm64.
> +bindgen_c_flags =3D $(filter-out -fpatchable-function-entry=3D%,$(c_flag=
s))

In general, one should be using the same version (we warn otherwise
early in the build), but yeah, it is just a warning for now and it is
nice to try to remain a bit flexible.

Now, if we are going to filter this out for Clang, should we just
filter it out for GCC too? i.e. outside the `ifdef`?

By the way, "generates no code" sounds a bit strange, since `bindgen`
generates source code...

Thanks!

Cheers,
Miguel
