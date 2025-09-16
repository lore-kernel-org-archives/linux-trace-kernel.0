Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDF219E8D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046999; cv=none; b=mlHNCCZbqIKXgpA88nNwjEEIu0iVcavn6YOWFcV3uRyHvXx3Zww61zN0T9zUFzgosBHWC1ku9pVsPEfjOfmxulAT8h0+P7RXYPdkBJJ8+rcbXwWEH7/ALOm6FJKk6kQ7KvPYfBjA/m0aWNPw1/SBq68Irc/4Xkyd9nH42PGuGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046999; c=relaxed/simple;
	bh=MWP0yXO5hqblKAsf86sVb92EBQ6Tee6NsUCw9nEvo9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqcuYEvS002xSQ3cPan8V9WM/JY6Y7otS7cXKibH6f1+K2QHq1kqxNpS25pG6URU7sQeOhi3SXwcadxHGy6djqv0J0Nq3N+bpIpEbFXW5ag54WbPMRLykBI2Ls4ZFlVLbJ/O0/Ei6AQ8iJzpqHipw42c9R8GdrOwR7XlcezCJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHZOcV+c; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHZOcV+c"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2637b6e9149so26375ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758046997; x=1758651797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxUZE7TC0xZyMAyFa+6mdSBsb32RFob5X99goi87Xdw=;
        b=BHZOcV+c6MvOfCF65mjwe2IECKvFxVl2aV2YgpzUCnkCAPcYhJJVMweggAcfmmLOIe
         2RV9aX5ubl/xGN/A9Lkl5iHYRnNCxLahMeFB20QpHZ9A2tT5gcx7soK4U/UpdeuVma3J
         i7n2UtmYDVwc1SaptmDPUfClDnslr+ozNmj5dYzjpjQezKEsa78W3yEy7ZoHBtB5t6LC
         mGTdm6imIgfYUrVjpyDpmmZPjgaLHYwlkTGoOq3oyYSpDSrPFi7DGlmKfh1sENmglEgC
         VTzOtoHzZYMDNNZSWa5FLUzvl8D2OI+o2UaZmkoxNav7lwfybTzYQRQCeac5o7ljViKc
         5rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046997; x=1758651797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxUZE7TC0xZyMAyFa+6mdSBsb32RFob5X99goi87Xdw=;
        b=RIDumqnr0E/KFrc/S/zupDtXb7jL1ZrTQWt6gVwgp66HLRxxMN2XhB/B4iO/E7YhMY
         R6f0x6wJK2lDSsCC4c5UZGNUHBNVOybLtSFfiN7xgviBwqrM7bXuVMOwd/DRKoGGi4yO
         LeC9/e62Ead5m+vl37YHn9CYfr/6lCUqhRRi3Q37TyEQFydRJJifOQzhDoCWOIyzt0mK
         0VHYmdE31GXnvrbVQR+6qGRBPAk7lI2ze1zGEAG7wnOL9xkcP/GQhI/fLZ/0ljHdYMoo
         ndV+BkzxgIDpFXzF1bQwNp0ImHGgIHIdwdzjONRfO7/a2b3qSmLpVjswocyWIOmeNtC+
         c2dA==
X-Forwarded-Encrypted: i=1; AJvYcCXo1aVB5pHufiwZge3kRyvvMEKqb8jZt7BpIU+i5dyfVF4goBOBXkF38Uxd0dmecPbhTYLlF7tGmlCB1im4xgGKP34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwbWL/MlbG837A6kBSoIL9MPjaj07ozvj/EO8vNRuofXFtBdO
	MExGK//sM99UQTKvcqYm9DcxtmKfYCOoxF7YaXy273At0Hf+FwDp+h7ti7koa+bxqxIdWC55htO
	lIHkg+cknu/QSKNiDBc0zwtm8Z2hK6WsVlnbU3bT/
X-Gm-Gg: ASbGncv5N+zh1IlBxgeZPnarI3v0wNupPtdjbfruJE97vFN2Euyk84ePzDtkn5Wx2Tu
	QAUf3oKd9v42HK6N1BwkwKnj8UA5ynvegf3AqaQyAnLq6a+3Inb4UIQrakXUfW70Mh6e+eKn4MX
	Y2a8Q1UMuWSPkr/3TDLVhQMxGsgQ3c6WexmevhLZZJWb7Xb7DaNb+3iUa7QwBk4EYpjWTHA3+bP
	IHdrRZ8XZvdSgiQdl280IOwz9Op4oht81k2/RwXhmAHlKXTF8BfQ+I=
X-Google-Smtp-Source: AGHT+IFeMeqAy+cuIfy8BDPUr07CVnLWSx0isY1COTxmQUhbfeHhUc/gJKs+z9vTXpQo6NDvDMpWAnnnlJDkjgySN7E=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-2680120ed16mr333025ad.3.1758046996934; Tue, 16 Sep 2025
 11:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com> <20250915194158.472edea5@gandalf.local.home>
 <CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
 <20250916115220.4a90c745@batman.local.home> <CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
 <20250916134833.281e7f8b@gandalf.local.home> <CAC_TJvc6aqjBRZ05wyGb49AU+-aKpSph=ZSk3fdV2xraXi-_nQ@mail.gmail.com>
 <20250916140245.5894a2aa@gandalf.local.home>
In-Reply-To: <20250916140245.5894a2aa@gandalf.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 11:23:03 -0700
X-Gm-Features: AS18NWDeydKXZzxWqGElteJppqO6QozHlpb4s_Ylp5BcEhKGMmDvVoyYUojBOGg
Message-ID: <CAC_TJvfAQDiL9PydWnKE6TDMcCzw0xrsLMZVZLe6eO0R1LODhA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded trace event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:01=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 16 Sep 2025 10:57:43 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > > BTW, why the hash of the mm pointer and not the pointer itself? We sa=
ve
> > > pointers in lots of places, and if it is the pointer, you could use a=
n
> > > eprobe to attache to the trace event to dereference its fields.
> >
> > In Android we try to avoid exposing raw kernel pointers to userspace
> > for security reasons: raising /proc/sys/kernel/kptr_restrict to 2
> > immediately after symbols are resolved for necessary telemetry tooling
> > during early boot. I believe this is also why rss_stat uses the hash
> > and not the raw pointer.
>
> When it comes to tracing, you already lost. If it goes into the ring buff=
er
> it's a raw pointer. BPF doesn't use the output of the trace event, so you
> are exposing nothing from that. It uses the proto directly.

My understanding is that the BPF tracepoint type uses the trace event
fields from TP_STRUCT__entry(); whereas the raw tracepoint type has
access to the proto arguments. Please CMIW: Isn't what we'd be adding
to the trace buffer is the hashed mm_id value?

>
> Heck, if you enable function tracing, you are exposing every function
> address it traces via the raw data output.

Right, security doesn't allow compiling CONFIG_FUNCTION_TRACER  in
Android production kernels.

Thanks,
Kalesh

>
> -- Steve
