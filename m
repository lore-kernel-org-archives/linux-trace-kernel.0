Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853305;
	b=35V6WGvxQv6fgzZAv/S9rELXq8mlYQGdlfan3FRvBUHrH3uG1+FwsumBTyMgzRG/0oBK
	 eKrRP6auxg/iQsyIPE5wSG1mfp/NOgg+6/i3S/Mbpjy5T1qjaz7HpnAKfbWBtuQLl0LEN
	 sZKTVTp+KztczbQ6EpSeqxJy9nw7UjmkgvIvoLVgEc1J1kXeXBiWM1iToerPXnLtr/IcI
	 2lch3CIengjxRIYW+iYgNw3aU08GnZH+5yQrj6K5kTQ18GjOZJu4SycHECdqBBCJvHUC0
	 NZasSON8pN7MYCwWFadUveo/Eewpg9lGr3zhdOR+C2Bx4woDPvuKx/xSPrAogHaX8zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853305;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=ABDMRmX2qjUWTye2+cWKlCKH3jB8QfXq511EgObbU6Q=;
	b=zJw1FrgOaojdgoFkZmkK44zQdvNnIQAZnr8OCK+b1E88Ovn+g1qX+fgJJmuskY97P34N
	 sipu0Z3uUGP+sQJKe65RLYa194G6Y1t8aM8VjHxAe4JjMp/syfModTtXE7f8adFMD/mvB
	 MR2Aq6mNVSF93jAQ5nnT6HPgJgIHrXT1wA81cqaEsme1CDblX8RE6IIX8gT6kv1klCb7u
	 Oi3GtJmM0/QoMn3Zx0m4VYpKQ7KBo7VhJAqJUSiQlhR2w+kd8dhru35mWoQk+QGllQY+j
	 IUfmt2Tol1kVfJi9rVTFhojeEFCOJQERg1dm+H/QKrTEWBmvetteVbp7WN69fSBe3mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=vQTLFVbz;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CEE606A31A;
	Sat, 24 Oct 2026 14:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51CEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=vQTLFVbz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792853299; bh=ABDMRmX2qjUWTye2+cWKlCKH3jB8QfXq511EgObbU6Q=;
	h=From:To:Cc:Subject:Date;
	b=vQTLFVbzAd5lN3pTBd2zjr9yL2XUkqlgxaF5ulPV57hnsLjYZxdNVSDWfNSixpEBX
	 TQW35VmBi8VxcfoGJLvdX2y5IrCRPe7TAIXcW8axorfDaHAttMaxEKLbagnpOgO805
	 CL+TH6WEyWunL42S/Jyfgoi5404/CH87dYbwGZKw=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id C113044A; Sat, 24 Oct 2026 22:48:17 +0800
X-QQ-mid: xmsmtpt1792853297tyw74ycl9
Message-ID: <tencent_51CD3420AAC8A722EA2FD5FEFB6524D4A905@qq.com>
X-QQ-XMAILINFO: NCmjBvJFq6XNAbEtx0Z7xNxzzqc47/GroJE9x+wPdFR8MfzfNmjq7PMNCVFM/C
	 ePrbLqSWa7gNqYk/HWN/0Izh3JJcVYcWHZIksej7JjTit30IeCzAKVHq87NHLWeib5SWBuQdAR9e
	 +ALM8h5RZy1FW8dVMTJXU1jOiztsVGi9izvfaiwJPMiGIrGA2fgxrtTkJT10vQ7FbU1xvrPJ9rEf
	 mPSQEyjI1F2jUAziAyaAm39WaRvsafCBz7FSSKe8HD5GxWMwIfmfQ20ezO1eCVpzcA0kCq8gCpm8
	 wMvB0qYQ6hEsApf0dGTFVPzTBTX09/LPgw6MGJp4CBqVhYAke+ELq6etktV7+SE/kSoee/+NCGAl
	 Fv9GT6Btvc8RZEhxiPNhBUWLooISO65uKei4YDj47ht5uz2j/tXUAgUkjXBIg4+hkyHBk9cjKF5m
	 0YzXvTfPCkR3J6eMtCJzgvPD8KYmTtCFyAsjyMi+UVVi9vcDbe7myUlUVq3wHI0jsX7geE+UBP0k
	 J86n40WmiZmR+EIAiMNAL0sdhXREvE00LamMdcHXuZh1xnezi446yIquvZJCnSQ+w6aZw4dljXua
	 4qAwdETStyZfbgRiGKf6hmg2wqDlyUSdMz5yNcmP1ztyJBil8Da7R7Dmk3LWAxxuG7jI7qVNqKwO
	 cZHrQXhhtq9QXSEDKMAkfbTsQpIUYhv9KNCSgtG/jXRI8TPVZGjBSFVrb4219/AmNF2EI9h5844C
	 uFIN3sIcdaN/lg1Q01QovMYqrxVf9ptTNjv6bBXbOFUbfoxYlu+cJp3LDxYM+6tsl74X2v2JkLde
	 Flxpli8ycrhYOcD/q2w56PaUE9rVXDbw9b4GawGDgOsMkhQUUTVY4bIlFeh2KyddZo3Ac2twL82s
	 e3GXEoeZ7Yq79+8/winzCJ1Kr49jyA2Co9YgzUqkQpkk2SuQxkkEw+C3pENPih1bWjqYOKkVuWt2
	 pb0gnMlDUjHKZ12epFOqLwY0FjG5Qvfb3UwNOXoQ9LdiYBwMa/9OncRpltE4AzB8JW3x50RHqFgp
	 H2WFEvJlW7GfFYSvXjUkZADYBPTd4kemTEWFTMVerCmBE3iOYs70ttdp88Ug5i93CL6LxPL0q6uH
	 LmwbTFBnpoiBX/GSQ=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Guikun Yang <yangguikun19@qq.com>
To:
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] tracing: trigger filter use-after-free in set_trigger_filter()
 ENOMEM path
Date: Sat, 24 Oct 2026 22:48:16 +0800
X-OQ-MSGID: <20261024213000.91820-trigger-yangguikun19@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Steve, Masami,

set_trigger_filter() (kernel/trace/trace_events_trigger.c) violates RCU
publishing rules in its ENOMEM path, leading to a possible
use-after-free of struct event_filter.

The normal path is careful:

	tmp = rcu_access_pointer(data->filter);
	rcu_assign_pointer(data->filter, filter);
	if (tmp) {
		/*
		 * Make sure the call is done with the filter.
		 * ...
		 */
		if (system_state != SYSTEM_BOOTING)
			tracepoint_synchronize_unregister();
		free_event_filter(tmp);
	}

The old filter is freed only after tracepoint_synchronize_unregister(),
because trigger handlers read it under rcu_read_lock_sched() via
rcu_dereference_sched(data->filter) in event_triggers_call().

But the tail of the same function is not:

	kfree(data->filter_str);
	data->filter_str = NULL;

	if (filter_str) {
		data->filter_str = kstrdup(filter_str, GFP_KERNEL);
		if (!data->filter_str) {
			free_event_filter(rcu_access_pointer(data->filter));
			data->filter = NULL;
			ret = -ENOMEM;
		}
	}

At this point data->filter is the freshly published "filter" (from the
rcu_assign_pointer above).  When the kstrdup of the filter string fails
under memory pressure, the just-published filter is freed immediately,
without any grace period.  A concurrent event_triggers_call() on
another CPU can have already dereferenced data->filter (this filter)
under rcu_read_lock_sched() and be walking the preds when the kfree
lands — a use-after-free.

Sequence:

    T1 (tracefs write, holds event_mutex)      T2 (tracepoint fires)
    -----------------------------------------  -------------------------------
    create_event_filter(...) -> F_new
    rcu_assign_pointer(data->filter, F_new)
                                               data->filter deref -> F_new
                                               filter_match_preds(F_new)...
    kstrdup(filter_str) fails
    free_event_filter(F_new)   /* no sync! */  ... still using F_new

The write side holds event_mutex, but the trigger execution side does
not take that mutex; the only protection for the filter lifetime is the
RCU grace period, which this path skips.

Trigger conditions: an admin writes a trigger with an "if" filter
while the target event fires at high rate (e.g. sched_switch,
irq handlers), and the kstrdup fails (GFP_KERNEL allocation under
memory pressure).  The failing allocation is easy to hit repeatedly
via a memory-hungry cgroup.  The freed filter's preds array is
then read by filter_match_preds().

Fix: either free the new filter before publishing (i.e., don't
rcu_assign_pointer until the filter_str copy succeeded), or perform
tracepoint_synchronize_unregister() before free_event_filter() in the
ENOMEM path, mirroring the normal path.  The first variant is
cheaper: move the kstrdup above the "assign:" label and release the
pointer only after the string copy succeeded.

I found this by code inspection.  Checked against 7.3.0-rc7 and
linux-next (2026-10-24): both are unchanged.  syzbot has no matching
report (its trigger coverage focuses on counting/snapshot triggers,
not on the ENOMEM path of filter assignment), and I found no prior
report on lore/marc.

Best,
Guikun Yang

