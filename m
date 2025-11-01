Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF9153BD9
	for <linux-trace-kernel@vger.kernel.org>; Sat,  1 Nov 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956410; cv=none; b=BrowAwh9HfSO6kTj9Ry684OKEGvm/lSAcme5lAcBnS7u7n7CFXkWxEgI6joSq0yzqsF/E76VRIlJQcXn0R6x97LU6yKyW8erczaguynsikhB4+5ENh+c2kSBb5krFpfDJj3oS/SuWrSr/uinSn8fvnLKvs8RE+k15jrA7m8oW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956410; c=relaxed/simple;
	bh=+CLbNx0+SCLkDIniWRg4lwdqf5by9vfde27UuYHGViU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iedc/CvpHDir8mcaWhxzXKIdNI7OENvlfqkTIQf3anNWyrSJ+F/7P2XEtLj15qJE45cgontIkQuBkvAoHxkMZ1uBNrrGlS09QFCyoF0YTIRjdiYNbXgvdckfHkqCSy0u4uvd/hYvC6MyCmTMS8c4bjBIBzrmg7RJeQD9fauZeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEVxPZQy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEVxPZQy"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ece1102998so1931255f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761956407; x=1762561207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CLbNx0+SCLkDIniWRg4lwdqf5by9vfde27UuYHGViU=;
        b=cEVxPZQynHD6EVYmi8B7DVKrmIX+D86kI5J1eyjbpM+4S5aqXmGZUHIeZi9HURHdSg
         NFbmizHnaM6aHfgpJ0nIAp205iBzeltylEEal3kF3wqgnAIlD6PALzd1W+DxvYZCBulb
         oWTvxbRXUn5VeL+iW6WuD8HfAZHeTR0Fcs0TH7hpA30cv4HBFAIFQte2Z+MnISfhpsvF
         q9AVlnzRKeFZLa7YtxXezTRCCryEnb5rvjCrwk0b00eWOvIN1nR2UM7QKVBpglByX+m/
         pNqa2Zx3kVFOBftlpMi+IfIrs73JB2O96RY5iYv93inZ21emikzS7Xxn6VZrc06A/3Ys
         tE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761956407; x=1762561207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CLbNx0+SCLkDIniWRg4lwdqf5by9vfde27UuYHGViU=;
        b=bvUxSDYvH9WJGahMBIbzofZv5RURgMIvjBY+DUudjr5MmQxVl5n7GE9WNDU4ExRNzR
         F1R6Jb/d4OvPevDdyCGbVGbSW3j80SVX2n3/K0RwulN4nfKrKfvw2CK0lLb6Oe4B9lAC
         MQsCvlYNLRuq6C6m72yQUDeRiJMrblR3GEApnWLptn+Jkqnalz+5egIY6JKN3/0E0O7J
         vOKfFBAqnuTybVUF498IXOyjvh31RalQZ6F7TYYLwSPXC4McmZpzRhchVTqNcfu+tSFo
         MI/ovl9GFaF5pfs3Zt1rnMFpPWbswFbaXedqFQmmTMvR/FEfkNyW3WdPoToPiyzR3dSx
         4r7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXZy3VXYPZyjTVRXEtQdmMlChyaFnD1DIViO99jE9uy/H6Nxj2gBx39dkT/Iho2sqXVbrpPDdCJNT4SOEiJEsFa1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/nkkUQXgR6x56Jt3sNkG4uxtgDmBZ5r+5jdLYl0ShXaeQ4NE
	sDWXEb3B7qcX669/jKry7ekFjBAWDAT49CZjGq/fjKDjLMV6lVIrX/ZtzNgathvv4pke01ppFcf
	wkZwISojANu/Z7hfXpnHYWy1l57ioYdI=
X-Gm-Gg: ASbGncvsl1oeg2+t47e7MGgYq12AB20esXtB76AAlSiWuiMRV6Y5B/jeWXAVRjg781+
	djPXnbcDnyqKIYj5wkZB5cZCy2JCWLQs9ib+2CPa60jdjlDccP1LrP5cyoc1QNCmi6pXsLh15jh
	Hd7ElEMfhTZNfwU2JDAScSx3SeVa5UHIySGIeJcrAlEqqIvkQDXu3VexVDPCUxW6OTi02/MAFp+
	JLYhtXCKL97GwcHeJDBbUHLoZqtw1OJgYnceZLVYC05R4WVa6tbpxljh1tzo2AImsXvDhiowH0X
	xiv3XXpavwoOeo9avUV5i1zRBqXvMDm14RNSAJw=
X-Google-Smtp-Source: AGHT+IHNYlEWOUMUtDvrTK4geQQrmMKnQJBQrV6hcEirA2F2JhOkgWTEMrJG0KJ/zrGB83nhreewf0v0Vbb+Cn07cBE=
X-Received: by 2002:a05:6000:4283:b0:427:8e5:39df with SMTP id
 ffacd0b85a97d-429bd67bd2dmr4146048f8f.21.1761956407306; Fri, 31 Oct 2025
 17:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027175023.1521602-1-song@kernel.org>
In-Reply-To: <20251027175023.1521602-1-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 17:19:54 -0700
X-Gm-Features: AWmQ_blwHGysxMuw7rx01dYjPj9zdTLkr7fwqsaiFUdesnwh3GVJuzrF-PEto30
Message-ID: <CAADnVQ+azh4iUmq4_RHYatphAaZUGsW0Zo8=vGOT1_fv-UYOaA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/3] Fix ftrace for livepatch + BPF fexit programs
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, live-patching@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:50=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> livepatch and BPF trampoline are two special users of ftrace. livepatch
> uses ftrace with IPMODIFY flag and BPF trampoline uses ftrace direct
> functions. When livepatch and BPF trampoline with fexit programs attach t=
o
> the same kernel function, BPF trampoline needs to call into the patched
> version of the kernel function.
>
> 1/3 and 2/3 of this patchset fix two issues with livepatch + fexit cases,
> one in the register_ftrace_direct path, the other in the
> modify_ftrace_direct path.
>
> 3/3 adds selftests for both cases.
>
> ---
>
> Changes v3 =3D> v4:
> 1. Add helper reset_direct. (Steven)
> 2. Add Reviewed-by from Jiri.
> 3. Fix minor typo in comments.

Steven,

can you apply the fixes or should I take them ?
If so, pls ack.
