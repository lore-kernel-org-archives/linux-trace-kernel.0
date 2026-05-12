Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C851FBEBC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614036; cv=pass; b=PMKOYYGNE5ghgpdCW9LqRhY+rg7iHfCMK/Q8gYab6Ini8KjzIvGMKNneA31X6SJvt8UQv9glqkDO9ruYLQrnzgCDC0mZ9XrXpsfwY/wThLtl38fera3ZwdpYjHndcfc7wBq89n6nf1feCyROmcS3tKXAAKE4n7NlRNInYtL7wsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614036; c=relaxed/simple;
	bh=QQzyFvehisNQbIcMvVSJU+1EurO5BpZKIZMWk7KTRzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f50Cx+TAfcfhI6tyVTOb5BFdLTF8vmk4hFhIR5w8rZ5ecpihG+ivF7c/gh3iisGwE0Vywd8lT9g0n8Vd+zTqFbpeJ+76NtOPt8vbzi5MYwOcn7NGeiAP9E+GHE4VIbr2T1mSEcJSKsWr++JEg52blubJX3IGp1v34r9RJmWN/2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6tuKFkP; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6tuKFkP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-444826c16ffso5132275f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 12:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778614033; cv=none;
        d=google.com; s=arc-20240605;
        b=Y5CuRulGamvIQSApnusBf8+hAnzZwVfuJ0dXfINlsgbQaeaF+MpIwNhVr/P3Sxp6pK
         bQVR/GrGFZp12JWlJEFy1wh6Fbd0ORA2jYEEo3t2cn+oLCV/Hdu5cDlgEw/IMozdBVkL
         xL92x5KKY3GKrXVNw6FBOsVKaYDKFN4sPcpOtT4RZz7q68GEi1o8IoH9lisqVNN38OiW
         umhey1I81UyK7a4mMA1vsqz5U69lnwB2JZI/vozY2hcO8rlQx9Mx6YxbihvA9/vMaIIp
         Z9R/PLWaJlNjm1oBZIjDVSN8/BonJgL8vT9APGzJoxBbVkABiqLW2iz45n8OtoZMKcjt
         5Xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vLRnNtGKyp083DarWgK9pY2oLAWso2ibbh8nUzf0/Oc=;
        fh=mC9Zkoy3bCH392WVgxubu49nMYcxoFjLnrIRdgAL44Y=;
        b=UfyQYt0euLPHKpsnA/Lht0OPSZYG3hAMoCo8lfudxWISbemlEA8wy1OAI8F9BFCQJu
         e9nMnQGkGVuUvnYOi5qqRCvBMdLwyWbMExwCAIcFlabrsbHSyLHxxyq1XCA+e7LgVuoR
         eyCbqjHXk7Tgqg3AeudkAK4eogVXcsUwTy7bzwh+OCSrfUCmlNvuWrWkGf2qSDs+3wKL
         PWZwVBB9V3vFUGt588Bgl2u1C3Tg1hens3D0aqFG22rm04DAyYoAo77YGG89RYml9S6T
         ROHHA3vClnYeGsm3KEbKTnG1viSLIpQgGBnjiO5hnB8iyyWCcau5ZyOLJyoGJ1JML9l7
         A+5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778614033; x=1779218833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLRnNtGKyp083DarWgK9pY2oLAWso2ibbh8nUzf0/Oc=;
        b=F6tuKFkPFTP7R2bGH09y8K6A1uj+K84HxmsLVdqRDc2xutu7c6CxUYa3gplibqBVdt
         m8qEZfCYbI2Zt1CutLOLVo89Zqf7gqlIkDe7VVMC84NeqetuT/1RdFs34slDHbMdHrDT
         oY2UJkOuqb7myenFiGoRaiIffHD531NZtDGXUVeZWn3j8FfBw6BPi3IBxafvUkVwsjHb
         +PmhxFDA/HZotRRFbgSvlrrwYEs7+DOGPrcgcIpJBFGF8XqWI9auV3ClwUAQBpuFHEHv
         RaqWT3Je49ieHhSjGyAupa5Crhg6Q3DCTv6vkcfjUIDVcOJxNWs/r3Fh9WrVkoOTrUKA
         hilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614033; x=1779218833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vLRnNtGKyp083DarWgK9pY2oLAWso2ibbh8nUzf0/Oc=;
        b=CCLX91eGxV2aTVIsGSRv9UJhDzQFoAAHQI3Ewh2gptTfob8LmjCqCpl6uORA+qMjfl
         +QytvmiEc6pz918mFV7K/9AoUcg+Mqlr8Z9F77+jaA1Z6TSNsnyQ0hdtP96ygFez3x59
         Ua3wQ77d+OdLPESv0TmHfCVfOGEH7AYGu+CDKA9UdjQaqfZrUoigJjQW7DRzdgQ35JxM
         6ACBzuAdf3uQZ/sn6NO7BZmTiVcpbaeYoQ9KXJLpJJ+lLNtYOlPPB9Oiz9k+qDsqivVR
         bGN5+15h9ClbutSsJvL1t0jhnehZnBAFDjwK7USUr/EUnMPpo1MDK/MrAnRcMZtT3r/q
         X85A==
X-Forwarded-Encrypted: i=1; AFNElJ9XD6dW94EOF79p8KM9LTIyy7S1dx/I6mDg+v/Ft4RU6oOr1yV0AvqSFJcbktnFcoU56hQWf2iFU+C0jcZFvSUv95o=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPAEI3Uy6UkOjG88IuFB2uZrQN1YFmc7HyHD9bx4FBSh2hj2j
	5Q6bmy6t+dMC+xaILq5GnJYdjCWz3MRSChdGqM/e/AC0trxYhcapx8EeEEY9HTMg6GI9MImtu4u
	nmgFperAgkEi3bTlqekuIRKSgSs1dlrY=
X-Gm-Gg: Acq92OF6bKYso9sVczbUQMh4rNvoHJHdyeGOQ1G4+W7PEK3SKuIfuJCEUoWle7ngFu5
	dJ8IpDjYJTT/Rdea1PlUMd3UmjHshXExK0Bh0lUlYsRZoZHmLLwD0E1jTSe83Ykt4tFWZqHXJ7N
	iLmXSvDJUU+26rbHMmh2FASW4Kw9dB/Q4m8edKUXLtQnBsCRl+MRdDVX6wI9vNMfLMr8uRf8zyd
	acbF+iwgkq5w7ZoqUtz7F0seRe0VcDQ+k/5vF//v7MXda5uqXqwn/yS6vwPauMs9JEmBLDP61Dn
	sFq09si7w/KMVSnPWUS5j4P275RlgvEIqq+wBTwSUdSern2Rty+a6BcJoCl6cTsWTR8/O8jV1uv
	VPn/7g1ASwE0iKlGP1pZCQNw3/Q==
X-Received: by 2002:a05:6000:2289:b0:43f:e99a:ff91 with SMTP id
 ffacd0b85a97d-45c5859f1famr188352f8f.4.1778614033288; Tue, 12 May 2026
 12:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <agD3xq2MUyskd7X-@krava>
 <20260512141431.a70375744fdae263bda5b722@kernel.org> <agNeEzjiThzmJHiP@krava>
In-Reply-To: <agNeEzjiThzmJHiP@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 May 2026 12:27:00 -0700
X-Gm-Features: AVHnY4K4JaNMU6u0L4AjaCC23qpKLbG-yzy8GmglAF8f-r01jNkXpfSztamVT3o
Message-ID: <CAADnVQLfgxEzpSTLhsxN2BYWpSxJ+RYku03UMfrSTi4Abu5SBw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> +       /*
> +        * We have nop10 (with first byte overwritten to int3),
> +        * change it to:
> +        *   lea 0x80(%rsp), %rsp
> +        *   call tramp
> +        *
> +        * The first lea instruction skips the stack redzone so the call
> +        * instruction can safely push return address on stack.
> +        */

typo: lea -128(%rsp), %rsp

you can also do:

add $-128, %rsp + call tramp =3D 4 + 5 =3D 9 bytes instead of 10.

Initially I didn't like this approach, since we just introduced
usdt nop5 and now need to recompile everything again,
but looking at the fix it's definitely simpler than alternatives
and doesn't have annoying limitations.
