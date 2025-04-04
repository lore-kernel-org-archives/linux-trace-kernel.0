Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D421171B;
	Fri,  4 Apr 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793151; cv=none; b=WswLU3BfNYH6Cf17Ud/cHeEUgkMevkUbm2GxstJahEgLjiKbx4IVcEal8334RzztL6mhcoj+0S9p0657r9nJcxc0ULawJmjU9IL6tHN1WFZKmBTHnScwl2eIX1HLfw2eH+u8fCQJzThiAh7NeWpWu65c9N7Sm3hYbWKGATh6bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793151; c=relaxed/simple;
	bh=yQ9hdxCYDvZLZy9cwnQzNC/wg6VEZN0qrwYMaic6OB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBrgTkIJ/1hK4svTitlPdcQktc0MDWit4Di6U3N+9YOu1UsYJKzMJltf0CYWYUohjqAuH02Yk9o2NGrr6YyK04rwtaxFA95cB5nQVdE91GPJxut+EM8Yb9N/dnbFo9ya64MVMVrINlLeBTenGPYHU6344hpSa9P013KSKyO5fjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBSYmD7J; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBSYmD7J"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c55b53a459so236626485a.3;
        Fri, 04 Apr 2025 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743793148; x=1744397948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IKjUACZPIJS63zOoRpXcIU0I0KFD19K+GUNwLuKaBJ0=;
        b=XBSYmD7JbRGSahmzxx3RqGSK5Pue5/MRWtqXBAsWoT4GiDnArZyNQ+mzqSfuYFc8Yp
         k6+kYJZNTgQ4KYNBZhHUmMq2yP1ZmMqAObp1mQJ+oEzpFxEUSnnwQb3Bfpx8X46je6Cf
         TwyYr5lsmEN9f92dfv61wwD7JjqMFEFJocMMgEDJ+LLeCgwrJeepIqywCB3QeUTV1VH9
         21hYU54L2ClVXbtdPQ5m/6ajc1Vse7On71yNhQ7cceJ+tykVyr08nxZ+31Njj/ifsqkn
         1xqIA1VCNJ0kQiOahj8U60D7DD5YWwixCgK3or0Glxtubg7G2Acx8EHktY1twikAzqDt
         KNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743793148; x=1744397948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKjUACZPIJS63zOoRpXcIU0I0KFD19K+GUNwLuKaBJ0=;
        b=QMZWQbLlwZVZF6uPevNLTjfXchmEwj+a0c5rAhjkumbEqaW3BqoDN3KpXbRcTWKuRp
         44d4pBlSrdqcpUS1L4+wWGCS5HnCErUTf4XKYkqkKauUkzrcRClDbREuWda6JCSCARfb
         7qAS0d87dUISvh7mgtyy2R0ChwIX6FzLuS3o/H3GSXikv56QaC5WyU7e4+l+KOA1Uj0+
         o/PTW9oEpCUkSanps/E61a8ctjotDsYxOO+yr6C7SDuIvkjbmEmansiUvJFVXO0TRqb/
         oNXE6JoumBCyPkodhgMQ/SqAJ1ZbI2eA9dA5meyRgsvDES0DNFevTeec0Gr973/4uSn9
         xNZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL6Ik0n6Bqnitd0shGA99Xfxg1T6lQoMvZAhw/J9Uhdm7dMHQ4ZM/XmFtRNZ8MoY6Qx5A9g7EMx3uSqmY=@vger.kernel.org, AJvYcCV5633EgHJtbZ8sVGjKqFxWSDK5RrGnaULHs5eiKtARyph1qnLVIE6KfYL4TGLLweAOpAAH8JQosEzUy9Jv6Ja0A6Nm@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOJibEzV3xHU8PCW3JqXwN+8XrU5FjS/tKEe5ATnmRip50vHd
	Jx0ZnEoEV13yqhr0asrWXHr/SqB1DW5EciF1gwmmKZe5kSHgVgTjArNcOJhMwc0c7iabjKuxvbB
	dqkMU0U5xudhVIbC0RJBpQB2X7PM=
X-Gm-Gg: ASbGncuEAUJmxyu3dbwUFC99HAYvziJ3NOCgoUEJ/9RE9sLJ883nnhwxF9Lov0OQLMJ
	EXRtRLYAn4o+YbpGG7QqbC9lK+5jkT4dQgLkMT83eoF37pGFdWgBlRAfmug3a4ZY+Bnk924EnKC
	BLXFu5TCEVWh6JtdVoYFmirj4P8upIpI+ptEh60B0pEq4=
X-Google-Smtp-Source: AGHT+IHK4lPWaHjVzf96lEuYnTdrBloLkWqdaEB22PpT80oP2tng4AuXivWfJ/G3VF+mcikH2Q5kZKH9Fk2/cUXAY7E=
X-Received: by 2002:a05:620a:3723:b0:7c5:cdb5:271b with SMTP id
 af79cd13be357-7c775a0f60dmr500906185a.15.1743793148612; Fri, 04 Apr 2025
 11:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404135850.2695211-1-devaanshk840@gmail.com> <20250404142010.4af17918@gandalf.local.home>
In-Reply-To: <20250404142010.4af17918@gandalf.local.home>
From: Devaansh Kumar <devaanshk840@gmail.com>
Date: Sat, 5 Apr 2025 00:28:57 +0530
X-Gm-Features: ATxdqUGsIsK8DS_fm-3DSox-hiuQDVXc-gGywCAuYU_mxCWuj_VHuB0qEooATvY
Message-ID: <CA+RTe_iqc0qCaeZFsyv9==-VUH2VhqCU46Jx7C3ve2=VDwFUOA@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: Replace deprecated strncpy() with strscpy()
 for stack_trace_filter_buf
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Apr 2025 at 23:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri,  4 Apr 2025 19:28:48 +0530
> Devaansh Kumar <devaanshk840@gmail.com> wrote:
>
> > --- a/kernel/trace/trace_stack.c
> > +++ b/kernel/trace/trace_stack.c
> > @@ -543,8 +543,10 @@ static __init int enable_stacktrace(char *str)
> >  {
> >       int len;
> >
> > -     if ((len = str_has_prefix(str, "_filter=")))
> > -             strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
> > +     len = str_has_prefix(str, "_filter=");
> > +
> > +     if (len)
> > +             strscpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));
> >
> >       stack_tracer_enabled = 1;
> >       return 1;
>
> BTW, why separate out the len? I use this notation quite a bit for
> str_has_prefix() checks.
>
> $ git grep '(len = str_has_pref' kernel/trace
> kernel/trace/trace_events.c:    if (!(len = str_has_prefix(fmt, "REC->")))
> kernel/trace/trace_events_filter.c:     if ((len = str_has_prefix(str + i, ".ustring"))) {
> kernel/trace/trace_events_filter.c:     if ((len = str_has_prefix(str + i, ".function"))) {
> kernel/trace/trace_events_hist.c:       if ((len = str_has_prefix(str, "key=")) ||
> kernel/trace/trace_events_hist.c:           (len = str_has_prefix(str, "keys="))) {
> kernel/trace/trace_events_hist.c:       } else if ((len = str_has_prefix(str, "val=")) ||
> kernel/trace/trace_events_hist.c:                  (len = str_has_prefix(str, "vals=")) ||
> kernel/trace/trace_events_hist.c:                  (len = str_has_prefix(str, "values="))) {
> kernel/trace/trace_events_hist.c:       } else if ((len = str_has_prefix(str, "sort="))) {
> kernel/trace/trace_events_hist.c:       } else if ((len = str_has_prefix(str, "clock="))) {
> kernel/trace/trace_events_hist.c:       } else if ((len = str_has_prefix(str, "size="))) {
> kernel/trace/trace_events_hist.c:               if ((len = str_has_prefix(str, "onmatch(")))
> kernel/trace/trace_events_hist.c:               else if ((len = str_has_prefix(str, "onmax(")))
> kernel/trace/trace_events_hist.c:               else if ((len = str_has_prefix(str, "onchange(")))
> kernel/trace/trace_stack.c:     if ((len = str_has_prefix(str, "_filter=")))
>
> It's fine being in the if statement as the if is more about "does this have
> this prefix" and the length is just a side effect of it to use it to
> extract the rest.
>
> This patch is only about removing strncpy(), it doesn't need to modify the
> format.
>
> -- Steve

Sure I'll keep that in mind.

-- Devaansh Kumar
