Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608552848B2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594883; cv=none; b=cytt7yBfiEX+mhef0BJVfri0hhX2p/+09LZqFW047FPhMftKyl6RLawDY/caZnyzzv0AHhOG60cuh5k4Vcbn64kLritQrQfrjYJx47EVv8hg8xUjKejkCGDOhYqMgXgyL4qMFrZg92kQ4cZMDL4Et1Vaccn3VqiaxzFDbajAM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594883; c=relaxed/simple;
	bh=IoV7WBKUuYn16T6F/r3wlHg0NlMpdOlWlmfnqLYAMxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A+iqW8ctclDiQcNX2NEVQ7BwRmtwTeRyWPYa2kqYl9nYKkDGtRGA98MxwMwES/8MXTvAkqGngoLK0WfpIcE/JImdYAHjkjBjD3XQlhE3AHVeUJcAQ8JCi9aWMZnLwjGbCxLN778L5O8OOnt5cKN5jyaljl0XgDGbKBRPS+qlrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrX0e6mX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrX0e6mX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755594880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WBft0XKYlUGliTx+DSLRnykfjvI7iBuKLMaBXeDuquI=;
	b=HrX0e6mX9SCZPaSPfQ6qi8Cs8J5VIl9AsoG8qcf+y3Mkq6Cg5OK9Za0cLQBttWnDS453hP
	QMcS+fEkhZyb9ISaFSY1amQoreaNYtu+5Kuu/bfbq8IJaZzEMK4FgAOnbrzg7pRgJk8pyg
	NmOKzIz5wTjQWuT5wEroqzifgy2zH0I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-y6yd_uapMRGVS-EnJHyhFA-1; Tue, 19 Aug 2025 05:14:39 -0400
X-MC-Unique: y6yd_uapMRGVS-EnJHyhFA-1
X-Mimecast-MFC-AGG-ID: y6yd_uapMRGVS-EnJHyhFA_1755594878
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e87031ae4dso536396085a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755594878; x=1756199678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBft0XKYlUGliTx+DSLRnykfjvI7iBuKLMaBXeDuquI=;
        b=aYFgJyJZyT4BBd3t/ZmRNiXRz0XZrMdK4bp+4cvLaPVvTnsXJOG1YLzs5juv2K/9dl
         GafE6gVFfZj0AlERLv3yWC2ODk3FGbZ7od9To/Af1hyE8mOwpFZjW5db9h2nSnykj9Uq
         nAyPgrluyCAgCwrecCQnS5e4M3WaA2yZATUxS/KHVITxB0fvo7xlHni4yMcQBtKbfYj1
         SHiwGolfRKqwjzjzS7YlYiu5xzyHPMd0J2qoHSeu6NXk2q6NGXdynFBgrJptCcw97TSF
         HYh9i4J15Ob6EX8cuiEQ15+bgcduQLYzEfe/V1ulsZ7QHRRGTVHoZe/xN/cRPHI9b5ln
         Hv6g==
X-Forwarded-Encrypted: i=1; AJvYcCWoOVAv0i09OVO2I3liXYdCYbd3UranD9VdXQl/M6zPKGoaC09Uw4r4YzEPagnmvy1iJPAtaZzLyxKjvEDGtqohC84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrrWVv1wvokLRPB9j9+7/oI21bjbhkpx0PBzUMmNm5Mr0rogas
	xoo1xazRJQnyu/4/dkwoXOqfpfdw5B/qHx7NM5PzlvNGrP/gAsF016OXrvonexAKeSpkOeClWTy
	chHwD+FdtmsE5pR+zQVjhooXy8Bw8QcF8u9uNO40W7tyjRahuZwaC+F1fGXbN9wxwT8v5aALHIw
	==
X-Gm-Gg: ASbGncuwSCqB+rzUbYkssDO3Ox8MHs+N1X4A9OPJbfb1yCulPu4wlHTOSXEKsykFUtJ
	rMlLpYbHX+yFoDuJpj2q96HjdVSiRDThpbaRYuhU9Zy/i1zMhOWsgwqWBZ6KxGo19m3pitUL+gr
	6+2crWTzKYX4CTMOEGzBtjpjyt2ZOSyUyACHik+mY0oPfwWgSP6lsU2Rd0Bl64/82bLPFrtB/q5
	+/UIOzwQp3uM98MxNqcXsacFwIljT/j0Kb73RycGjD6tW2FsyPnlGNkVr8G1ySClzDy1rf0KZMQ
	Iqs3g21aLQpzkoY/0Vnm3V8VjWygvIMZjJb8znX1sGGa9ClN7maQV44jkjrIZlgyfKYt
X-Received: by 2002:a05:620a:a48b:b0:7e9:f81f:ceba with SMTP id af79cd13be357-7e9f81fd24fmr40071385a.84.1755594878516;
        Tue, 19 Aug 2025 02:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmEoj+Ud8zs9th52SpZwFEUaYKQf8oz1qBWLxnyzGAiTxqSStJPJDiPCnTXIiBo4xdTU/u7g==
X-Received: by 2002:a05:620a:a48b:b0:7e9:f81f:ceba with SMTP id af79cd13be357-7e9f81fd24fmr40069585a.84.1755594878120;
        Tue, 19 Aug 2025 02:14:38 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87f16f9ecsm712066085a.24.2025.08.19.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:14:37 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:14:32 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 11/17] Documentation/rv: Add documentation about
 hybrid automata
Message-ID: <aKRAeOakjiwmgML_@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-12-gmonaco@redhat.com>
 <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NB5tSJz6RVEKygFdWKSLJFf1VFTuuk8vljNC3_eY1rs_1755594878
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19/08/25 10:53, Juri Lelli wrote:
> Hi!
> 
> On 14/08/25 17:08, Gabriele Monaco wrote:

...

> > +  static bool verify_constraint(enum states curr_state, enum events event,
> > +				 enum states next_state)
> > +  {
> > +	bool res = true;
> > +
> > +	/* Validate guards as part of f */
> > +	if (curr_state == enqueued && event == sched_switch_in)
> > +		res = get_env(clk) < threshold;
> > +	else if (curr_state == dequeued && event == sched_wakeup)
> > +		reset_env(clk);
> > +
> > +	/* Validate invariants in i */
> > +	if (next_state == curr_state)
> > +		return res;
> > +	if (next_state == enqueued && res)
> > +		start_timer(clk, threshold);
> 
> So, then the timer callback checks the invariant and possibly reports
> failure?

Ah, OK. The 'standard' ha_monitor_timer_callback just reports failure
(react) in case the timer fires. Which makes sense as at that point the
invariant is broken. Maybe add some wording to highlight this?

