Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CB2367DF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761889037; cv=none; b=oYDw2ETxkVCaN/ftWC2Bg4DytfUg0iULapHVRtvSYvlkGChq/jNeyRcTsWOAY4LOwVFgX0Qa6PETjdzlJJnnvkBqQscIyCTohFFftLVELIGDtH11bTiClb/bvKpWrJio59Q1w5MzXRpAn0KSqT+bCi4AO2R3a6D0+Eay14uMlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761889037; c=relaxed/simple;
	bh=lPDfYflv3IYSjUyPurz357kPpROg3ph60HnwVeSDGmY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=egz0OgbgruecAKcKxNvLwlPXs15EANC4K/WIFAwBpvfcxT1T3rcbEuh4ZJgrCEY+6OX0wTX8zlnhHG8iIlMauKlzytr1XhpUZX2fNmQAQpJ1VF4TP2PnkyHAywINCf5XpYrl7b1bogIqD7NhEHjA8j6cAPiVceQcptfcHyk6/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qHjPFw9T; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHjPFw9T"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso16266465e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761889033; x=1762493833; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afDYIcBtolcFuYg2njws4kwhh8xv1xPHYCskh73iz7M=;
        b=qHjPFw9Tb8k0tmR7UJ72BrIPYVVguysfvcZgS+5f89FhR3MZ6jyr2Dsd6oX8xMxbtu
         rI7oHaAXnHvNOyHeXJPQjjd0tVBaZHAEgiUy53mHtdQ5IXgL9nel9sNZO+9G8M/2j96m
         ANDcs/4Bo+F8noirQ0J0UZ15jsuRXT7dTsIqrWQO1uNX2wQzsuGom30vslV5s1LI9g4w
         zzw3WV16baaoW4MDt3mGHvwlPuDnwC2Rp1+SFY6LU1B4/TlRXaIcrSzaOJFl74wjIHiw
         O6aPRBkVvBoKU5RjHISknNp1QMSKC0EnKpXd+meX4izXQHVs6Um8RJ4L/y5b+aBdukIl
         z4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761889033; x=1762493833;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afDYIcBtolcFuYg2njws4kwhh8xv1xPHYCskh73iz7M=;
        b=M3Zr+3jQiOHrjlCVxO3kNrTerlEOfg3q3QREW+9y12UOFy2OFE8znul5c98eMN1cIW
         xhqnxS9cCLEfsGNwxGimALZoD1/z7jA/XH7mtiCa9x+jrBtq/4LKY/zqtS2ZZBdqaep8
         BDLH/aJMDCSCa3ZLx58K47SXYQqvOiFwEe10vV2jRPAnLTzacPipbtWm4eGi/Odldtmw
         Cui/Mtn8pTEvr53H9fUoDSsyXrGnRGnyMPESl4BQo8xzyVp6Ll0uhGjiGH1W9f/SB027
         PMlEf8T5SoYkzj3AVVQQFploTq/Him8radQj6CmCn9XM2eu8l9gh7qkeG/ftK4OOgMcY
         O5yQ==
X-Gm-Message-State: AOJu0Yy09/IedfC8VejZnACyOt/dvlg+p81uD46Ocw5ckgpOzyWgMdt5
	ESCY0nutXAaSkj1AGvn5VB++NFp4zTW1t1GruGlcoLB12u1DzyzEEthGeziI2Mf3kW0K2unBgS0
	mw/fy
X-Gm-Gg: ASbGncvLLST67E7rhdqMLXqgAMtVENXs6blHEYCQSBHBFckXrunv+o3Hai5ItS7Rg+L
	XUUQGQFpjv06qLS92CLliGeYkEHgVl6YBWQRquAbp5s66dgVdXRJLT+8drZCS/gbyBVUnVcT8+U
	WvEO3AogNn0+U7RcG6DR/fro7Tj/Wi26Ms0vs2152VmvJ1AdBpb9qkTFEVW2FA+TTie4/hv63h6
	Wo9X1xjqLeoqr9+gv2IedCO1ig0nsJgQQB7BdgfAAxxfOXqZnGAtGV1LIm9osdGv4D2Q1NTku2n
	9MVYpLI8WTPfm6Qw90O/4aaezshIghvBfQyPT9XkX4OTE5UEmGisXGATxKXx6qGQQ0cCgjKC4p/
	cHusNAfs5PKeUwsnYAUMXhgmwQ1KkT7Et8jSW4qtji7cliJ8xv9I3EDEa5VqSeGzCyjm2QdNar6
	DQTD4pljFofWsk0f4V
X-Google-Smtp-Source: AGHT+IH1hUtTRzmAeobeC/O19VIKw+fC2l2XCskT+JRLve7vbUHaa8ygf+h7zi4RoKOEUdefVbwThg==
X-Received: by 2002:a05:600c:8b66:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-477307c1f31mr20002135e9.7.1761889032852;
        Thu, 30 Oct 2025 22:37:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47728a96897sm75672485e9.11.2025.10.30.22.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 22:37:12 -0700 (PDT)
Date: Fri, 31 Oct 2025 08:37:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] tracing: Have persistent ring buffer print syscalls
 normally
Message-ID: <aQRLBV_KzDHaaYiG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Steven Rostedt,

Commit 25bd47a59275 ("tracing: Have persistent ring buffer print
syscalls normally") from Oct 28, 2025 (linux-next), leads to the
following Smatch static checker warning:

	kernel/trace/trace.c:4273 print_trace_fmt()
	warn: if statement not indented

kernel/trace/trace.c
    4260         if (trace_seq_has_overflowed(s))
    4261                 return TRACE_TYPE_PARTIAL_LINE;
    4262 
    4263         if (event) {
    4264                 if (tr->trace_flags & TRACE_ITER_FIELDS)
    4265                         return print_event_fields(iter, event);
    4266                 /*
    4267                  * For TRACE_EVENT() events, the print_fmt is not
    4268                  * safe to use if the array has delta offsets
    4269                  * Force printing via the fields.
    4270                  */
    4271                 if ((tr->text_delta)) {
    4272                         /* ftrace and system call events are still OK */
--> 4273                         if ((event->type > __TRACE_LAST_TYPE) &&
    4274                             !is_syscall_event(event))

I feel like there was a line of code here that was accidentally left out
of the commit.

    4275                         return print_event_fields(iter, event);

Or we could add another tab here, but my guess is there is a missing
statement.

    4276                 }
    4277                 return event->funcs->trace(iter, sym_flags, event);
    4278         }
    4279 
    4280         trace_seq_printf(s, "Unknown type %d\n", entry->type);
    4281 
    4282         return trace_handle_return(s);
    4283 }

regards,
dan carpenter
