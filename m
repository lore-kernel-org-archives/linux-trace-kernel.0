Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63559154BF5
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Dec 2025 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765176890; cv=none; b=gvG9lfKIpm3tnp+3ETFFUU58oUg1z5Wkb7a2CvtfwIfKIloCIE3QbzIEuc08+40bQ+VilZPsG09Aq01dZxXOV4B0s20Y8wqwXgDy0H1KrvGH7H/naE/RvDoUsdXgbKcBsaWilYl1aQPSdplVq+6TOnF7PH3izs/34vnm7GoE/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765176890; c=relaxed/simple;
	bh=fT4xrR7XveYD7319xDdVcz2P85NNBqNplk/FvvOxokY=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OwXl0rP808NwOyksvXlb1In8jYcV9GOhyvPveJJsCX0wkBeKB2jfBTo6+23qeN8CmjeCwtTQ/FevgN1D7rwGSTTPmZea8dUF2wmlDcqJklc8ZXGnC6xSnsyHM41jwdDGIY+jigTCIu/DCwtkVLv+jIRD9nET9xR04scDn0GkMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJsb4ud+; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJsb4ud+"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-298250d7769so33603905ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 07 Dec 2025 22:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765176889; x=1765781689; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g85CXXEGMAoaN9uLOHfz6U4w4WdkMrQ+cbR5swbIZy8=;
        b=QJsb4ud+MRPt8knvJ/qAVIsVc1P4KjylHNQKIUHqhSqwVRltZCFX9fjG9IXz2SUJ65
         ni+/nGPVFKthF98mLZqd4Vs5uBswOhtFEY4V6RmXD9m2UeYuG01N8bwn/NT4N5jRmQa7
         uJY1e76JlVCi+Nhgmaoz8Oe4CDkPfyAGlLBnSFDVRJCxKGT54NqraBa0UxDQ84TCnQ1h
         qUz+ojYSci3+27Exewh3qY5RiAMlQ3XJx5aIMlNsBcMGcXk9WT6OtFpId3Hadrs6Lxj0
         wiVYP/+x6LBxaJG1FUSN14VdcbqlGx4cJS8fjkx7bHpx4TYZ2q+yMpOiL6/b8xYRNV/O
         t7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765176889; x=1765781689;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g85CXXEGMAoaN9uLOHfz6U4w4WdkMrQ+cbR5swbIZy8=;
        b=nGLxqk5SgeUjpzo/ppXbDfLRimAj97IlJ9MfdvbIxi7V9iPLeyQm8btY4COE98Vcxi
         94UH+oxrEnkNpXqrcDVRRpW71B1xOoY1TQqy/iy7Gsqs6ML7yARyS1mse8ExzbuqwRWC
         4iwustT77JdGdYH82+hfZADZTWbyR6UI+UEymCuOoQRwfzC1TamXw6OsWR+PzEoNo/Vu
         uiMCangcVv9HdNWyskxRaffbdPB/ji10CBj7YBcoRuGRc/f07P3XV31EC31/KVyW5ahb
         Hdw7C6T3yOICG1oNBwwlCN4hkH5q85ZUxgpIbMZwNTiN7AYJXnBtzJQTOHV0z7GFvs4M
         r9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRs31xRKI2sY+j4uffg0mYAqp2qReq7DbYc9ULi7w+Qm7WkA+x3a+w76xD/vjcMDdDFAGmMXTUDWajJt0T2NLCOWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TI6W93iAQnFC2mXYlUh18DiDQK2ZvUQHwk9y8GMDX+Rswp0c
	vh1xZ+Ocm+LzUMOWm/hnOmVZqU+ZmF6lcZaToBerVuQ0aQWCW0s3cD+m
X-Gm-Gg: ASbGnct2eg3OLcmzlEn0900vXHxsmfL/nOQbmXT1TFRM3zcyY7PvXxHa80schVNmD2l
	bW/z+WM7bdmYk4UpvA9HAXolH6Joc4jGq8rg21UfvM2Bppuz6tbpOntrpTh6dF5Y7YhVARUvnkY
	DPAM7xg7azBMJz+KnidzujghqYBa5oEnFKgDAELXfqmjx/W2uG2Y5q6e03rSuWBPI2lGktNV+ez
	1JE4EEhNSxnn0eTT5Q112MyyuGExVOF+D7t/RsWYTSMlDYR4G8a17dLJCQp2Ir9+80E7eB+jQiV
	IiAbmSKZRdLzbZvldIzd3zPtx3js1AAc0QluAVBUoFG60VIb54xa900trq/6xVNm0g61+Ar2pMh
	2GmP4NqJ/e+BGhpv8ffLhznIqzhuLe8o/KBs4geO1uhNsOTk88p2d4AhvspRLvovRHxc953O1r3
	w66Vw1wb3Rw31Ap8891x2PhY8sOno0o2Eevw3sSDVi
X-Google-Smtp-Source: AGHT+IFbXqSGzBOjNEpd59Js9J3ubvKt37yvs9+Wqh428XujcycFZvOBZi0V5wE+RT3M4/hG9EKXBg==
X-Received: by 2002:a17:903:1b03:b0:294:f6b4:9a42 with SMTP id d9443c01a7336-29df557225cmr53663055ad.9.1765176888666;
        Sun, 07 Dec 2025 22:54:48 -0800 (PST)
Received: from smtpclient.apple ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6e95sm116181635ad.95.2025.12.07.22.54.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Dec 2025 22:54:48 -0800 (PST)
From: qingwei hu <huqingwei.kernel@gmail.com>
X-Google-Original-From: qingwei hu <qingwei.hu@bytedance.com>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH] kprobes: Call check_ftrace_location() on
 CONFIG_KPROBES_ON_FTRACE
In-Reply-To: <20251205100823.28aa8ffd@gandalf.local.home>
Date: Mon, 8 Dec 2025 14:54:33 +0800
Cc: davem@davemloft.net,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org,
 naveen@kernel.org,
 qingwei.hu@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E248E7C-773B-4998-B059-A576163B36B0@bytedance.com>
References: <20251205092933.3889547-1-qingwei.hu@bytedance.com>
 <20251205100823.28aa8ffd@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3864.200.81.1.6)



> 2025=E5=B9=B412=E6=9C=885=E6=97=A5 23:08=EF=BC=8CSteven Rostedt =
<rostedt@goodmis.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri,  5 Dec 2025 17:29:33 +0800
> "qingwei.hu" <qingwei.hu@bytedance.com> wrote:
>=20
>> From: Qingwei Hu <qingwei.hu@bytedance.com>
>>=20
>> There is a possible configuration dependency:
>>=20
>>  KPROBES_ON_FTRACE [=3Dn]
>>       ^----- KPROBES [=3Dy]
>>         |--- HAVE_KPROBES_ON_FTRACE [=3Dn]
>>         |--- DYNAMIC_FTRACE_WITH_REGS [=3Dn]
>>                ^----- FTRACE [=3Dy]
>>                  |--- DYNAMIC_FTRACE [=3Dy]
>>                  |--- HAVE_DYNAMIC_FTRACE_WITH_REGS [=3Dn]
>>=20
>> With DYNAMIC_FTRACE=3Dy, ftrace_location() is meaningful and may
>> return the same address as the probe target.
>>=20
>> However, when KPROBES_ON_FTRACE=3Dn, the current implementation
>> returns -EINVAL after calling check_ftrace_location(), causing
>> the validation to fail.
>=20
> This is a feature not a bug.
>=20
> The reason is if you put a kprobe on a ftrace location, it can cause =
ftrace
> to trigger a bug, as kprobes will modify the location and ftrace will =
see
> something it doesn't expect and think the system is corrupted. We =
don't want
> that either.
>=20
> If you say "KPROBES_ON_FTRACE=3Dn" and place a kprobe on a location =
that is
> controlled by ftrace, it had better fail!
>=20
> NAK
>=20
> -- Steve

Thanks for your clear explanation. I will look into other approaches
that work with this configuration.

