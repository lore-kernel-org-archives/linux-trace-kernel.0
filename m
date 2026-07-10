Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F89431E50
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684613; cv=none; b=jg8USdzda0J7KMeFCaTA9xwEgc0YKAQFIcZbqiWV8w2jXqdw6nIQlaDNQKCqVBcanHIO3+f4Ljqszd433JVOQmDIs13j++rsSIn8uqOJC0+quQxsVyWPcqVPNEINNt0XmUQ5sVR6ZCCKIqYSuXRLzzgNqdYEQ/UGoJm2qq4UOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684613; c=relaxed/simple;
	bh=9TxnLfNYrPWrx2bquvirAzZJUBr6aeku6R42eLdI90k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbYaqMBGsHySrKswiPgP+qxrAi77BeoCblWzQbYjFCQ8qSxC9pmgxP/6Hd0nssGqy9nFYdBx9ZdkKgARnoiJjlYOescizey1Y4+e67XFxvccYiQ7a/vgug5VUgJlA1mOElnYN9jhPIK8nCpsWizdKe5jxjQVVXHc0Sbt8S3OvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YoEGLZpP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YoEGLZpP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-476d8e647e9so980456f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783684598; x=1784289398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Z1QOtUf+44PYKBFhNZsW3TA0rvft+x2B4hitYh+2Yg=;
        b=YoEGLZpPnGRs1JiNV5e8lo2dZs/yZh0CYvdJz53uvFhAmR4//7obRaYiwW6VHkcTuH
         pyGQQcu4PbmZoRWn/LwpeWXfyfkEA4Bde1p0J8kfl1V0gle6jLfnZo56zA1oUld/EV35
         KwpyWxwMQmSl943lQr8pptPzLLB/N4qFRHvWUXlrxQNiapjDwKonR21NDwsddRYNG2zf
         1wmzVCTV+ZKL/VqkV+XiqsCbCd7qTr5xw3hCHzP33ipmQh3x4lneZxFWgogy1pdUBwyR
         XNFcfznt3CX7LuEgJzZJC1BYShGaIH202T8sw3KeIz2t/HAuj3dbnvsO3jvopucqN52l
         s0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783684598; x=1784289398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Z1QOtUf+44PYKBFhNZsW3TA0rvft+x2B4hitYh+2Yg=;
        b=U3H5IBBmTmAXcqWVx+1jzp4eQajpHpUPQknM7HyDAE5Dso/0tVTgzQ4Rb400Nl9pMD
         D47D/kqoqjjbedwt1SfjHub4xaxuIZEK0Z3JF66WecZdl0jxfWfStC2uiQp5Pkro07e6
         s5YlB023qSmQtZcptePja8fm0o3V5jxGDZgXEOf0RCmJ5Aj12a6ixtHmlgiViMbxWJbh
         JBgj79Ss30t8n5sSVlJMZPA0+6EW/TMf7aFGeVQ2wC7eQykjc85OdH7CBXF4fo0cWJ1r
         jXqOnbPm88ch8uHzQzCkoI4jRfYGPhusXwjRGYCSe2bbCRuoMnEa1hqvjHvjB2teTDsl
         vjBg==
X-Forwarded-Encrypted: i=1; AHgh+RpfMFTqKLoOsMHtJysIFpXQWimJRi5ezFL19ReIw1xCKDoyio76zG4D2Kcod3npWFDAt+qPfms/BhSr1UsshpyMNG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5cknSZx0+ZpfxCOkUfXpKH+8pQNYuIBAZI+GXa/X8ZBeefTb
	nrSsJz87s+L1P5rqI5ZWvvkPXLu4VJrIGBOsTfX3IVWDLqKTnB7f00uEZtYRCn+GYQ==
X-Gm-Gg: AfdE7clJPfz4luhIcwY9ha+wHVI3CsT/Q0yU2q9Vko0K0MEArOT98Ptbf0LDivGJId7
	/FJ62MiB7HAf/BgJtWZl9Gkio7fTmyLj7pQUAbkAYQN7tZWRPzir6Ac9MjKefTu10v9mvN6B/XD
	PnvqS3eM04vSuHQMhSrubfy8Dm+qnnWhfi57Hjh2D7lUHQkk9QBItSjp2HaHZlQZCnP+ShTUEnm
	atyaqQ28NyJzbRVwYCZsIkYwd3srFVxckiFcO4/8Uj4Y+Ptyqfaq/rBwzb/9REK6f/uCoN9kcD1
	xHQ2fQ5WND7t9p8IC0TJuPn1gsTY9fy+ikcpoREjwjq6QqMSEjT9+tZJg1kUd3gqG//MHzn9kvw
	fTNQCJE+dKJnPF35VrPj6wPXSOXpQOKOjO9MtllAGvuoyVsyKyJqfv6XA1fQWccab31EmZy+Uh+
	6aLDom2dZECIxccTq9l7m9gnZZWyl2au4le+QMw2S0TAU8hOqO55E=
X-Received: by 2002:a5d:59c5:0:b0:474:ad57:1720 with SMTP id ffacd0b85a97d-47df07a561dmr13085174f8f.43.1783684597334;
        Fri, 10 Jul 2026 04:56:37 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm59612780f8f.5.2026.07.10.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:56:36 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:56:32 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/3] tracing/remotes: Fix leak in
 trace_remote_alloc_buffer() error path
Message-ID: <alDd8OrrcI8vcPDL@google.com>
References: <20260709160017.1729517-1-vdonnefort@google.com>
 <20260709160017.1729517-2-vdonnefort@google.com>
 <20260709191516.7a7ad6f6@gandalf.local.home>
 <alCmOw8l4e-DS44v@google.com>
 <alCm5fq3UC2JtzZV@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alCm5fq3UC2JtzZV@google.com>

On Fri, Jul 10, 2026 at 09:01:41AM +0100, Vincent Donnefort wrote:
> On Fri, Jul 10, 2026 at 08:58:51AM +0100, Vincent Donnefort wrote:
> > On Thu, Jul 09, 2026 at 07:15:16PM -0400, Steven Rostedt wrote:
> > > On Thu,  9 Jul 2026 17:00:15 +0100
> > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > > 
> > > > If page allocation fails in trace_remote_alloc_buffer(), desc->nr_cpus
> > > > is not yet incremented for the current CPU. As a consequence, on error,
> > > > half-allocated rb_desc will not be freed in trace_remote_free_buffer().
> > > > 
> > > > Increment desc->nr_cpus as soon as the first allocation for the current
> > > > CPU has succeeded.
> > > > 
> > > > Fixes: 96e43537af54 ("tracing: Introduce trace remotes")
> > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > 
> > > This patch makes Sashiko find other possible issues with the code :-p
> > > 
> > >   https://sashiko.dev/#/patchset/20260709160017.1729517-2-vdonnefort%40google.com
> > 
> > So one of them is fixed as part of "tracing/remotes: Add printk, dump_on_panic
> > and boot parameters" [1]. I can pull those fixes into this series instead.
> > 
> > I'll look at the rest.
> 
> Ha yes this other one is real too. However this is in arch/arm64/kvm/ so I'll
> post it separately to kvmarm.

Posted here: https://lore.kernel.org/all/20260710114819.2689386-3-vdonnefort@google.com/

Let me know if I should fold [1] into this series.

> 
> > 
> > [1] https://lore.kernel.org/all/20260605163825.1762953-2-vdonnefort@google.com/ 
> > 
> > > 
> > > -- Steve
