Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A52F1FE6;
	Tue,  1 Jul 2025 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751330011; cv=none; b=U90XzyOgImkfxcRnjFLdHAuntuDRKH6CJG+v/Ggx3kH94LmEyRSTwLhYThg6/nXsiANl9SREdZGao07rLsShEIma41qRi3sn3U7H91JEyK8CDb6ubhKQGJ9Xgyd2sv+HL03rMC/PZ0V3CpD1fGLzba7VXch/qRkFrJl9VWEI3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751330011; c=relaxed/simple;
	bh=/skP8Ljo8IEscW1zmu5gFSkR+/tvjcLxuPcDoAwB+6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPlC6TFxCLGQJ8t6AmQlxCVuVxPzE3vJNUU9e3q/S2E3wwAECrRqNqpoEy6X4JSWRoRHgcLsCAE7ZrFGcRXWQO1qiBfbbAn+QxhbWIP2YleGH2lXyKgFAnN47paFcYhkNqP6QtmJSPL8s/MTh99VMz1zsdqD+LmeEY1ZQg0U0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6EF4F121CE1;
	Tue,  1 Jul 2025 00:33:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id B5A1E20029;
	Tue,  1 Jul 2025 00:33:25 +0000 (UTC)
Date: Mon, 30 Jun 2025 20:34:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
Message-ID: <20250630203401.1a11e58f@gandalf.local.home>
In-Reply-To: <d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pjgbnxhko5ejey819w8n1j8n6cuyxz71
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B5A1E20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+b2IhGEXg5GPmPtXjNLo1Qu7smsYZuQP0=
X-HE-Tag: 1751330005-756817
X-HE-Meta: U2FsdGVkX187jE53da+biyQct+qC0+tc43RGlHOpd9J+9/BJSRYAxs9npKwnthlQ38mbTcJE4YQl9gnvbpD0V98zAg0R2TyKlk9O9YMVTiBDnCLjrU+maXuCJCVXKW0e/4vR3wUTioZhbT86bWQegtpPZQ4dviNkkVDBVVHTjRFuBPN69+fVJCe4hD7HRBZgM4QyPbdCvQinoxDBpibzsWM3kxXCvc2hDzrsJlgLPEVXU20b9RVdn4K/w5qmtJGh/NHcapIcNB1eUZ37dNOAQG8mMPUf+j63W2FRZl0i5NKUM+NhPC7d/Vas5AtjVpTV

On Tue, 10 Jun 2025 11:43:42 +0200
Nam Cao <namcao@linutronix.de> wrote:

> +static void
> +ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsigned long *next)
> +{
> +	bool task_is_migration = test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
> +	bool task_is_rcu = test_bit(LTL_TASK_IS_RCU, mon->atoms);
> +	bool val40 = task_is_rcu || task_is_migration;
> +	bool futex_lock_pi = test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> +	bool val41 = futex_lock_pi || val40;
> +	bool block_on_rt_mutex = test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
> +	bool val5 = block_on_rt_mutex || val41;
> +	bool kthread_should_stop = test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms);
> +	bool abort_sleep = test_bit(LTL_ABORT_SLEEP, mon->atoms);
> +	bool val32 = abort_sleep || kthread_should_stop;
> +	bool woken_by_nmi = test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
> +	bool val33 = woken_by_nmi || val32;
> +	bool woken_by_hardirq = test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
> +	bool val34 = woken_by_hardirq || val33;
> +	bool woken_by_equal_or_higher_prio = test_bit(LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
> +	     mon->atoms);
> +	bool val14 = woken_by_equal_or_higher_prio || val34;
> +	bool wake = test_bit(LTL_WAKE, mon->atoms);
> +	bool val13 = !wake;
> +	bool kernel_thread = test_bit(LTL_KERNEL_THREAD, mon->atoms);
> +	bool nanosleep_clock_tai = test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms);
> +	bool nanosleep_clock_monotonic = test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC, mon->atoms);
> +	bool val24 = nanosleep_clock_monotonic || nanosleep_clock_tai;
> +	bool nanosleep_timer_abstime = test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mon->atoms);
> +	bool val25 = nanosleep_timer_abstime && val24;
> +	bool clock_nanosleep = test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
> +	bool val18 = clock_nanosleep && val25;
> +	bool futex_wait = test_bit(LTL_FUTEX_WAIT, mon->atoms);
> +	bool val9 = futex_wait || val18;
> +	bool val11 = val9 || kernel_thread;
> +	bool sleep = test_bit(LTL_SLEEP, mon->atoms);
> +	bool val2 = !sleep;
> +	bool rt = test_bit(LTL_RT, mon->atoms);
> +	bool val1 = !rt;
> +	bool val3 = val1 || val2;
> +
> +	switch (state) {
> +	case S0:
> +		if (val3)
> +			__set_bit(S0, next);
> +		if (val11 && val13)
> +			__set_bit(S1, next);
> +		if (val11 && val14)
> +			__set_bit(S4, next);
> +		if (val5)
> +			__set_bit(S5, next);
> +		break;

What's with all the magic numbers?

Can we turn these into enums so they have some meaning for us humans?

-- Steve

> +	case S1:
> +		if (val11 && val13)
> +			__set_bit(S1, next);
> +		if (val13 && val3)
> +			__set_bit(S2, next);
> +		if (val14 && val3)
> +			__set_bit(S3, next);
> +		if (val11 && val14)
> +			__set_bit(S4, next);
> +		if (val13 && val5)
> +			__set_bit(S6, next);
> +		if (val14 && val5)
> +			__set_bit(S7, next);
> +		break;
> +	case S2:
> +		if (val11 && val13)
> +			__set_bit(S1, next);
> +		if (val13 && val3)
> +			__set_bit(S2, next);
> +		if (val14 && val3)
> +			__set_bit(S3, next);
> +		if (val11 && val14)
> +			__set_bit(S4, next);
> +		if (val13 && val5)
> +			__set_bit(S6, next);
> +		if (val14 && val5)
> +			__set_bit(S7, next);
> +		break;
> +	case S3:
> +		if (val3)
> +			__set_bit(S0, next);
> +		if (val11 && val13)
> +			__set_bit(S1, next);
> +		if (val11 && val14)
> +			__set_bit(S4, next);
> +		if (val5)
> +			__set_bit(S5, next);
> +		break;
> +	case S4:
> +		if (val3)
> +			__set_bit(S0, next);
> +		if (val11 && val13)
> +			__set_bit(S1, next);
> +		if (val11 && val14)
> +			__set_bit(S4, next);
> +		if (val5)
> +			__set_bit(S5, next);
> +		break;
> +	case S5:
> +		if (val3)
> +			__set_bit(S0, next);
> +		if (val11 && val13)
> +			__set_bit(S1, next);
> +		if (val11 && val14)
> +			__set_bit(S4, next);
> +		if (val5)
> +			__set_bit(S5, next);
> +		break;
> +	case S6:
> +		if (val11 && val13)
> +			__set_bit(S1, next);
> +		if (val13 && val3)
> +			__set_bit(S2, next);
> +		if (val14 && val3)
> +			__set_bit(S3, next);
> +		if (val11 && val14)
> +			__set_bit(S4, next);
> +		if (val13 && val5)
> +			__set_bit(S6, next);
> +		if (val14 && val5)
> +			__set_bit(S7, next);
> +		break;
> +	case S7:
> +		if (val3)
> +			__set_bit(S0, next);
> +		if (val11 && val13)
> +			__set_bit(S1, next);
> +		if (val11 && val14)
> +			__set_bit(S4, next);
> +		if (val5)
> +			__set_bit(S5, next);
> +		break;
> +	}
> +}
