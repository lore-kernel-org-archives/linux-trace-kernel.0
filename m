Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D854A7D5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930515; cv=pass; b=Z5WqWWe7EoZnLQlM5/q19TLlzFoqXHI6SDnQkCPMg+bq3Po4TyLZzcPfbNTOg7XtSVWdjhqrMv4pb+Ryc0CGxyo5jxFe7WEEzlZ++B7rTu7ccQNR3ZZAblGc6dL/c0X8aGIXnGn8IC0zK6fwlQ/2xiqGhkMRuYe6ndVeatxcVSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930515; c=relaxed/simple;
	bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m56UuqV7VqOc09VRBINs2oJ1OE4umlS6qAybA7dMk5KdQ4GzloT+H3foePKlgH71S/x9Cs0Op7Z7CSRmilo7n/m1ygFTwZy937soJoIhklPRPQS88GiSLX1lSrj14igxjwV2X/5tIkW3dvSCyfMrDn6jqLI94dDs9ChgTGFH0qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DUSXHq6a; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUSXHq6a"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8a83d2706fdso4436537b3.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 15:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791930513; cv=none;
        d=google.com; s=arc-20260327;
        b=RrOq0N+W6hPoQWWCb2DZ19V3HmSl0VOzZfQjKOibusZItRYWVhgK12LCbywFRGr8GU
         QcYL8NQSv6TferMmBQ8oq8+o6QCkjZjobXdR6bbSDUdGhzpYH+IIY19PpwCmXJLVPHVF
         Vo//XrF7okJCjLIEQ29iktET/foEVuFHQshRbnfzbiSBmxxA3MxG8imHxuTGTKkkih67
         UEihT8vj4ZNZCxFLmMGxlmmGoQN+cD9CpLIoX4z3zGZ6U1CS+9DkfRLLcS7RDCAGimat
         /Znq4xLykSpHTzI8FmrKqFjnUqUyq5U/bFX3JyG4bFap+EIv5cWxpan7Jiva4jNohJ3Y
         KXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
        fh=J5Hbwt7XYYvgRdnHB7oC3AZVlB7IUzxz1TfY8onmMbE=;
        b=KBNIHGN7EMjSJbKcPWzM0g52pRTrw8aPKKVFuzIhTv8DYfsBj4bz9MBnucMRpblbiL
         BN8coclrrWUq+aJRCnXKf2czcvjQSV2zSlewUcUOFIPC9wlQOHhgUIynWaCYItLjnGA/
         maIx11AjSzMsmUKoJlrhY4w2KqNwypRh7MjRcf9mZMTgG3Ulflc26OKiN7j4T4BWe+SN
         thItt093ZQTWScHpUXo8cxY9Tz7eDBuxKrzHTS08x2pw38CkSew/A+23PW8oUIFCyNg2
         w/u3TQRKZTX+gVpZYxOJQMdPF5jCHAERptujFswlQvK1nsz5CoXqRmXYRaREUFRAYYcd
         pVjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791930513; x=1792535313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
        b=DUSXHq6awOXCzmeM9lLEMtkMS1ys4ectWQNADf/Wr89M6R/5Ao9JRiZUqGyXDjy5T2
         JOT088ik4rp9/uXTDrLqf6AkzM5NhYBRpFSq6CIRt5rO/4hPnJUQfk3MHN3eJIe9KuAR
         U8PSiCTpeTfIdCGG8YfydaxD3paJQX36Q3vqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930513; x=1792535313;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
        b=e/TwxTS3Qw8naNlXWjhhPwrICEOf2EBmI86pOQwXhpOnT+Q+OzQF7wRD7E/0M4WATQ
         2sRlzrMkes1RCqm+/rcy18kwv9Iz5xEi26OFkErFd4/tgtzaq5YViNwSzWFY7iq08IYH
         2yUrCDVu7Iiky5tgEyGsVmeJ/+D16xwKcMwh7jqjPZNu7Qn0Rmd8gUCnLyB/jCNP48dj
         0LVr8CT8VTYFFFJF9nouwG42TeRjg4dITbpq+0qvpNWn9Ir/elvz5GXDRsqjGzp6jrW9
         jtOQBQwhjDHUNzdd0vCnB4ByplvDLc3V9YtbqRbNSE9Bd7lVbokWBnNvrmmzcNUiZ0q7
         cI6w==
X-Forwarded-Encrypted: i=1; AKwUvBwNWgGDRCVJ9x4xJpm7dYVGTp/vi2uQXsW4gcQABQ9xgwcg7JjrGtIuQd8Y0vC+xLnkNhybHXToGg8p9QVP3XOfIQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeCrCOQJsBqXMa523l9afep1FV/FOZNN9LpQ8xrOa0w1SuVuSH
	mNHA5WeZjp8bC35s0/6E1p9WUX1jqA+f0eh7GTd8kDf2L4eAk/e/3AJT84C9AKO/dLr93eNS6fV
	aU1FefFDZmSSrlsycgAj5m84TVdu1WVKL2IzF1vOR
X-Gm-Gg: AYBFou3giktqi8+lDXs4TFUJPCfZD9hQxWjAn6Za73V3AuuFgZQj4x4UhZDKEPV1zbZ
	OOFi45GmDkicGONspmpaWNF1xjetbAcPcg+h8LdFxvpwDt1btWEIIiSFsLqTzc2IhJKkFKXGr+I
	lPrmP7cTrjBuiXXqNzY53BrW+vCJDjuUpMMraf9YE5ZZ/OMlEWVTSJ6Vf0KzxYiWd2vKGo34weo
	oja5ClIONXi6vg6M4OQQeIQRtrTX4dCFMg4Eyw39Kil3PfQD99aljy1hgTGqsU4SOrhGPEqGWrp
	SixBwwf7cj/XUBypsWs9GwK1eLwEe6vb1MYu772Lo21I5C+bGTkFQNtnBkPBOBcuUeRyaDo0jOF
	Bf43MxPbBRmekh1eu6kLz
X-Received: by 2002:a05:690c:6603:b0:8a5:1570:a298 with SMTP id
 00721157ae682-8b07edfeff1mr40474577b3.50.1791930513249; Tue, 13 Oct 2026
 15:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-9-384af01da3ee@chromium.org> <998a8c7b-82e3-4370-b0f4-765deccdb348@kernel.org>
In-Reply-To: <998a8c7b-82e3-4370-b0f4-765deccdb348@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:28:22 -0700
X-Gm-Features: AclHuK9UE5fFXMlu7KAnmwYM6JrldO8UdUyYtEVe8VXlPWtvlfdV-v2OaGNZ5vI
Message-ID: <CAEe3GZEuB+i2XS-GnGsmHaaULzThPL2wKT4j6QdMYbCCz47q8w@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] dt-bindings: input: Document hid-over-spi DT schema
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
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Dmitry Antipov <dmanti@microsoft.com>, 
	Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 11:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 10/10/2026 00:25, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> >
> > The properties are common to HID over SPI.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Tested-by: Dale Whinham <daleyo@gmail.com>
>
> No, fake test.

Will drop the tested-by tag in v6, thanks.

>
> Best regards,
> Krzysztof
