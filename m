Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209931E84E;
	Tue, 23 Jun 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226197; cv=none; b=K3C2KT2mkZS9JgKDaygwhGkRQYyac+1UKqFRYDRUR4t0GRjDlkssGiUG9NpXavcjtmw5UobMy1QeR2PwBQzg7cu0E1H0MbZf6fAklr1JEXHU8Nd6FwluQ8Nma7n6JNZj6OXqdp8x0kB91nY6pkwWnTgJnMvO61c5FlSxDEpbmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226197; c=relaxed/simple;
	bh=QfTvAy+x1hC49KvWQqLJof0UTqMaIGPP7koTnJ+x7RU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=T4W2J/t+XC8QA2MRXZ8O2W5VrDNQ7yPhsimkFeIPlnsAD5ASXdRNjzh2v8fa4PIb4ec0Dyc8HFypbnnjvwhYwAUrNZFVpcvpQIWct58ZhTueJl5Ngd2CLqf6Cmo9gv/YQphOGkT449NRZsxAz0iDr9nZqm61eW+OqPFHSazvu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=KtIlrF0C; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="KtIlrF0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782226192;
	bh=o2iXiKw3WOFmFNd4p/XpLc0ehaPGE9uKhnvwB827W9s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KtIlrF0CJd6PlDbBin6ES7N6eZiCHKPxLej6e6lmD681M6SCvYFGQ5azdNTEqd0pv
	 wLFwM/yr156kYJFeJbbxAe+feZ4X0idvYxBen+UtIzIUnNy1uVKbqKkurfZWuugl1T
	 satLVYT5aB2ahVxLQbCIqlfVAevdmZHvWjMZU73g=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gl7Jc1RkgzGpHy;
	Tue, 23 Jun 2026 14:49:52 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gl7Jb5424zGpHd;
	Tue, 23 Jun 2026 14:49:51 +0000 (UTC)
Date: Tue, 23 Jun 2026 15:49:51 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>,
 Aleksandr Nogikh <nogikh@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Adrian Huang <adrianhuang0701@gmail.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_signal=3A_make_sen?=
 =?US-ASCII?Q?d=5Fsignal=5Flocked=28=29_take_const_siginfo?=
In-Reply-To: <ajpiSbciUfZr2zfm@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net> <f754c4e5c82b45bcbb770aa8bb1f4ab1d87a0b0e.1782159692.git.include@grrlz.net> <ajpiSbciUfZr2zfm@redhat.com>
Message-ID: <09C44F05-1ED0-48F1-A9CE-F120EE48B07D@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On June 23, 2026 11:39:05 AM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>On 06/22, Bradley Morgan wrote:
>>
>> send_signal_locked() should not change the caller's siginfo. Make that
>> part of the type and keep the local rewrite on its copy.
>>
>> Suggested-by: Oleg Nesterov <oleg@redhat.com>
>
>Ah, sorry... I only suggested to change the signature of
>send_signal_locked()
>and thus has_si_pid_and_uid(). Perhaps a broader change makes sense too,
>but
>this conflicts with another (under discussion) series:
>
>	PATCH v2 3/3] signal: fix evasion of SA_IMMUTABLE signals
>	https://lore.kernel.org/all/ajVD6ZmiSQLxjj57@redhat.com/
>
>Now let me take another look at 1/2 ...
>
>Oleg.

Aww. My bad.

You may keep this shelved in case :)


>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>> Changes since v1:
>> - New patch from Oleg's suggestion.
>> - Link to Oleg's suggestion:
>>  
>https://lore.kernel.org/all/0873AC4A-3CB2-4F7B-BFE6-75D855AD22DC@grrlz.net/T/#m5f8a2d54928efff41de539969b68149e1ec5fca4
>> 
>>  include/linux/signal.h        |  2 +-
>>  include/trace/events/signal.h |  4 ++--
>>  kernel/signal.c               | 20 +++++++++++---------
>>  3 files changed, 14 insertions(+), 12 deletions(-)
>> 
>> diff --git a/include/linux/signal.h b/include/linux/signal.h
>> index f19816832f05..a1ba8c5973c6 100644
>> --- a/include/linux/signal.h
>> +++ b/include/linux/signal.h
>> @@ -283,7 +283,7 @@ extern int do_send_sig_info(int sig, struct
>kernel_siginfo *info,
>>  				struct task_struct *p, enum pid_type type);
>>  extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
>>  			       struct task_struct *p, enum pid_type type);
>> -extern int send_signal_locked(int sig, struct kernel_siginfo *info,
>> +extern int send_signal_locked(int sig, const struct kernel_siginfo
>*info,
>>  			      struct task_struct *p, enum pid_type type);
>>  extern int sigprocmask(int, sigset_t *, sigset_t *);
>>  extern void set_current_blocked(sigset_t *);
>> diff --git a/include/trace/events/signal.h
>b/include/trace/events/signal.h
>> index 1db7e4b07c01..05a46135ee34 100644
>> --- a/include/trace/events/signal.h
>> +++ b/include/trace/events/signal.h
>> @@ -49,8 +49,8 @@ enum {
>>   */
>>  TRACE_EVENT(signal_generate,
>>  
>> -	TP_PROTO(int sig, struct kernel_siginfo *info, struct task_struct *task,
>> -			int group, int result),
>> +	TP_PROTO(int sig, const struct kernel_siginfo *info,
>> +		 struct task_struct *task, int group, int result),
>>  
>>  	TP_ARGS(sig, info, task, group, result),
>>  
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index d72d9be3a992..26e8b8e1d03c 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1037,7 +1037,7 @@ static inline bool legacy_queue(struct sigpending
>*signals, int sig)
>>  	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
>>  }
>>  
>> -static int __send_signal_locked(int sig, struct kernel_siginfo *info,
>> +static int __send_signal_locked(int sig, const struct kernel_siginfo
>*info,
>>  				struct task_struct *t, enum pid_type type, bool force)
>>  {
>>  	struct sigpending *pending;
>> @@ -1154,7 +1154,7 @@ static int __send_signal_locked(int sig, struct
>kernel_siginfo *info,
>>  	return ret;
>>  }
>>  
>> -static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>> +static inline bool has_si_pid_and_uid(const struct kernel_siginfo
>*info)
>>  {
>>  	bool ret = false;
>>  	switch (siginfo_layout(info->si_signo, info->si_code)) {
>> @@ -1178,10 +1178,11 @@ static inline bool has_si_pid_and_uid(struct
>kernel_siginfo *info)
>>  	return ret;
>>  }
>>  
>> -int send_signal_locked(int sig, struct kernel_siginfo *info,
>> +int send_signal_locked(int sig, const struct kernel_siginfo *info,
>>  		       struct task_struct *t, enum pid_type type)
>>  {
>>  	struct kernel_siginfo rewritten;
>> +	const struct kernel_siginfo *send_info = info;
>>  	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
>>  	bool force = false;
>>  
>> @@ -1196,26 +1197,27 @@ int send_signal_locked(int sig, struct
>kernel_siginfo *info,
>>  		struct user_namespace *t_user_ns;
>>  
>>  		rewritten = *info;
>> -		info = &rewritten;
>> +		send_info = &rewritten;
>>  
>>  		rcu_read_lock();
>>  		t_user_ns = task_cred_xxx(t, user_ns);
>>  		if (current_user_ns() != t_user_ns) {
>> -			kuid_t uid = make_kuid(current_user_ns(), info->si_uid);
>> -			info->si_uid = from_kuid_munged(t_user_ns, uid);
>> +			kuid_t uid = make_kuid(current_user_ns(), rewritten.si_uid);
>> +
>> +			rewritten.si_uid = from_kuid_munged(t_user_ns, uid);
>>  		}
>>  		rcu_read_unlock();
>>  
>>  		/* A kernel generated signal? */
>> -		force = (info->si_code == SI_KERNEL);
>> +		force = (rewritten.si_code == SI_KERNEL);
>>  
>>  		/* From an ancestor pid namespace? */
>>  		if (!task_pid_nr_ns(current, task_active_pid_ns(t))) {
>> -			info->si_pid = 0;
>> +			rewritten.si_pid = 0;
>>  			force = true;
>>  		}
>>  	}
>> -	return __send_signal_locked(sig, info, t, type, force);
>> +	return __send_signal_locked(sig, send_info, t, type, force);
>>  }
>>  
>>  static void print_fatal_signal(int signr)
>> -- 
>> 2.53.0
>> 
>
>

Thanks!
