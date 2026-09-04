Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E6486B8F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524315; cv=pass; b=nc+r/4ztlyCT2iF49dVpW+ISgCUUEkwxaJ3kxCMhXaWbyJDL7Bd7b9qActinxtU8ArbJizmZHIhlNVP4JmRon29TTAbTp/wbOBbd13y3bR+Ih8kKiZ7yClqyECENeHgdMnboK/iFK2UXdQtJYf4tlc9n1OHuyFa5k/xmceEocZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524315; c=relaxed/simple;
	bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5YOkYBIuH79IJ80CrgrFuGrGG8TQFGTJXBdWKsOKbEvKMdps42DO+FyqiVP8sS3W11nAH4x+HwB5ssYgx2W5HilUdYI7FJ7K7QU5GanZ4tlaBo7pAz5rmN9ICh6EFlKGAn9etODHoLvHT0n1AEHZitVyIldjlxnDqas4MaMiSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMNauiri; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMNauiri"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398a29be161so122819a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 05:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788524313; cv=none;
        d=google.com; s=arc-20260327;
        b=V1II88P2VL/t3iE7MIODSXQ0tmOk0WM6wDLFT/C5gacsgJbedIvJQMFwgIlX3yM5uF
         fKeLcLQODpRVE36Y3DDcGahkuBkXc73xFzISNnDBUF4jOK4pHgjI+XPVMhYgiZhM+n2h
         Cd+kXRpxXdAw+p5GBjQpwApVLBhRESax4QCEy8D+DjXSfBw97aROnr5qsiDuhjArgu6L
         gA92x09KAj3BnjcJlnk/tPpbg57XF/pFPVM/kUeM+Wmrj1U80o+/W0Al9Qf7Obps/9pZ
         PuVZ/CPbjbbEjt0+T84XW/xHc3MmksRO13o0mEJetMd+8A94n8FkAAp8vmZHLPn1RnXF
         kcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
        fh=zt8roCI3Jdn2RHVt4iaIwwXGOM1yzx3q4rnel7ZYEtw=;
        b=q33aC/HMnFIO3sJxhacCR2vU1hSEtPOM3jpB1pJLzil8hh+AwxUIqo5X25lNxrd31X
         UA2H/onhSmcecWOaWRVVowO5Co2syvlK3eqReFEa7LFsZfSpe6DnSWIzoBRRjUUxczCi
         kZvYctukofHxINWZyc80cMj2o0AU7lggvm/cHSA3DQqDoiBinjAmVPGST0WCLkyUJA3I
         3CydSWe56EBtZp3HhUokmKvlf0bFS7F9KTU1xTxUSI7od95qmK7o8zdGHzx8an38+GRI
         OAs/LoVTIFg1OZPUJ79NiJAHPxti37HnM/k68QbsHmX5vESmSkHFOz65Nrr/roYHsYmi
         Nflw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524313; x=1789129113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
        b=WMNauiripi6Md2Q3C3KkcuWrocOGGRafMxbYDlATW6HV68aOBusr3FL4eXVoF4vhsX
         DO7Jgfmeno5zhnwRWIgfHvrvUM+3XTG/xFulQb6uxqGbEytQPlf+GGxxMKD983IfwasK
         JZ8dP4XrZbEY8oiEzvYHXjbMf5wbZHBRAbESh+IxlSqcdT149S3ok0u273lxbuoHsZB5
         x3PySqQZGNcJbPkCUFb2OKLEFffWYo+K3UUed1DYlevwTlbFIAr1+u029uYrVRygQ4ml
         OkrtFQlxk0wYKPBPPf39rZeJx4CxE/88YUpd0GyCLyKaJbRs/qop3EUiAQiviishSpQw
         WkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524313; x=1789129113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eO4W0pBpUA1VKwgA7pWUVcs1Sx0AhhcRANb40uA3yFU=;
        b=ULqHHhdoEntn11Wv5OuXaQJ2oZAW/13M9qxqYawqDJFw4ntD/yMLD2SD7JDPbE/jqQ
         ZlJVMESBYFGkQBz4+XmGiBvHMIyiZDjt9kijrOAQmW4Rj9UZ/kyC9FR6lzP9cKxrnfWz
         v+OpPuyiuy8DFvodl77idSc3rgC1iVh1ujK0qzuByEzEJsTCRRI/lmswvBUJpmVPvboC
         cfJ0jg90UFRP4uxZ/v0caaJtpcD8E+eZM0apgdMqP/CNNJZeRntziRrglEHSLygCKW61
         0Xzy+fwMUaCGluLfW4+cWQzGgKdXPHt3wsgROq325wmo6S+Ou4jFFcfkzSD4S7A1FNiK
         HyeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmFGiJ6zusYnQt5dRDKkBgTE9kylyDx0toPbUXcfbsA9XyHm2QC+QDUAfSRWnARVkMmazu5Rfq/r0f6AiF8zC5+7I=@vger.kernel.org
X-Gm-Message-State: AFuF++kWDCZxuEyCBr7BGw7AxAwqV1QyqtbY2LcwEl3dbEayJ74k4sNR
	0TgqQ2vsMCRr8AamKU4jzemuSGmJ1kTI+7TXHnw/X7vgnqjsDdzEy9AWJxVz09iBFj1uGsXpUMG
	FaPOFXCyjaPet5LsCYgTLcjIiUqacC7o=
X-Gm-Gg: AYBFou3e/Q9g/o/JLczlA875EE/9uMorFQCWf93gkl5DGm7fD0/++zxsFdjrBDZ5tSz
	GO3v3A/kVfUS72qGsWi2SUXQsM418Q5BLtwZ5RmMrKq9rSZRkIwRwfyo90JK2HtfjY8bpNiILKZ
	8jdXHzOrsiFQ5tTnvVcagFK8ItO8LmlUgneNglArOm0Vof0zoR9E5I+HITFgo59Qlk6CYx3i3ll
	XRhxqXgoUNZmZqPifkPN9K1vUCjlOEMEhdyhnghhR6WHwpyZ1ZUu0OwVU6MWkH9OIKpv5Q6cUke
	60t1+HoFRcRLvSo/b+CSpXMy7GNop8yVKsJ/PPwKtTkBgTksFNw0mY42z2CphT93EZFdmGODiU+
	Q6WDZLCYqWWU0NchJVaVF4aMlOScpACuic2SAb3YYxygf5FalFLg3p06FFFE5
X-Received: by 2002:a17:90b:5404:b0:396:d28e:b52 with SMTP id
 98e67ed59e1d1-39b26229b5dmr5722108a91.3.1788524312944; Fri, 04 Sep 2026
 05:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev> <20260904-b4-arm64-callops-kcfi-v1-6-ce6687739b0c@linux.dev>
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-6-ce6687739b0c@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Sep 2026 14:18:19 +0200
X-Gm-Features: AcwNN1W-BJa7t0_HMwRoOS4jQPgmmEa3lTrRn_StsdokzqumkRB4EleU3vHebmI
Message-ID: <CANiq72kg3Z5rB28H4Ck+EzqQgiRSSowBMe3YW6p_iNwOG_dzWA@mail.gmail.com>
Subject: Re: [PATCH RFC 6/8] arm64: ftrace: Support CALL_OPS on kernels built
 with kCFI
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
> Gate CALL_OPS under CFI on ARM64_CFI_PERMITS_CALL_OPS, which needs
> clang 21 or newer and RUST off. rustc has its own flag for the prefix
> NOPs and this patch does not pass it, so Rust functions would have no
> prefix and a different hash offset.

Why doesn't the patch pass the flag to `rustc`?

(Looking at later patches) Ah, is it because you defer it to the last patch=
?

Thanks!

Cheers,
Miguel
