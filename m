Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F71FA166;
	Tue,  3 Dec 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246514; cv=none; b=rGXsEILsATssCHgxuJ7RpdDiQA0qwq1NrJw++U+alPJ4W5GbBC+qcKyJ3bz4ENisKqIb8xR9v8Dmg6+5+815MLwEPufFXaihhK4nyibX4QzAB8Ni6lpYHUTa2MJT5qrwDdOcy1szqOT9cs74IhMAYOI/RC8LzTt52qALIHbFu+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246514; c=relaxed/simple;
	bh=xy6Tvlpd9L1+hVrAsSZEgFC+sDEa9jTQGFW09O89aIM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pNhZQ4HUC/D1oLFivQLXi1Hma21RVJ8QgS8JSq5JvgjKcvSvWCyfHhYfTGUnhhrS4D9lapPH3mUwxNgQV2yaIZBKSCUg3ktiG96OlL1hZtjKX0vkXkv2UDlG+/Jb0qzyOvhOXn06FcbCPHLYd4u3F9t8Z5wxc4MB/5oyhXof0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=dO2woW4y; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="dO2woW4y"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75265240006;
	Tue,  3 Dec 2024 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733246503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WtJeg2U2iP69o6t1Gwg7RiKNYXTEb2gTKKysOkdqUKs=;
	b=dO2woW4y1AZj9r8gNdbG0r4WuQPaj15d/6RpcSOsYWZgDJujwiOIVh7rc3DsvKNj3R3411
	EJU4uV0zWuDQvQj9REHt/zWuS1YtKbycLy9Uk6nuTPT9g+Qw0Zlx2L/Ex1dk2dXGVmjX+Y
	75BWr8YMPXfVtTcITgMmxYQo8S2iFfnqi8gWD0ukeK+Jghx3C19q/yc3I1tCgAY9KzUOIk
	Aha6z0JU3G1qkNaoDs8EezOAHWtulk5jnEhP/KrwAe34B2wXjzPbdGiClKO+HpRJmVZE2m
	uZnFkBuMoiYAm9X0fK1rF6oYRRy4pnJ8wv+LQdMuc8xxUyYU7d1dX2B0k7/7Ug==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH v2 0/2] Add basic tracing support for m68k
Date: Tue, 03 Dec 2024 18:21:37 +0100
Message-Id: <20241203-add-m68k-tracing-support-v2-0-77302097a9f4@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACE+T2cC/42NQQ6CMBBFr0Jm7Zh2Cti48h6GBdIKE5U2UyQSw
 t2tnMDle8l/f4XkhX2Cc7GC+JkThzEDHQrohnbsPbLLDKSo1Io0ts7hq7YPnKTteOwxvWMMMqG
 pO20dkTHOQp5H8Xf+7Olrk3ngNAVZ9qdZ/+wf0VmjQmWtcSdVVlTdLktI/snHID0027Z9AZKyN
 xHBAAAA
X-Change-ID: 20241021-add-m68k-tracing-support-36c18d2233d8
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733246503; l=3859;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=xy6Tvlpd9L1+hVrAsSZEgFC+sDEa9jTQGFW09O89aIM=;
 b=N/j2K5z9l5huXlI9GzLXNeT2fsNS8bKC2jRHQXhWrmIrfFPtpNVWDSCOiVGau995daaKnQbk4
 BscNATXkn/8CGVGBhjfGslCMqGyD9nNp5fw1qiUyHpihJZ9OaX1yNJX
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
Changes in v2:
- Use the frame pointer and declare it
- Comments on trace_irq have been tested, but adding the trace_on/off in
  entry.S fails badly
- Link to v1: https://lore.kernel.org/r/20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org

---
Jean-Michel Hautbois (2):
      m68k: Add tracirqs
      arch: m68k: Add STACKTRACE support

 arch/m68k/Kconfig             |  7 +++++
 arch/m68k/kernel/Makefile     |  1 +
 arch/m68k/kernel/irq.c        |  2 ++
 arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)
---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241021-add-m68k-tracing-support-36c18d2233d8

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

