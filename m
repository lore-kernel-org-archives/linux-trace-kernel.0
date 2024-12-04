Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517B518C322;
	Wed,  4 Dec 2024 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296491; cv=none; b=QVPN5IdziSEnt4oSUcezuigBuhXFmPFDQwCfva3xCkXEwoOurIK0sr1AAZlL7fcbjGDPztsn4LWk26yxJ1LWp9J16bvv0u3t9ygroz2CfWrAdYhDlhJ0+6EdJEpbsn4zIh5WU6koIsaCKkdMHS9TKagaD8mw3dv0mBlC7RknoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296491; c=relaxed/simple;
	bh=jrRF81R7GiQUG/i6IsP2J+XUCxX2FNzubzQMoebkzjc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C1DKsGBAURBC+6KBnxquhtauu+AeZhsAklVk9OuJBmw2Ti8hA5rVyy/dT2f9h2Ux0eHiuL7jfyaJ9otmNgfMY1O4mYuEpzfwPBndbKyCDeE6O8MSbd4nNqV7IuOZFiIrnC6dtl612oBsdqj3Qih6p6Y7SkPDq0OvPE8foKTmcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=GKaOJPBg; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="GKaOJPBg"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69801E0003;
	Wed,  4 Dec 2024 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733296482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Otn7eQsyNkDKL3YbZcuyAks8iNT3u3kMYofdXFSjDs8=;
	b=GKaOJPBgWYmXYBA+RVwYMZz4JrOG9oYmBeIESEAibyVbeKvforEuy9VtHKkeRZ67Fy7nwc
	MtZZ9fou+kUTWfoB7JqBNsrK3Rw2rp2upXUFe2Q2PVCLhKkaa28v/pbb8sF+Z+HYPdVg2A
	WC7yn3ORWXKaHDm+p6aSeYmUmBkYd56F6+ulVuhq8pVjz61Jd0+n/3a8V1CYVVxCaVuKuv
	Qf0YKnncJZ0xGVX93ZE1h5ITW/JCCECRo0/2c3yDMRUisJQiAtQDewY8pJgA/IrnHC8l19
	ClMbbr/YPeFYYukav4ISUI3EliJSiMbbCdY8CyVbHruhGNwOX3guUdQ9nlulVg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH v4 0/2] Add basic tracing support for m68k
Date: Wed, 04 Dec 2024 08:14:38 +0100
Message-Id: <20241204-add-m68k-tracing-support-v4-0-e24fe5ef3b6b@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF4BUGcC/43NQQ6CMBCF4auYrq1pZwoUV97DuKi0QKNS0mIjI
 dzdwsYYE8Pyf8l8M5FgvDWBHHcT8SbaYF2XQux3pGpV1xhqdWoCDARnwKnSmj5yeaODV5XtGhq
 efe/8QDGvuNQAiFqSdN57U9vXSp8vqVsbBufH9VPky7oBjZwyyqREXTCRQXY9jS6Yuz0435BFj
 fCRgOEfCZJUFMiAlYUqa/Ej4VYJkyS0KbHOK2Wy7Eua5/kNGVTivlUBAAA=
X-Change-ID: 20241021-add-m68k-tracing-support-36c18d2233d8
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733296481; l=4146;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=jrRF81R7GiQUG/i6IsP2J+XUCxX2FNzubzQMoebkzjc=;
 b=Tx3NVvmOt8vLlOIdvC8hWm+/AqMKcjgU3Qrb3P61BDk3gW9ikgwREL51D1k8qCIyS8SzPSviC
 nuSOnzqGlqqAdykS7I0coLjARDGAAIuRhb8w3yuJLE0SMCdwY5XR0iT
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
Changes in v4:
- Take Steve's v1 remarks !
- Link to v3: https://lore.kernel.org/r/20241203-add-m68k-tracing-support-v3-0-4de93f6cae55@yoseli.org

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
      m68k: Enable traceirqs
      arch: m68k: Add STACKTRACE support

 arch/m68k/Kconfig             |  6 ++++
 arch/m68k/kernel/Makefile     |  1 +
 arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)
---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241021-add-m68k-tracing-support-36c18d2233d8

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

