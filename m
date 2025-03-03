Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264DA381A3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016089; cv=none; b=oPPrihPG2d0/Lzhitmgg+doi9SitpJInojVEnqa4LTQinpe5ZRPpSLLh/fniY8ykOtYWicNrt8F5GcL1J09MEpU1xPYnirLiwMNIijLgu/WzVkl72EKqWCphXuWQp/nZWmcYbFFS+jFkDL36Ga8XmN8gkwbC2e5VhPgMn4XQ+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016089; c=relaxed/simple;
	bh=Ca2qBuXoBttJq4mL06NxtHHTUr9UHSwapOZGMTJpNFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g81NSHWLRmmd/0kJiOeMhZSzJdLMlN83lNPzuyjVVMzGhUKy9P25XB0iXshJmM/V3xr29gKn0R/gl4rnpZ4YC/Td4YzFvCFM1iftSFJTvInT4v0yU2+W6gLvA/1WjAdDU14vX0Hni98g4wWcLGhN86XwEFQqKcZnpvGmku0cj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q86B+k2h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q86B+k2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741016087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ca2qBuXoBttJq4mL06NxtHHTUr9UHSwapOZGMTJpNFs=;
	b=Q86B+k2heFoIOZpIEe2znaKwE55k95oOo25oUNM5fF0NIygi28a634Jh7Dl7Fua7jD2wgO
	YMIASB8q0/lwQijJpR1h65tQ3Wa7I9cCmLjMVdGDHMkMt/qHXLCU8P7Kw7v4bxVzFnqcSX
	RcluL3jnOSTl07dv/JkCqjyiLfS37tA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-W6z6p4fVPGqWdYqKiaJbAQ-1; Mon, 03 Mar 2025 10:34:33 -0500
X-MC-Unique: W6z6p4fVPGqWdYqKiaJbAQ-1
X-Mimecast-MFC-AGG-ID: W6z6p4fVPGqWdYqKiaJbAQ_1741016073
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf75d77447so152067066b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016072; x=1741620872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca2qBuXoBttJq4mL06NxtHHTUr9UHSwapOZGMTJpNFs=;
        b=V0r1Gln0NjvHVfiy1c9ukcp5dyTFIC5G5+E3cUwO4+1O3Y4NfZHVvykmIFpMfr8V9l
         2Uqi6EZ3gThDpQYq6okkWU1S6iTV8dW7pnYHDOvX9T5itW81f0yHpFN2zgbG5ZRXNYvp
         vRekkc5l6MkeLhWKXAdivRAD8D6Xy4XYmZwdTB4HEvW+KieOzr9WJQ9VWNqOag9bsPSV
         XfkIJ8efABps0U/lBgrqAevlmqC+6CXvskzNkH2orRmbmAjTKdzJ36HTMf1ZiSiHRjVL
         hU+0TMlrbi1BPeUmVKEaSf9LMsdXY34GzxrJZDB7aPiwp1xwD+TvcJnmElzf8QO7b54Q
         eO7A==
X-Forwarded-Encrypted: i=1; AJvYcCW2iRAdzEwLe24/cwxkdcI9pOR8BP2w6pyAXW+roOBLbJHKuCEhh218a10OxkmKdwGw5TV+7NoSMe8y9tCM9dqp2ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCjiiSE1H40dQasI/Z7WV0M+5Rtab/1w6PenPk0nK/uczPKkT
	Hbgd8NVhKkcAFosqf/NtUbJ9g+vhMYsTmS4b0nQZ07jN+N/dLeJMmXFIBqPryVm+JuUMjwBjJYH
	bRKyhvcmC4JERLDpbd+lgkrllhe80EyPr+SFSnC8Q03uhqpXEQPhqBSlWF7wcPL/d4usse8eIas
	jk0J79RtszhABHX+k9sVy9U6FxRbp1GEX/SMvMsR3cSo2e
X-Gm-Gg: ASbGncvOstwncEIT6bdU8pRwgsvyovaaGzpilD8+Erx9L8R2PcGK+D74yvHijyWl1Gp
	CthBxYvsKHLz0jTE6VD19yZ/YQ0sR6yqBpQmWAMYZvGDv9YC063DuMqdGprcdCyEmmTDT84KtrV
	gZXYssC4V4skrwBIsHWfamGxkwpE0=
X-Received: by 2002:a17:907:9815:b0:abf:529f:eedc with SMTP id a640c23a62f3a-abf52a13846mr1007386066b.17.1741016072667;
        Mon, 03 Mar 2025 07:34:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAPhCygFos26ctd560TT1gMWRr3/Uab+HZgsRTIPBxptaGMGDWgtA55byUAFQxa/MLgbkRkUa6mNfpUo1buDo=
X-Received: by 2002:a17:907:9815:b0:abf:529f:eedc with SMTP id
 a640c23a62f3a-abf52a13846mr1007384166b.17.1741016072362; Mon, 03 Mar 2025
 07:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com> <20250227200623.60f20571@gandalf.local.home>
In-Reply-To: <20250227200623.60f20571@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 3 Mar 2025 16:34:21 +0100
X-Gm-Features: AQ5f1JokxHLLpaJHRnPBCkMVVdRSxJZSq3sfwROW0wf1tH0Av2oob8BpykFjucM
Message-ID: <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ygn-l0IhvWp3ipY2-XG9w5l2mjALpL7NqzgmOFEwvbo_1741016073
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 28. 2. 2025 v 2:05 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> Without tracing being off, this can run forever if the events come in
> faster than it can be recorded. And save trace uses the "trace" file, whi=
ch
> is slow to read.
>
> Are you sure you want that?
>

Isn't that a different problem though? As far as I'm aware, it
shouldn't matter at all whether tracing is stopped on the main
instance for collecting the trace from the record instance.

If the record instance generates a lot of samples, this can already
run forever, regardless of whether tracing is stopped on the main
instance or not. This should be a separate fix.

Tomas

