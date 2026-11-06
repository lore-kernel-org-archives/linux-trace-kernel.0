Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794003751;
	b=PwbCG6UyytFJypuvPpXpPkIwHmc4xks0kC8ruxFmOlmPCZn0U3CE43nP1kUjtK860gVx
	 ergeDW2C3yVTxxcEd/RcWz0YmGtdgni9tge8O5lB7Z5Vlf/8QDfNNAYZryyzVok2oMSrP
	 U5q6zNICf6jqpwT5rfsjgUT0vmewHKmCU0c83W6neLMWdPfCEQBaj62P/iQoDBi0u90Sb
	 +2xxlR/SQgDR3athZSSl2kTRyhsdKiBrkBtCHC+i5KqTtU5E5b1PPrQJ6FinJaxtpPXDs
	 g8nlE5DKG19CNYG+3D4kSV2YTCbVRR3fIho5jLlOAEXh3/9yUrGjUk2v353WTkMk37Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FQ/cFlG3xWdEnQr8IGd7fdJaX0rgjv3jYzHWnWHzP/U=;
	b=ToVrORvbIByedvEQTHNTAYUrkC5Ru6zd7PXyP2JXBEzlFcVlXhDW1jvrf9UBPHImAyOb
	 hD+J3Bn71Li/en1n9+J9KAME7VzswWy8+bJntO9+V8FONpDKyyo48nCPvjPhM8fVewLjw
	 mkY0rT7iTuN6p7VSSIpbErpeAoQDw1ME3LGJMTZbDxnI6VgrQzgKL4GcQK3oQymzcACpu
	 n+b91cDnJ1zcKZ6qi6CSFm35n75wkQ77rLsybwIt4oNMVt2bfR4rQ6PyZnwmUyf4Bjy8n
	 rzleMYMG45kIgclG8X+wKD9MIFKw7OKUVL5EvFNEQ/QpHg90xMp6zwEwlJEYbFr7NOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPyt+i3d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25229606A32D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 22:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25229606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPyt+i3d
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53dbe9b8d6eso115794b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 14:22:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794003750; cv=none;
        d=google.com; s=arc-20260327;
        b=GYlr5Uyd8X1XcynNZ/DSh2Nvp6jpfPwlC7UnNbL+MDJ9WQc/ZjErvsEc8HHCcvwlv7
         DAKtGORUpL1EqWpLFv49klE2pfHnSatzPd178wQ2Langt+ej20E+3Xsxp/yjAzNpITPX
         z+qULsC3T6uJoX8itRBmUjO6LFvI7pyf+1oFZUfKwdAJXDAz1+YTwFKLiYSxai6eSyH0
         gisZ0E/xO0i4NV6bQ3ebZExZqigoEIogY6+wkYZE/z+jnUAhSOzIQNbLmcqe2zEkWurJ
         pL9RsSIvM8G1HOd9U0MwCWlBY1JRyLCVFIoYLuysWZ/M760LpVDIPzNqd5Gcpi/xF2IN
         qTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FQ/cFlG3xWdEnQr8IGd7fdJaX0rgjv3jYzHWnWHzP/U=;
        fh=/lhUe22o91j++Z6QFyIKBJYMwFvwYOoz4T3tQeL+O2s=;
        b=iJKWtk0LrIRatw6r9/esqMtAVWOveHYLV2nfrwt6ViIDCZUiRFOHlewZugK+YKE/tW
         QwdL3E228P59nMjeTNGU1l1RalOJ/l6c0sjaHwnoeKXw+ZSyN46Abbztk4GNsB/YX7yk
         wbqqUyCIT3ooQewBTe/wQvYTY8s9U0r6GZva44nvtVDb2Jb+RhQJfb0oprMCRGyMB6tV
         GmOiTxSaBQG6sR0abqo+tfwTyQhF4RvvORFPywemYouPIvuLOazMtDktsSr40dGllyGM
         j3i9sIvU2XVWxVMFtKdL3kEGeBFrGpv5KgWyDljmcaTL2K7PkcAjAdmmDLzMuzTmCOSK
         kz4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794003750; x=1794608550; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQ/cFlG3xWdEnQr8IGd7fdJaX0rgjv3jYzHWnWHzP/U=;
        b=cPyt+i3d95+KCeQQkOH8F2rDwgzTTfJHa/LbAjB9yasv9CzJ4zC/3OK589tpx8JtfR
         MeA0VXlDYyh43VNR/VlvoSt6nkPIKqEFFaJVQY+/UvcaCkzf8hd3oHPbgmjkimjnS9Nm
         1WYuMUgP5Rgy3nQLo+Jap9gUD0nQAbCZiNC3XPhFFTS2OjD60vbUFT99fK6Zi1V4aN5t
         wNVcja6zVclHdwENvR4xakimgq1AmYbgb3znnVStoD/Y1GVMaGpvml5UQj2b7gI5yX5m
         LNi4vDQBxiiBhLNmld01+CSNfO1DpyfkwvgspJL4lsmo+pXddu7wrLQ1Z7PFl4YhDMrl
         fuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794003750; x=1794608550;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FQ/cFlG3xWdEnQr8IGd7fdJaX0rgjv3jYzHWnWHzP/U=;
        b=fg95MbGPdK8KkAh26HwqueIfdf54fsnKFwLMcS81qPWLMOLZdE0+CpZgA9/HaOXHCX
         CX418n2BtEy8B4dyBp793QKyiABtVAPCi01iNudVu12621IsXww/bhewdHYTTA47JtUt
         gw2X6F6Tl4i9mrbxzJ5UQ2bUYXVbjGdXIyebuLXAyxi7v2aQeokQiyE+lada6yJ0C2rr
         u/hpKRNE9SvCEuuj6yv32Tr1w/RA3hTdKyNjPCFNIvBmMGPuMtPJPpQam8a56tte8yO3
         /W6WvyMLQ633orfc7+SVL6bjEg/v1ghPNohocZjsTDJSFN5XvxzzMK6z6ToZPfFHG9AS
         0JOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzC1OF+VEuklRKOfto1u42tVx5eeWqVNKGmlFIgh7Ul+zpcjla/+se8o7zxxR9GZQ0ACwkBUbk1rXNx9jwRC71gfPc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/niU2v8Ase60byMdstGjqIPewozN8SYacgQsLpgIn0S9lwQqY7
	sqg+L4R2kcnMVxMZaiMjioifCEpUd99O07pyicdqtEuvSBE47PtmHoRm8UrZnM6ELVtQWxd4qic
	PCj4rPYYO5bcp1xO0xzziKodRkYWkzy8=
X-Gm-Gg: AYBFou3ZyWaHoXpVrGms7Pu7yEDgXQSF5C1tUTtXyMchfLFQlajxgTwJyrI3TOVd9cn
	H+wPjoN7I06sp1SBUDwe8RYdV1EZJN8pC1vNqgRc/BUro/igGxMFNXxDe3LjgFNR6gTQDYCknvf
	YKDZ3DLDhx6SOPymcO+0XRtM9p53vldcBECyxMBTKbdVYSRNuAdEzh42Zm3kLlzh3Z66NxvJaSb
	3bkal/edz7vm9O+dBfbWeXrH3zFAaZ3ILVV/IbKJ+TJ98UzIz1ol3Hu/wlBlNxA8dkgFxHWw5z2
	8YhE/r+ivHyDRnRzlj5+urZtu2UHzw4VUSZ0B0rC/S80qgx1uPbfCmLixxbiW2uaIVKi6LhLlF6
	n8cyxcCCPCejJA9IkY7ggyEZuqXukJ1BS5vKDoB1TjGfzM1bAWFhJqmVaazKbk4gccSsojpGnaW
	nly6BphIqeqwbD92b2nQ==
X-Received: by 2002:a05:6808:2f0f:b0:4f5:214:fb96 with SMTP id
 5614622812f47-567fd5bde12mr191162b6e.42.1794003750060; Fri, 06 Nov 2026
 14:22:30 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261004-ftrace-mod-bsearch-v2-0-c1de73e72e73@gmail.com>
 <20261004-ftrace-mod-bsearch-v2-2-c1de73e72e73@gmail.com> <CALr3rD93RT_=w8VB6aKfuV5crbwXK4Tffq9bLD=eJBj07Tv1=A@mail.gmail.com>
 <20261106111154.0e09925f@gandalf.local.home>
In-Reply-To: <20261106111154.0e09925f@gandalf.local.home>
From: Mitch Hen Chez <mitch9654@gmail.com>
Date: Fri, 6 Nov 2026 23:22:18 +0100
X-Gm-Features: AclHuK-7xQ6612mfqm3wxXygc4s6PKZhQY2O295ToyoiA417T-cVE2TxsGyvghM
Message-ID: <CALr3rD-A037pOODDLMsOcFwFbQm2d=xna1sW3KMRJtnv41raYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ftrace: Drop weak function locations of modules
 when loading them
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ah, thanks for clarifying, I appreciate it :)
