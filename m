Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACC1F7584;
	Tue,  3 Dec 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255796; cv=none; b=G6A8n2SIallQY/jzMqWFAg2RUk8GpGqIS3N+K1PnkuhTrmz2u1wy1KT51cS2Cf7cqTmUYd/XVkR6REixQmKHoHZHOXDUE99VQuBeZW8K8GbxoTTbvsqcAa/+pHyHvuTVuuK7cUP5iqeteCtSkF4MznU1rVDDugvmegQKno6rLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255796; c=relaxed/simple;
	bh=pxvKSQlwdw9GcfJR9m9NtJpiZxZib1r1YsmMbG8FTC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YXpZargxBFr/AqpyRubUmNW2c6T+rGHxrDDbrKHQOeTHVoZkXmZA2T/tQsdd+lBqYY5Hl07PPx6WL8cq0ums84oJdpEcoLq/as482ztPDUYP2SkMpMIoiQDtpd+YieJByEovD5NYlcGmhySxYToNVcL96efyLhIJicwEaq2gWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=Wbzm45kY; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="Wbzm45kY"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EE4520004;
	Tue,  3 Dec 2024 19:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733255786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qNJss9Ll1Ccm9hr8vFcFCAyc+39IF1+cDqKxrq+GcDE=;
	b=Wbzm45kYJ0K+xm/b82Td4vwYrFb6HorgCSOLpP6OQMOJVTup+rTx6elYcsLGAGk8Igz/Ix
	Wu2G5F5SBvaxiJm6euIDyhNVxGE+q71YdC9mnlPTxD8OcVYZvlM98dzusQwgbzZh3vQV9y
	zKa0fnJWBBsG2RgCS9yp2oOh2hHccsNJCAtyQXz/vY4EHjVBZXbYHjLQu76Gi9d8qWDVs1
	nC9ACCWZv2gpaWzEiNmRdnd3KpKVRTPJHjicxtRiWrZliNnkfXSFhernKdslIocmhh9hN9
	M0OBpv7g8QvBRqQvIMIKzO+iS5JBTfQ5Lr6hkRyWYwiJDWd4nyFqzPVklzjhdw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH v3 0/2] Add basic tracing support for m68k
Date: Tue, 03 Dec 2024 20:56:24 +0100
Message-Id: <20241203-add-m68k-tracing-support-v3-0-4de93f6cae55@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGhiT2cC/43NTQ6CMBCG4auYrq2ZTvkprryHcVFpgYlKSYuNh
 HB3Cxvjxrh8v2SemVmwnmxgx93MvI0UyPUp5H7H6k73reVkUjMEzASg4NoY/ijUjY9e19S3PDy
 HwfmRy6IWyiBKaRRL54O3Db02+nxJ3VEYnZ+2T1Gs6x9oFBw4KCVNCVmO+fU0uWDvdHC+Zasa8
 SMhyB8SJqksJSBUpa6a7EtaluUNGcy5iwsBAAA=
X-Change-ID: 20241021-add-m68k-tracing-support-36c18d2233d8
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733255785; l=4031;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=pxvKSQlwdw9GcfJR9m9NtJpiZxZib1r1YsmMbG8FTC4=;
 b=ysd6Zs594kqIExopOfRnJ+sTVswj2FEbUkaEGAwlZebqvAi/zKZ3z5OtSi9T0xxe+n01B7LdZ
 7Hr3xNWysmND5ig9qY7jXZiLN6NSOn4FJFqbJAdl4LInzGm8W5EawkJ
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

In order to debug latency issues, I wanted to use ftrace on my M54418
coldfire. Sadly, it is not supported yet.
Thanks to Steven [1] it does not sound too difficult.

This small series adds basic functions to make it work, and for the few
tests I could do, it seems to be working well.

Here is a simple output I get:

```

            bash-232     [000] d..3.   947.629000: thread_noise:     bash:232 start 947.629000000 duration 0 ns
      timerlat/0-274     [000] .....   947.629000: #51598 context thread timer_latency    409280 ns
            bash-232     [000] d.h..   947.630000: #51599 context    irq timer_latency    110720 ns
            bash-232     [000] dnh1.   947.630000: irq_noise: timer:206 start 947.629000000 duration 1000000 ns
            bash-232     [000] d..3.   947.630000: thread_noise:     bash:232 start 947.630000000 duration 0 ns
      timerlat/0-274     [000] .....   947.630000: #51599 context thread timer_latency    407168 ns
            bash-232     [000] d.h..   947.631000: #51600 context    irq timer_latency    108608 ns
            bash-232     [000] dnh1.   947.631000: irq_noise: timer:206 start 947.630000000 duration 1000000 ns
            bash-232     [000] d..3.   947.631000: thread_noise:     bash:232 start 947.631000000 duration 0 ns
      timerlat/0-274     [000] .....   947.631000: #51600 context thread timer_latency    401472 ns
```

I used this on my board and afaik, it works quite well.

```

 telnetd-229       0Dnh4.   13us+:      229:120:R   + [000]     118: 49:R irq/100-enet-fe
 telnetd-229       0Dnh4.   53us+: <stack trace>
 => __trace_stack
 => probe_wakeup
 => try_to_wake_up
 => wake_up_process
 => __handle_irq_event_percpu
 => handle_irq_event
 => handle_level_irq
 => generic_handle_irq
 => do_IRQ
 => inthandler
 => ip_finish_output2
 => __ip_finish_output
 => ip_output
 => __ip_queue_xmit
 => ip_queue_xmit
 => __tcp_transmit_skb
 => tcp_write_xmit
 => __tcp_push_pending_frames
 => tcp_push
 => tcp_sendmsg_locked
 => tcp_sendmsg
 => inet_sendmsg
 => sock_write_iter
 => vfs_write
 => ksys_write
 => sys_write
 => system_call
 telnetd-229       0Dnh4.   68us!: wake_up_process <-__handle_irq_event_percpu
 telnetd-229       0D..3.  348us+: __schedule <-preempt_schedule_irq
 telnetd-229       0D..3.  368us+:      229:120:R ==> [000]     118: 49:R irq/100-enet-fe
 telnetd-229       0D..3.  395us : <stack trace>
 => __trace_stack
 => probe_wakeup_sched_switch
 => __schedule
 => preempt_schedule_irq
 => Lkernel_return
 => ip_finish_output2
 => __ip_finish_output
 => ip_output
 => __ip_queue_xmit
 => ip_queue_xmit
 => __tcp_transmit_skb
 => tcp_write_xmit
 => __tcp_push_pending_frames
 => tcp_push
 => tcp_sendmsg_locked
 => tcp_sendmsg
 => inet_sendmsg
 => sock_write_iter
 => vfs_write
 => ksys_write
 => sys_write
 => system_call
```

[1]: https://lore.kernel.org/linux-m68k/20241018124511.70d29198@gandalf.local.home

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
Changes in v3:
- Do not unconditionaly select the frame pointers
- Link to v2: https://lore.kernel.org/r/20241203-add-m68k-tracing-support-v2-0-77302097a9f4@yoseli.org

Changes in v2:
- Use the frame pointer and declare it
- Comments on trace_irq have been tested, but adding the trace_on/off in
  entry.S fails badly
- Link to v1: https://lore.kernel.org/r/20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org

---
Jean-Michel Hautbois (2):
      m68k: Add tracirqs
      arch: m68k: Add STACKTRACE support

 arch/m68k/Kconfig             |  6 ++++
 arch/m68k/kernel/Makefile     |  1 +
 arch/m68k/kernel/irq.c        |  2 ++
 arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)
---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241021-add-m68k-tracing-support-36c18d2233d8

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

