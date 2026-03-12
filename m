Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B0385508
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349436; cv=none; b=KfjpZt041ZphE6dLp866xNSKiotvKMCQ4wEGZl5AugwNev44N5GbwpgJNBIDOa3AFI+v581i15sSlSCi4W1pTXxWaBMmoUKMfGBV++mYIcNW9tCbjLYwCevuFmaSYGXPFZlVZU8I56suqUnb0+IfU8dB+EHZXBgEE4xE0sR7cLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349436; c=relaxed/simple;
	bh=Ah4cAU/rsZ89pM1crolpyoa+Kaozqik3Sw2x/N9VOoc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OY8spWXXsZaFKQMIjae9SxfPGjzFV/Bk7Zn+sJOPqAtVo1lrWa0t/7D4dcII4OJx7WRk2MqBMg4wBJU9IqOky7OYbxlDdDzIb8ygpQloey/sf9RSK5lMU2eMJAXI4P7Cbccve42cCYrnwUtZuoB2bovTCMiPIEuQZ21Aq/UCM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKOjBAmC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKOjBAmC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a8482fcso11636585e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 14:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349432; x=1773954232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah4cAU/rsZ89pM1crolpyoa+Kaozqik3Sw2x/N9VOoc=;
        b=KKOjBAmCkfg1GWYM9WSqzUsvo24aSwt9DNSUtf4/upuJx1RrAV0z5VhiZVKaC4uXoA
         zVSLIVQKqw16zInGyaEoOq5/25U6EjPSe2APUMpIfMU+wLAa+Cy1F21YmYppDl/1MVZt
         Oi6I3Sad5kaACGVP1KLVHJnolZToAWrNNprVFx3mQA2Y3+YyojKrFcVMAjq/wsoDAOck
         j0nuslLWEy7RfcC8m6P6tBePOW73Z6VOMM0aFrOkv2Ahb7RvUIJm++cwwVPyTqbhjmHa
         /HuNmrvDEsuEmjFVFIPxMgJhJKGnuLNTv4gKb6+4ADMZ4hRjkd7n9PXa/Z4/omWhQmVh
         y2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349432; x=1773954232;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ah4cAU/rsZ89pM1crolpyoa+Kaozqik3Sw2x/N9VOoc=;
        b=FPshx1hIdOpu25umykw9IevWk8/y6H+Zmc8Ertan7HDN58DAHBzMzZ9O1J5ig/7/HY
         Y/lyiETVpjpZ5PSHzxl9HENZWpjy4sdbc9m4EYhy7xopPbRV4HEBVjwSRmNbB69fiFAu
         +H2pJ26kzP26Cfeyx6PynpYhbeks8uAcBD7XjFZmRvvHCS8oV0/fzPuLKw85c/Nvj/yi
         LTYIb0X1agPQW4L1aR9IUsdZvIYSy6RWvWoppE97+/Yth0h7f0x10VEgk1eaFOhnr9OY
         8cI1TCjoG6ERL1w43+K5Ims1PKfYFCu4zMmthn/VpzIHmEu8vKX0QzSWfI8OCNp6hn4Z
         x72w==
X-Forwarded-Encrypted: i=1; AJvYcCVLx4avQ7kilJC/9KOA1OhfZEb2b33s9bxluGPt0f+vIThZH1/d9BsvZljc6MahR/dZi2UytfMnWjiJ0Dof/lr7lH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2AWL3e65gvV71Et/HuRXYpnQZvnltLMX64WDnEpA5EWyRoNo3
	s9CMNRfCu8a8QYXYDPzOSIEga2rG+F9eBXrlA4Va8PbxyA4u5u2PVAka
X-Gm-Gg: ATEYQzze6RBXcCQBhUEU5WI2GAKsdperzknlwTaU625N1XF3w/qwhr4CxRR8AEmgFBW
	l3QDbgCB1MKVuY4XCDWkoBDJhh1+b8oPf34PMqTrKZdKcIij0N6aJ2NYOkqAyaQPDk6no2bqBnP
	PScW0wdbunOKYVLEBkTlrtAwBtMjjPHHpuI403JoMye64+s8PvLB6RKWAWJB6HH0XsGMvlyWhyB
	HYUohQPRCEqRaxnVTZuYJWsm0zQeybnn/PMroaz4zDa9XJijelNRuuFpW8andQnhkdq3DVlGJ62
	/WXZRF9T6hKFQz1p1cgCJXNXcN3N/uAm2mdAFwtlWdVqvqjiSDnhjvWueNhqIIgnzVIcUIGENMR
	tvpdlgxpGLp8Hmhh7krjy7PPjdt+RZNeoiDmMGFsmjFbI/DVAHfdz3+NxLt8umviiR5n/6k0Nud
	diHYjkUW+spGSVyNgz
X-Received: by 2002:a05:600c:c4ac:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-4855670e7c6mr11729765e9.31.1773349431770;
        Thu, 12 Mar 2026 14:03:51 -0700 (PDT)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66ffe2sm146061635e9.13.2026.03.12.14.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 14:03:51 -0700 (PDT)
Date: Thu, 12 Mar 2026 21:03:52 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Law <objecting@objecting.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Message-ID: <48aee348-5859-4d13-aa88-d0c21a4c0289@gmail.com>
In-Reply-To: <20260312170303.61c1233c@gandalf.local.home>
References: <20260312191143.28719-1-objecting@objecting.org> <20260312191143.28719-2-objecting@objecting.org> <20260312170303.61c1233c@gandalf.local.home>
Subject: Re: [PATCH v2 1/3] lib/bootconfig: fix off-by-one in
 xbc_verify_tree() unclosed brace error
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <48aee348-5859-4d13-aa88-d0c21a4c0289@gmail.com>

12 Mar 2026 21:02:51 Steven Rostedt <rostedt@goodmis.org>:

> On Thu, 12 Mar 2026 19:11:41 +0000
> Josh Law <hlcj1234567@gmail.com> wrote:
>
>> From: Josh Law <objecting@objecting.org>
>>
>> __xbc_open_brace() pushes entries with post-increment
>> (open_brace[brace_index++]), so brace_index always points one past
>> the last valid entry.=C2=A0 xbc_verify_tree() reads open_brace[brace_ind=
ex]
>> to report which brace is unclosed, but this is one past the last
>> pushed entry and contains stale/zero data, causing the error message
>> to reference the wrong node.
>>
>> Use open_brace[brace_index - 1] to correctly identify the unclosed
>> brace.=C2=A0 brace_index is known to be > 0 here since we are inside the
>> if (brace_index) guard.
>>
>> Signed-off-by: Josh Law <objecting@objecting.org>
>
> Nice catch. May I ask how you found this.
>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> -- Steve
>
>> ---
>> lib/bootconfig.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
>> index 2bcd5c2aa87e..a1e6a2e14b01 100644
>> --- a/lib/bootconfig.c
>> +++ b/lib/bootconfig.c
>> @@ -802,7 +802,7 @@ static int __init xbc_verify_tree(void)
>>
>> =C2=A0=C2=A0=C2=A0 /* Brace closing */
>> =C2=A0=C2=A0=C2=A0 if (brace_index) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n =3D &xbc_nodes[open_brace[brace_=
index]];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n =3D &xbc_nodes[open_brace[brace_=
index - 1]];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return xbc_parse_error("Brace=
 is not closed",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xbc_node_get_data(n));
>> =C2=A0=C2=A0=C2=A0 }

Hi Steve,
Thanks for the review!
I found this while doing a manual audit of the bootconfig parser's error ha=
ndling. I noticed that the post-increment in __xbc_open_brace() didn't seem=
 to align with how xbc_verify_tree() was accessing the index. I verified it=
 by intentionally passing a malformed config with an unclosed brace and saw=
 it reporting a 'stale' or incorrect node location
