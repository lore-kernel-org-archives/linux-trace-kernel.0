Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E270246A2D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931728; cv=none; b=JeLbR8EWjz15yP8+JR0WNXqxnKe9bB7TBXjGwu8JBZeEOwi1opiVEt6C/qNcnlT8LDek4P9Gcvq6rAHHvGhqbE3Nsbmm0DT7wnQP9R/NJ7sAgKDqkTFbeelCF/+vi/xoSnpgzCO02TQjSOfdG647kjfM3nWTt2pKEWnE6/XYHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931728; c=relaxed/simple;
	bh=hwi2zCPDCBAEE3NRQVgUJNWTcABgkhV/xlx8OBAUBxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMx8Wk/hZCZdkj9OnY4BDLgdBUD8W3f0WFonh6JQiMLwTIpC7fPkoITIjIOeyKU2+s/EDratp1Pw0lK3upmfCSiMnobIlXwzZr9RJCzaQlK6S3BA+64I9cT9wPwwIjq9qngGBqrm4m9rsGhRm4nok0disXUPn+or26t4QEoq/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TwU/NuG3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwU/NuG3"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so12818042a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 01:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736931725; x=1737536525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/IqV5HMf2LJ1m+KlJasEf4xUZjqCRJ6n2XncWlOs+Y=;
        b=TwU/NuG3AeXY8gUIKVvloOeWqvRFBmR0/TxJEy1XMRofVmYTY3OVeeb8TJE4luSONn
         IEAFD92W8hes6ZTV+Q2XhWMN89uXMhifnZjQ8Dhv0mpwQtRBbMPIIOLlZc3kwxTG+EHM
         4HKghfcEaQ1iDE7laZoSqiqv3V0x7/56EoeMB+7XWmZgQ3GMBy4N2++hrQY0oZrD+mJ4
         N6eORiMsUlpBsOz3m5Bjv8iIV6rHRjeQ5FiscipS01H+mAWVLsid+8PkXB71OI1H0FMe
         vr7qs/X+PCz3TaIrBoBWLQJORtBm6c3yv/hBMMojF5ksJdVhvA1t5+0jYZu5WqggZQgE
         xkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736931725; x=1737536525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/IqV5HMf2LJ1m+KlJasEf4xUZjqCRJ6n2XncWlOs+Y=;
        b=s6AQ9ZaKwfWHXehXjPnRzZ8EMNfA+KSDRfQr07k2ENdsIp33CBKe/7tC8Jtk8keraJ
         ffNf4l84DNye0ZZjiCZ+56wMRoCuCXEZHCpLDHgniE1xcmG8T4L6879Xh0dGTReF9zWu
         eirmqxqUyoc2ttpB059quE/9GxK/Y4DD+Gqtu2j618xJt8DOeoYi+nL7TuEzprvjJn/u
         VPvkOiC43VfBAZCD/CwReRioFj3DYnS5b90jsX7qY8Y7M72hn7364ND2AW5i3ZdrHTlf
         5ob1tl3vGniLyT1edd8YNbC+AeJhGewnZC5mKb8mcjK8W2azh73yRM/s3L0C5jCXhKl0
         XuQg==
X-Forwarded-Encrypted: i=1; AJvYcCUncbnK0sHEFK+7/FjDlWYOb4zFv6/RX1EgB7/kmYTvY8vj/aJbxUQ8q+e6+ItTIPdRdRDPpJAjgOqjhwY4tJZJxwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjJHrA/HDvD2YXiYBXpNCYcYuYRoz0h0KnM2t9JfQtWtXJ04G
	uiIfXeleFLMNRZm6IiFkORyzVm0yJIRly03QqmR7lJVeYxPvt/60vQyiuBEtIxH/ByjU9Yes/0L
	3
X-Gm-Gg: ASbGnct5qgdcaSDgRKl+79r3HiIK2kYnN7ioVhXF+3rATs5yHnvYObiLgEZHrmBevzL
	wezhSRu/2HIKA0V39caHH5LEpoggamgLXDDKEAPF6kE0f+ZV0XXWCCM+YtmbXJ/aQF4SkJuzGy0
	YjqinP7sbgB75KJojimdvX/88TXkZIEzeplQ4g3Gt2QagI/1F416EqmkKECDgRpYaQIo8hcd+0Z
	VDeGUwLtlkDRw33zR1oCUlNAYIKfcF9mvz8ikVlCS/o8SGNFsez4SwHSLgLsA==
X-Google-Smtp-Source: AGHT+IE0YV+TAux3fWGWtKczFKfzUF095AoW6fu7kND8UVHo3qyg1cjMHFlOUS8u8HrrEgdbSzZcvQ==
X-Received: by 2002:a17:906:fd42:b0:aa6:8bb4:503b with SMTP id a640c23a62f3a-ab2abca0603mr1923718966b.55.1736931724700;
        Wed, 15 Jan 2025 01:02:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9563b1csm738053666b.98.2025.01.15.01.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:02:04 -0800 (PST)
Date: Wed, 15 Jan 2025 12:02:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix bug and add osnoise_trace_is_off()
Message-ID: <4ee1e1a7-f0b3-4062-97d9-45a342d0ca21@stanley.mountain>
References: <20250115081157.1274398-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115081157.1274398-1-costa.shul@redhat.com>

You need an "rtla: " subsystem prefix in the subject.  You're going to
need to remove the words "fix" and "bug" from the subject because this
is just a cleanup.

On Wed, Jan 15, 2025 at 10:09:56AM +0200, Costa Shulyupin wrote:
> The usage of trace_is_off() contains a small and elusive
> bug that requires a detailed explanation.
> 
> To expose the bug, let's modify the source code by moving the first member,
> `trace`, of the `osnoise_tool` structure to the second position:
> 
>  struct osnoise_tool {
> -       struct trace_instance           trace;
>         struct osnoise_context          *context;
> +       struct trace_instance           trace;
> 
> A correct program would work properly after this change,
> but this one does not.

No...

You introduced a bug by changing the order.

You have to undestand that to the original authors this stuff was really
easy and they knew the order of the struct members because they chose it
deliberately.  In the end, they get so used to the code that
"&record->trace" just becomes an idiom for casting "record" and they
forget how it looks to a newcomer.

I *personally* am not a fan of code which assumes we know the order of
the struct members so I don't have a problem with you re-writing the
code.  But the commit message must say that it is just a cleanup and not
a fix.

Which reminds me that I had intended to create a container_of_first()
for code like this which assumes that container_of() is just a cast.
There is lots of code like this:

	struct something *member = container_of(p, struct foo, first_member);

	if (IS_ERR(member)) {

Which relies on the face that "first_member" is the first member of
foo struct.  It's a quite common thing.

regards,
dan carpenter

