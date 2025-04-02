Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3C207DF5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Apr 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578320; cv=none; b=O278tRH8L9iZ8mB2fCW807Xp8cVjCrfk7kjZEsZE+hoEF+XMIg4Obw8a0VJ+AXts4+8vuwnE9S3PPp0uworyUQwXpSJNElbmYeNqAkpo0jTEsI8aqxOBD68+iQ4IG8hDI9TsHhfs1zHISiOP9kIQcDsBYNyToxseltVbARMPssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578320; c=relaxed/simple;
	bh=rjEzmnr1+2wjq2FxTj4ZIbqL36uWLhzyqELF4hjcmb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl/ljOeX5xdqQ2e0jqPEvLvf2E9m+hHFYoO7rLYkPZRDDu0Bo5NVRMiPawdyh3iyEvX9AmnjBoKp8VmnOBnX01fmEx0jw2VOZZXZZcA0qGQ0yV8ZCNbDOnRZ6l/ZfyrAB7mspmbPXiUc2iMl+2g0Lm6h867UKDfEou67aAYIl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AfY1RVlW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AfY1RVlW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so41585825e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Apr 2025 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743578316; x=1744183116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0eNMuQ6+Ok777NsoTbkMeCm6WNQ+H1nK9Grprmoglc=;
        b=AfY1RVlW9XQmP7xzI2DNsaWJ45+U8MgmD0aLQcJyZcezFt1PKA0bvc/zAW6yzhpoic
         CzGB5YFyBAexQYzTd/SXfCdJ6XIiTwhFRRIaAHVbb6rrGCxTVw1Cv9HjU5H7x5rAyJ9k
         elC3LgSXMhIpysPT5pIDSdSNLLy+ouP0ZruPayBZq54nLHz9Fnkg/htKDvRZctxUzgRS
         sxrJ/psnN2NGNf8AGr0Pg2hhwyjinIJVaCkUHKe2QlvgXWDzNUZlM1TNiIInFh1yfSgK
         +VcfMK1PJfLr+XvKuyXPywUqQY5BKm5K9bjPV4MTV1Pjn1xs1yA8t1J3HbBk4zg/c7u2
         sl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743578316; x=1744183116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0eNMuQ6+Ok777NsoTbkMeCm6WNQ+H1nK9Grprmoglc=;
        b=Ep39U5GSpK1NAS6TWb8cVAIomMYL2EnKygC/WMvPJ9Ljhre+DtgXCDPtuQ0GSLcAh6
         86nd+UhEbSVwNl5jgoJS0eNn5bfplD+0TmtJ8mpotXm7OCs68zKZa5A8LrAApcMjw8vM
         LLBcwQk5MajNS++Ydpd+Lxg4+hJPLmq9J1spssTgzxW3/EJrqhnR9YQG3V6/ZuRwVLLh
         +WLraGwDVCQizHl1IG+GeNiG9LXg2aJmvp0Aw2IbVVIqPmr0XqmiFkQ8aF2RUN7e1VZs
         UxvUBzEXok1MSpafjpWqt60BK3OlBb6vnRCHYQwbtdghKC3yXyE34VwVuY0hneYDpNPb
         EtYg==
X-Forwarded-Encrypted: i=1; AJvYcCV2tYX0NU7IbOX8dCpUGIoeQ444axNwG1MFKuSydgDCenJNgZiCtV72YZaRvwz3+VYtMsXQ6HG+QUpvhnKcfdgxMzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhMcbwXPRw5zuflIoK93EzQhk9u3+JxFeJv0VKdnfobzp3BGUG
	J+BJ79OBlI6twwM2i0vG8xg7ghrOag9Qujrd2aVtgAI34/VcUrp+6UvtE9UXoKTziHSjFq1KN3I
	t
X-Gm-Gg: ASbGncuEMXUgBZOUFumWqA8XfZGRbfvzoo2ykWkkzitGO5c4XVp4lHCXZr1C3+/d9JB
	yaf1a7m0mnayKm/J6uEETzv7yCcUTMFL5ihD5AcS79fMSshZ1TR5sDa9C60wZScTJuzhTg8xrbB
	bxmbKShDVltZlM7j4TOVEiLWZJaomUY+HQTjBD2Mtq4IrRdWi6gU+TGj7lNTm1dQryB/8re9EuF
	owTRhwqq0VF5GfWe1aXCAKVjwLSYU0xvCe0F17/zvBYZ9k2lLt5b0PhGpOzDbrLA+CtQyTJ6erY
	ZMvN1f+ICyaFl2Ei9ZK+RvXrla6tWZHjLUp/63O5roywjm4yS5lpXtEsYn7An/rlPAEi
X-Google-Smtp-Source: AGHT+IHQ9iNu+elipxYIEZPm2TvVq8PRAYgvNwvPs5tGfD6BvIXUlyeIxgVszh67+jwKs4A4yZZ0tw==
X-Received: by 2002:a05:600c:444b:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43eb5c188bemr8972985e9.14.1743578316325;
        Wed, 02 Apr 2025 00:18:36 -0700 (PDT)
Received: from localhost (109-81-92-185.rct.o2.cz. [109.81.92.185])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b79e393sm16360517f8f.72.2025.04.02.00.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:18:36 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:18:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com, oleg@redhat.com,
	brauner@kernel.org, glider@google.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before
 current->mm is reset
Message-ID: <Z-zkylk6r_rZ5V_K@tiehlicka>
References: <20250401184021.2591443-1-andrii@kernel.org>
 <20250401173249.42d43a28@gandalf.local.home>
 <20250401173416.45a164c8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401173416.45a164c8@gandalf.local.home>

On Tue 01-04-25 17:34:16, Steven Rostedt wrote:
> On Tue, 1 Apr 2025 17:32:49 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > static void exit_mm(void)
> > {
> > 	struct mm_struct *mm = current->mm;
> > 
> > 	exit_mm_release(current, mm);
> > 	trace_exit_mm(mm);
> > 
> > ??
> 
> That should have been:
> 
> static void exit_mm(void)
> {
> 	struct mm_struct *mm = current->mm;
> 
> 	trace_exit_mm(mm);
> 	exit_mm_release(current, mm);

If the primary usecase is to get an overview of the mm before exiting
then this is more appropriate.

-- 
Michal Hocko
SUSE Labs
