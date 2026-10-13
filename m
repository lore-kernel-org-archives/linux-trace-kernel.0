Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7932551997
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924564; cv=pass; b=AUmaOIhj77OYPm7Nm1E+HlbRH0Yu0iFO63hpgmf/h41Pd4iy5biE+jUZCMq5RH9mxsFiGOcFT9Ht7i77ejaZ7lvxrZoVKj0cgLd/b6HVo/Wb/982I7fZb2TW9f5HTNvpq1BFd5gvKFPSZEWXUW6ex3qmbDvpRhQKzsLA4lOaV8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924564; c=relaxed/simple;
	bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVOPgPlKofGes9MCFnfsAl9PcfLRZ1M9BVocBcZkY5B5iCukkCVh3dFmRZIojEgFFZnVCKzsHuIRMemq9TvkjFSJwDOk7lJf2hALuofxQo2pAeYIbNklFKIhGnYLmilPNi9d+33E5MZXDCRWoY/r1/Qq5AeuMfPFSKWzoY9BLgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hq0WLQJE; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hq0WLQJE"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67921b515a6so2707995d50.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 13:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924562; cv=none;
        d=google.com; s=arc-20260327;
        b=svvhPVKNCxTIEoyXwJ1cI6A5HPUy5Bu/5JtP1C/rMJTKSDFCUFeFZ5N5kL4O21Q2jb
         gloZNZbIcnf1o5Cyi6iNj0FPgaj/q2f7/5fHviVqhW+ElGm5n7ZPtHJodnEQ38GxIz3A
         iDAMdtLKZnUYCzETIPvvmIyCEx6Lc3C9DGa80DwQkOyQIy+o7uHD3RWh3wvqkkA6mWDx
         e/Pbvmt3UTt2J2kZAfoY62SUUDruJI6qvS+c92LPSRE5zWmTsBE+2xYluEq5x0Toephw
         Cagnlhv5UW9bZXAEMUyQATC3bfFK9IoUhDtex6WZwbVpJ1mPjBKjO1WVGP5rl4iZhkQQ
         kwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
        fh=EhbtRT96G8ExdmJ1bIhxz/gGTAb4KwjNLITflCr/O/I=;
        b=EAQGNXUvnRcEH6DUz/JBmkXuK1B0X+Bkz5x6B8f0ccDEze99xPHIAAtAn3VPdZ2un0
         yRrxm5w+nv+yOkMh0qA6+ICkQjCdemHpEIwmChH753iSZk9AzZA1J1GQtna8totclP2x
         q9tEZU5340ydAuzIH4OhLa2cZ6YFGXm9AEwqCvV68aXJryTasecllPfbshqSkCQ1Uh5Q
         exBSuRzk25WY4kkZyfDfx5Wv1tLGzZZuVWajSowsend86fmfcYEw8LzMU2FdIO8VUez0
         4JjNS41PQTBq1ux+013qqSoqyy2UMCggm6HrCFt5/djTOX5oK35WOUD8i8C5/ZQoa15V
         Av7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791924562; x=1792529362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
        b=hq0WLQJEF6QP73pmJ6c8FJeMVwrlj6kQptWIXaj1nw7k4uKBOCtdqhFa4ZEx1U9iI5
         2noQBoKQenrv5zmZJK06HyjM7oJBoTx6T6GOFZDkIBKYzCTH4eq2ThweRjcfkv9OdK9g
         gmGNRBbxuOwIzL99EqhlmFKi50HlDL2A7kFw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924562; x=1792529362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCb03VA6LjpMHOfUp8pvf/EGXGe3r0X2vnJKPUWICB0=;
        b=wtvytL+WRHwLvDoEZBLkZozTOaGWJESw9+9RfmeG0QfR+IFcr451kBjucqCBMhiuWW
         p9LGxlyD0bLCpuoWMLDjoj0wqkrCG+5kKwE0B7zQhoX9Urbbrtla/1T/PSUnDpJ416zW
         SbVKKXx/OCo91z8bcjJ2gHlEwyzO3SpBrwl3l2knFN87eX5iuPYuthZc0ik8+ZHuPNKd
         tkqF37CnhsXlijFX5m6W44VGsznPmryy3wduLnglNfeGpJiqDRPJqrZRDUuJqXOLtsRP
         +Zhbbp69OINywAji/sBlKsfsDRlX8l7G1GVCgbwAq2vs4VjpgbUQlHPXVEW5sB3/Wfhj
         zWIw==
X-Forwarded-Encrypted: i=1; AKwUvBypyVBn/x/WS8PHFjV0fNUqRLEwF+B2S55cOR3UmLkWaYaEtUA6MNbtl7OYTiriGdGvpcPgtK0y3kXSXfzhi22eQ7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN2ctguDk0FlRNxC+EBWuwdxWibm/M88kyE5s6mx3FD969AQYB
	m/9LijiaybQXP5E6MFxuo7C4CGm8uXI2Okr7kfICoXeB+FOsdpViZnzc6++pcGS1hUX1m/HoE8j
	xfIT5hUnWEkl/A5U4F82DY1/JrpEPrJzf24n4I/RLLFhdSrqW0FU=
X-Gm-Gg: AYBFou1XzdlGx5wqXE8cUbMp+Heo1eSROsQgOdHWxRwVXq9es8Pd/WuDxNEuGpA8/RX
	5SosOWkySH1LqNFZGRYjWsnioEx1VygNRhSVgh6DHcGMOdzyB5RiCWoIY328MvY8t0AHyluPRzT
	pMZT5MTOqdyxIv1HxDQ0dvxe1RHiKa9pI9czmb33/XeHmrWy5HzBsLmn1dV2kfaX/2TD+0n63ZA
	mLMNiTAsP82859zjtb/enHc2Gqv84YgghrBdZsXR96TVgET3rS31hvOK8LG5olK4h0faDQtvGkm
	RS9r3JHZnEdFQbbcQU9WAOgm20kwnqKW50nr2+sMV0aLBLNdEJZQdxZV086btTDche0AGjGm9tv
	dmrlxyPNVWg==
X-Received: by 2002:a05:690c:3346:b0:89a:63da:fab2 with SMTP id
 00721157ae682-8b07ee2c80emr43041947b3.109.1791924561531; Tue, 13 Oct 2026
 13:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-1-384af01da3ee@chromium.org> <be3f853e-8b37-4b41-a998-94de1cb552f3@kernel.org>
In-Reply-To: <be3f853e-8b37-4b41-a998-94de1cb552f3@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 13:49:10 -0700
X-Gm-Features: AclHuK9ox7K2COGXrl-FRR9cM2pKj2PME_s-ad7oALLfV1KkNB6t3-cZk6Vgeos
Message-ID: <CAEe3GZE-3rCTw-2L-dzXqim5qHxLs1BKjpbmo9aT85ZBLWm5_A@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] Documentation: Correction in HID output_report
 callback description.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 11:04=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 10/10/2026 00:25, Jingyuan Liang wrote:
> > From: Jarrett Schultz <jaschultz@microsoft.com>
> >
> > Originally output_report callback was described as must-be asynchronous=
,
> > but that is not the case in some implementations, namely i2c-hid.
> > Correct the documentation to say that it may be asynchronous.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Tested-by: Dale Whinham <daleyo@gmail.com>
>
> No, you cannot test documentation. Do not add fake tags when they simply
> do not apply.
>
>
>
> Best regards,
> Krzysztof

Thank you. I will drop the tested-by tag in v6.
