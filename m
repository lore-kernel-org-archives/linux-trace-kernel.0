Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562046EC99
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711839; cv=none; b=Z4VnG6CmDHvjlmG6euckJosobH7RAfTKyWy071OvhXKfDQ21qakMLAp0dQ6piDRdEF/8IaTq9op4ADOXknU5kfPi9Et8In7WLgSqXsUXkXEjiwdhhX75nkItGKoTpDujeWynqEBWHFikn81WejCLDMdKSsGEWy2NLvfMesqsdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711839; c=relaxed/simple;
	bh=uXGXqhKxPO3WVfEUtCn32UUny8ZMo3y4i5IfgvuftYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fggqJkD/m3s+a3d0ytXcsoflYafNolWQS4Yv/QMoCZ62xVor2T0LzCpm+3Bk2u7CO10UcZhj3g4i0Nqrt8u3oyACPGZk60AJsFWshiwKZhogHMr0TitjYHk7yeI9tJHcbAgYA20NQuVvIHljZW/eEtMmjRHB2IE8Cpxt1W2BOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pR6R+JZ0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pR6R+JZ0"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so873463f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786711835; x=1787316635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uvfjAp3XMuQILVAte78Ci8+jrJErkZx5cSt8zSfGlwA=;
        b=pR6R+JZ0+l3MGxpjB90N9OR/AXFvAbhIjRA8bo3NcrPujYEx4yh4VDjy9A28sna+qb
         D/kjtrB/7I6hukBF+drDyEyRhDlEoMQ4nTRf4CUCkX63zE0ejnYNqSL5qBMLcwDZfI8p
         aQVLs69GulGE4/NHasS7SezOERhzYCVSMVqXz7hThAp0SmI5N7ptMDcuXy2EE0Dr4auv
         kDqHkXFwkMXVQGNQdT+96DuoPyUmlnObtRPKNJp1slRZDVSlwLYdKPUamcWWg4f7cc9K
         VYxYcOKrG6wPQhbrdbftmBd9ruyr5ozPdTz0B+lk6aEyg7TXElcOlu0n88XbDNn816Jm
         TYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711835; x=1787316635;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uvfjAp3XMuQILVAte78Ci8+jrJErkZx5cSt8zSfGlwA=;
        b=c7xcjKx8lQtCIpf5RWXkVLbT5v5PD6lr3hfAw0YSJyOZua1O+rfGoBijwv5EYimc8L
         jeCkk14F7XLZE5JCG7LoTq6+qXl1YqjG1cP1S3qg6JvDfWAKC8EFrJreZw/fWhcaodAp
         ei4vZh+paK9idENY1UtZwhjQhvv7JSsv+pjg7U3PYN8rZTdUNejzNEWIQbSiT2Jsz37J
         fFm5yoSj5Uy38BIPXZ+bHlQIOgfs2MIR8w+gm5QGy+oXKajbt4+vvuoFFwr3mh9Vc11A
         Wg0t44EWQaZtgDs/Wrrv+lbVk55qKOanNBC8Jz517r0/sWtdwemb6iL+C6dl+dFoe80Z
         M8Dw==
X-Forwarded-Encrypted: i=1; AHgh+RobHGUeCJUo2sandGuvjMfe2OzpWWYsGZqpUG3HNHX3GnY78rCt7+eJPRtLW15k2TS5geq8vs6qqIPYzXxHSQzAwws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4Qd2FPidawdBRT1mfkNHqebEMR1zkt4sBapFdlmaSjh01od3
	Mc+dOJ5wb9k8Puea6SLYmqMcCVEgNY2i6O3IzIPEAXIn+UGXxPTUYGxx2iRBTbGKAw==
X-Gm-Gg: AR+sD106Ge3t83ErRPfC3m+Z/UsqAyJi9ddsgyr0eEAguVfi9QgR7XqCww9RJjO2C70
	dTC0isXF+GdHGNn8q4LoWmA761ToYxTZQnBPIfOX89Wue0EKL7jizZBxKHA4DvyYG8oEA09OzCx
	qHIQIyrLl4o98G6B5nm/jANXfpzejj+Ce2qCpvmfHkoJKgXq1ZMz5HI0MF+7kXSjR6cWcypAZTZ
	xSYCXFh0v+l4rrUzbAbzMkf9j1yHZ04ah0oiCR3EWUKAsGTRnt36hfWKynCb+AoFVsqClPX71rx
	xOXuse1hI0gr9z4c5IzHg7341v1e8s+q633nQWpivEPeoLdvm1epK4MNN29kiwUCY4WAD1Zf4N1
	n0v0EMJfWpziLJwug1cM7cCgEtTIvdMlQfIEbC1GU7ZhWREBSiArFkW8m3uI40mRqKgevMe8fJC
	d0LPgSvDV/yfFn0vuYnlqsWTtCMzDuqico9/EWnuWaEU0E7TtQlvy6MTRtm3h4snD8UC8eC7ZUt
	a9fyA8ZUJlQmLsQwd2b4/cYL5gZFsChRPgs6rc52zg=
X-Received: by 2002:a05:6000:41cf:b0:47f:9464:86cc with SMTP id ffacd0b85a97d-4816070c29cmr9255251f8f.2.1786711834244;
        Fri, 14 Aug 2026 05:50:34 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f229681sm6673098f8f.16.2026.08.14.05.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:50:33 -0700 (PDT)
Date: Fri, 14 Aug 2026 13:50:30 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/10] ring-buffer: Dynamically calculate max_data_size
Message-ID: <an8PFkt0XECni75Q@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-8-vdonnefort@google.com>
 <20260813213407.6bc29cc9@gandalf.local.home>
 <an7K08bEyc70erD2@google.com>
 <20260814084612.75a15682@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814084612.75a15682@gandalf.local.home>

On Fri, Aug 14, 2026 at 08:46:12AM -0400, Steven Rostedt wrote:
> On Fri, 14 Aug 2026 08:59:15 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > > Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")  
> > > 
> > > Why the fixes tag? What is it fixing?
> > > 
> > > -- Steve
> > >   
> > > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>  
> > >   
> > 
> > I wasn't too sure about that one. Let me drop it
> > 
> 
> I already did ;-)
> 
> When sending the next patches, please base it off of:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  ring-buffer/for-next
> 
> As I applied 1-5,7-9 of this series.
> 
> Thanks,
> 
> -- Steve

Ok, so I will respin a v6 with just PATCH 6 and 10

-- 
Vincent
