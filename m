Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1103085A9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Jun 2025 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269163; cv=none; b=TXgJoxX63v3Xgmcg/ZMupYz3MxsIPSYOrTAHDPlEl13izg6XMAcBzbdXJdh28NANoq7mD9LeMQHyJ62lSXs7a353gVS1/4nQeaaLcMJnWz9l4nZULfK8zfrxeS/PBCQPPNPkcJSHHn3tmXpL75nyx0uQ6/mKiXvifKxtFZ7X5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269163; c=relaxed/simple;
	bh=y9H/LE+xIpHZ/6sGJEJkqEbtfi7uc50nx0i7lJUVD8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8bwh/vXvoH9rtSFgGs3tvAQwGYtXA3oSXSzrX3Aio7DBqBdz9hevZDsFkU09jund0wo/ZdM6hEMhyV6pchjmnug5ajXnRA8QbmoxYgNqIURZZ786+el/qutJQZ8jadJ9Ora0FSY1G7RS9as///fe2YbdmSMpsO5MufxvGS5FKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DqNCnZ94; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DqNCnZ94"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so1425428866b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Jun 2025 10:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750269160; x=1750873960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kygiEEUFulB3nwwpk+ux/04z1+ZqdUaQ3pGhL4WTR/Y=;
        b=DqNCnZ94Z/il0GPjRQkFd0niZZ8DN2mhmADcVOUYhrbdi5XUdLGIhMfWLVrLwRk2GS
         /2PS/OBkUcD1ejiogLRtqP6yjEQ84prfKj+mxBfRIvcjTnO9Fb8+hzb247RNW6YpJ8WI
         ckVc8nYCiR+6U+vkRDuO/UhPoegsqQJJWn3rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750269160; x=1750873960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kygiEEUFulB3nwwpk+ux/04z1+ZqdUaQ3pGhL4WTR/Y=;
        b=b2eaG2Sp+cf5WgNXGSpUifRODUZczwhxSn9eaYyebfeVhkFBncyk52vtq4jkqBK+e8
         M2O1oe3S4dy1LRfqJ09boQh5wmMXVYeiyClZ6lJNezEuUpZ0ONVBYj8D3U+3c7MFbCXV
         03XNUiksW9tt350TtFH4XjprV00V/u64jL7kpy4XyiYWHqhhIos6RmL9TmTG0WpPv48A
         DqZCRYXerskvjXPbwZgX9PAI30LfjaB4ugrNk4OPe9DiFo0XLxPslb7JjZRTUVdMNLMe
         jWmkvg0Tqakdm9YUS8OW+uNFKbpNGQcN5jo1Ubm5PLO+EeNN67kEVpZgHyGbW+6h2alL
         BUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLGi/xx2Srf+x+3IqTKraIqsv0CmNqMFpWcswbyBGFPBbjIYq1Z5TaYbxxZHVqEbEIOifup8IGcVRWvZXJQvisqeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0z4mvCI5fu7oXU2adpL3jkJ+6dKhqdZzio93bPaUQjp/Jwab+
	cFnd930N791Mm0mELmkublF9BVaf+bVyF2/lmt5vag+ncSoksZ/mHgXf4z1Oewlw8CqfIJr6dYY
	7JzSK3MU=
X-Gm-Gg: ASbGncv5JgpZ6mBGxqRCgd6kObVM7t2cMzLSIoGVPI3Fkzptmhu2pMofTQl9OXby4x5
	/153Q76qlUFIeBB/mjG/i9Y+FMlyA2SSVBAeeG9nmdpcbsDsYXnaA0gAjAO/XZ0cNThpt9n3/VO
	vjSGzxP+uPwXsX/hNm6tyGeNnfgixMcOT94ZsM6XKnyFdL4KzpXCL/qpBq6fHEcQs45R84RopbK
	YsxUs1WQhBfjckrIFAj2Ja3Dt29yPYBs2tV/+wt22Cy134F6a97k9MSquZty0GyssjBsfhsL94L
	RMsjXYwrhw3bMROzEzs0k4LZxDxXrniTtPErpi6ZKCGrLXamuHWk0bmhpHpfLlvpXGm7bslShT2
	TSHoVK7xDDuOtb1W99N4LVHvVk5vLao11hB2ID6DW3088PXo=
X-Google-Smtp-Source: AGHT+IEgvPXoFAWe9ZSS0J2hubAqXemAow7YzJtBwVfDFVCPG0lFTyWZZ+JlFtsQcfqvbRsk0Y8vAg==
X-Received: by 2002:a17:907:962a:b0:adb:7f8:9ec2 with SMTP id a640c23a62f3a-adfad682f5fmr1796218666b.53.1750269159659;
        Wed, 18 Jun 2025 10:52:39 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8156ed7sm1099622666b.37.2025.06.18.10.52.39
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:52:39 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so1425425866b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Jun 2025 10:52:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7BXc/VuZIRHZAtJ/qRqTYZAWL/CNQ+9eR6gQGKYPEvYL2otgnsmC4SPuTZV2MxJNzoF6tEb9lH7tgQ5fF3NE/usY=@vger.kernel.org
X-Received: by 2002:a17:906:9fcb:b0:ad8:9e5b:9217 with SMTP id
 a640c23a62f3a-adfad60cb3bmr1891902866b.45.1750269159066; Wed, 18 Jun 2025
 10:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611005421.144238328@goodmis.org> <20250611010428.261095906@goodmis.org>
 <20250618134641.GJ1613376@noisy.programming.kicks-ass.net> <20250618111046.793870b8@gandalf.local.home>
In-Reply-To: <20250618111046.793870b8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Jun 2025 10:52:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGWM50Qq3Dgha8ByU7t_dqvrCk3JFBSw2+X0KUAWuT1g@mail.gmail.com>
X-Gm-Features: AX0GCFtVJDBhnv7J2rLeWOvRjD7ENnpnCnae_NwDFoiDlVyU_VzUYIzxqy3Sfo8
Message-ID: <CAHk-=whGWM50Qq3Dgha8ByU7t_dqvrCk3JFBSw2+X0KUAWuT1g@mail.gmail.com>
Subject: Re: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jun 2025 at 08:10, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Don't we usually shout macros?

Not really. It's more about "we shout about macros when they _behave_
like macros".

So typically we do all upper-case for things that are constants
(whether enums or macros, actually) or when they don't act like normal
functions.

But when it's not particularly important that it's a macro, and it
could have been a function (but maybe it was just simpler to use a
macro for whatever reason), we typically don't use all upper-case.

In this case, I have to agree with PeterZ that this just looks odd:

-       if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+       if (UNWIND_GET_USER_LONG(ra, cfa + frame->ra_off, state))

why is UNWIND_GET_USER_LONG() so loud when it just replaces "get_user()"?

Note that "get_user()" itself is a macro, and is lower-case, even
though you couldn't actually do it as a function (because it changes
its first argument in place).

             Linus
