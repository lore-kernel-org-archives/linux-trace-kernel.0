Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1F30BBB8
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474008; cv=pass; b=BIYCtlEuwOj5I5X5XCNyiZaYUYhLCUZwD32bHQZTS1mvraJWmeyNwE+1bVVm92qhwdAJhA7Q+zAUvM/OyxAMm7q2s94akis57M6Bxu/3fWI/mS+icoYnyyb9cRubuUkdbAl0jYrFMF1PDPiw6IiFaSsUJB1AE31WUF9jicClU6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474008; c=relaxed/simple;
	bh=oynyw7lcIZ5xObe+aDx2HP+H0gU8ruT/dxDQxLDEOM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMiXWvfgmhG/IaOf+m4T44ME4ip8voAROMuhJTxofN/c+dO1gmHXs9Tz+DK8+yiXbtZaPalY+eYIoUSwXcvoxUrrE7nhJkeXor9/5c6Qrxe9a1yb0uEXq9HIEwM0w9axm+hcieUeN6Z6liRcBKSJrDhLs8wW5tO1NdII9JII8nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haeB1c6L; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haeB1c6L"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439a90f194bso1636565f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 09:53:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772474006; cv=none;
        d=google.com; s=arc-20240605;
        b=IbumPGLIAUnwbAjqyropp9miBCRT4pq0vueOjU/wUKpOmbgeC19JNfcP+GMA1w91rf
         nlJOImicRefpJDt2lEnkjp9J7BaYjETtpgTdXBKpyEF/DvKrsNxu5Eht8/V3eOjbdIcf
         cjk8aNfKL9a9/MO72A3dV8p4ERYPK5XfeAF7TYi5kTbgOZZYJifY0ZzYJU2W5XQFRl23
         FuqEYso+wXfBR51H+Ce8gl4C4CDs7As5aINAf95dPf+TYZ/L/Ig0zrhoamhR8Spm3tpI
         V3P6r4dgyfTbQ0ASBvMZGKo7wejhh6rSRI+N0HFxC6kuGOuitRPdprVxE9IdvRNZbZT0
         EV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oynyw7lcIZ5xObe+aDx2HP+H0gU8ruT/dxDQxLDEOM0=;
        fh=FxTcJSY6LKPwWEyKfXeq5Vp3cAoB5dEyEuM1f/ekaMg=;
        b=DzBsejC+PPBUkFJjhKTkKeSDJOjJsby3culYaMLnp2jJ7WqWFshOeTPic2dtPQFDep
         roieN7n+L6kKdbYtYc2bCp77GHundBxGfp8KV2B/c7PUQr2dC0mi/3p3wZSEi88kfQBj
         /ozOuYS0OJMOq1/YAOvVzVqKFnWucOjxHI40xh2hPg1pNiaRhTjRxxDOcqQZ0GsE4AwA
         Kt3jm5gKrsuU3KELI8pz2E3Weh6H4ousBbGpQcgwn4ha7p7/OpjFJEk6LrKki7af9wfd
         N303h3E9baqxMz4BdO/QnAormRdgkOPGnrAlN/+MC+KIKZmfvD8u5m/QNFPO4axqgWrA
         zIDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772474006; x=1773078806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oynyw7lcIZ5xObe+aDx2HP+H0gU8ruT/dxDQxLDEOM0=;
        b=haeB1c6LWWur6RrHJmmWJnI1dtZ6X0l9Bu1tADV19MKat8QseAiRPl0KRFjAjbpQp4
         m53g4GVx5MpRnZrJpN76xxfYuEePFhPR44wJKC/0HnbjZJJ5EeRAytvGGB0P3UYdp1Xz
         RlM+C8+q+zugtTNCsW0lqiUxzJfYs7Ee8OnZNAOCQqiu7F/fdKFRpjMHzdw2XMvCz8oZ
         Lxa429v19nDb/SmCQXI8kIegV16ObTwPGuO0LEhhv460GyG4/CssQXo0J8E9lGA9oObo
         c2KbmZBgpA9ZNpa+c4OJaRWZZEv1IpE7Ry/IK9PUK+WQn3VvjxsyPPdqxJ9GQf+NFu0S
         N0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772474006; x=1773078806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oynyw7lcIZ5xObe+aDx2HP+H0gU8ruT/dxDQxLDEOM0=;
        b=wITgJxi+VXcTTaCtjGskr3HIz7AIDeiDnN/fWG+Fa0rEKsnk3igHqKj5hIDjvDc8bE
         haArCgEd2rR8uN+B+AEHmcQD+pnodhKHxCxKHpnkZwa0UCW5X2SabMvwmRDi3NrMmN8p
         oZYF+dlhN25+LgYC4q0buPh7sYWm9wvLmaiJb9nCTwNZDK8Mhztu8y9d6G/aayvL9odT
         nuz5t8PLZRs8H4xN1yEkn7UQjiQDGNS7FzMH2tDGe09Ku7E37FIqG5XWbsGbIOOc8Lmo
         Y7gl3e2w3bYl+VyZb1/iarONlO/acivSCMLlSm7O73+M1Jlg0zBN7HwrcujIRf4MJu/c
         eWmg==
X-Forwarded-Encrypted: i=1; AJvYcCUuNdIjLsBIgYDcNyyV2bz2LnW01ogMK/h2X8ZsGOWJjoAnT7r761EYVOI4kLqhSNj6bf8ol+mlOEs80XDxqKbm0Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxau6hcyVsEXhPoiacCAWITzlMXThGdL3MBx267wXtQDtQMoNpE
	8V/pStXBdpzm/l15VqhIo0yRsOiXUjU9UAooM+mNumEUwuWkZE8H4HeXHp1hfh50YNiteMEX8XE
	DJekX+RUXpmtPUVJzPbaQr6CFf8zVbDo=
X-Gm-Gg: ATEYQzzm2JX2ZElWRbpp3zVDmVeXIqNGW55mtpEk5OCCIJ8nR9whx8JDIYYx8zGEroz
	MdQpWUcaCEFiha7RdesrN7UVc0K385sAxU+MQhq6aHykr5BIZliEOcjluvraI/O3yEZa/Vgf8Fj
	CujGX6E4dCEHyCSwJEo861/uzo/Ce0K8NHaKEAn/KN8ouM1E+uApBp46KF3+X66QbnjA2iyK6QM
	CTH67yH/hxusBYYj45BP9okguaClX8sVkhZ6NopyVZUAOn9t7h15IdT4pfBLXaWZOJNLhVGYPtK
	8bDmkZHhsUgzuZ4yf4ce4y/oZdhFITNLrH3kRF1slL/7r4Y4ehuto3kbZFmrvr83gaAs4XiY+fT
	xGLs55g==
X-Received: by 2002:a5d:440e:0:b0:439:ac98:7520 with SMTP id
 ffacd0b85a97d-439ac9875camr10630519f8f.37.1772474005867; Mon, 02 Mar 2026
 09:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302081622.165713-1-jolsa@kernel.org> <CAADnVQKBx71HOwVcRFj7ja+y_NL83rpKQ0BRcismOwdCNx6pbA@mail.gmail.com>
 <20260302124755.4ff16264@gandalf.local.home>
In-Reply-To: <20260302124755.4ff16264@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Mar 2026 09:53:12 -0800
X-Gm-Features: AaiRm50oFCeMqWDjRaaels5ZujM2CrG2K_lxFfYLspEAPuE4HMm6GAwzq8uSE-o
Message-ID: <CAADnVQLXBfd-U5Teqv7vd+EFNX6cT4KxA-oiiCZx4aPNrme70g@mail.gmail.com>
Subject: Re: [PATCH bpf] ftrace: Add missing ftrace_lock to update_ftrace_direct_add/del
To: Steven Rostedt <rostedt@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 9:47=E2=80=AFAM Steven Rostedt <rostedt@kernel.org> =
wrote:
>
> On Mon, 2 Mar 2026 07:58:11 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Steven,
> > should it land through ftrace tree?
>
> I added my review by tag. It's small enough that you can take it through
> your tree.

Ok. Applied.
