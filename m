Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680670;
	b=AHiGrPB4xOdn9sNHOs7HV9UACHShyb+PaavrHsfjzoBtcaJCQ6jqOqiAtzhe+3nATD1Q
	 Qv0742Cvlx4FX4CA/XQ2cnnUX5W6N7aVXZzBXI+e9rzMSOVuQQAs8yjV6PnRUZZqo5ma0
	 /QwtR5TMuUtSrtjCkj7m7hrQm+/LMfBLEznJPJ726sscLEh9IYgM1xo8dlFuuuizULcXR
	 vqMq4pVewaYwavkUuufsM/0mjbAJKFTUtRi/HcY9LOujJm34Iz2m6fB8FSDNbT3UuXkx/
	 n7dkCfxnrAqxa2ZrsvYj7UkuGy2axhBZXwkgi+qbk7rhMCDiU3qZMOusrBNiWEDjlJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680670;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UWeiiXU/CGZhT/IB9wANq5icufSPJ3/2vx8+tvdIqsU=;
	b=dFzzF9m+bWafHIgkhooBeUuxzi787NqyOXKZoMWwwHG/6ytqbmxdaZLX56blLbZ96RzU
	 0Oh4OYJNfMDqElYFZek+3SLbv+hnPJEnFacdY5AdBkEtk+jTCAeniRP/DecSdpRqE8SYl
	 AlfT1CKFf4vGYMX89P7W2F3P8zfKIcXpQWOypw/dRyRVHHJ6jGCIJiDMhdpxoj9PvGUf3
	 yfUb99RcmMKLdV7wPC7+1RDUM/+7VDiqpLomEWZeKO985tWoVFDppT82zLqzngPbykZgv
	 G0f5CYUTHcGo0MJbvD/QDGk6faQjehKJHaBfxsgxRPjYcDYsXjjuLIsfZ8TcBkdlvNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=kSjtprfG;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFAA606A31E;
	Thu, 26 Nov 2026 08:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FFAA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=kSjtprfG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=kSjtprfGX4h7QS7wO1QyhzVcJd3FsvZcIU5XQzipr7AedqZUynInMdndTgl+MixI6oEZN6Ihh4plU
	 iTVSIgwdyjX08X1pW/+xqapz0K+11EwfIgvZYxUQHeYxV6w46349bZCfGP1reSY5o82hw6Zlh6MERk
	 IUWScND/JZWO0Etg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36b07e999eed-26204;
	Thu, 26 Nov 2026 16:11:06 +0800 (CST)
X-RM-TRANSID:2ee36b07e999eed-26204
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-c950f82eaac8410e-20260515094303939 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76b07e997bc7-634b9;
	Thu, 26 Nov 2026 16:11:06 +0800 (CST)
X-RM-TRANSID:2ee76b07e997bc7-634b9
From: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing/sched_switch: drop duplicated NO_CMDLINE_MAP check
Date: Thu, 26 Nov 2026 16:11:03 +0800
Message-ID: <20261126081103.4224-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20261126081028.4208-1-zhaimingbing@cmss.chinamobile.com>
References: <20261126081028.4208-1-zhaimingbing@cmss.chinamobile.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NO_CMDLINE_MAP is defined as UINT_MAX, so "*ptr == -1" and
"*ptr == NO_CMDLINE_MAP" compare the same value: the signed -1
converts to UINT_MAX in the unsigned comparison.  gcc -Wlogical-op
flags the duplicated condition.  Drop the magic number and keep the
symbolic name, which is what the rest of the file uses.

Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
---
 kernel/trace/trace_sched_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 1bd351c1f..de58ff104 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -526,7 +526,7 @@ static void *saved_cmdlines_next(struct seq_file *m, void *v, loff_t *pos)
 
 	for (; ptr < &savedcmd->map_cmdline_to_pid[savedcmd->cmdline_num];
 	     ptr++) {
-		if (*ptr == -1 || *ptr == NO_CMDLINE_MAP)
+		if (*ptr == NO_CMDLINE_MAP)
 			continue;
 
 		return ptr;
-- 
2.43.0



