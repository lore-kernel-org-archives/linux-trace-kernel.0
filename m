Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A981D63FB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965676; cv=none; b=H+zK+CJrPHEAZ392JxmFEtaA3ADgyC7OJigOO6A6tTfAvb8C64rv7BTcnF7+Ey4HNIWsA4OpqhClfxSJcEQlKaLN+pCA6e0C1AI5UgJ7jHf7Sa7oLhcgKXPt5gT4lsm1jmcp5tgbzQR/TYt2Mz5Y5sGEy3BjN+R8sLhzBoJj6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965676; c=relaxed/simple;
	bh=b81TDoYer9uSPGtGgKgaQXhHGD9mvax9zMxqg4mP1tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2j46TfQc8hoOZzWn/iZlin4S5YPwYxEvmJBbOWalWxi6GwmenHcv7CKtrI/pDgq9ZcZkFrEYcewRZeXNIqCv3O5Sd9xEIlBURnne/xrly+AmCEhbypE+VTAU/zL+Ob+kBOMwHKNA3msSt8wynRcG1yZaB8bax4733qPgtTQ5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eGuBx32L; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGuBx32L"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so62000a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 10:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736965673; x=1737570473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7oLEDLp95AHbo5oQtn8gEnk71S0ZQtoEW5mdd9dPbF4=;
        b=eGuBx32Lr3x5zUDmQD8HOo/smxMVBZ0ykoCl1OFuKhFGMruiBqcKCcquUFcb5GmCo1
         lTXYIpFmRCul8Q+Wrfi8p3EbFUyw11C42dVi3dn5ARdCrKWYnKFPwpUnvllAipS8P4Y6
         2olX8wA2pFjwIEQj2paeHAjKQVHpJIFIdbkAtTbz56ELpHDhDUHr6x/s6dcL7JZko383
         8zi6IM/nTngNJZrIurLSu5uXxmZxSi576b6DQQ3xRzIpKSjqD5YIeyFoAzoW+Hu1Xj5I
         60jBMmne8HFvuE1H8FGbi7cZT7SVsYi47QWFkGAuUQQR6+pvbwFlJ5DxX8yRynJvQn/A
         66Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736965673; x=1737570473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oLEDLp95AHbo5oQtn8gEnk71S0ZQtoEW5mdd9dPbF4=;
        b=LAx/3ZXaQY+3u5DbhPdiu4En1h5XgTi1ZdNLFxKF9eT1K3IjH1iPVtyfrhRrcbCwNS
         mi1QDwV9Rj6e/3X3tFwaMHSbkEuv0EXF0KsVO4LQ/mSa8kD6O5kuSyMK38hEx16VlEnA
         NEjMzrKZqLI6yXSxVV1XjcRyFrfMN+n5Ar+EVbdlASawsSVbU9/qx7ZfsVbCaZQS6uCk
         P/EIIM/cDDDjoww/K2YmrPkJ3GH0bR1kDnNY1IfmotrYUT6Ho0kP1Gk36mGIOMC5OX5K
         2iynM1gi1QqbiOlIjbQTWvqqUvNdvnjJVdW0YA9nWR4FhcfyWLrKUu2HOD7QBljgkylp
         9igw==
X-Forwarded-Encrypted: i=1; AJvYcCVXUA9a9tDB0gT9R2TqPOywB1yTsQL9KeMw65G9ahEXUArCJ1mNLrZgszoev9bh2q7O3W/HCRRhMt9YJ/Rw+qEmcfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwImYsJUBAoPHcuW/iIWf/QI7xzXNr3nD8qWr/30ic1vsslcMjW
	5C8vMf+cje139IhX1flwjfGjAJBfhluxkfLX48PIyhLl/2ej8Quvcvdf7UyPP6c=
X-Gm-Gg: ASbGncub+e01knRqfEeEmDofw+Xz17rG64rN2LtUMOnZsVpXzIaU0j3MlHq3rxDz08U
	h/xgauQlseHobC3VyRklMQkaSnNcfEnrMN1TfpZ3uVAnMdi9/QI2vKWoLMTfrLckmnPAHYJ8YLt
	dT/wDXWeFWGshqmu4z17SlhbGnayEhwBRlyO0kmBCvIY53nUmcrI+e6WRAMdVNTTWfKAzkay6/J
	KxFIia0tuiZhlEaZLykbFwhACDoPliff8xHEg7AVu+2zpsyxfu4TXltLqhYZQ==
X-Google-Smtp-Source: AGHT+IFnh/mf8QpCO5KOVM66CBu2aIULtQ0OwPffDYH7pNUvhK6RjWRKYXvrK24PestFeF88220XYA==
X-Received: by 2002:a05:6402:84f:b0:5d0:d330:c965 with SMTP id 4fb4d7f45d1cf-5d972d28da9mr28448865a12.0.1736965672674;
        Wed, 15 Jan 2025 10:27:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c2d7sm7804452a12.3.2025.01.15.10.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 10:27:52 -0800 (PST)
Date: Wed, 15 Jan 2025 21:27:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add osnoise_trace_is_off()
Message-ID: <142694b4-85de-412b-9016-4ea3c66e726b@stanley.mountain>
References: <20250115171359.1954533-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115171359.1954533-1-costa.shul@redhat.com>

On Wed, Jan 15, 2025 at 07:11:59PM +0200, Costa Shulyupin wrote:
> The usage of trace_is_off() confusing, which requires a detailed
> explanation.
> 
> Let's modify the source code by moving the first
> member, `trace`, of the `osnoise_tool` structure to the second position:
> 
>  struct osnoise_tool {
> -       struct trace_instance           trace;
>         struct osnoise_context          *context;
> +       struct trace_instance           trace;
> 
> A correct program would work properly after this change,
> but this one does not.
> 
> Then, run the program under gdb to observe the behavior.
> 
> gdb -q --args ./rtla osnoise -D -d 2 -T 10000 -q
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x000000000040298f in trace_is_off (tool=tool@entry=0x418458, trace=trace@entry=0x8) at src/trace.c:538
> 538             if (trace && !tracefs_trace_is_on(trace->inst))
> ...
> 
> The program checks if trace, which has a value of 8, is not null,
> and then crashes when it attempts to dereference trace->inst.
> 
> It happens because trace_is_off() is called as:
> 	trace_is_off(&tool->trace, &record->trace)
> 
> Where `record` is NULL. Expression `&record->trace` returns offset of
> member `trace`, which is 8. The original code accidentally works because
> offset of `record->trace` is zero.
> 
> Expanded wrong instructions are:
> 	record = NULL;
> 	if (&record->trace && !tracefs_trace_is_on(record->trace.inst))
> 		return 1;
> 
> The correct instructions are:
> 	record = NULL;
> 	if (record && !tracefs_trace_is_on(record->trace.inst))
> 		return 1;
> 
> Refactor `trace_is_off` to `osnoise_trace_is_off` and move it to
> osnoise.c because it instead of `struct trace_instance` accesses `struct
> osnoise_tool`, which is out of the scope of trace.c.
> 

This commit message is so confusing.  It takes five paragraphs to
explain how NULL + sizeof(void *) equals 8.  Everyone knows that
already, but it's irrelevant because the actual math in the code
is "NULL plus zero".  And then there is the crash dump which can't
happen unless you change the math from zero to an eight.  It would
be easy get the impression that this change is some kind of
complicated fix to a crashing bug.

Earlier I provided you with a good commit message which you could
just copy and paste but here is an updated version:

  This patch is just a clean up and does not affect the behavior.
  Consider this code:

    if (trace_is_off(&tool->trace, &record->trace))

  The "record" pointer can be NULL in this code.  If you're new to the
  code then it looks like a potential NULL dereference.  It turns
  out it's fine because ->trace is the first element of the record
  and the trace_is_off() function has a NULL check.  So it's fine.  But
  it does look sketchy when you're not super familiar with the code.

  Refactor the trace_is_off() function to take a record pointer instead
  of the trace pointer and rename it to osnoise_trace_is_off().

You need to add a subsystem prefix to the subject as well.

regards,
dan carpenter

