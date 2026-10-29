Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793311152;
	b=bE37h5Ged6a4YyCPN8PzdTx62JPusZO32/XMM0qZ8SOdg3Lqyl1DYIOg8xZdhiKmWjVy
	 KNV71CzHsKJGfcBh2DKxNkgkt/HKQYr0bn7+HXZuOjlFnsdYFqirsFskgG9sVPk9O19W6
	 NiiroHkZxKBiBs86S9e5LkGsK8fPVJHOJ8eFkBvjU9xa8WsDDUsr5xzQ9tpxHAOpMGlqJ
	 N788C5tKvpPYg7IO8H61DU1dmkMj9eKxm2H8wsA5OtSoIm3l08BaCHAc29a2f3p33FgI3
	 LVNzJixwkiXIKOsGg5XNpy/nIXdvCYkIq3up8t18yyqQIIUht1tnj9egVXHLIfvdkNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lD4NnHsGQ2Vqml/5riD8yTS62RWO3XbEmugu6s7tsuk=;
	b=xs6HAdlmnk3rJ+A4A2sAsox9f+gLy+CJVC67phCKfrrxoo2s99IdW+eqeRd6hVNpshYO
	 lGyVzO3bgYFWlSzk3VqPrSd6qxB3SZxJ1mMZdtpkRQrVwuHiKjIZT9fnxUQBmzoCn2P02
	 GbDhu9qaarvLrEVitWSARasBLz4rVzDQTbGXYHUox5XaxlHGoWOvpb53Jr1DH0TN+06yk
	 3vFmgUN3mKUjvsR20NY7mV2Wc5s+tUXyjmjyeMFyw0BE6CUyz8uHlDaklvPl9+vBJ+UAI
	 MTvRdTeb4POC0nehgpiT1L1KdOgp8/QdAg/MErb2DOc9mcmKW6DsEd66lUhiKQ0wO/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CXE++N5d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6B606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 21:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE6B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CXE++N5d
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a018493d57so25885e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 14:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311150; cv=none;
        d=google.com; s=arc-20260327;
        b=l2s4PkqHwpbJx6lpNhi0ca40UpwZwX2wq54aUWW5uQA1tD7Kvi0DhP7VCGeHlcGiy2
         9PamPGpspjPRa6/Yd31o7g6jfl9367VqY2nCFL5JlsIZrg16Fb18YdandUWOcxIMW7Cq
         T9rcadscaor1iLcDjoU4mbHrXY2IXytwZ5GxzLWi00B/JFjd9dIpVVcB2IwmtxP4qEmr
         krFIZbgT/KxituBQYUGYwWBDz94s/l6bffeWFHiO0A55W8qyy6MulFr7UWWPaC7qHsTB
         Wsc/UlHr+zuCu+b9EEN/1H/0S2cVXFkq7rn/Ebd5RrU/uC/krSERwSGGlN72OEkIMASa
         +clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lD4NnHsGQ2Vqml/5riD8yTS62RWO3XbEmugu6s7tsuk=;
        fh=ab+tTPusjsEexZW9U+KZezjhTQnW+JekTC8r+uYsZqo=;
        b=U9VmeDNbYqL3YBk59ogX43tc6XLmQ5pIP2CuEBfbwjTImtAEQYR2VU5KoGj1QlUAgI
         rNMTeApgjIWp6p0kTNKp5ZwYlSmx0zHDSc4+tX03XBskS0qTK9K85zZ533Bj89Oze2Id
         3ZLzv0CoGXvMwFTrQ1J7TOPdJok4C94Lw7d4BNkgm1HO0D8PrNMWY2BNyZHIQSiJeK32
         8+l+E18IIfv25OM3BZO1y8F3lcnRgNVmfZIzf+4XFt5wwVSqciSgHoOOTJlZihz3UCUI
         Ci/7DgcgD4BT+hrUeknA5NiK/Zal4en2Oe3CTPRI/M+AtwBylhAE0HH9aj+X0KX/DTLk
         S+5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793311150; x=1793915950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lD4NnHsGQ2Vqml/5riD8yTS62RWO3XbEmugu6s7tsuk=;
        b=CXE++N5dmB5IkjGlxZH28gvFCgXnsc2wrfnP5g6TtCM+sSlbwflisl0R1KLXrUnOKS
         Ek3rbBE5w2zml77efBruyGCAt6HbvlKgxrYbB50rITUBf2xJK27r5d3N63AUEoW7o8Bd
         UXyRMMLOQKImOAV3gkeB/wxDTy2THktDT6MvhfJEeFDtNy5QPzoRlX2efjLsM/dFBXJ8
         /yLJFCaZNVaBzM7KAWLwVt9vg/09he712OjVvnwAFjgkpJLA1qFb31g41pzV+YA2mD9W
         uoFCbzGcga040rzzCpMd6UObaPwww4loMtBHFsY98Titg1RuF7k5rwYfAFKXNx8Q4IgU
         sRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311150; x=1793915950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lD4NnHsGQ2Vqml/5riD8yTS62RWO3XbEmugu6s7tsuk=;
        b=jNQ4hYLWIPekQMIyqrOD7Q24bvBb8BXVqd712ILgVC/uFM0nW7mqXaWxzulqf3zVjm
         aumcubgpLxDDVy7hvDUM3fgVrjW1p19uTUavJXvdzJV1nncelxw6p14c6PZ/pidqt8h4
         AWmogt4CWuL1ie1eZEt7gdQmtQADIw2PRoJ1IYdrqiAPdLZBIIgbeCpli9h2+Fn5oKW1
         wuQJiVLXKwSRIuG/7ONUHYQj6SWJ2wBYg4lQ4qaixoxtvNdqU0W4/MbYwd2dmKBB9THH
         rW9zz9he3fT2YacHdaKXnrd0AYumP7oxpAFCB0CG5D/4p7cA+1BgsHyI7TBilAyBLcUG
         GPsw==
X-Forwarded-Encrypted: i=1; AKwUvBxO0QCPMDOAeO8y6JomHa62jM01zY0RywrGGzht/qTU45RDnEEw4sqlok9cTW6aiXp/Wam6muW3KxPIoi/nicE0+og=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzbPPscMwOVXXXKp88Xr4iZHAn0UjwzadqBsL9wVTtvgPhvxve
	+N5lU8G+01UKPlzAj/sVU4uM7pwXCpGkmONd3ifYs58g+n08fuhebTZ1epNJsSe4GwW58wN9zdk
	4pLogLZfbNoFdHkqsy52JJYxZt0vHAOLzIVp4V28L
X-Gm-Gg: AYBFou2EczOgxt29iKVU8gUNAFAx/bB9Be52kL3AY3kbw5UeMnmBv735hW6twCqGfZ8
	ansALVVoTlSTXdHcKBJtbOQyOgiZVocx2XFn0zoc1EUM1moMRiYlveLimq93kDqio5ySQMuq6th
	WxfEi+R+ZzHgXEg2jufP4x4jdA+8Kzx+fIhre7vyzvHd/UpAB+6Y0FsB4U5hBM47yVkR9xki+T1
	SkEgQ24oyFSm95UlwDLplXIjsPED+SoBWOuTs3CoTgpVIUO5YbqT+XFj9/J6c2wLjD2MRbQzr54
	SovIfNaZpU6JuNV9QR9KKMk9NlVz6xQi7XA0M1tsMEYdBp1FSYvIHgY8aPLzsy1Ngx0cIlBgmYj
	4XhNQn4P7Uq1TOR4PXGrJlhTu3iEsgWiqIA==
X-Received: by 2002:a05:600c:6098:b0:4a1:e7d5:5132 with SMTP id
 5b1f17b1804b1-4abf6e63ee7mr351585e9.3.1793311149227; Thu, 29 Oct 2026
 14:59:09 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
In-Reply-To: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 29 Oct 2026 14:58:31 -0700
X-Gm-Features: AclHuK8ASG46JARQbXb1REUMHY0OEjL5EAbmE_577-jrD-4XvLvRMqXYq4UuuIM
Message-ID: <CABCJKufu04HxOurNGyg2uHAeDVyTNQZwBeb4Nw95LL8L1AUFKg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] arm64: ftrace: support CALL_OPS on kernels built
 with kCFI
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Puranjay Mohan <puranjay@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Ben Cressey <ben@cressey.dev>, 
	Florent Revest <florent.revest@linux.dev>, Bill Wendling <morbo@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jose,

On Thu, Oct 29, 2026 at 9:53=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> CALL_OPS and kCFI have been mutually exclusive on arm64 since commit
> baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS").
> kCFI checks the type hash at a fixed offset before the entry point, so
> every function needs the same number of prefix NOPs. Before clang 21 the
> compiler could not emit prefix NOPs without also adding the function to
> ftrace's table. Since commit 9315e22b0c0a ("arm64: ftrace: allow
> DIRECT_CALLS without CALL_OPS") a kCFI kernel can attach BPF
> trampolines. A trampoline out of BL range is reached through
> ftrace_caller. That path costs ~10 ns more per call than on a CALL_OPS
> kernel, plus ~4 ns for every extra ftrace_ops registered. Clang 21 takes
> a section name as a third argument of -fpatchable-function-entry [1].
> This series uses it to give every function three prefix NOPs while
> keeping untraced functions out of ftrace's table, and enables CALL_OPS
> under kCFI. The per-call cost drops by ~10 ns and stops growing with the
> number of ftrace_ops registered.

Thanks for implementing this! For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
