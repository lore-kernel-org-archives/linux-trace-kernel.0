Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C11547D5
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 Nov 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731236221; cv=none; b=oAs8TelKXGbWq4pNoa/QY9TQL8TMTgjIonoZO1llkDuenJu9jnLuCAgjMhCm/IYo/b6nRwa3mEll7tjMupzqq6aWuELg9dnDtgP1Mzk87zwR4PtkcM8jZfttI5n+7xoKHJVRQM3OcMrNfCgeFOXRC2bChDbaQoF2Xn3kR++vKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731236221; c=relaxed/simple;
	bh=fApCHzHaNaMN9ZQJrGXmdWes5ZsjF+zWr97kyjUl1Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgstSNEHUtLfDPNBbVk0USZ4n0twoRRKkWw6tKscubzk7KLS5YJizBdDbwRwD55HkBkXNs7zcQrZu25QDcNDYnJVtnPoiHZdpgT5FqLtH71KGfRlq4exdaUjBGHxoRbiMTS92sR+HrUVbHi8fJLb0EgyCCQnon1dBBvZUqsEfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPNRG97x; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPNRG97x"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4fd00574so1969660f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 10 Nov 2024 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731236217; x=1731841017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6pZc1K5vHW1yLRrOq46D/RKiIu83zxt8iuFPjL5iSM=;
        b=tPNRG97xDYcZRaVFOPuoMoDKQsphmkyD+SxrMAW2TwOnX22AtrW3+672fryaqR0zAj
         us4HTz+iOj+cyP4peFjaoZJWZp3V0Mc8PvMU64xJFkuuTvaskWHuKkvvOmr6liD8BKDE
         0+dc3X6Vu1ttFp/99H+6PAaBg4PJ0mDP2ntPvGWmN+ln0A0PJRnnBaqSmM8F2f/cIPdH
         HZdoWgdAPK3+HMfkgONVXMJJJQ3TPIXq6yWUsMs10rN5U9O85d+PSv3yKVWjnUHh2Xei
         mN7G/YO1P5UOaZqhUsfos2UY7zWTKrzA1O3gBCKlGHwAZXYsQXSX2ndgX0q7AlVliEnE
         eX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731236217; x=1731841017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6pZc1K5vHW1yLRrOq46D/RKiIu83zxt8iuFPjL5iSM=;
        b=pXkcVBmx1/ToezihsrVKs9jVWqkZB8qOCF67tPU+UUigMYUAY/oP51LYo7OZ7U/vEP
         h3+blzCk8xwejWPJeRg0vOHsh6PvTJQbBQQmxqPWpzpGQkicGP2/gMxhDZZt+N28XdbU
         5jxwRZ+YgUSj30BWb2XGjNE/TqZWtwbZKfX1UUyTNfLFjFhcpXJb2fkOj+PVapxCk42R
         OjfzwLvz16UF62x2k4NHdRSo/B6dgGtlcvNvSJa4H+MyuAPIBEbN+x61zUebG+fZgP1g
         Rk3jjraOTeTNLl+y156qb/fMTlT1xvsE1hKn8Yh9QG9pK1sdx+ZBmCUBssJovHlpSsx2
         RylQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCG6m2y0FjEZb7HY5x0Lvz815foHoxQuXszTSuuJs0FqjdDlkKRrAh7oj7kMYoesggdPs1RLPjNjcAnZWVUjssC3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQlNjhn50SXviNjXzTQ57OEFr2agMbD/1Ng0I4RycafHZLw1b
	qml3uP0iJZOXj38T0iDbEeocfiwjUSrINSmUKutuy3xW87LZTSx4HxCo5CTsa9HG13bymD1Wewc
	EPG6E/LXKq5EbtsJBB5McGYadXgUY33m+d4r6
X-Google-Smtp-Source: AGHT+IHMoahnfY0BITCuLZrb0MEqyF9R5+UE+yA+o8e4yfiWrcrbfycPVvQoH4GneTAdVu6kkPrdqxT9YFq58Bk4Ryc=
X-Received: by 2002:a05:6000:1acc:b0:37c:cc7c:761c with SMTP id
 ffacd0b85a97d-381f1a6675fmr6413285f8f.3.1731236217034; Sun, 10 Nov 2024
 02:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109165520.1461400-1-ojeda@kernel.org>
In-Reply-To: <20241109165520.1461400-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 10 Nov 2024 11:56:44 +0100
Message-ID: <CAH5fLghd2qdW02CeX5QgP2p2mwgxGEj93MrW5G-T1zOCVaUOhw@mail.gmail.com>
Subject: Re: [PATCH RESEND] samples: rust: fix `rust_print` build making it a
 combined module
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, patches@lists.linux.dev, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 5:55=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> The `rust_print` module, when built as a module, fails to build with:
>
>     ERROR: modpost: missing MODULE_LICENSE() in samples/rust/rust_print_e=
vents.o
>     ERROR: modpost: "__tracepoint_rust_sample_loaded" [samples/rust/rust_=
print.ko] undefined!
>     ERROR: modpost: "rust_do_trace_rust_sample_loaded" [samples/rust/rust=
_print.ko] undefined!
>
> Fix it by building it as a combined one.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20241108152149.28459a72@canb.auug.org=
.au/
> Fixes: 91d39024e1b0 ("rust: samples: add tracepoint to Rust sample")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Thanks for fixing this, Miguel!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
