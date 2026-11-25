Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615288;
	b=p9BZkzycep/0gD6fRUwDeoJxDBE8n2R3qbkuFjG5bIwX+9tVEyi0T631tjIUeJUML9DX
	 aJg2XodfdKS7731wEce69x12Z4MYvNoZZiuZE4yuK/Mmg12AZ6dzhGvZH5FsJCqDcWbVY
	 cbJzjY4uShehL6XQDn82CYoR7YugjbeUCcyTbj9+jwXkrozzBMmWvllWhc9Gv0bDfq/y5
	 UfRQqzzXhCMxfiw3jFlAKnEPYfB31B52OAcDCtaMveC52zHJKWmC58+xQufLDLh5pY1iM
	 hitX9p62qd1zlJxEVRl9Abo2udCL2Tu6WWajZhm/o0oCZiXWPhQdI+dssXxkReEBaRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615288;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=RfXl4FRDDVW1X94ViYdkTXaMgGXqsvI0xJ4HQkDNBN8=;
	b=L6rPzJhbpPqy4Sm0JmRGJC5aPK4zMsxNniZj+q76kFFuv/62iORtlpt1NkLgqeJOKx+x
	 hk5zYaWJPaA3/6E1RSwwG/8f2D7rSW4AEXVEGuc+v/wNBbJ/4qWGGfkGNnsvxQy9JnPI2
	 7iiGVq7kBt6eg7v6SKbIvVGhbPOah5xf1XxNYkRFd0uuxZCLV4C86eCNu4IO5PH0QuOvY
	 Mmt5rRXfXU87nV+cULHTyKUoW+d/rGD775tVTkx9OymMRnh5GVIehpfiHDZaVKl1GaAor
	 SFOK6PfyhPLy3PgJj1MpbrAUKU9HWUCOtw8xsS8NyWkzdmhTAxnNn0S8uhMTnT9/KKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=1VS+6sgw;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336A606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 14:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1336A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=1VS+6sgw
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id CA4BBC0F16;
	Wed, 25 Nov 2026 14:01:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 1288920027;
	Wed, 25 Nov 2026 14:01:23 +0000 (UTC)
Date: Wed, 25 Nov 2026 09:01:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Crystal Wood <crwood@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/10] tracing/osnoise: Per-cpu mutexes and fd
 detachment
Message-ID: <20261125090122.22fdb88d@gandalf.local.home>
In-Reply-To: <20261113064103.3041704-6-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
	<20261113064103.3041704-6-crwood@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nr3zie6s489mqjkzfsfa9b9b7qahtmtz
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1288920027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/MceYRNl5XYwXtkoyFgBTcZmoi0/RAQA4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=RfXl4FRDDVW1X94ViYdkTXaMgGXqsvI0xJ4HQkDNBN8=; b=1VS+6sgw6+XaMC35/0hPFMgtjVbk0Sl7J/N1cMEFKvJEPpuZqFV7oWvHjUsWetbtRyIuG1/4fwxvJdn5lx+71N0wnRNb40xsO8Hz4TwCcUl72Tg/zCNw6LFGBA/JG8R8mRiyT7antBtriBtfbNNc1Zo3dH7qKmqhWlVAE+3bnbU=
X-HE-Tag: 1795615283-541472
X-HE-Meta: U2FsdGVkX18HXv07MGUNv0LVL2ECeNMPQswWeWNb2zlqXbsUK6j/4BpZq6GklkMUGmQeB6x2xCKeLUMOViQ0vsgpFIXp8spnMU0ljhsQyVlws6Y7p8SrQH3hMb0hNaOm9obkKbguoFy0Yhedljg5sJU3k0bKtEYHwpROFdGheRZbupgVOGD0954fnPUvg3vGAeMTSI2VNgqSqvS+wXYF5kYTk9KhgkD3GWJ3HfLL8+moNClFMrz0E2f/l0R9Zae4hmJbqrUENhN2Kw2Et5lUTx58XqHHH6zDLM27wyt/8KnbCIqlQw/P1RiqYQSthpHKPTsdqUeqMt6kKIN5a4f2kjHCmtSizi31

On Fri, 13 Nov 2026 00:40:58 -0600
Crystal Wood <crwood@redhat.com> wrote:

Hi Crystal,

> @@ -1977,32 +2008,24 @@ static int timerlat_main(void *data)
>   */
>  static void stop_kthread(unsigned int cpu)
>  {
> -	struct task_struct *kthread;
> +	struct osnoise_variables *osn_var = cpu_osn_var(cpu);
>  
> -	kthread = xchg_relaxed(&cpu_osn_var(cpu)->kthread, NULL);
> -	if (kthread) {
> -		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
> -		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
> -			kthread_stop(kthread);
> -		} else if (!WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options))) {
> -			/*
> -			 * This is a user thread waiting on the timerlat_fd. We need
> -			 * to close all users, and the best way to guarantee this is
> -			 * by killing the thread. NOTE: this is a purpose specific file.
> -			 */
> -			kill_pid(kthread->thread_pid, SIGKILL, 1);
> -		}
> -		put_task_struct(kthread);
> -	} else {
> -		/* if no workload, just return */
> -		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
> -			/*
> -			 * This is set in the osnoise tracer case.
> -			 */
> -			cpu_osn_var(cpu)->sampling = false;
> -			barrier();
> -		}
> +	mutex_lock(&osn_var->lock);

Please use: guard(mutex)(&osn_var->lock); here instead.

> +
> +	if (osn_var->fdd) {
> +		WARN_ON_ONCE(test_bit(OSN_WORKLOAD, &osnoise_options));
> +		WARN_ON_ONCE(osn_var->kthread);
> +		osn_var->fdd->detach(osn_var->fdd);
> +	} else if (osn_var->kthread) {
> +		WARN_ON_ONCE(!cpumask_test_and_clear_cpu(cpu, &kthread_cpumask));
> +		WARN_ON_ONCE(!test_bit(OSN_WORKLOAD, &osnoise_options));
> +		kthread_stop(osn_var->kthread);
> +		put_task_struct(osn_var->kthread);
> +		osn_var->kthread = NULL;
>  	}
> +
> +	osn_var->sampling = false;
> +	mutex_unlock(&osn_var->lock);
>  }
>  
>  /*
> @@ -2032,16 +2055,20 @@ static int start_kthread(unsigned int cpu)
>  	struct task_struct *kthread;
>  	void *main = osnoise_main;
>  	char comm[24];
> +	int ret = 0;
> +
> +	lockdep_assert_held(&trace_types_lock);
> +	mutex_lock(&osn->lock);

This definitely needs to be:

	guard(mutex)(&osn->lock);

>  
>  	/* Do not start a new thread if it is already running */
>  	if (osn->kthread)
> -		return 0;
> +		goto out;

Then we don't need to add all these "goto out" calls!

>  
>  	/* Can still happen with timerlat via cpu hotplug */
>  	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
>  		if (!timerlat_enabled())
>  			osn->sampling = true;
> -		return 0;
> +		goto out;
>  	}
>  
>  	if (timerlat_enabled()) {
> @@ -2055,7 +2082,8 @@ static int start_kthread(unsigned int cpu)
>  
>  	if (IS_ERR(kthread)) {
>  		pr_err(BANNER "could not start sampling thread\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto out;
>  	}
>  
>  	get_task_struct(kthread);
> @@ -2063,7 +2091,9 @@ static int start_kthread(unsigned int cpu)
>  	cpumask_set_cpu(cpu, &kthread_cpumask);
>  	wake_up_process(kthread);
>  
> -	return 0;
> +out:
> +	mutex_unlock(&osn->lock);
> +	return ret;

And this isn't needed.

>  }
>  
>  /*
> @@ -2089,15 +2119,8 @@ static int start_per_cpu_kthreads(void)
>  	 */
>  	cpumask_and(current_mask, cpu_online_mask, &osnoise_cpumask);
>  
> -	for_each_possible_cpu(cpu) {
> -		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
> -			struct task_struct *kthread;
> -
> -			kthread = xchg_relaxed(&cpu_osn_var(cpu)->kthread, NULL);
> -			if (!WARN_ON(!kthread))
> -				kthread_stop(kthread);
> -		}
> -	}
> +	for_each_possible_cpu(cpu)
> +		WARN_ON_ONCE(cpumask_test_cpu(cpu, &kthread_cpumask));
>  
>  	for_each_cpu(cpu, current_mask) {
>  		retval = start_kthread(cpu);
> @@ -2417,11 +2440,46 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
>  }
>  
>  #ifdef CONFIG_TIMERLAT_TRACER
> +static void timerlat_fd_detach(struct fd_data *fdd)
> +{
> +	struct osnoise_variables *osn;
> +	struct timerlat_variables *tlat;
> +
> +	osn = cpu_osn_var(fdd->cpu);
> +	tlat = cpu_tmr_var(fdd->cpu);
> +
> +	lockdep_assert_held(&osn->lock);
> +	if (WARN_ON_ONCE(fdd != osn->fdd))
> +		return;
> +
> +	WARN_ON_ONCE(osn->kthread);
> +	WARN_ON_ONCE(fdd->thread != tlat->thread);
> +	tlat->detach = true;
> +	wake_up_process(tlat->thread);
> +
> +	mutex_lock(&tlat->detach_lock);

	guard(mutex)(&tlat->detach_lock);

> +
> +	osn->sampling = 0;
> +	osn->pid = 0;
> +
> +	WARN_ON_ONCE(hrtimer_active(&tlat->timer));
> +	hrtimer_cancel(&tlat->timer);
> +	put_task_struct(fdd->thread);
> +
> +	fdd->thread = NULL;
> +	osn->fdd = NULL;
> +	memset(&tlat->zero, 0, sizeof(tlat->zero));
> +
> +	mutex_unlock(&tlat->detach_lock);
> +}
> +
>  static int timerlat_fd_open(struct inode *inode, struct file *file)
>  {
> +	struct fd_data *fdd;
>  	struct osnoise_variables *osn_var;
>  	struct timerlat_variables *tlat;
>  	long cpu = (long) inode->i_cdev;
> +	int ret = 0;
>  
>  	mutex_lock(&interface_lock);

Hmm, if we switch this to:

	guard(mutex)(&interface_lock);
	
>  
> @@ -2437,16 +2495,16 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
>  	migrate_disable();

and this to:

	guard(migrate)();

>  
>  	osn_var = this_cpu_osn_var();
> +	tlat = this_cpu_tmr_var();
> +	mutex_lock(&osn_var->lock);

and use:

	guard(mutex)(&osn_var->lock);

>  
> -	/*
> -	 * The osn_var->pid holds the single access to this file.
> -	 */
> -	if (osn_var->pid) {
> -		mutex_unlock(&interface_lock);
> -		migrate_enable();
> -		return -EBUSY;
> +	if (osn_var->fdd) {
> +		ret = -EBUSY;
> +		goto err;

	this could simply be:

	if (osn_var->fdd)
		return -EBUSY;


>  	}
>  
> +	WARN_ON_ONCE(osn_var->kthread);
> +
>  	/*
>  	 * timerlat tracer is a per-cpu tracer. Check if the user-space too
>  	 * is pinned to a single CPU. The tracer laters monitor if the task
> @@ -2455,33 +2513,47 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
>  	 * setup.
>  	 */
>  	if (current->nr_cpus_allowed > 1 ||  cpu != smp_processor_id()) {

		return -EPERM;

> -		mutex_unlock(&interface_lock);
> -		migrate_enable();
> -		return -EPERM;
> +		ret = -EPERM;
> +		goto err;
> +	}
> +
> +	fdd = kmalloc(sizeof(*fdd), GFP_KERNEL);
> +	if (!fdd) {

		return -ENOMEM;

> +		ret = -ENOMEM;
> +		goto err;
>  	}
>  
>  	/*
>  	 * From now on, it is good to go.
>  	 */
> -	file->private_data = inode->i_cdev;
> +	fdd->thread = current;
> +	fdd->detach = timerlat_fd_detach;
> +	fdd->cpu = cpu;
> +	file->private_data = fdd;
>  
> +	tlat->tracing_thread = false;
> +	tlat->thread = current;
>  	get_task_struct(current);
>  
> -	osn_var->kthread = current;
>  	osn_var->pid = current->pid;
> +	osn_var->fdd = fdd;
> +
> +	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
>  



>  	/*
>  	 * Setup is done.
>  	 */
> +	mutex_unlock(&osn_var->lock);
>  	mutex_unlock(&interface_lock);
>  
> -	tlat = this_cpu_tmr_var();
> -	tlat->count = 0;
> -
> -	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
> -
>  	migrate_enable();
>  	return 0;
> +
> +err:
> +	mutex_unlock(&osn_var->lock);
> +	mutex_unlock(&interface_lock);
> +	migrate_enable();
> +	return ret;

And all of the above changed to simply:

	return 0;


>  };
>  
>  /*
> @@ -2497,36 +2569,28 @@ static ssize_t
>  timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
>  		  loff_t *ppos)
>  {
> -	long cpu = (long) file->private_data;
> +	struct fd_data *fdd = file->private_data;
>  	struct osnoise_variables *osn_var;
>  	struct timerlat_variables *tlat;
>  	struct timerlat_sample s;
>  	s64 diff;
>  	u64 now;
> +	int ret = 0;
>  
>  	migrate_disable();
>  
>  	tlat = this_cpu_tmr_var();
> +	osn_var = this_cpu_osn_var();
>  
> -	/*
> -	 * While in user-space, the thread is migratable. There is nothing
> -	 * we can do about it.
> -	 * So, if the thread is running on another CPU, stop the machinery.
> -	 */
> -	if (cpu == smp_processor_id()) {
> -		if (tlat->uthread_migrate) {
> -			migrate_enable();
> -			return -EINVAL;
> -		}
> -	} else {
> -		cpu_tmr_var(cpu)->uthread_migrate = 1;
> -		osnoise_taint("timerlat user thread migrate\n");
> -		osnoise_stop_tracing();
> -		migrate_enable();
> -		return -EINVAL;
> +	/* In normal usage, this should always be uncontended. */
> +	mutex_lock(&tlat->detach_lock);
> +	if (fdd != osn_var->fdd || current != fdd->thread ||
> +	    tlat->uthread_migrate) {
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  
> -	osn_var = this_cpu_osn_var();
> +	WARN_ON_ONCE(fdd->cpu != smp_processor_id());
>  
>  	/*
>  	 * The timerlat in user-space runs in a different order:
> @@ -2562,9 +2626,6 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
>  			}
>  		}
>  	} else {
> -		tlat->tracing_thread = false;
> -		tlat->thread = current;
> -
>  		/* Annotate now to drift new period */
>  		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
>  
> @@ -2572,7 +2633,21 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
>  	}
>  
>  	/* wait for the next period */
> -	wait_next_period(tlat);
> +	if (wait_next_period(tlat) < 0) {
> +		if (signal_pending(current))
> +			ret = -ERESTARTSYS;
> +		else
> +			ret = -EINVAL;
> +
> +		tlat->tracing_thread = false;
> +		osn_var->sampling = false;
> +		goto out;
> +	}
> +
> +	if (WARN_ON_ONCE(fdd != osn_var->fdd)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	/* This is the wakeup from this cycle */
>  	now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
> @@ -2599,39 +2674,24 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
>  	}
>  
>  out:
> +	mutex_unlock(&tlat->detach_lock);
>  	migrate_enable();

This too.

> -	return 0;
> +	return ret;
>  }
>  
>  static int timerlat_fd_release(struct inode *inode, struct file *file)
>  {
> +	struct fd_data *fdd = file->private_data;
>  	struct osnoise_variables *osn_var;
> -	struct timerlat_variables *tlat_var;
> -	long cpu = (long) file->private_data;
>  
> -	migrate_disable();
> -	mutex_lock(&interface_lock);
> -
> -	osn_var = cpu_osn_var(cpu);
> -	tlat_var = cpu_tmr_var(cpu);
> +	osn_var = cpu_osn_var(fdd->cpu);
>  
> -	if (tlat_var->thread)
> -		hrtimer_cancel(&tlat_var->timer);
> -	memset(tlat_var, 0, sizeof(*tlat_var));
> +	mutex_lock(&osn_var->lock);
> +	if (fdd == osn_var->fdd)
> +		timerlat_fd_detach(fdd);
> +	mutex_unlock(&osn_var->lock);

	scoped_guard(mutex,&osn_var->lock) {
		if (fdd == osn_var->fdd)
			timerlat_fd_detach(fdd);
	}

-- Steve

>  
> -	osn_var->sampling = 0;
> -	osn_var->pid = 0;
> -
> -	/*
> -	 * We are leaving, not being stopped... see stop_kthread();
> -	 */
> -	if (osn_var->kthread) {
> -		put_task_struct(osn_var->kthread);
> -		osn_var->kthread = NULL;
> -	}
> -
> -	mutex_unlock(&interface_lock);
> -	migrate_enable();
> +	kfree(fdd);
>  	return 0;
>  }
>  #endif
> @@ -3146,6 +3206,14 @@ static struct tracer timerlat_tracer __read_mostly = {
>  
>  __init static int init_timerlat_tracer(void)
>  {
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct timerlat_variables *tlat = cpu_tmr_var(cpu);
> +
> +		mutex_init(&tlat->detach_lock);
> +	}
> +
>  	return register_tracer(&timerlat_tracer);
>  }
>  #else /* CONFIG_TIMERLAT_TRACER */
> @@ -3157,10 +3225,16 @@ __init static int init_timerlat_tracer(void)
>  
>  __init static int init_osnoise_tracer(void)
>  {
> -	int ret;
> +	int ret, cpu;
>  
>  	mutex_init(&interface_lock);
>  
> +	for_each_possible_cpu(cpu) {
> +		struct osnoise_variables *osn = cpu_osn_var(cpu);
> +
> +		mutex_init(&osn->lock);
> +	}
> +
>  	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
>  
>  	ret = register_tracer(&osnoise_tracer);

