Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F78388E71
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349687; cv=none; b=JtnP6LRWAA0Y3Eke3ej29S0w41wadGrc+RMLM0nMwQEMTg1H6VvCD3m03R5QjeqRsRM9ki31o0esFx2hbk8vDlGOYS1s+bHRJpbvD9cEK4GMFXdK50n8SrIcoil25beu5n3wd9NacNG4o2CFPNsS1j+XmjU0tsz31zU1SSnQ3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349687; c=relaxed/simple;
	bh=Upzo/J553/HQOufdjjMXQZDfB/yqJV7IFtVzh1MVDdc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bfRNDdBgqjh3R54vhUvBtsgHJgEFvtY5mJb6JCul6nsBu6TdNH29x1ES6YqrOZXHsowgga5ELkpu3ZXYpInQt7/sWDGfcORhT3ZXfJ+QhEC12Ktnp73gUIDhhG0tAGnfPPx0Wo/3AfVmwqeOa2OnsdVsgjSxChb6U7yhWR0RGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYiE9NJu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYiE9NJu"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso1547325f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349684; x=1773954484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Upzo/J553/HQOufdjjMXQZDfB/yqJV7IFtVzh1MVDdc=;
        b=RYiE9NJuFIbf//D65FElvXm+dV4j7QXo/mX0esAyh+meFQJ48ZeVJaWbQdTz4UPhtT
         OSfCbxMj4X01U/m08zDUL2sz/CfkmMbl70eZ7AZwr4rEwVQ1h/cCBlfHRxQgkUZx1x0A
         892KKOL/vVcfONDRwzlN0vBUOmGuc4Ol7ku4JSb1t4zCcQLPQUVIfxroaH7S9KSZHJ+d
         PmWT3towzon+EatPsvG2JeNwqRSQUHuAv4pQUuNr9bzPpZJuoBnhK6mPSpz2d/0IFh2T
         LuTgzraPA1uQZZnEf/ecpFpcVYjayFiX4dhbsXwVJu72i1eNnA4K+crR/OlGd7Vky7/c
         J7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349684; x=1773954484;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Upzo/J553/HQOufdjjMXQZDfB/yqJV7IFtVzh1MVDdc=;
        b=jvB3hwi0pCB8qSUl3EXI+6hm/GuyFohpGfurj96xyIVQD0uxUGvjr7YR9ccae6Clzp
         sfPruG4Wkp/SHhs6Sj3MpCwoE4qGiIKrbwa02Y/w+B11L/uIqtra2kM9s39kjoretNwW
         c2BB4ZT6Z7PVTlFwn0RDolW8gww0oCG8qCBIZ3DeaT4N3tcZ4COA7YDZJfJ43rmjueNB
         ywtBEfNKkYaTEnPLUBSEONgbWs5KQKeAxGwfZyv1Va5SvInCVGyxGhRZNtSR1DROmA0D
         DwL3ai6uyeCwqEeTQWvWieKbb63ueh6DsEz8YGY1Y5EcDieUUZ1tZpmzNmSdy5DrRSzV
         yurw==
X-Forwarded-Encrypted: i=1; AJvYcCVFOvwN7lgM2FH7sQnpNLqsRLWZGjLguaT6yqRTc9k0xBZxPeN0nK0xW88b21ErJw48GzRJaYPnlAHFIUlrcJ8bkFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRm74/6er64tOdk0JhtujMJQdVOB35scH6lKVyvLC1skyzE2qb
	Uay4YClqqp2fN2GxK8n/ylAD+aoamFzwz0OlhIkuS7VKN2nvE62WY81b
X-Gm-Gg: ATEYQzzvEiepoXh0RGkADad+F/7hzf3t0daQAni8ujnf3CQOfOedrHmmeyt2QmCazHB
	JdPWkp0k4G/dPnzKqTudMSfO88IHd0As5YfBdbX46zJKew7ESY4xLZ3PptyTsJocxD64wUXAbG0
	LJ0lOMJYO+a4CjlafZZzZ1kToDlOFx4hdTOc4KfbNVAbZF4MPabqy/FS5gPbVwVgS0qCMUxj8kM
	a6OTBxTzHxBivkqU5F/Zutj4ZgaQmkXgvLqVfDWTAcdSpvqT3NxMAB+85A0RLWvx648a2s0OPKH
	y9J7S2JctPqWaNIR5OZU4Dkx/lI3pLXLwaYV9IZXfEozR4LECXu5GDoueeD4ZnaFQ8nbl3TSRbv
	5k9m+nWP5kJLALJudKEVk/+eWax85DPrEj9ELBG4+YPgiRiOQUftXYDBuI4kBFZ8pEbXKOdkXpb
	x07A6mY8dyCW1+q98YBNx0ZEAs6Hg=
X-Received: by 2002:a05:6000:2089:b0:439:af81:1b2f with SMTP id ffacd0b85a97d-43a04dc83d9mr2196027f8f.46.1773349683973;
        Thu, 12 Mar 2026 14:08:03 -0700 (PDT)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bd9csm11383340f8f.21.2026.03.12.14.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 14:08:03 -0700 (PDT)
Date: Thu, 12 Mar 2026 21:08:04 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Law <objecting@objecting.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Message-ID: <143ca1aa-d053-4947-9817-72462876c224@gmail.com>
In-Reply-To: <20260312170643.4b0f926b@gandalf.local.home>
References: <20260312191143.28719-1-objecting@objecting.org> <20260312191143.28719-3-objecting@objecting.org> <20260312170643.4b0f926b@gandalf.local.home>
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
X-Correlation-ID: <143ca1aa-d053-4947-9817-72462876c224@gmail.com>

12 Mar 2026 21:06:31 Steven Rostedt <rostedt@goodmis.org>:

> On Thu, 12 Mar 2026 19:11:42 +0000
> Josh Law <hlcj1234567@gmail.com> wrote:
>
>> From: Josh Law <objecting@objecting.org>
>>
>> The bounds check for brace_index happens after the array write.
>> While the current call pattern prevents an actual out-of-bounds
>> access (the previous call would have returned an error), the
>> write-before-check pattern is fragile and would become a real
>> out-of-bounds write if the error return were ever not propagated.
>>
>> Move the bounds check before the array write so the function is
>> self-contained and safe regardless of caller behavior.
>
> This is the only place that increments the index, and the check is >=3D,
> which means even if there was just one space left, it would fail.
>
> As there's no other place that updates brace_index, I don't believe this
> patch is needed. It could even replace the >=3D with =3D=3D.
>
> -- Steve
>
>
>>
>> Signed-off-by: Josh Law <objecting@objecting.org>
>> ---
>> lib/bootconfig.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
>> index a1e6a2e14b01..62b4ed7a0ba6 100644
>> --- a/lib/bootconfig.c
>> +++ b/lib/bootconfig.c
>> @@ -532,9 +532,9 @@ static char *skip_spaces_until_newline(char *p)
>> static int __init __xbc_open_brace(char *p)
>> {
>> =C2=A0=C2=A0=C2=A0 /* Push the last key as open brace */
>> -=C2=A0=C2=A0 open_brace[brace_index++] =3D xbc_node_index(last_parent);
>> =C2=A0=C2=A0=C2=A0 if (brace_index >=3D XBC_DEPTH_MAX)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return xbc_parse_error("Excee=
d max depth of braces", p);
>> +=C2=A0=C2=A0 open_brace[brace_index++] =3D xbc_node_index(last_parent);
>>
>> =C2=A0=C2=A0=C2=A0 return 0;
>> }

That's a fair point, Steve. Given that brace_index isn't touched elsewhere =
and the current check effectively prevents the overflow, I agree this isn't=
 strictly necessary. I'll drop this patch and stick with the fix for the of=
f-by-one reporting error instead. Thanks for the feedback!
