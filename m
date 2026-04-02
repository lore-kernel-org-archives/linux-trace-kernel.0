Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143131A01BE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775094858; cv=pass; b=tzqazhXUEU7Tzd+QzsyL1cI2txe+x1OdukNIBquIUcpjiSFJ+elpgUYiy/Fit9xnlpJ4qP3Y+GSVeUHVIDP2zBRkGtZxDGMlJ4cNpEjPH/SHV5FkVhharyKw/WQIy4n8YmoWqWawVZbnF+XRfKY5qWEKXF7AfW+ynIZuA9QbPMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775094858; c=relaxed/simple;
	bh=ZgdAy4qNSHyKJtotTutzlKM7jv1dqpgGb4Vak3LPpxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTnfwG9cOA8G//WTZlu/CS95r9uQedOFNE/G6/hL2rghugvS3K4cZHOH4bP/DkdKFtBA0WVLiVAWk34TefUnrvnqFA6SKYjHgCiow1Jcudr0kD+Gsi7IhmK9+p6PrQVRdppp3+SicHrgXJmlmQZ+h1daCrHhk9rZRUmg3p6HbvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ww7PwDxv; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ww7PwDxv"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64937edbc9eso361518d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 18:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775094855; cv=none;
        d=google.com; s=arc-20240605;
        b=e/1JqlPOyYUYFdniJancDeLJw7EAZJWQUHjkNEQnzYVWH84az5xg3CTr4xQ8UL0x3E
         OGMv6in7nXIdf/p+lrpRF/6tm/7B+GI6fjNqsdQU4IEWkhAw5e84wWMCsEtpHoZON3iM
         OR8ueS0TxPP+Q9mDQ5BQTA2EuJRjgjXHj5vqe6xHmjnAC/AXejoULfJQ6ToXmFky/F5U
         S8ZAxqyoCdnhIvIUhLz/w1anZetyia+dvreDpUMIBnyUh4DnDO12yDath06xhje66yW+
         H08cHkxAy2azNZHrhoN7IN2wS1bqNP5YHl4mpwckof4qL6HiWxL3K9SYLPHv2mVGgGb6
         e0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kiceuLyx91rPyzndVsPjUqGeAIHXDkrelSUnbkKBTJU=;
        fh=Q8jqETUkYQGIxOq8S6pkFcwrHp1cs5WK4/aQTGyPZJ8=;
        b=BNGbHIbMO2ciL0lK+rKSsSdpVVwU0nWvkuU7JHAY6iS+ZCgQ3D8PVXdNWaAl7lupCZ
         LCHmHriInuQqQBXj2InGwJH8+hOlRLk4hukNRfaNWyOuD9NdrLURqywy6kMN69Fy9MhA
         QkQ2X9FrNBNDtevsljsuzizDxhQJAqn8H4d6uH900hGyjsnvO0QcXuAsQwLJoyX0knJD
         w5ZRvFINsnjgzPslizKmDWIGFLin5Ko9HLNU9ZUC2Zd3bOSBDgkms94GTOYeBid+Q3fy
         psHaJ+kBx0C3aLv4sGkRzu705lQfvWE6A0Qq34s2OgfbbUsM1PXsK95bScUbCWVRZ+wP
         bv0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775094855; x=1775699655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiceuLyx91rPyzndVsPjUqGeAIHXDkrelSUnbkKBTJU=;
        b=Ww7PwDxv5MVp3tsNlTeE3CT0Oz5MhiebXjUc4q6rFMf/GmFYPBDczuil0bH3TBySVW
         cQ7fkOrw3Fs2HWzDJLfsnjY/hZHPdGI6yfTW7uszLmZv0eLNZdu2a/xGZzT5b/Uebxp/
         Dl/sKqbTT84G8zvSDyy7UpAWWhRqTBa6rXzvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775094855; x=1775699655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiceuLyx91rPyzndVsPjUqGeAIHXDkrelSUnbkKBTJU=;
        b=VU1f9ANWy2LujaSfBcaGK9BS+737YODkePXt+abknofm8w52wvFZODYX2fwG0SPHMh
         tWUUN6ZNOMkHGhobHXrHMVKBA+T/yemjCa372GG1GBJwYGd4fPGBFD6SbK2l26A8eDBP
         z4lGTB2r6rXtOh2MqbVcYtAnD4ettHMiLqnLBx2WTWAcOmg4DqVjXAL6QJw4ddXzaDVX
         CcyfShvV4sGHfVrf6Vx11gcUB8StGTRKxtoYHhRi2Ni1AhQsKAiZNOABurKiJPeJuoP4
         uhuDEzs/zE7j0nsEYqY3Xq/8bol2H3Do2mXxYcV102Iqsb+xU7JQB+cKKG1nmKr54vMI
         2rHA==
X-Forwarded-Encrypted: i=1; AJvYcCW1b+T0W0m0SqUCFAKb1vKIKLdOj7g3JHLKeL9e3jsxAuGGriyG1DRSB+bTsJUwoUik0Q4QjHRgsz/qPeilBFqit6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5A7wvUGMRUwxPVcMZjJ8hA+/KUHuVNdBc+7c8hGAA5MjhH0H
	6M1WobfcV+1LGxi8FhaiNxlMHRZf/EqJQv0JZSY3S9ayDM96OjE8SKxbmIMeMeqlcftafsgNCdH
	kMQfibDY1tU2f+LF+s3j+oJJsW9N3s72iNUxj59r0
X-Gm-Gg: AeBDiesJMOpH8OA3s3tnDyKk0U3EZ+2IxOtFearRsqcwyUw15hMRidsYwKqD/BAct1l
	CF+uZ90Wh0CZzasaqo5mqp/vC3GbkwK06rlkRSwjY8zrsV4tiVvzUPxCH8G+kLwqulE0eiCW/nQ
	CEuqA/of2wkujqHB2h+TY64CnAXYKiAeSdOg9WpuFaCXXl7FWo7zb+1q5pqe/52ShyJ1OL/OEoF
	KywR/Xdwl3kkfjnAONlsZoMUuk+ZfYjs6Qc3HoZIiESKNLNY3De1A04CDsQqLceW+W0/D8Ihjjm
	rdTy7jTRohQyMWqb9vwehnbp7vGc0cRTiPMna8YOzg==
X-Received: by 2002:a53:df45:0:b0:64e:abca:564a with SMTP id
 956f58d0204a3-6502fdd0ac9mr5063421d50.22.1775094855220; Wed, 01 Apr 2026
 18:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org> <20260325-naughty-hungry-wapiti-658e83@quoll>
In-Reply-To: <20260325-naughty-hungry-wapiti-658e83@quoll>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 1 Apr 2026 18:54:03 -0700
X-Gm-Features: AQROBzDfrwBIaLEV9wnEuLry8lUVCQVrP4uxpF2MQpcY1Q98CokyJ5Vf0yATg4k
Message-ID: <CAEe3GZFWiUG5ET2oQ42+KvO-TMy2Eq02tR0UMaTbACJ0=V8D0A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Add spi-hid transport driver
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
	Jarrett Schultz <jaschultz@microsoft.com>, Dmitry Antipov <dmanti@microsoft.com>, 
	Angela Czubak <acz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 1:49=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Mar 24, 2026 at 06:39:33AM +0000, Jingyuan Liang wrote:
> > This series picks up the spi-hid driver work originally started by
> > Microsoft. The patch breakdown has been modified and the implementation
> > has been refactored to address upstream feedback and testing issues. We
> > are submitting this as a new series while keeping the original sign-off
> > chain to reflect the history.
> >
> > Same as the original series, there is a change to HID documentation, so=
me
> > HID core changes to support a SPI device, the SPI HID transport driver,
> > and HID over SPI Device Tree binding. We have added the HID over SPI AC=
PI
> > support, power management, panel follower, and quirks for Ilitek touch
> > controllers.
> >
> > Original authors: Jarrett Schultz <jaschultz@microsoft.com>,
> >                 Dmitry Antipov <dmanti@microsoft.com>
> > Link: https://lore.kernel.org/r/86b63b7b-afda-d7f4-7bfa-175085d5a8ef@gm=
ail.com
> >
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > ---
> > Changes in v2:
> > - Fix style problems and remove unnecessary fields from the DT binding =
file
>
> Style and removal? So other comments were skipped?
>
> Please write detailed changelogs, otherwise it feels you just ignore
> parts of the feedback.
>
> Best regards,
> Krzysztof
>

Comments are either resolved or awaiting further confirmation. I will
add more details
to v2 changelog in v3.
