Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D73346B2;
	Mon, 17 Nov 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392043; cv=none; b=XddbWnNUwpA3ilVJvOar8BEJlXsO6cmeexR9RkfjAcV7zE351aYYccyIgua/uys0rfr5WvKHwHhspTfp63KQkGYe3bH16kx2pL1HIKv4Jy+i2ZSiSGNsGhvzHoN74VZ9Ri9e/+8PtmV1J8KCetkmeCDXGunm02tQrqQVHlQ/0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392043; c=relaxed/simple;
	bh=6EuCeGKIffZ9ql54ZJ7YCYx39Oe8uRr92X4gxK+2rrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lh5DIBoTFXa0l2p9blW+Dv4/aVFL/Zww8NhQmVCfzgy6HeTdkutkz6OOj9aioJMiYK4aidH2KpUrVdYroM4p1g1eMaCA37i9SV+S+n6bdQtHUtHJUnL2Ndyjua+b5QlRuBvItVaUnNUKeqWfGrFLFAP8e1sdu3YjVvmMrYFqPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id F341A86905;
	Mon, 17 Nov 2025 15:07:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 2738A20016;
	Mon, 17 Nov 2025 15:07:11 +0000 (UTC)
Date: Mon, 17 Nov 2025 10:07:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rv: Convert to use __free
Message-ID: <20251117100735.71466d12@gandalf.local.home>
In-Reply-To: <6b2a618815b45ac4ac09976ef4fb0bd3635c143d.1763306824.git.namcao@linutronix.de>
References: <cover.1763306824.git.namcao@linutronix.de>
	<6b2a618815b45ac4ac09976ef4fb0bd3635c143d.1763306824.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2738A20016
X-Stat-Signature: h3w34hijk4gp6i364web3wse4sdtgjem
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Wztyf0dKuu9UuLbz8Mg2QUabJ0jwHtlQ=
X-HE-Tag: 1763392031-14422
X-HE-Meta: U2FsdGVkX198x4CMWcunMgns1H9idKxHKAOZjqEcX9Nlq/LmhQwT+OUllPV1GkRjvWADN6zpS6KFcTXTAyNM2cnBjvHkKO7V2BDNHvhick7bpX2ZD2VRui2wxAmqbU+BaYlOBAwccrvwc2UW8q424PaHKC6PtJuIV4i5lYsipBF9//So6qx8JRkyE6/p+2tg9an/q9YYWhtTQ756fntRcZc7XW8JMssBqW5xskr4wpTU4fbMe9GLgpeD3e3/BB63jL7kFH9Pxti72aI4tkIyl8VL5+2zJUIvBOo73gnNoFIVIklObs2WuXnYss2+oVXR

On Sun, 16 Nov 2025 15:35:12 +0000
Nam Cao <namcao@linutronix.de> wrote:

> Convert to use __free to tidy up the code.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  kernel/trace/rv/rv.c          | 65 +++++++++++++++--------------------
>  kernel/trace/rv/rv.h          |  6 ++--
>  kernel/trace/rv/rv_reactors.c | 32 ++++++++---------
>  3 files changed, 46 insertions(+), 57 deletions(-)
> 
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index b1059a3cf4fa..e83dc9f0c7bb 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -420,35 +420,28 @@ static const struct file_operations interface_desc_fops = {
>  static int create_monitor_dir(struct rv_monitor *mon, struct rv_monitor *parent)
>  {
>  	struct dentry *root = parent ? parent->root_d : get_monitors_root();
> -	const char *name = mon->name;
> +	struct dentry *dir __free(rv_remove) = rv_create_dir(mon->name, root);
>  	struct dentry *tmp;
>  	int retval;
>  
> -	mon->root_d = rv_create_dir(name, root);
> -	if (!mon->root_d)
> +	if (!dir)
>  		return -ENOMEM;
>  
> -	tmp = rv_create_file("enable", RV_MODE_WRITE, mon->root_d, mon, &interface_enable_fops);
> -	if (!tmp) {
> -		retval = -ENOMEM;
> -		goto out_remove_root;
> -	}
> +	tmp = rv_create_file("enable", RV_MODE_WRITE, dir, mon, &interface_enable_fops);
> +	if (!tmp)
> +		return -ENOMEM;
>  
> -	tmp = rv_create_file("desc", RV_MODE_READ, mon->root_d, mon, &interface_desc_fops);
> -	if (!tmp) {
> -		retval = -ENOMEM;
> -		goto out_remove_root;
> -	}
> +	tmp = rv_create_file("desc", RV_MODE_READ, dir, mon, &interface_desc_fops);
> +	if (!tmp)
> +		return -ENOMEM;
>  
> -	retval = reactor_populate_monitor(mon);
> +	retval = reactor_populate_monitor(mon, dir);
>  	if (retval)
> -		goto out_remove_root;
> +		return retval;
>  
> +	mon->root_d = dir;
> +	retain_and_null_ptr(dir);
>  	return 0;

Why the "retain_and_null_ptr() and not just:

	mon->root-d = no_free_ptr(dir);
	return 0;

As from my understanding is that the retain_and_null_ptr() is for use of
passing the variable to a function that will consume it. But for assigning
to a variable, I usually just use the no_free_ptr().

> -
> -out_remove_root:
> -	rv_remove(mon->root_d);
> -	return retval;
>  }
>  
>  /*
> @@ -827,39 +820,37 @@ int __init rv_init_interface(void)
>  {
>  	struct dentry *tmp;
>  	int retval;
> +	struct dentry *root_dir __free(rv_remove) = rv_create_dir("rv", NULL);
>  
> -	rv_root.root_dir = rv_create_dir("rv", NULL);
> -	if (!rv_root.root_dir)
> -		goto out_err;
> +	if (!root_dir)
> +		return 1;
>  
> -	rv_root.monitors_dir = rv_create_dir("monitors", rv_root.root_dir);
> +	rv_root.monitors_dir = rv_create_dir("monitors", root_dir);
>  	if (!rv_root.monitors_dir)
> -		goto out_err;
> +		return 1;
>  
> -	tmp = rv_create_file("available_monitors", RV_MODE_READ, rv_root.root_dir, NULL,
> +	tmp = rv_create_file("available_monitors", RV_MODE_READ, root_dir, NULL,
>  			     &available_monitors_ops);
>  	if (!tmp)
> -		goto out_err;
> +		return 1;
>  
> -	tmp = rv_create_file("enabled_monitors", RV_MODE_WRITE, rv_root.root_dir, NULL,
> +	tmp = rv_create_file("enabled_monitors", RV_MODE_WRITE, root_dir, NULL,
>  			     &enabled_monitors_ops);
>  	if (!tmp)
> -		goto out_err;
> +		return 1;
>  
> -	tmp = rv_create_file("monitoring_on", RV_MODE_WRITE, rv_root.root_dir, NULL,
> +	tmp = rv_create_file("monitoring_on", RV_MODE_WRITE, root_dir, NULL,
>  			     &monitoring_on_fops);
>  	if (!tmp)
> -		goto out_err;
> -	retval = init_rv_reactors(rv_root.root_dir);
> +		return 1;
> +	retval = init_rv_reactors(root_dir);
>  	if (retval)
> -		goto out_err;
> +		return 1;
>  
>  	turn_monitoring_on();
>  
> -	return 0;
> +	rv_root.root_dir = root_dir;
> +	retain_and_null_ptr(root_dir);

Same here.

>  
> -out_err:
> -	rv_remove(rv_root.root_dir);
> -	printk(KERN_ERR "RV: Error while creating the RV interface\n");
> -	return 1;
> +	return 0;
>  }



> @@ -438,30 +439,25 @@ static struct rv_reactor rv_nop = {
>  
>  int init_rv_reactors(struct dentry *root_dir)
>  {
> -	struct dentry *available, *reacting;
>  	int retval;
>  
> -	available = rv_create_file("available_reactors", RV_MODE_READ, root_dir, NULL,
> -				   &available_reactors_ops);
> -	if (!available)
> -		goto out_err;
> +	struct dentry *available __free(rv_remove) =
> +		rv_create_file("available_reactors", RV_MODE_READ, root_dir,
> +				NULL, &available_reactors_ops);
>  
> -	reacting = rv_create_file("reacting_on", RV_MODE_WRITE, root_dir, NULL, &reacting_on_fops);
> -	if (!reacting)
> -		goto rm_available;
> +	struct dentry *reacting =
> +		rv_create_file("reacting_on", RV_MODE_WRITE, root_dir, NULL, &reacting_on_fops);
> +
> +	if (!reacting || !available)
> +		return -ENOMEM;
>  
>  	retval = __rv_register_reactor(&rv_nop);
>  	if (retval)
> -		goto rm_reacting;
> +		return retval;
>  
>  	turn_reacting_on();
>  
> +	retain_and_null_ptr(available);
> +	retain_and_null_ptr(reacting);

Here it makes sense to use retain_and_null_ptr() as the two variables were
passed to another function. But the other two locations should simply use
the no_free_ptr() wrapper.

-- Steve


>  	return 0;
> -
> -rm_reacting:
> -	rv_remove(reacting);
> -rm_available:
> -	rv_remove(available);
> -out_err:
> -	return -ENOMEM;
>  }

