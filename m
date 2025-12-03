Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1422D7B5;
	Wed,  3 Dec 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801547; cv=none; b=MkYzGiTeGaSc/KeD+N3ZG6QhJEWml0C87KEJz0ROvt8oLhxBsBw1TGzdmE9q5tRrdrvOKKRQDWeMvVsJRT4B73F3GMJCOTpgizcM2jpqQhX4vJNjb61i5wa3hlrgCDhvoCZWKhbKVMFe9UDPd96hy6Ib/5W+6ZZsuTjk1J3tHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801547; c=relaxed/simple;
	bh=jCQ1gASlQztHfXgp6fI53DhEfp9d/b6de4+33+Ar5Ds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K/YcCjEkjDxrHoTZXtIUFvX09rvJwfCBUCcjV3amGWf6s7VYxZ1r0YX1CAXYzaTlz2o9+006DUI5WP1weB+Lb5YfoWRApEleTPeu2go9P7VT8J+P4+UYhNpgYqCqTGsBBIizPtShHabNYZB1FehTmtTcklkukVHBdKrRpOl3M1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3wUQeww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3wUQeww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4685EC4CEF5;
	Wed,  3 Dec 2025 22:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764801543;
	bh=jCQ1gASlQztHfXgp6fI53DhEfp9d/b6de4+33+Ar5Ds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c3wUQewwpSUWHN7K0NqeEk5gj/Wm2Opsq4wISWOuhSb4WZNJBIK9X58Z2DpBlh9dZ
	 97o/EVZfuFkQ7lssmXJIeSFHDK5xavYLziT0OCFBV5M8/MjmKujd1w49JRWu0/spml
	 Tpz9hVYd/2TcjUvij82JqbDnKf19wrV+ucMJoMB5dHabLcihB4QVhHvnL0BUjj2YWC
	 Yik5RIHo9tVIHwy/eEHeAs4VAlMZ2RLP/FzuWT91Yg0Suqmca9IdHZMzrKBIFkL8jx
	 5CwW/9bG+O/KFCo4Pi7/1AV5QCxSy9aC680rTh++wdgVHW1xK7mvXvps2Pz08J8SIo
	 4W75Le2qoTc8A==
Message-ID: <383568a33fdca98e08b38dc16079e57ad88c0d44.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] tracing: Add bulk garbage collection of freeing
 event_trigger_data
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 03 Dec 2025 16:39:02 -0600
In-Reply-To: <20251125214032.151674992@kernel.org>
References: <20251125214004.396482401@kernel.org>
	 <20251125214032.151674992@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-25 at 16:40 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> The event trigger data requires a full tracepoint_synchronize_unregister(=
)
> call before freeing. That call can take 100s of milliseconds to complete.
> In order to allow for bulk freeing of the trigger data, it can not call
> the tracepoint_synchronize_unregister() for every individual trigger data
> being free.
>=20
> Create a kthread that gets created the first time a trigger data is freed=
,
> and have it use the lockless llist to get the list of data to free, run
> the tracepoint_synchronize_unregister() then free everything in the list.
>=20
> By freeing hundreds of event_trigger_data elements together, it only
> requires two runs of the synchronization function, and not hundreds of
> runs. This speeds up the operation by orders of magnitude (milliseconds
> instead of several seconds).
>=20
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Very nice!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

> ---
> Changes since v1: https://patch.msgid.link/20251120205710.151041470@kerne=
l.org
>=20
> - Moved include of llist.h to trace.h as it is used there (Masami Hiramat=
su)
>=20
> =C2=A0kernel/trace/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A0kernel/trace/trace_events_trigger.c | 55 ++++++++++++++++++++++++++=
+--
> =C2=A02 files changed, 54 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 5863800b1ab3..911fc75dc6c4 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -22,6 +22,7 @@
> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/once_lite.h>
> =C2=A0#include <linux/ftrace_regs.h>
> +#include <linux/llist.h>
> =C2=A0
> =C2=A0#include "pid_list.h"
> =C2=A0
> @@ -1808,6 +1809,7 @@ struct event_trigger_data {
> =C2=A0	char				*name;
> =C2=A0	struct list_head		named_list;
> =C2=A0	struct event_trigger_data	*named_data;
> +	struct llist_node		llist;
> =C2=A0};
> =C2=A0
> =C2=A0/* Avoid typos */
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_eve=
nts_trigger.c
> index e5dcfcbb2cd5..3b97c242b795 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -6,6 +6,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/security.h>
> +#include <linux/kthread.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/mutex.h>
> @@ -17,15 +18,63 @@
> =C2=A0static LIST_HEAD(trigger_commands);
> =C2=A0static DEFINE_MUTEX(trigger_cmd_mutex);
> =C2=A0
> +static struct task_struct *trigger_kthread;
> +static struct llist_head trigger_data_free_list;
> +static DEFINE_MUTEX(trigger_data_kthread_mutex);
> +
> +/* Bulk garbage collection of event_trigger_data elements */
> +static int trigger_kthread_fn(void *ignore)
> +{
> +	struct event_trigger_data *data, *tmp;
> +	struct llist_node *llnodes;
> +
> +	/* Once this task starts, it lives forever */
> +	for (;;) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (llist_empty(&trigger_data_free_list))
> +			schedule();
> +
> +		__set_current_state(TASK_RUNNING);
> +
> +		llnodes =3D llist_del_all(&trigger_data_free_list);
> +
> +		/* make sure current triggers exit before free */
> +		tracepoint_synchronize_unregister();
> +
> +		llist_for_each_entry_safe(data, tmp, llnodes, llist)
> +			kfree(data);
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0void trigger_data_free(struct event_trigger_data *data)
> =C2=A0{
> =C2=A0	if (data->cmd_ops->set_filter)
> =C2=A0		data->cmd_ops->set_filter(NULL, data, NULL);
> =C2=A0
> -	/* make sure current triggers exit before free */
> -	tracepoint_synchronize_unregister();
> +	if (unlikely(!trigger_kthread)) {
> +		guard(mutex)(&trigger_data_kthread_mutex);
> +		/* Check again after taking mutex */
> +		if (!trigger_kthread) {
> +			struct task_struct *kthread;
> +
> +			kthread =3D kthread_create(trigger_kthread_fn, NULL,
> +						 "trigger_data_free");
> +			if (!IS_ERR(kthread))
> +				WRITE_ONCE(trigger_kthread, kthread);
> +		}
> +	}
> +
> +	if (!trigger_kthread) {
> +		/* Do it the slow way */
> +		tracepoint_synchronize_unregister();
> +		kfree(data);
> +		return;
> +	}
> =C2=A0
> -	kfree(data);
> +	llist_add(&data->llist, &trigger_data_free_list);
> +	wake_up_process(trigger_kthread);
> =C2=A0}
> =C2=A0
> =C2=A0static inline void data_ops_trigger(struct event_trigger_data *data=
,

