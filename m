Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051256479
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650594; cv=none; b=ZYFf5rl6JzvKW0SO0CzJck4qtiCphgUyJMLjkfoXR4z3GlMm4SiY0GpGzG20HLVYQjIPTTN/awacBR8mrzrCFZ/UAoAX6aVxIhUi1EEAi9aXmgt713kLMtDMPN4ULWqGwGSL+gMX8mN119inA2upmgk7qK+US/CmfkOwekLp4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650594; c=relaxed/simple;
	bh=Yw5Gqmr8Z8jqHG32kk+kikuaKYDOk1WB4PO3rY5HdM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVDqnzOchEZqV5lKIKPKT0cMb3iLzA2dtYj+u3bTGk+BjrwbfZ4hpriPa3TnijMcEnzOa+GSA6FCHOB1beMtdt2reUP0TaPydYbsJ01Ma2Ls4LF6Y8aTza+SNTxeWUUVAnliPpYnIOoet8vzrWo8yNqX7gs3aj9YQ0GKP08ujsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LC6RDpv5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LC6RDpv5"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a366ad7ad45so3941066b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706650590; x=1707255390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=poQiwWHTggbwboPucRWxNk69pRsy13qZywqxkH5Fd3Q=;
        b=LC6RDpv5Gxce7Hl3XdPYuR0X0NZbX44V/B9IWiSIBWF/agWpe3MLgmD1iTbjuCOWYG
         Y1A+WhtD28XUzl0R6sQnlRaxYfbl5R/B1Ejxt2RAAuST10pB2kpohUpzsd73XTIfpUr8
         yA2Q/0AM4ZW1lQKFKDQLQTfzqRXAVfPEvdGzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706650590; x=1707255390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poQiwWHTggbwboPucRWxNk69pRsy13qZywqxkH5Fd3Q=;
        b=I7QiT7nEuRECHtq3vTRd5p3OdMk+7qJcm+lf8lgZsRyZuuG3CznwOQyQ7v2D5PnwTb
         gZ9NojR0Vt3UvJFIkvb9+RmxU+SzVweYapjzvWRNtF7L2I5OjiIqBUSajBDDHY3kIePS
         QYB3uu0JBgS6Lop6oQ90hCQAsGksXt0dDBUwXsD+JC0BC0oz60eDF33r728RQhRFcbMs
         VjaloccamgM4RXvOitzRJGKIg8DqPbIEYgsA0P/j7qqEgnK1Ox+Rc4dso4pu/fMZ8sHO
         g2C23h1CZFK4iM1hNZCeN2fl4b8eFZCqsWWiM5TRF5U7PEzoqqvBjO2ViUg1fm1ASXqH
         1HuA==
X-Gm-Message-State: AOJu0YyYsqoS+NiMpgaFn6FTHxW9WPhuxtRn3NPqF/OAi3z8yENEuQHe
	4CpBOuKHeM19xuv59EiEOS3ZVV7v9FKjoJoc5dIRCVqfjyQx0AiIQ9hyJulPMHHmdXptJWwfP7+
	iJn2HwQ==
X-Google-Smtp-Source: AGHT+IH/nc1B8AD7Ynm4Jhx8sRt8adXTULBjHmwVB6+iMXTPp1N8ov/DAMBmNDkATmNEpDFzI3BJmQ==
X-Received: by 2002:a17:906:2991:b0:a30:2690:5c48 with SMTP id x17-20020a170906299100b00a3026905c48mr7781482eje.8.1706650590308;
        Tue, 30 Jan 2024 13:36:30 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id st14-20020a170907c08e00b00a35c5491b58sm2492350ejc.174.2024.01.30.13.36.29
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 13:36:29 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so4696505a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:36:29 -0800 (PST)
X-Received: by 2002:a05:6402:278d:b0:55e:d46b:7d82 with SMTP id
 b13-20020a056402278d00b0055ed46b7d82mr6496982ede.28.1706650589312; Tue, 30
 Jan 2024 13:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-6-torvalds@linux-foundation.org> <20240130162512.312eb446@gandalf.local.home>
In-Reply-To: <20240130162512.312eb446@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 13:36:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrt4uUzxkboZtHOHkNbNBg9Hv4XAFTaNLTrpyq-VctyA@mail.gmail.com>
Message-ID: <CAHk-=wgrt4uUzxkboZtHOHkNbNBg9Hv4XAFTaNLTrpyq-VctyA@mail.gmail.com>
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate function
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 13:25, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I actually find the dentry's sticking around when their ref counts go to
> zero a feature. Tracing applications will open and close the eventfs files
> many times. If the dentry were to be deleted on every close, it would need
> to be create over again in short spurts.

Sure. I think this is literally a tuning thing, and we'll see if
anybody ever says "the dentry cache grows too much with tracefs".

               Linus
