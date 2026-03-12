Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862063CAE92
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349803; cv=none; b=Rork5sT3jVy79IW7GMzeqb/ax/8zo/EFgHcBPlLlIn/rDBZJsiQgqOw18TTKZDemsFxjSeF7Qhz3fhypOfeCwGCYDzotjXbRV3kbRn44YCwmAUPHjZSSOJdxh+E9ZSqwuKzF3VG8l8x+gXIst9RJGMdoa87M7yIki8R5wttxLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349803; c=relaxed/simple;
	bh=GC4p8K5O2l43icrKaGl5uvtXY/uhUv9L36dDitwojew=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FAA/RAXP2ZxR0Wt2r1rsZN/8XEFJTd97Mhed0+944Krb7Znu2iNNksGWKjzY4g0hDd2qRiKYFMdSZK/u5HfvwPxZRjQf1xBd89azG+gsZhhyWnNVIFelgcb1NKZ0n56MmTN3ob0T6cmdq+LFpXIJrPqiPjvZ6mZ0pRe5EznFFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKD6etAM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKD6etAM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48540355459so12753775e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349792; x=1773954592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC4p8K5O2l43icrKaGl5uvtXY/uhUv9L36dDitwojew=;
        b=JKD6etAM5GndTbS3WeYweSlhRgx7XbG+CAFRlkd+Fm9+Et2VitLHv5EQfkWsk9eVZf
         MI0VZJ83ws9K0tc2W/6C/dyNLyZhaHbYTmdCAl5cPJufVIlQmWYO98wNH1KdqQZ9vVCP
         AHF6J44FKMqx83BrWmxFFHXToOSpaZ5obcqILjrm2iAhg7XixLWuH2j3gV3NoDwXZ+1Q
         L0Jr0fvdkGB4UaB7k+7ES0XuD8QJ+vH6hlOhc7lkT2mD+Xk755sqY5RAvZyiZCOeT7Mw
         2bmy0VwWnnoUyNAL7JgC2zqesUMZWHYoVZ56DsDFFZt/grp0S25yve5kLuQByXJUjUBy
         qdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349792; x=1773954592;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GC4p8K5O2l43icrKaGl5uvtXY/uhUv9L36dDitwojew=;
        b=Zv8yQ/92nUTA3eGkHCA2a/uhJzMdTbmrV9UJQB4rjUtqqBKs41vSHHKyMwhGk8Gs7I
         7ZO8EuptR8DGgYswLTwMkKpQZHfKfuN1sSOz1NBsoNjLlciD11j4347BcMwE4DD9eWl7
         6x4h3fd6tKiRfKtdFCGv25eqddkiAcTvs+SRrkRdhtLzf6nwXvNaevvi1HFIHC2ZjpjP
         hDoxLxuGqeOFGALN/GgOgvxOl+t0E7a3dPl6CDrSmkF8cGykckJpEYrgZ2e64KLdy2x5
         FHVtZffnFGu5x89KRtfz9dswndLOD0WEDQhlktpkCOSsS50CU4Ort4qlURrQdSHCN3bw
         OWMg==
X-Forwarded-Encrypted: i=1; AJvYcCVXWCLAT3Xx1hmz7jV3+UvEEwd7y/5edBB9XeIRjjulTXGLBe9ibv9Xy1KILApupwuelZL/DJ09yee35tiUGqBzlPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziiwCAUMbG4RNaGjV3SHuQaEXD/8CrCjFlSX3PN/7/k8HCb6FG
	B4baWIs+GwFXKvOjmKPMJCKgnBKUSxfyrTg98qxoQlYNx6L3T/aPPXZphPCzyIizAxU=
X-Gm-Gg: ATEYQzz/UEuZR/Phd6jlDYcRHL++NVSb41wuor1GfLNP52fnnh0gVCVm50o8/RgF61H
	K5ChwfkkNkI+Zw94aJ9qvbhNwghmxZVaNP6UCr3z1y2YAQIOWkyyVuwFNKAjDxGK7RreJohnN0e
	A2PcsOSlnEqWP1sVhQlxRpCRjXZ32dkFydCi8EQ2XU1eUoZOoVLsyalh0GUHOLX6WgiCYsEQlb9
	Yus2dXLNffQF4ZGo/M+G7JwkOHR8f/MFd9cRz52bEYQ2d9s2tVNjfNu05W4N1cwCycqvMODxBZB
	Om1USCj8QbS6I8uxvaDpva3HzPIYvUUFES2a5ZAAU07kCgrW1WkKXoO/J26nAQOj0hnFieQ/grZ
	qWUrzX/CyFRk3sra7JGmvG2xNMNUPcREtYmB3BF7l4vg/tGtKouyomCQpupH7eYT6Sofv1ik6Eo
	M+zoFpiCAI3X/MW+SH
X-Received: by 2002:a05:600c:4ed0:b0:485:35ba:1d8a with SMTP id 5b1f17b1804b1-4855670e7bbmr12465485e9.27.1773349791477;
        Thu, 12 Mar 2026 14:09:51 -0700 (PDT)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm723943475e9.2.2026.03.12.14.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 14:09:51 -0700 (PDT)
Date: Thu, 12 Mar 2026 21:09:52 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Law <objecting@objecting.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Message-ID: <4c426803-91f8-48fc-ae8e-20676479b370@gmail.com>
In-Reply-To: <143ca1aa-d053-4947-9817-72462876c224@gmail.com>
References: <20260312191143.28719-1-objecting@objecting.org> <20260312191143.28719-3-objecting@objecting.org> <20260312170643.4b0f926b@gandalf.local.home> <143ca1aa-d053-4947-9817-72462876c224@gmail.com>
Subject: Re: [PATCH v2 2/3] lib/bootconfig: check bounds before writing in
 __xbc_open_brace()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <4c426803-91f8-48fc-ae8e-20676479b370@gmail.com>

12 Mar 2026 21:08:03 Josh Law <hlcj1234567@gmail.com>:

> 12 Mar 2026 21:06:31 Steven Rostedt <rostedt@goodmis.org>:
>
>> On Thu, 12 Mar 2026 19:11:42 +0000
>> Josh Law <hlcj1234567@gmail.com> wrote:
>>
>>> From: Josh Law <objecting@objecting.org>
>>>
>>> The bounds check for brace_index happens after the array write.
>>> While the current call pattern prevents an actual out-of-bounds
>>> access (the previous call would have returned an error), the
>>> write-before-check pattern is fragile and would become a real
>>> out-of-bounds write if the error return were ever not propagated.
>>>
>>> Move the bounds check before the array write so the function is
>>> self-contained and safe regardless of caller behavior.
>>
>> This is the only place that increments the index, and the check is >=3D,
>> which means even if there was just one space left, it would fail.
>>
>> As there's no other place that updates brace_index, I don't believe this
>> patch is needed. It could even replace the >=3D with =3D=3D.
>>
>> -- Steve
>>
>>
>>>
>>> Signed-off-by: Josh Law <objecting@objecting.org>
>>> ---
>>> lib/bootconfig.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
>>> index a1e6a2e14b01..62b4ed7a0ba6 100644
>>> --- a/lib/bootconfig.c
>>> +++ b/lib/bootconfig.c
>>> @@ -532,9 +532,9 @@ static char *skip_spaces_until_newline(char *p)
>>> static int __init __xbc_open_brace(char *p)
>>> {
>>> =C2=A0=C2=A0=C2=A0 /* Push the last key as open brace */
>>> -=C2=A0=C2=A0 open_brace[brace_index++] =3D xbc_node_index(last_parent)=
;
>>> =C2=A0=C2=A0=C2=A0 if (brace_index >=3D XBC_DEPTH_MAX)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return xbc_parse_error("Exce=
ed max depth of braces", p);
>>> +=C2=A0=C2=A0 open_brace[brace_index++] =3D xbc_node_index(last_parent)=
;
>>>
>>> =C2=A0=C2=A0=C2=A0 return 0;
>>> }
>
> That's a fair point, Steve. Given that brace_index isn't touched elsewher=
e and the current check effectively prevents the overflow, I agree this isn=
't strictly necessary. I'll drop this patch and stick with the fix for the =
off-by-one reporting error instead. Thanks for the feedback!

Wait Steve,
Thanks for the look. I see your point that it's currently redundant given t=
he call patterns. It looks like Andrew has already merged this into the -mm=
 tree, likely as a 'belt-and-suspenders' safety measure. I'll keep your fee=
dback in mind for future cleanup, but I'm glad we got the other off-by-one =
fix in as well!

And in my opinion, merging it is a decent idea.
