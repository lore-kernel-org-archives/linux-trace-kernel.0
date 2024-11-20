Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258DA155C9E;
	Wed, 20 Nov 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126168; cv=none; b=MbKKUJps1NYOG/Xh3kEa3dJtp4qa/UGtxk6qvbwYqAvchFucgUEW5RWY+60TiAtnNkJS67Ytbtb5ThwlTvR8F1Mxm8Xc7xDP6KeZoFUttisakOK8QmwXXvKsMLp5iVkEWNC17cREl26HrNW9+DwIVnFrVa4wLkZRgkMDJND1HpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126168; c=relaxed/simple;
	bh=hrt55QuxvsEKUiAA4HEO76X7BtbxVjTpwF/QOzkat+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzSzwk4S+UlQq2X5zSQMA3guAJumOLLOuian2aoAGLtSfZp4NC8Bg6V2ruyfR9KyVDSUuzn/fBQ4cBliWnhcuzyYajIPz21Hqo3Tjcb4BrcPUJ902QMskMDIXRPt7vhKZQKwWM414a7Yu/Dlzt4bkadXpPMkGxiPot1oAXMsdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAGvKwFh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAGvKwFh"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e4eb91228so8816b3a.2;
        Wed, 20 Nov 2024 10:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732126166; x=1732730966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrt55QuxvsEKUiAA4HEO76X7BtbxVjTpwF/QOzkat+E=;
        b=nAGvKwFhq/Ihp7tbfAPUnMHKrnVISZtKmsYp4ma2Sb1zafeh+PC6agdeMAjGRse1Qq
         rnFWSdU2qnb+X9tKHSJNhAlg4zcph1H2KoEYYjPRyJqmvsS9WmD+bMQCTIzlGSU4emB1
         CVkHGHFCzzau28Kis76csdYVwO+/hbIK+/ty6/yRTPdZ+SkFCZIcvyTLZR2OrV8amZ99
         K6KixPzkavCoMEOJNRjF2cBoTCelnni4RtychXBRys5JG5wr0LD8PyeoSbeLpOfzrr/P
         wl9rCQ6mMuukuQWmF8wjQN5Zh3arMx72t2s5pFpfoUIifrrVQe17Dz79B90YO+oCA/Uw
         7U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732126166; x=1732730966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrt55QuxvsEKUiAA4HEO76X7BtbxVjTpwF/QOzkat+E=;
        b=fvbiEeMYMIKFujhW4KtxYi8kqX7vbmbPE6D+Vj1HiF09e/0/WBQpT8vEh6wh15nKq9
         bkmUsGkvjY7a/MvNwxibAzk4nbBm6aSFp5g2JEV36P9tPAUyBWqcAhE1T827OUOSSEvY
         i5F3pdImtbvX/LX8KZailh2KQTqjIA2uN4xsij1g5nDi1hIf83XlS3BsFA6eVsGKFqfl
         M8/QKmHfhI6ZQTkXrRWAN7VeQZPoXh0rUloL/olzIrtNbmWv27nbj0JYSJr5VFG/ST1n
         IIgSIKENntoAAXN9K660lnnIb3di8hOHmd+DVSSe1BbflHBUMw/9EsL7r78vEwwGq/Jm
         0Ccg==
X-Forwarded-Encrypted: i=1; AJvYcCVDpTVDTEj8zzqdrfeMljCxwsYQlwD0xBS3gy6J1mWPBubTDlZsjhhuAqED3mA5pYPRW2m1b5rRK3yAI0wV6t4=@vger.kernel.org, AJvYcCXyg0IgEH8xs2ce2Tu5RBas/19OS+5tdqu4uRWDRS45ZMioS/V1TxX+ZVgEH+kt3VqFCIClX5RpnMTMMtMtZaoYFJ5n@vger.kernel.org, AJvYcCXyspaJnWbpwMAuUUxBJV/f2Wrn/yeT5q+l4y8RwgNHMxRlWMz8WeuyfljBVaCulRjA80z2f4sFM8PC9Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyneMCSNTFgcgK8m07G2xpAZ6BKREoar4iQ/10l9RIWmq4ZvY9E
	ZgWgfAvSUT8CpyeF3bajj0rWQYgyoyx5Ec/VvCtND+KjB+/xMW8XkJTXHstwd4lFAsfAkK+4DMb
	UVH7ivRvx2IO0WEfwBWPOOewNzdA=
X-Gm-Gg: ASbGnctrxW3eU9Uq0d+iQqRKELk7917w1LCMbcPd42cdL9E4H4X2Mvt4T0+YtVwQhPE
	1WPgtN6GudsVnfOY3VEGm2sQy1vvQxhQ=
X-Google-Smtp-Source: AGHT+IGGm6PRqmhlAaTH3tQW6D/vi0ZzgDVzpl6/FwqRUDcQ8DS8p+rcMu6VIr3hyk0xwtPaOfPObtumwIW9c+K3IAU=
X-Received: by 2002:a17:90b:33cd:b0:2ea:aa69:106d with SMTP id
 98e67ed59e1d1-2eaca80f5f3mr1895605a91.8.1732126166357; Wed, 20 Nov 2024
 10:09:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120175916.58860-1-ojeda@kernel.org>
In-Reply-To: <20241120175916.58860-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 20 Nov 2024 19:09:13 +0100
Message-ID: <CANiq72mOoAxA9nW+5=kJMmet7JarT7TAADejXK3XCAcVe0A-bw@mail.gmail.com>
Subject: Re: [PATCH] rust: jump_label: skip formatting generated file
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 6:59=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Thus skip formatting it by prefixing its name with `generated_`.
>
> Fixes: 169484ab6677 ("rust: add arch_static_branch")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Steven: if you could please carry this one too before you send the PR,
that would be nice. Apologies for not noticing up earlier, I noticed
when doing some manual merge tests for the Rust subsystem PR.

If you happen to rebase for the other sample/test that you asked
Alice, then please feel free to just fix the original directly. Same
for the other fix you already applied -- both are really just renames.

Thanks!

Cheers,
Miguel
