Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D8C2BAE3;
	Wed, 11 Sep 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036864; cv=none; b=bVdkY3yRa5VJ8yHlRs+5soJ2iE5DXz6i0hGhd8kpuJf+tnX+Rdm/X4xxYfbPzuj83OpgQY/kVUGpOcDAKoLnyAZjHFZn1Omd171ubLr46VGFy4bOyBGlNHYuLNTvm+JsNjxdPHz00+5gECVJTYJl6fT5rErILiUnYrRD4FuEaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036864; c=relaxed/simple;
	bh=PUT6YAZ8urCaAMTnaBkha89E9PhBervZNpgnP6+Uxjs=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=To7bIBOCcvTv8J7Tebq4Cv//GlYfzTxZkpsO3V2UamMvOqCfRooN8hm+58MTZsx2nwhD4s/OBn+6mr+SDWH9yPZcdR8rmRRygXnCDnUgH03cmEUW5moxgjTXd3cwCxy0NXtxDFQlr2JHD3gjc9EneBaaAGg9xxY0Hl/q/7y2Iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxyul5O+FmTXIEAA--.10403S3;
	Wed, 11 Sep 2024 14:40:58 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front2 (Coremail) with SMTP id qciowMAxKsZ4O+FmkjsEAA--.19709S3;
	Wed, 11 Sep 2024 14:40:57 +0800 (CST)
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Question about config UPROBES and UPROBE_EVENTS
Message-ID: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
Date: Wed, 11 Sep 2024 14:40:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qciowMAxKsZ4O+FmkjsEAA--.19709S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy3CryDJF13WF1xJFW3XFc_yoW8GF1Dpr
	n0ywn3Xrs8GFsYy3yayryxCry8Xwn3JrW3XFn3Ga4rJrWrA3y8urnIgr9rta4UCwsrt3yr
	KFyfWayjqa9xurbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
	VUUUUUU==

Hi Masami,

I am a little confused about config UPROBES and UPROBE_EVENTS.
Uprobes is the user-space counterpart to kprobes, I want to do
some small changes:

(1) since config KPROBES can be selectable, just make config UPROBES
     selectable too.

(2) since config KPROBE_EVENTS depends on KPROBES rather than select
     KPROBES, just make config UPROBE_EVENTS depends on UPROBES rather
     than select UPROBES.

Could you please let me know are you OK with the following changes?
If yes, I will send formal patches later.

-- >8 --
diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..5de2187d3440 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -124,7 +124,8 @@ config KPROBES_ON_FTRACE
           optimize on top of function tracing.

  config UPROBES
-       def_bool n
+       bool "Uprobes"
+       default n
         depends on ARCH_SUPPORTS_UPROBES
         help
           Uprobes is the user-space counterpart to kprobes: they
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 721c3b221048..7db0462a5d11 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -732,10 +732,9 @@ config KPROBE_EVENTS_ON_NOTRACE

  config UPROBE_EVENTS
         bool "Enable uprobes-based dynamic events"
-       depends on ARCH_SUPPORTS_UPROBES
+       depends on UPROBES
         depends on MMU
         depends on PERF_EVENTS
-       select UPROBES
         select PROBE_EVENTS
         select DYNAMIC_EVENTS
         select TRACING

Thanks,
Tiezhu

