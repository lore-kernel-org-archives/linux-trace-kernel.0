Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCDA463B94
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809599; cv=pass; b=OwG3ldyluBkIWu9OwKMeQzWiAzQ/eHU8u/W5EdxxalE1QXCw8a4hfoarRDku68xNdZBYnOlpeLgfqBeG9SzUoDctNTbaZzT7B/h0tx8yXSl6iKtASfnBk51Ha4CYbwPfg9yjmgiwNl4QjtRi8qAwvBh/JDVbJy2NCszavCaUTPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809599; c=relaxed/simple;
	bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRiRLAUFsrqXaVS61oe4V0G9YvMaKDKLV/IICH8gf9pUuNme4Pp1grE+WyLXsDnrY04VhFNX96ijdbotwytFlEcPgdIjBLMb6NXGV9YHzRFqz+mBGxuaJLBqHQkiBikbwaQZ1Lr9i8vbmTTlK6UdqPzNN++zw/98dQEUOn15Ck8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK0qYj5j; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK0qYj5j"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666bed441so700716a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 12:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788809597; cv=none;
        d=google.com; s=arc-20260327;
        b=I48J1TAQo2WXFDDYjkrAn8fhaW9FLh5jZWyn5hfSzlUbFjvF5XunHnsOrADZoyFD5u
         N8m0jaoPxpOPG8z5wdV+iFzXZYr+JoB8pfBQTK0J/9WUVTBuEph3mrWHSHfLwaXVvSjA
         R99l5M0DuzHYnYRKnatvuAfN+hoIHFGvKGXAKhOaGN05nrS92hEgXOx9TCatlsPGPIp9
         67GhlfL9ecE/zs2rvPEx3ZJPfCMM258dvPR2yVgvsPWeYcTjnJWe9Po/xrmQ8KP//mwn
         ob3AZ1quFQHTDAUjEBM3PReNpL7okPSMVDyVhbbbfTyT/mo4DhtsTIXStsXR6DJMBJez
         QIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
        fh=tmFNrS31yjDr+0awNOaWQv0vFKlZXErNVDgp70d6lGA=;
        b=Eo/v9vFHqreFW6x/Ia096hPD8WKObBHORuX0fZ5mf0NnIHxN7pMv1dVx6dAr/xOFnI
         Yb5+Kvy1w0GLsicE/c6jCT4A3qkixXJIamTDOs2ESItPRaVKzvmiGHHe4wtINQr5Nydi
         3SUh92UE9jQiMl+j9Tli+/EAxArepfB43ttjXt3a+sBdSNmIxuI0JGJ6LvAM8g6Uai/E
         5XNUThPupIAEhX58zfoYu6T/rtNbVG6G84XImkyFdgGXI22NTPSEXwqnJkP+IZ829xF+
         XU7HXNEfN7aQxpVwXd3tYXDsJRIDAJ+HYBOpEOl0d4w3Vg5hC1KASDNmvMnu+7V+UKbM
         bt1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788809597; x=1789414397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
        b=iK0qYj5js7h9LqZ16ntFi4pR+coNw+J1DIsxddLy2bybdXua8s7AhsQh5PKG4aPy8k
         cWfcsot8Jd3QOFo9QOMLhxclr26W+2bFQXUQb/5htv9RCQ75k/nTYOvsiDpAh9ZC1h0P
         17HYrGhBkPAcaFKfVJDBRota6XZwJTFU94U1d0QKrv1bCLj5OM6vuETU3sDAU1WcF6/P
         XwKGZTES39HLJn7EPOvbTJ556I3rp76dCWF5AVgyuUSKXaJklfe1ypw/YLdAV2Pt4o8p
         oIt3UyGz4+F70fE+3rhKKK66OxHCacES0jUQHDbVEe3CfUFb1qgvkTLFywu8+KyEsrhR
         Wz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809597; x=1789414397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbkJYZrKBAOtEAIquwnyRiPsYzlue46mhX6agZEqU8A=;
        b=SJTTBRkTNxi5fLK84S323DXjP8IM5SW5RU5gv5jfdRR8GyP3RtH3aDORMccevkj62+
         FSFd0w+HJF+UYPhmjtyWLaQL5+28SgR6UHOZubyyDDyEfAG2uR01OmnUXAPYgUf1jpvK
         hjHoh/JAfBtPSpk8qhOcpCpPo6doLHOVuMtD2GvB6Lrt2KF+PWpZ9ALUrCgNdn8X7kXF
         Kf5dnMxmtP7fHgY7eieTTHSjmd8PzoSmkmJ12VqXH3JWb/MfObGeUSFxOz57mYS7FG+u
         nixNVvKMIVizMdzV4HB8DpRgWW7lytfr14qR2S5B86cQf4+ZykaQj64Y0+qfZneOJXiQ
         aRXA==
X-Forwarded-Encrypted: i=1; AKwUvBz8Pk1X//Ei7hiWaKcvOCYNDk7OD3U9MZ/j9i2RhBXD3sht0LUmc/cX+VBAeIdVQK6yHziQ89QwE2kGmZl5ey9KRXY=@vger.kernel.org
X-Gm-Message-State: AFuF++nbG/Db31qxsvFsyMHqqT8byiKL0jZQ/2OlDjTzUQ1+iIirC5iN
	SWmJ86KKO0SDLhoQRSXi1+SSwkxpDDDlIksUX/0G4h41AQv41fbKvVp7/sQQr0ZRGI2uB6BHhWL
	YojmaMPfK65IrJ6uXZDEOP4xqPesUw38=
X-Gm-Gg: AYBFou3+j93sEi5j/eD4+efrGplUYXD3ECDxpZ4+DTmFWB4o0mh+nVS85UuTNLGPoYM
	mpFaDboEQ9Oih7/SAvExHLoCI68je4x1xj0V4hKjxIC5KtDTUv9BX+UYPL+arAP5YaojZeJBmGq
	dMD/qtPpvg3SvDlFOfUm8zj/8WTUIJ2gBrPtggVmIPdbOyjNx3Ii+Upg8HfNtVTfFH9YCxgNhaL
	3YEX+JJ9V9/MLNrhsDb0R6yTq6N8/tjSYTZvK8B07Le6YI5sKt6KjkbGV6+epTGJym1Phz6cWGV
	Es9M1B6pJ9QFuNqOjdG7OFuixrjf/wWvpFx06rEydImMd7g2MpCF2EBzze9Bo9EwlpyTd8NyrOf
	Mg9PUPGJDOw3F5G5VUB87jXFTw2fxZ/O10C9VXt4pRor50AqhyOHWeAg4hSvfLA==
X-Received: by 2002:a17:90b:1e04:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-39b264b24e2mr23088437a91.0.1788809597288; Mon, 07 Sep 2026
 12:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
 <20260904-b4-arm64-callops-kcfi-v1-8-ce6687739b0c@linux.dev>
 <CANiq72=xOrSXBBdmrKYfX1=qgF37LRAMzMJd4GJkXaYHMVe9yQ@mail.gmail.com> <ap3Z-YDtzmdtMiMk@linux.dev>
In-Reply-To: <ap3Z-YDtzmdtMiMk@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Sep 2026 21:33:03 +0200
X-Gm-Features: AcwNN1UJ5AD1nmjaRgagxZvj3fkfuD3Z7c-j0Zc231NENpcPq2HjO9j40kxIvNk
Message-ID: <CANiq72mVXNmqh-RdOunFLBKRwMgYHFBqJOP7NbXrd8WHPb3sAw@mail.gmail.com>
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

On Sun, Sep 6, 2026 at 11:24=E2=80=AFPM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> # Do not pass -fpatchable-function-entry to bindgen: its libclang may not
> # support the section argument (Clang >=3D 21), and parsing does not need=
 it.

Thanks! Hmm... Not sure if "parsing" is the right word, i.e. a flag
change could still make `bindgen` parse and generate code fine but not
match the ABI of the C compiler.

i.e. I guess I would have expected something like "...: its libclang
may not support the section argument (Clang >=3D 21) and the removal of
the flag does not change the ABI" or similar.

Cheers,
Miguel
