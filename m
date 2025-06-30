Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BF1EB5D0;
	Mon, 30 Jun 2025 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311089; cv=none; b=UtLHSO83C1xk8cCJNnlMzRtF/um4HeEcZQitwlO2vi5VDr+MatRO5AWcfn38R2SdThdCzREQyR4HOb6UZ8zLVEj6penaUzVGDdrmYQUW2zbhLmhB4c2vfGs6cFHyOovUVYF4xdfcphHg7PH9jhgyvPHS/I9ViZbOyrcQjYOj6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311089; c=relaxed/simple;
	bh=GRf15//kYt30s15Y9TEb/Zr/0IQjmiILEY2CR1LttCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9RayB7/iP3+uuzyz5mSqFWMDJHc9nTXPylvvP/lgID4DD4AsApuNT1WxT0XnNsIxN6oZ8s77aVSrDTDL/A0CjLu+tiuZkgprvthUb7CMZB7+W9bEbKmXn5/YXJuoWC1GagO9u2AKfaRRMQ35J4Kv98Qq9/E84+nYq1sHnvmp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5F85EB3BF3;
	Mon, 30 Jun 2025 19:17:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 9670620027;
	Mon, 30 Jun 2025 19:17:57 +0000 (UTC)
Date: Mon, 30 Jun 2025 15:17:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 13/19] rv: Add support for LTL monitors
Message-ID: <20250630151756.3104c5e9@batman.local.home>
In-Reply-To: <1750e36e7b445cbba283cd564b07e16dcd65aac5.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<1750e36e7b445cbba283cd564b07e16dcd65aac5.1749547399.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6shsomqmjgcihybaqascin94w7hynoeq
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 9670620027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18fiNKiASJTgCqFiFfib6u+P2dM1kLzSaU=
X-HE-Tag: 1751311077-642000
X-HE-Meta: U2FsdGVkX1/kO334lXKO/c0UZGzuQ06DcdwhLqLUXj0NO/uN99kkgWMW/SGzv7CE046gLFO+I/ucrMCEtFWYtPjSmna0PQA+QRZZ74dSilcg3MxgyfIqkdcg3+K6stBkNxy2lM/wlkBk2FpMApbLo+VPUghHnkeHeqIjcmoeZgPBFiT6hSGePoMpfggSP3bU/1nI2T1geWQGdZkEw2InB6D4UBsloYCRhYlGRjQV6v+tjv49gipMiYbbzAwPsYIEUG+r3otSh17/wr8KvXq06D+PhIFiIl7Q1geNEFUBGK/22cuPq0XJhkWVQFJaeej3

On Tue, 10 Jun 2025 11:43:38 +0200
Nam Cao <namcao@linutronix.de> wrote:

> diff --git a/Documentation/trace/rv/linear_temporal_logic.rst b/Documentation/trace/rv/linear_temporal_logic.rst
> new file mode 100644
> index 0000000000000..9dc1de4ca9349
> --- /dev/null
> +++ b/Documentation/trace/rv/linear_temporal_logic.rst
> @@ -0,0 +1,122 @@
> +Linear temporal logic
> +=====================
> +
> +Introduction
> +------------
> +
> +Runtime verification monitor is a verification technique which checks that the kernel follows a
> +specification. It does so by using tracepoints to monitor the kernel's execution trace, and
> +verifying that the execution trace sastifies the specification.
> +
> +Initially, the specification can only be written in the form of deterministic automaton (DA).
> +However, while attempting to implement DA monitors for some complex specifications, deterministic
> +automaton is found to be inappropriate as the specification language. The automaton is complicated,
> +hard to understand, and error-prone.

The lines in this file are unnecessarily long. Can you keep them at a
max of 80 characters? This isn't a hard limit. For examples and where
it makes sense to break that limit if it makes the output more
readable, then by all means, break the 80 char limit. But There's a lot
of places here that break that limit for no reason. As I get older, it
becomes harder to read long lines.

> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -10,6 +10,10 @@
>  #define MAX_DA_NAME_LEN	32
>  
>  #ifdef CONFIG_RV
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +#include <linux/array_size.h>
> +
>  /*
>   * Deterministic automaton per-object variables.
>   */
> @@ -18,6 +22,58 @@ struct da_monitor {
>  	unsigned int	curr_state;
>  };
>  
> +#ifdef CONFIG_RV_LTL_MONITOR
> +
> +/*
> + * In the future, if the number of atomic propositions or the size of Buchi automaton is larger, we
> + * can switch to dynamic allocation. For now, the code is simpler this way.

Same for the comments in the code.

> + */
> +#define RV_MAX_LTL_ATOM 32
> +#define RV_MAX_BA_STATES 32
> +
> +/**
> + * struct ltl_monitor - A linear temporal logic runtime verification monitor
> + * @states:	States in the Buchi automaton. As Buchi automaton is a
> + *		non-deterministic state machine, the monitor can be in multiple states
> + *		simultaneously. This is a bitmask of all possible states.
> + *		If this is zero, that means either:
> + *		    - The monitor has not started yet (e.g. because not all atomic propositions are
> + *		      known).
> + *		    - there is no possible state to be in. In other words, a violation of the
> + *		      LTL property is detected.
> + * @atoms:	The values of atomic propositions.
> + * @unknown_atoms: Atomic propositions which are still unknown.
> + */
> +struct ltl_monitor {
> +	DECLARE_BITMAP(states, RV_MAX_BA_STATES);
> +	DECLARE_BITMAP(atoms, RV_MAX_LTL_ATOM);
> +	DECLARE_BITMAP(unknown_atoms, RV_MAX_LTL_ATOM);
> +};
> +
> +static inline bool rv_ltl_valid_state(struct ltl_monitor *mon)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(mon->states); ++i) {
> +		if (mon->states[i])
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static inline bool rv_ltl_all_atoms_known(struct ltl_monitor *mon)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(mon->unknown_atoms); ++i) {
> +		if (mon->unknown_atoms[i])
> +			return false;
> +	}
> +	return true;
> +}
> +
> +#else
> +
> +struct ltl_monitor {};
> +
> +#endif /* CONFIG_RV_LTL_MONITOR */
> +
>  /*
>   * Per-task RV monitors count. Nowadays fixed in RV_PER_TASK_MONITORS.
>   * If we find justification for more monitors, we can think about
> @@ -27,11 +83,9 @@ struct da_monitor {
>  #define RV_PER_TASK_MONITORS		1
>  #define RV_PER_TASK_MONITOR_INIT	(RV_PER_TASK_MONITORS)
>  
> -/*
> - * Futher monitor types are expected, so make this a union.
> - */
>  union rv_task_monitor {
> -	struct da_monitor da_mon;
> +	struct da_monitor	da_mon;
> +	struct ltl_monitor	ltl_mon;
>  };
>  
>  #ifdef CONFIG_RV_REACTORS
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> new file mode 100644
> index 0000000000000..78f5a11976659
> --- /dev/null
> +++ b/include/rv/ltl_monitor.h
> @@ -0,0 +1,184 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * This file must be combined with the $(MODEL_NAME).h file generated by
> + * tools/verification/rvgen.
> + */
> +
> +#include <linux/args.h>
> +#include <linux/rv.h>
> +#include <linux/stringify.h>
> +#include <linux/seq_buf.h>
> +#include <rv/instrumentation.h>
> +#include <trace/events/task.h>
> +#include <trace/events/sched.h>
> +
> +#ifndef MONITOR_NAME
> +#error "MONITOR_NAME macro is not defined. Did you include $(MODEL_NAME).h generated by rvgen?"
> +#endif
> +
> +#ifdef CONFIG_RV_REACTORS
> +#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> +static struct rv_monitor RV_MONITOR_NAME;
> +
> +static void rv_cond_react(struct task_struct *task)
> +{
> +	if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
> +		return;
> +	RV_MONITOR_NAME.react("rv: "__stringify(MONITOR_NAME)": %s[%d]: violation detected\n",

Note, the above *is* OK to break the limit, as we shouldn't break
strings.


> +			      task->comm, task->pid);
> +}
> +#else
> +static void rv_cond_react(struct task_struct *task)
> +{
> +}
> +#endif
> +
> +static int ltl_monitor_slot = RV_PER_TASK_MONITOR_INIT;
> +
> +static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *mon);
> +static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bool task_creation);
> +
> +static struct ltl_monitor *ltl_get_monitor(struct task_struct *task)
> +{
> +	return &task->rv[ltl_monitor_slot].ltl_mon;
> +}
> +
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1ee8eb11f38ba..b258728792e09 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1886,10 +1886,7 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
>  #ifdef CONFIG_RV
>  static void rv_task_fork(struct task_struct *p)
>  {
> -	int i;
> -
> -	for (i = 0; i < RV_PER_TASK_MONITORS; i++)
> -		p->rv[i].da_mon.monitoring = false;
> +	memset(p->rv, 0, sizeof(p->rv));

It's not apparent that the above is a static array and memset() like
that is commonly a bug. Perhaps make it:

	memset(&p->rv, 0, sizeof(p->rv));

So that it doesn't look like a bug?

>  }
>  #else
>  #define rv_task_fork(p) do {} while (0)
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 6cdffc04b73c2..6e157f9649915 100644
> --- a/kernel/trace/rv/Kconfig



> diff --git a/tools/verification/rvgen/.gitignore b/tools/verification/rvgen/.gitignore
> new file mode 100644
> index 0000000000000..1e288a076560e
> --- /dev/null
> +++ b/tools/verification/rvgen/.gitignore

BTW, this is quite a big patch. Can you break it up into three patches?

One for the Documentation, one for the kernel, and one for the tools
portion. I may even put the tools and documentation patches into a
separate patch that the one that modifies the kernel. As Linus likes
tools code to be separate from the kernel code. It's not a hard rule,
but it does make things slightly easier.

So far the patches look good. I'm still reviewing them.

-- Steve


> @@ -0,0 +1,3 @@
> +__pycache__/
> +parser.out
> +parsetab.py
> diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/Makefile
> index cca8c9ba82e8b..cfc4056c1e87a 100644
> --- a/tools/verification/rvgen/Makefile
> +++ b/tools/verification/rvgen/Makefile
> @@ -21,5 +21,7 @@ install:
>  	$(INSTALL) rvgen/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2k.py
>  	$(INSTALL) rvgen/container.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/container.py
>  	$(INSTALL) rvgen/generator.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/generator.py
> +	$(INSTALL) rvgen/ltl2ba.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/ltl2ba.py
> +	$(INSTALL) rvgen/ltl2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/ltl2k.py
>  	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
>  	cp -rp rvgen/templates $(DESTDIR)$(PYLIB)/rvgen/
> diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
> index 63ecf0c370343..fa6fc1f4de2f7 100644
> --- a/tools/verification/rvgen/__main__.py
> +++ b/tools/verification/rvgen/__main__.py
> @@ -12,6 +12,7 @@ if __name__ == '__main__':
>      from rvgen.dot2k import dot2k
>      from rvgen.generator import Monitor
>      from rvgen.container import Container
> +    from rvgen.ltl2k import ltl2k
