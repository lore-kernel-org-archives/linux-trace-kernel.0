Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070061D529
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ao4m+7og"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40b5155e154so139814005e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704308703; x=1704913503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OKmjMzWb7Jj/X9j8Rv82hF1TJV7D5FriH7ZLTHY6fDQ=;
        b=ao4m+7ogigntnvTeyIC59CGV9tn7ofZAVy1dd/7fCULOJRl5vI0JEC6tQLnl7e9eJg
         N/gz/zOXgU6Ib+H+s8fTUWfY96ECOWOOKO0No+y2hzF3VRBk+KqaSl4C9CMnXtYJSAf3
         0r4fvMOXzciyDZdGx/86ehjkSunwpu5xHL/mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308703; x=1704913503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKmjMzWb7Jj/X9j8Rv82hF1TJV7D5FriH7ZLTHY6fDQ=;
        b=LTu32Fa8HTdITzh3BagulsAa34WHe6hko39o4SpCuEQfslL6GhRxaf71zt4MGfZGIT
         N2i6ztwY8Bqv76jPwWCVAYlLvu0qUbbQxULVY7ZHlCJflo+/zlaamuk7eDejwwFvzoPR
         LcMyEogqniG0GOJBWpHFjKUiWc2UtzQudsgyPBMgVi1YQShInyV+TIpje4aNYAja0hyM
         CInOfQOenQP/Dlv5ERrgCwj9IlZxtQjVYLZGjwB+2iEp0BlJ3+kSeXmNixvpbhuA3ajz
         1iNz+1hOCJCEQUqeD1Gzt9nOBnMZ6tDbaeskljsOlIo0F59yAR6yDGb0C5Z3K6+LDsTw
         EWAg==
X-Gm-Message-State: AOJu0Yy9sTQblTzo2Lnae7cnnYrextgcaSpUNIDQQ4nQTkTGj/qhofY4
	jJiTEV4vjVaiP+Sc9i+TYWS/r0wolxopaMn9ga0230ut/Dst5uRU
X-Google-Smtp-Source: AGHT+IHLgA1BFY5U6F78g7EEKPORydX859uR/kSuxeTuphQrTSvfLhWwg6gtV94YiQvN3NQ1ecxusg==
X-Received: by 2002:a05:600c:5192:b0:40d:889d:8e8f with SMTP id fa18-20020a05600c519200b0040d889d8e8fmr2469112wmb.126.1704308702640;
        Wed, 03 Jan 2024 11:05:02 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id fw22-20020a170907501600b00a26b44ac54dsm11785941ejc.68.2024.01.03.11.05.02
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:05:02 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26fa294e56so729658666b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:05:02 -0800 (PST)
X-Received: by 2002:a17:906:b114:b0:a27:59a2:93fc with SMTP id
 u20-20020a170906b11400b00a2759a293fcmr5684885ejy.107.1704308701823; Wed, 03
 Jan 2024 11:05:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com> <20240103135102.38352956@gandalf.local.home>
In-Reply-To: <20240103135102.38352956@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 11:04:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcVh71g2G-cQQBV_65jM2WJ916oW6Bv0+=xppNtE6Fzw@mail.gmail.com>
Message-ID: <CAHk-=wgcVh71g2G-cQQBV_65jM2WJ916oW6Bv0+=xppNtE6Fzw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 10:50, Steven Rostedt <rostedt@goodmis.org> wrote:
> I think these changes are a bit much for -rc8, don't you?

Oh, absolutely.

None of this is rc8 material apart from the oops fix in your pull
request (which my patch that then removes the whole function did *not*
have - so that patch won't apply as-is to your tree).

But let's aim for a tracefs that doesn't play games with the dcache.

Basically, the dcache is *much* too subtle for a filesystem to mess
with. You should either:

 - be a fully virtual filesystem where the dcache just maintains
everything, and you don't mess with it because you don't need to (eg
tmpfs etc). Everything is in the dcache, and you don't need to touch
it, because you don't even care - the dcache is doing everything for
you.

 - be a "normal" filesystem where the dcache is just a cache, and you
maintain your *own* file data structures, and just get normal lookup
etc ops, and you don't mess with the dcache because it is just doing
its caching thing that you as a filesystem don't care about.

and in both of those cases the filesystem just never has to really
delve into it. But tracefs had this abomination where it maintained
its own data structures, _and_ it tried to make them coherent with the
dcache that maintained part of it. That's the part I hated.

               Linus
