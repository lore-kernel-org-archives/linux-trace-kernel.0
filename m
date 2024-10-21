Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7251E32C2;
	Mon, 21 Oct 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503893; cv=none; b=BTI/3TetdW/oLrVS+WdbxdBqT1VoQQ3HYBzCAaae9ksUiCKFZUk8p7qzkz2/TiuQHQ8qYSQDYUa+GwlX+KRzETkhjgkrdTNhR3dqRLqx0fq/1jrsbvbZBzRt0KoDm+1fRkG9FXwXZujFCk5S0LidCDIrkLkEnQgOuJNQ8S6WdAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503893; c=relaxed/simple;
	bh=4hhyyXoiB5pb01jeMMh9kHegq0/iQPW7gU2ES1fF2ro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bi/Vbh9g4cvUh48GJXh7sWApGLwO4sCNA//NsKNR4jPygQuxCJHe5wARD3TTSkFj1ekbHS/OvJ+1TrdGx+M7NwLAZvPLfAcRDVJXGO2VoMfqBCguNTzoKp2Kp0omX80rt+YdfAyq5szya4WJvYPNv9eDKldtYrBzooO4DK4Eykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=D5rn6Eae; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="D5rn6Eae"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E43361C0007;
	Mon, 21 Oct 2024 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729503883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NZEgQgSIER4U+57OAed9+YasME4GNodja+ZxrnB9kC8=;
	b=D5rn6Eaen6Ua1EPzxZTBRrtlnYpYoyLdJd8hmBgOFEb4UlKRJwwW2wnBWP5zYiFBUML0GH
	2twz6bWXSyCtJms8TsATfi7J7DjFFM6jey0t5bQokUXxkaDmWQ1rg5mQF7loWJ/rF8R64c
	DIS/BpSDaKjanHb8ublu4FHpiEq3KCGCebdENBWcOfCsXwSKk0nRWoUgwBTFdKmLlzJBYy
	PXRvRNOjYnzYLnbd3ogkYa/+oZet2Sx9E0A7MJaVjrzWSom4v8iMw2nOPNnVuiu8EUIYnI
	qGoRNV7lFqXHgCkok1/7jpLhNmpQZ5DSoAbXPXxs3JANN4b5X6/DrGdcfVRdoA==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH RFC 0/2] Add basic tracing support for m68k
Date: Mon, 21 Oct 2024 11:44:41 +0200
Message-Id: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkiFmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyND3cSUFN1cM4ts3ZKixOTMvHTd4tKCgvyiEl1js2RDixQjI2PjFAs
 loPaCotS0zAqw0dFKQW7OSrG1tQAMFvKdbwAAAA==
X-Change-ID: 20241021-add-m68k-tracing-support-36c18d2233d8
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729503882; l=2478;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=4hhyyXoiB5pb01jeMMh9kHegq0/iQPW7gU2ES1fF2ro=;
 b=1JKFddvpN6dr45qJtYHNMvSGtjmGr3vem/1uEBLLfIhlP3hOzYg45ePNZS6/3y25bxP07OhZW
 4hXmwkXXNDkCPeiBiRf53qL03hk2O2Ok86RRiG49Km9XYnU5Vh8SdWB
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

I am very interested by any relevant test to do (switch events ?
Anything else ?) to improve the series (and the platform :-)).

I am quite sure I missed a *lot* of things, but it seems to do what I
need :-). I post it as RFC for now, in particular because I added a new
file, and I am not sure if it is the proper way.

Thanks for your remarks and improvements !

[1]: https://lore.kernel.org/linux-m68k/20241018124511.70d29198@gandalf.local.home

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
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
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241021-add-m68k-tracing-support-36c18d2233d8

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

