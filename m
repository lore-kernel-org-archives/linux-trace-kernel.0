Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02C3B42FF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211161; cv=none; b=Xzuswd1fC45fwaUNdUca48T60VniwZbCNOajVtPgbhStk0/pzfKs3/gYq3kqv6pHECpfB+VDghyR3t2gE+XjFX6gKN5yrz60xO9a4z5jC3Gj7+KdcMNOLetXv9a/0JkTqTGfKLdJ9ECaB7nJ+xoGXgFZ6AugU4PwDBRcWyHM5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211161; c=relaxed/simple;
	bh=IV1QldZgqzH52eVxugIeJGz+StgBDJ2F0UNDEKfNXR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T8xdQUvDbkdWpTCDVu7XUCELrIeDxf1jGTlCch0w3Vc+C7ga/1NlT2+ko9mME3KctuMKgpTDMsdh5bHVNVz9eU3/9Hm//zlK0EhjbkIzcb0heW4gcAyfML3JH32675oj0BGlA1r9l+jpOUYlCd4Bl4GMUmxPb1wlPsBYgkj0yZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHd/tT0Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHd/tT0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782211159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xl8UbG6E1hb/5jf156FSHiPb13Lnv7ruACH+pYdCnkc=;
	b=YHd/tT0YHyVxyXM9p7STJZs0P3+ob+iR2QTzsOh0wtG9t7GSl2x5o7s7uosRJA80eONfFq
	koV+0fGN0MXkEQYTuj5x0OyR9RREJyxNIDBNH27W2HG9Raln/NbSeTJvE/0YouZAXGBs4P
	9jshhvPZUP7PNynnFrfKL4G2WXx9zAg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-1EGTjoUYNUKtwR4XEGGL8A-1; Tue,
 23 Jun 2026 06:39:15 -0400
X-MC-Unique: 1EGTjoUYNUKtwR4XEGGL8A-1
X-Mimecast-MFC-AGG-ID: 1EGTjoUYNUKtwR4XEGGL8A_1782211153
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B776D1800D9C;
	Tue, 23 Jun 2026 10:39:12 +0000 (UTC)
Received: from fedora (unknown [10.44.49.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4E53F3000B50;
	Tue, 23 Jun 2026 10:39:06 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jun 2026 12:39:12 +0200 (CEST)
Date: Tue, 23 Jun 2026 12:39:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] signal: make send_signal_locked() take const
 siginfo
Message-ID: <ajpiSbciUfZr2zfm@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
 <f754c4e5c82b45bcbb770aa8bb1f4ab1d87a0b0e.1782159692.git.include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f754c4e5c82b45bcbb770aa8bb1f4ab1d87a0b0e.1782159692.git.include@grrlz.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: bXMFQdTi8sqCsm1Wulnn8csU89aQB23Ys8RcIQqLN2o_1782211153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/22, Bradley Morgan wrote:
>
> send_signal_locked() should not change the caller's siginfo. Make that
> part of the type and keep the local rewrite on its copy.
>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>

Ah, sorry... I only suggested to change the signature of send_signal_locked()
and thus has_si_pid_and_uid(). Perhaps a broader change makes sense too, but
this conflicts with another (under discussion) series:

	PATCH v2 3/3] signal: fix evasion of SA_IMMUTABLE signals
	https://lore.kernel.org/all/ajVD6ZmiSQLxjj57@redhat.com/

Now let me take another look at 1/2 ...

Oleg.

> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
> Changes since v1:
> - New patch from Oleg's suggestion.
> - Link to Oleg's suggestion:
>   https://lore.kernel.org/all/0873AC4A-3CB2-4F7B-BFE6-75D855AD22DC@grrlz.net/T/#m5f8a2d54928efff41de539969b68149e1ec5fca4
> 
>  include/linux/signal.h        |  2 +-
>  include/trace/events/signal.h |  4 ++--
>  kernel/signal.c               | 20 +++++++++++---------
>  3 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index f19816832f05..a1ba8c5973c6 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -283,7 +283,7 @@ extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
>  				struct task_struct *p, enum pid_type type);
>  extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
>  			       struct task_struct *p, enum pid_type type);
> -extern int send_signal_locked(int sig, struct kernel_siginfo *info,
> +extern int send_signal_locked(int sig, const struct kernel_siginfo *info,
>  			      struct task_struct *p, enum pid_type type);
>  extern int sigprocmask(int, sigset_t *, sigset_t *);
>  extern void set_current_blocked(sigset_t *);
> diff --git a/include/trace/events/signal.h b/include/trace/events/signal.h
> index 1db7e4b07c01..05a46135ee34 100644
> --- a/include/trace/events/signal.h
> +++ b/include/trace/events/signal.h
> @@ -49,8 +49,8 @@ enum {
>   */
>  TRACE_EVENT(signal_generate,
>  
> -	TP_PROTO(int sig, struct kernel_siginfo *info, struct task_struct *task,
> -			int group, int result),
> +	TP_PROTO(int sig, const struct kernel_siginfo *info,
> +		 struct task_struct *task, int group, int result),
>  
>  	TP_ARGS(sig, info, task, group, result),
>  
> diff --git a/kernel/signal.c b/kernel/signal.c
> index d72d9be3a992..26e8b8e1d03c 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1037,7 +1037,7 @@ static inline bool legacy_queue(struct sigpending *signals, int sig)
>  	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
>  }
>  
> -static int __send_signal_locked(int sig, struct kernel_siginfo *info,
> +static int __send_signal_locked(int sig, const struct kernel_siginfo *info,
>  				struct task_struct *t, enum pid_type type, bool force)
>  {
>  	struct sigpending *pending;
> @@ -1154,7 +1154,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
>  	return ret;
>  }
>  
> -static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
> +static inline bool has_si_pid_and_uid(const struct kernel_siginfo *info)
>  {
>  	bool ret = false;
>  	switch (siginfo_layout(info->si_signo, info->si_code)) {
> @@ -1178,10 +1178,11 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>  	return ret;
>  }
>  
> -int send_signal_locked(int sig, struct kernel_siginfo *info,
> +int send_signal_locked(int sig, const struct kernel_siginfo *info,
>  		       struct task_struct *t, enum pid_type type)
>  {
>  	struct kernel_siginfo rewritten;
> +	const struct kernel_siginfo *send_info = info;
>  	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
>  	bool force = false;
>  
> @@ -1196,26 +1197,27 @@ int send_signal_locked(int sig, struct kernel_siginfo *info,
>  		struct user_namespace *t_user_ns;
>  
>  		rewritten = *info;
> -		info = &rewritten;
> +		send_info = &rewritten;
>  
>  		rcu_read_lock();
>  		t_user_ns = task_cred_xxx(t, user_ns);
>  		if (current_user_ns() != t_user_ns) {
> -			kuid_t uid = make_kuid(current_user_ns(), info->si_uid);
> -			info->si_uid = from_kuid_munged(t_user_ns, uid);
> +			kuid_t uid = make_kuid(current_user_ns(), rewritten.si_uid);
> +
> +			rewritten.si_uid = from_kuid_munged(t_user_ns, uid);
>  		}
>  		rcu_read_unlock();
>  
>  		/* A kernel generated signal? */
> -		force = (info->si_code == SI_KERNEL);
> +		force = (rewritten.si_code == SI_KERNEL);
>  
>  		/* From an ancestor pid namespace? */
>  		if (!task_pid_nr_ns(current, task_active_pid_ns(t))) {
> -			info->si_pid = 0;
> +			rewritten.si_pid = 0;
>  			force = true;
>  		}
>  	}
> -	return __send_signal_locked(sig, info, t, type, force);
> +	return __send_signal_locked(sig, send_info, t, type, force);
>  }
>  
>  static void print_fatal_signal(int signr)
> -- 
> 2.53.0
> 

