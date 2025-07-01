Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79619A47;
	Tue,  1 Jul 2025 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347086; cv=none; b=PVIWzQbNfV3T+WUW2BJKR0OTkBnLR/ByCnUW5pk9P8StKInULF68l/9HzQqaM/M7dLh0mwrL7OAJ1DCwr/gD5C0ui46iMrE8YuDEQuPYjv34z6tRYVI/Yinuti/EZwEjfOPuhKPAkB70w3IfEORhUiTu6VryAXoQntd9bxeKhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347086; c=relaxed/simple;
	bh=y4JO51qeKPzgLWPuY1dRsGYWm0kjxKxZ+48rPaqGEug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOsPb68ciBefJ9fhoczWOZl0yGyIsOmJ5hHmEpSewAwrHZFBR+eiIJsnRgzPH60nzYeTE3PDq24WRJhJrzuG8vlDq4wTJMpm1wI3953DEDIhUahdjhUOKq9vL15o7g0jRos0nvQ38SVFPyVH+GvPSxbi7PoCerbKd49wS9DWJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u8KQOMME; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CObkwDOW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u8KQOMME";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CObkwDOW"
Date: Tue, 1 Jul 2025 07:17:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751347082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhV6h2R6dfFBjGoqd4wVRZso6RFFdyNdBteMMy5uNpI=;
	b=u8KQOMMEAA0lqxRK0NGsMQVtBxCwORRrqxh95POuNAzvQ/J1ESpF/8KbeyN3I6pVhXPanM
	y+X7cMQF/m06izMRNtlQCCnrgfoADJgyuTlAxVgRiTPz+y7Mr5fM76wecwAXIJ7N1EJBaq
	cl4z1M/jF26/jnBSwI8teA0PyIvp5BhZNP1RZf0j44VvcYNsouHxOs+4sBUNp30YJaF6Gh
	GbRzS3OfVA4baSEDXY+punh2WjUbQEWMlssI061hzsEeGHvKHsCJTpEbHf2enaygOfulV4
	Yy0TltP/AQn17qR/17aR2syOFjuZc2optSCrsM9dsQtN3INAD0UOMO0TfXT0eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751347082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhV6h2R6dfFBjGoqd4wVRZso6RFFdyNdBteMMy5uNpI=;
	b=CObkwDOWH9HGrpcZc8EIkutEHAysVeqM4BkTKdROzQ1Zjs2Yxc5Ohfz2O88j4MVzkh8Rtl
	QwbZVc2EusjKK3Dg==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
Message-ID: <20250701051757.mBjQVdoo@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
 <d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
 <20250630203401.1a11e58f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630203401.1a11e58f@gandalf.local.home>

On Mon, Jun 30, 2025 at 08:34:01PM -0400, Steven Rostedt wrote:
> On Tue, 10 Jun 2025 11:43:42 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> > +static void
> > +ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsigned long *next)
> > +{
> > +	bool task_is_migration = test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
> > +	bool task_is_rcu = test_bit(LTL_TASK_IS_RCU, mon->atoms);
> > +	bool val40 = task_is_rcu || task_is_migration;
> > +	bool futex_lock_pi = test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> > +	bool val41 = futex_lock_pi || val40;
> > +	bool block_on_rt_mutex = test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
> > +	bool val5 = block_on_rt_mutex || val41;
> > +	bool kthread_should_stop = test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms);
> > +	bool abort_sleep = test_bit(LTL_ABORT_SLEEP, mon->atoms);
> > +	bool val32 = abort_sleep || kthread_should_stop;
> > +	bool woken_by_nmi = test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
> > +	bool val33 = woken_by_nmi || val32;
> > +	bool woken_by_hardirq = test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
> > +	bool val34 = woken_by_hardirq || val33;
> > +	bool woken_by_equal_or_higher_prio = test_bit(LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
> > +	     mon->atoms);
> > +	bool val14 = woken_by_equal_or_higher_prio || val34;
> > +	bool wake = test_bit(LTL_WAKE, mon->atoms);
> > +	bool val13 = !wake;
> > +	bool kernel_thread = test_bit(LTL_KERNEL_THREAD, mon->atoms);
> > +	bool nanosleep_clock_tai = test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms);
> > +	bool nanosleep_clock_monotonic = test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC, mon->atoms);
> > +	bool val24 = nanosleep_clock_monotonic || nanosleep_clock_tai;
> > +	bool nanosleep_timer_abstime = test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mon->atoms);
> > +	bool val25 = nanosleep_timer_abstime && val24;
> > +	bool clock_nanosleep = test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
> > +	bool val18 = clock_nanosleep && val25;
> > +	bool futex_wait = test_bit(LTL_FUTEX_WAIT, mon->atoms);
> > +	bool val9 = futex_wait || val18;
> > +	bool val11 = val9 || kernel_thread;
> > +	bool sleep = test_bit(LTL_SLEEP, mon->atoms);
> > +	bool val2 = !sleep;
> > +	bool rt = test_bit(LTL_RT, mon->atoms);
> > +	bool val1 = !rt;
> > +	bool val3 = val1 || val2;
> > +
> > +	switch (state) {
> > +	case S0:
> > +		if (val3)
> > +			__set_bit(S0, next);
> > +		if (val11 && val13)
> > +			__set_bit(S1, next);
> > +		if (val11 && val14)
> > +			__set_bit(S4, next);
> > +		if (val5)
> > +			__set_bit(S5, next);
> > +		break;
> 
> What's with all the magic numbers?
> 
> Can we turn these into enums so they have some meaning for us humans?

I'm not sure what you mean, we can't use enums as variables.

I haven't come up with a good way of (automatically) giving them meaningful
names. They are just intermediate values (e.g. 'and' of other values).
Maybe I should integrate AI in my scripts ;)

There's another option: we could drop all these intermediate variables and
use the atomic propositions directly. So I could hack my scripts:

diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
index d11840af7f5fd..1d1eeb82ae834 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -118,11 +118,7 @@ class ASTNode:
         return self.op.expand(self, node, node_set)
 
     def __str__(self):
-        if isinstance(self.op, Literal):
-            return str(self.op.value)
-        if isinstance(self.op, Variable):
-            return self.op.name.lower()
-        return "val" + str(self.id)
+        return str(self.op).lower()
 
     def normalize(self):
         # Get rid of:
@@ -147,6 +143,9 @@ class BinaryOp:
         yield from self.left
         yield from self.right
 
+    def __str__(self):
+        return "(%s %s %s)" % (self.left.op, self.op_str, self.right.op)
+
     def normalize(self):
         raise NotImplementedError
 
@@ -358,6 +357,9 @@ class Variable:
     def __iter__(self):
         yield from ()
 
+    def __str__(self):
+        return self.name
+
     def negate(self):
         new = ASTNode(self)
         return NotOp(new)
diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index b8da9094fb4ff..dfa625d130233 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -109,17 +109,8 @@ class ltl2k(generator.Monitor):
     def _fill_atom_values(self):
         buf = []
         for node in self.ltl:
-            if node.op.is_temporal():
-                continue
-
             if isinstance(node.op, ltl2ba.Variable):
                 buf.append("\tbool %s = test_bit(LTL_%s, mon->atoms);" % (node, node.op.name))
-            elif isinstance(node.op, ltl2ba.AndOp):
-                buf.append("\tbool %s = %s && %s;" % (node, node.op.left, node.op.right))
-            elif isinstance(node.op, ltl2ba.OrOp):
-                buf.append("\tbool %s = %s || %s;" % (node, node.op.left, node.op.right))
-            elif isinstance(node.op, ltl2ba.NotOp):
-                buf.append("\tbool %s = !%s;" % (node, node.op.child))
         buf.reverse()
 
         buf2 = []


And we would get:

static void
ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsigned long *next)
{
	bool task_is_migration = test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
	bool task_is_rcu = test_bit(LTL_TASK_IS_RCU, mon->atoms);
	bool futex_lock_pi = test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
	bool block_on_rt_mutex = test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
	bool kthread_should_stop = test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms);
	bool abort_sleep = test_bit(LTL_ABORT_SLEEP, mon->atoms);
	bool woken_by_nmi = test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
	bool woken_by_hardirq = test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
	bool woken_by_equal_or_higher_prio = test_bit(LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
	     mon->atoms);
	bool wake = test_bit(LTL_WAKE, mon->atoms);
	bool kernel_thread = test_bit(LTL_KERNEL_THREAD, mon->atoms);
	bool nanosleep_clock_tai = test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms);
	bool nanosleep_clock_monotonic = test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC, mon->atoms);
	bool nanosleep_timer_abstime = test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mon->atoms);
	bool clock_nanosleep = test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
	bool futex_wait = test_bit(LTL_FUTEX_WAIT, mon->atoms);
	bool sleep = test_bit(LTL_SLEEP, mon->atoms);
	bool rt = test_bit(LTL_RT, mon->atoms);

	switch (state) {
	case S0:
		if ((!rt || !sleep))
			__set_bit(S0, next);
		if (!wake && ((futex_wait || (clock_nanosleep && (nanosleep_timer_abstime &&
		   (nanosleep_clock_monotonic || nanosleep_clock_tai)))) || kernel_thread))
			__set_bit(S1, next);
		if (((futex_wait || (clock_nanosleep && (nanosleep_timer_abstime &&
		   (nanosleep_clock_monotonic || nanosleep_clock_tai)))) || kernel_thread) &&
		   (woken_by_equal_or_higher_prio || (woken_by_hardirq || (woken_by_nmi ||
		   (abort_sleep || kthread_should_stop)))))
			__set_bit(S5, next);
		if ((block_on_rt_mutex || (futex_lock_pi || (task_is_rcu || task_is_migration))))
			__set_bit(S6, next);
		break;


It is just a matter of taste. I will let you pick. Or do you hate this one
as well?

Best regards,
Nam
