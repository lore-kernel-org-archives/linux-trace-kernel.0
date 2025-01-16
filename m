Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F4234D1F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055873; cv=none; b=cOA5xVXC5kEXGEN2WsePzif56vKBOlMT95I6a8wynG/mxcDK+ceXGzz/p7iF2V8wrvrcKNCp86c/0BE48w0S0pMkaMS7OPLZ74yES03LeBSGdQ9bhncalMrc7P+KuYFmUwIBZXaRYy8xcnNNwanKPfoZCuIwu0Sov/eGgiyRlHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055873; c=relaxed/simple;
	bh=2jlycY9LvGGAm5Fdt5Hxp9Ba5whJHgzDPG05gxjLmTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKHNBCC6UvFYSRSWguUtqsq91iqMWNgjBLzWVI9uXceaVb6xxCdltE0xYV8pL94xVHHbegBnbuybWylG9QOl/pJ8deF5DrZm194kCWuYNvGaMd63Yv8lquulK5EFXtXt0HQpE2+/j5fJls0hj7w1a1XmVI+0m1YkXDp/N+dmQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JjNTKU9Z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JjNTKU9Z"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf60d85238so227083166b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 11:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737055870; x=1737660670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSOYM/2mUrieJNrzGjlGBXjVPYoZL00eeg4o3KbRfwg=;
        b=JjNTKU9ZBh9HY7SQvNR12HZdrXPByST9h98jXOi3RQS6lb2oOiTW9dVPWT9JgfGqF+
         H+BZnua6VnDREgqBOXTFWlXXTYocm9IQPG53de9punr8mS1pQSzLTDQe2jvILqJywi+Z
         Bz8b4d0nfoGTFqtwEdHEosLTAJvkcVtZ5mxk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055870; x=1737660670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSOYM/2mUrieJNrzGjlGBXjVPYoZL00eeg4o3KbRfwg=;
        b=WpbIFTDbFSIoEaXrQkpXsdl+rMPIU1uT35JTNFNCE0EWsAajHm95ek8PZ51UOlRv3S
         TloWCSbAYmf0zN5wM4ALHO8cjKz2uxN1aLYXH7uKHUmSLnb8/qTy4D2f9ewPeF+ugu0V
         WdYyG+VEnKNh/qmmHuAqrgx1IY5pk6n4rQjaH4aySGTcF/nG8UKB13SlfpJE5unMIN/d
         sp8kHpqeNvffbTzc74OOUo68khDnr1lXEYwhSnN9/rkiPiueC2wTAxU/nZLMOH6ww0D4
         9fxFuroLWDIO+S1yQSLpQ8jFtSwZxpFGdMcIi6IkVvb/ywIRS8zbZ9sfJFdAZHSUyQ/e
         z56Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRbrFcJml/QSmlAgtW2mwUIYouCRoCuVT4/idqYS0jZjzGCgh3jTw0+3yl42OnxcSRBfulJp845OMZ37mIqwHb4qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWx6ZG7aI1suxYyPmhY73+F7w/wLL5t3RVBR2zxwk3krHG8wk
	6NR3s+6PxIgXfmOadtN5n5hbrLbq7mIHrDMAyMDEbOxyH9ZBYtrSy/0DKOBonOEA+Oi9dB89j0W
	6E0I=
X-Gm-Gg: ASbGncu9A8SignBkZwkiZ8NOuqj+7R3oOzx53aLcWErDP7+mMwW3KGeSBaXpoC91zsj
	w+eMtkrgKMWQQPFAN05b6w5DJxsvSPsI7RzBZ/VgTwUu3l5sTi0RUd8EycAolXBwyy/czYcc+uX
	nDvGiaUQDSyHGbW5ExxeSMVZZwWOGWu9UpoBqHfIbV9F9n3qlYFPAG0KIDN1+p+QgUf7fYZTOsP
	7j+u+DuyIW/DBrbx6le6Wb5KwZgPo+AgN86XgzE36/BDBm9nV3rqoQjHRIIgrYLhi7EpcP5s9rL
	w5Dn1lqf3yTIjKmhgxaPho/u5llRTtA=
X-Google-Smtp-Source: AGHT+IG0BJgd8j+dzeqsgT2AsOZzxaaMsEcJBznYblPvQ1Wc0nreo84zsOWzeYbDF7qS4VtwIFhSLw==
X-Received: by 2002:a17:907:60d2:b0:aac:43e:ffa5 with SMTP id a640c23a62f3a-ab38b1ff088mr4896266b.15.1737055869944;
        Thu, 16 Jan 2025 11:31:09 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce6890sm39428466b.70.2025.01.16.11.31.09
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 11:31:09 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf60d85238so227079566b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 11:31:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOfOh7xDFxwh7M+rxZJ6NL0kJPsHVh0sSphobKDuxY9lm5oNnKEI0nD5+m0ifktRjIXZ8Fo2K13a488tN6zF84Ch8=@vger.kernel.org
X-Received: by 2002:a17:906:d552:b0:aa6:ac19:b579 with SMTP id
 a640c23a62f3a-ab38b29963amr4361566b.26.1737055868900; Thu, 16 Jan 2025
 11:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116132359.1f20cdec@gandalf.local.home> <CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
 <20250116141800.31d519eb@gandalf.local.home> <CAHk-=wg_2zXOKH2kDAnAyvC6MDWWgyuMRqQDNTGzKJBhfVzHVQ@mail.gmail.com>
 <20250116143018.0b156e42@gandalf.local.home>
In-Reply-To: <20250116143018.0b156e42@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Jan 2025 11:30:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHUvCTurVZosKsJhPmBJBYXeN=pNCE2nnV9EWp9P5JmQ@mail.gmail.com>
X-Gm-Features: AbW1kvZBSyHG4MwS-CjjlcCCEtuqunj8iks1xRIKuaG6PE1juORqj4L-17B5oGc
Message-ID: <CAHk-=wjHUvCTurVZosKsJhPmBJBYXeN=pNCE2nnV9EWp9P5JmQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: gfp: Fix the GFP enum values shown for user
 space tracing tools
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 11:30, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Would it at least be OK to add a comment there to update the tracing code
> if a new GFP flag is added?

Sure.

             Linus
