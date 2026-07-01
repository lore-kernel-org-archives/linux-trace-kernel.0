Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077039B96A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932008; cv=none; b=tJ6EYQ2GIySXJ/L69bmkjhGEq+3W+A1MRBfrsn9MjLAyppktxZjt/YJ0Ub/x2WgddPtP3djHrghtYpmWMi9vIQg1G9zWQyh40+lP2lEfM3KdPAuTPeZvnWuWgtx2DyrE/wHc98Ky/uMRe+lE5OTaf+5zNtzsNhuillPii0eWQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932008; c=relaxed/simple;
	bh=zpZx/8GKHBXgDfwh+pwBktW/ySFc9U22KLT7noierXA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Lt2JuiUAvUIJYc5DB0OhGoElPej3C3bAodWz+DUKtI+veKgHDu9XAwoPkYvoWKHmb/NMFNXXSfY3WNqf7SllgucZfgp+5QrQLItxP8+E14fAehtM7YEp13ZiZuUvR16O7/MwRoAhEonFDvYetJzEib1PMoblfpOu+M4ZGnVJi6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk+5JXqu; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk+5JXqu"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69eb8b6bea8so502482eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782932006; x=1783536806; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpZx/8GKHBXgDfwh+pwBktW/ySFc9U22KLT7noierXA=;
        b=Gk+5JXquQ6SVEb/naOIAnJ5/7tCBaMvlp7ke8fR7pl08Vhl9PlK4yk9LWS78WAKawD
         eu+T0fXLFZ/IItR+f28tKvEXhDobK/dOtP4LJrjwnXMpD1vDUoDFP1ssHGp6ALzlena3
         Sf5s/5wD7yBDi/hjsrt2GgRLZ1E7MuS6DQSn4/curbmLWDpt+Vs8t0TxA85+3kJm9Vjn
         23YLHRbyQGPVrrNMfGFW8ht7Cij44nDXRxJUBvEKPqmDcEVn4AAWALIwGjdzQZXD+VHg
         hqi1IJSIQlaWuXCQ/+TZ3pOblQrFUy2OTVe8yt4Ggw0tL5uWbEKke3T6x3f5QAQl1Q4x
         tQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782932006; x=1783536806;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpZx/8GKHBXgDfwh+pwBktW/ySFc9U22KLT7noierXA=;
        b=KwOCtNFwmVHv7tV62CpWLZdtNS1+c+8q+tU8wewW3CJJ1GiegmtGeaDsuWNgLUJaMn
         SHPTUQQcFydmZ+jUSe2FMgO0QpQtLM+TEE5vGvk5Bso1FT7g09biMkiPF05kUt7UGsZt
         YaKuwkzBOUu2RmRnZID3MuHV4M8E4CgGJZuohWc6R+ZniljnD+XEDtoMC6Bt7Iz9LZVr
         /rnbQrHvfnCYc5m3f/9AYJNFgfA+jfsayjCw/fTu0qdzSEh0xCFDKYan2BksDvtYA6IS
         eKZP0NZphuMHFEmm0Si8+cDOvR03oiAP41l8+pvQabukORripesFMx8YohBmoYtrSqGI
         N26w==
X-Forwarded-Encrypted: i=1; AFNElJ+IyFDZ3giC1UHRDuPjaep/z9TlT+mN9A+sHEQn+YRKQmugXiEF92lIooQchVEXkg2TlERx46JCnx0xey0CfQ/L950=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9QUKPodgshIoXXxaIyttR+QT7vSNq9DZFQmiQzNikd9yH4F3
	j0uR/ippAbC/R8bnOXsidd2jA28sYcWmBwY8hTtPFCD4svhIdo0kGUJo
X-Gm-Gg: AfdE7cni94CA259/a8Oo4cdPT1Pe9t7gsNv2uLXp5iIHQH5QlDsz1gWl/MxY+QD0u0n
	td5BI31WmHJYeo3EerAGoszXl9/Y+EGNU8n8ppxrE/nvi+vDvX2b5u6kyrO5nPGTyqRy1a9bQWQ
	Vs7tPVlHPQvYdzWqFe+xhvbg4m7BwguiSYakcX35xc798MJV+83X91kWgQnjamn1r061Wec9Kx/
	4swcWlTlfLGYK7qNMFWkZZTzapXJW36WXa715jBBU64fwCzR5ulKOefbyaISW+C4RsUAQA763zw
	/MRl5RA6nlGyRLJ6DhxfDOG05a6iveQAqi9HZJsPrVqSv9ITu0ETQk4tcq6pSApgtns3LF7qfvm
	p02LQIhZY+aGM/yDHvlA9e2+06K0/lsBcKhoeRHjrIhRwMMrL/z87d4imP4u9orARcQDf4yNMwg
	HptnORo9GscFJb/GyI720+gL0z18SpcGFisye+jctjVVocM++EihZYklHQWjiuyoAJrYmLL+qJL
	VkHmBU=
X-Received: by 2002:a4a:ee0a:0:b0:6a1:57aa:289d with SMTP id 006d021491bc7-6a309a031e0mr1581503eaf.30.1782932006353;
        Wed, 01 Jul 2026 11:53:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe841573sm582006fac.4.2026.07.01.11.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 11:53:25 -0700
Message-Id: <DJNGNBR6I841.3Q0PGODYNDSFK@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
X-Mailer: aerc
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291354144.1566898.14374948740441958770.stgit@devnote2>
 <DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
 <20260701144726.0a5f2204@gandalf.local.home>
In-Reply-To: <20260701144726.0a5f2204@gandalf.local.home>

On Wed Jul 1, 2026 at 11:47 AM PDT, Steven Rostedt wrote:
> On Wed, 01 Jul 2026 11:41:26 -0700
> "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
>
>> Nack.
>> I really don't like it.
>
> So the nack is mostly your opinion and not technical?
>
>> There were days in the past when the kernel generating bpf directly was =
appealing.
>> These days are gone. Performance improvements for fetchargs is not a goo=
d reason
>
> Why is performance *not* a good reason?
>
>> to add all this complexity and bypass verifier checks.
>
> The code lives in the kernel. What reason is there to add verification
> checks? The point of verification is because we don't trust user space. W=
hy
> do we not trust the kernel?
>
>> bpf insns should come from user space.
>
> Why?

because I see this patchset as pointless kernel bloat with the "help" of bp=
f.
Hence the nack to avoid dragging bpf into this.

Call it philosophical disagreement if you like.
