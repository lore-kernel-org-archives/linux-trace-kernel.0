Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76634D90D;
	Mon,  1 Jun 2026 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298694; cv=none; b=NUaKD3nc7T48Gz1DWSsQNZboTV6XWYeZi9ddJNTmPj+wmjWrNtCUy+BaExbkEV6yuW11YBZ7CKhjMjzckxRRePYWxbIH2NA7MyD8f3OGGULiQDh5w/2f72/Q8MhHQOkJ13/IlwsXWTmrEuwhkPPhgjvacmhusYo1nCV8WxBksH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298694; c=relaxed/simple;
	bh=Ccnp9yC8fe7LkbUrm2i/fOsTLgRamYC3fPronpT5LB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sz3faDZLy+006Rz5c98ZTeq8kSB2zgeir4h/5fJeoyCQWsOLIWIkecFRFzSFw8gN4sAhVfJOK5l1Yqw0kwZAV6iyDox+sZ4hL/Un3rBna0ut3+I4l1Fr8DCXM8OC4vMgZrrZlQxJM2rF4hRNgoXGNv2nC0bRDWk2/sC+7wRLCpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=glbrlO3L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wcEywnUL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="glbrlO3L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wcEywnUL"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780298691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3qistb0/d55KgvwdMPZ0N/y908ZuvkY3Y7ZoI0OfHk=;
	b=glbrlO3Li7qmA00mQI64GsBOCZv8rqapV1Kj2EjROETssYEy+qjQotIvGNqeaLk8Zapnvq
	fqWynMxbAAmpGEL+nKI3ddbpO+S7UIAocyzCTFkHaOAuFbEhvvgnMKuSBcoupwdi4kzxH9
	yE8g4m3KxhZG8lT4Anb/1J6JuBNs+FclatzbSCOq/+vooFSIyQFFn+FR8AeWfNM52JJi8I
	TZY6rj7RIzvJ4+LUfKyoW/THoJmg246VXufbDKdfg1D7xDgepTwjKGp712xJTnKZKeWx+4
	/m9GQ8VnjwyVviu7aYGwBH8JK2cJsbYu+j/7YEw7CyhxyqYLCtaHUYMNqWtS4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780298691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3qistb0/d55KgvwdMPZ0N/y908ZuvkY3Y7ZoI0OfHk=;
	b=wcEywnULUQ7B4tyS9lmYuw4i1F+FJywXEfzSmoi9rN/zsvjBq9VFIf+oJ8/rAKV68xvcAj
	cjqqdcFnw+NCXVCg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 06/13] rv: Do not rely on clean monitor when
 initialising HA
In-Reply-To: <20260530141652.58084-7-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-7-gmonaco@redhat.com>
Date: Mon, 01 Jun 2026 09:24:51 +0200
Message-ID: <87fr36yb7g.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +static bool ha_mon_initializing;

The global variable makes me a bit uncomfortable (a quick google will
tell why this is not the best pattern).

I am sure there are better ways to differentiate when we are
initializing vs destroying. How about the incomplete sketch below? I
doubt it even builds, just give an idea.

Nam

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 39765ff6f098..0549d3a35ee0 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -159,9 +159,14 @@ static struct da_monitor *da_get_monitor(void)
 /*
  * da_monitor_reset_all - reset the single monitor
  */
-static void da_monitor_reset_all(void)
+static void da_monitor_reset_all(void (*reset)(struct da_monitor *da_mon))
 {
-	da_monitor_reset(da_get_monitor());
+	fn(da_get_monitor());
+}
+
+static inline void _da_monitor_init(struct da_monitor *da_mon)
+{
+	memset(da_monitor, 0, sizeof(*da_mon));
 }
 
 /*
@@ -169,7 +174,7 @@ static void da_monitor_reset_all(void)
  */
 static inline int da_monitor_init(void)
 {
-	da_monitor_reset_all();
+	da_monitor_reset_all(_da_monitor_init);
 	return 0;
 }
 
@@ -178,7 +183,7 @@ static inline int da_monitor_init(void)
  */
 static inline void da_monitor_destroy(void)
 {
-	da_monitor_reset_all();
+	da_monitor_reset_all(da_monitor_reset);
 }
 
 #elif RV_MON_TYPE == RV_MON_PER_CPU
@@ -202,14 +207,14 @@ static struct da_monitor *da_get_monitor(void)
 /*
  * da_monitor_reset_all - reset all CPUs' monitor
  */
-static void da_monitor_reset_all(void)
+static void da_monitor_reset_all(void (*reset)(struct da_monitor *da_mon))
 {
 	struct da_monitor *da_mon;
 	int cpu;
 
 	for_each_cpu(cpu, cpu_online_mask) {
 		da_mon = per_cpu_ptr(&DA_MON_NAME, cpu);
-		da_monitor_reset(da_mon);
+		reset(da_mon);
 	}
 }
 
@@ -267,16 +272,16 @@ static inline da_id_type da_get_id(struct da_monitor *da_mon)
 	return da_get_target(da_mon)->pid;
 }
 
-static void da_monitor_reset_all(void)
+static void da_monitor_reset_all(void (*reset)(struct da_monitor *da_mon))
 {
 	struct task_struct *g, *p;
 	int cpu;
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p)
-		da_monitor_reset(da_get_monitor(p));
+		reset(da_get_monitor(p));
 	for_each_present_cpu(cpu)
-		da_monitor_reset(da_get_monitor(idle_task(cpu)));
+		reset(da_get_monitor(idle_task(cpu)));
 	read_unlock(&tasklist_lock);
 }
 
@@ -483,14 +488,14 @@ static inline void da_destroy_storage(da_id_type id)
 	kfree_rcu(mon_storage, rcu);
 }
 
-static void da_monitor_reset_all(void)
+static void da_monitor_reset_all(void (*reset)(struct da_monitor *da_mon))
 {
 	struct da_monitor_storage *mon_storage;
 	int bkt;
 
 	rcu_read_lock();
 	hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node)
-		da_monitor_reset(&mon_storage->rv.da_mon);
+		reset(&mon_storage->rv.da_mon);
 	rcu_read_unlock();
 }
 
