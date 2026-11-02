Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602924;
	b=ou29ga2hMUxTOdUiTISg+xgH03IseYew7S/ks51wSXAk1w2s3xvovr8RtYK1NXzuBqFX
	 gZNrW90VyQ15581J2bRcsvpqJKGK8dvPlEQvH/q1p+A0sPNaQ5h7B0wrXKru33JCxTxOX
	 u8PtiUC9MHiM279PiZKUmIjvvAQBsOIwFtvYr/jjlGtG2zWTkSIknoQwMAHXZUb0U4aVO
	 gS+yEY9XkWw5ibhC00C5ollYj0L7YuimwR/dffCNwCvBjWfpZG7/1C3ATI1tBnFhH/03I
	 bofYwBGdUoxnNx9r0YCiFHiuEKR+lqloov8E8Ze0CTbEH6jYmHoXcs5Sej7Cmi4ai8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602924;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=6PTR6abJpRyjElGgKx4JMxU9svg/JHoRrUggWCvaYyA=;
	b=4tcbYU7ab6hg7dpKbPO1L6UDClJF3GNur4b6g9auF2R9S+cO7HVFI78tn83V+n3qOfih
	 BPvk5t75Yxb1lzIy5349tyUsZ6UcWCTrAXA9mgmozY6GmewLwmRNcIWKqktlzCMy8PIHe
	 RIpgwci694Kpij8zNVypBePFw8ggBGjctlQGuQ4z0uDw91moA2f3wbsS//R1huT7uFvFY
	 eyMtOCFVEz7qz6dtMcUi6ERwXi7PcGx0tvdnEGcWTmSM4VT6EbutaIEbW4iUpRDsjJJeg
	 OMcnZZPfanehte/RcleV4Vru7NoOW+Ij8H7WbgM8KWhjaCCEgw2n55UgCDBufxblCpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LgnPqAtb;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B7606A335;
	Mon,  2 Nov 2026 07:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F8B7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LgnPqAtb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=6PTR6abJpRyjElGgKx4JMxU9svg/JHoRrUggWCvaYyA=;
	b=LgnPqAtb4H1CMwJ4C0I0iPLtFrUI2/YRYJ08d0qMN9YeHfiiLWtMOXTiQOR16A
	O1ge9gPmFSLmSQDRAhmLJNFFeptLrQhzro1Qey0m1tr02Bp6d3G7Pa7qYyqnoMBG
	MYFL8Td2aKKXTCaY9It3xQUGPhZ54L2A1zEP5/2ZoTsak=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtla: reject -e, --filter and --trigger without --trace
Date: Mon, 02 Nov 2026 15:01:31 +0800
Message-ID: <179360289114.124676.5863600854966859222@163.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3vyRaNehqaWhAEg--.56324S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw15Xry7Wr17tr4UCw4rXwb_yoW8ZrWxpa
	yvkr9Fyr1kWw4Fyws09r48JryDCrZ3XrWakFy8Kw1Fy3yavr9Ygana9rWagF4UCrsxA3ya
	vws29r1UK3yDJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3fH8UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xs4rWroNVvWEQAA3G

From: Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH] rtla: reject -e, --filter and --trigger without --trace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
    linux-trace-kernel@vger.kernel.org,
    linux-kernel@vger.kernel.org

-e, --filter and --trigger configure events of the trace instance that
--trace creates, and trace_events_enable() is only called from inside the
block that --trace or --on-end trace enters.  Without either of them the
options are parsed, stored in params->events and then never looked at
again: rtla runs to completion and exits 0, so the user is left believing
the events were enabled.

  # rtla osnoise top -e sched:sched_switch -d 1s
  ... runs for a second, exit 0, no trace file, event never enabled

  # rtla osnoise top -e nosuchsys:nosuchevent -d 1s
  ... exit 0, the typo goes unnoticed

Reject the combination instead.  This does not change what happens when
--trace is given: an invalid event still fails with "Error enabling
event", and a valid one still works.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -203,6 +203,19 @@
 	}
 
 
+	/*
+	 * -e, --filter and --trigger configure events of the trace instance
+	 * that --trace creates.  Without it there is no instance to put them
+	 * in, and they used to be dropped without a word.
+	 */
+	if (params->events &&
+	    !params->threshold_actions.present[ACTION_TRACE_OUTPUT] &&
+	    !params->end_actions.present[ACTION_TRACE_OUTPUT]) {
+		err_msg("-e, --filter and --trigger need --trace or --on-end trace\n");
+		retval = 1;
+		goto out_free;
+	}
+
 	if (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
 	    params->end_actions.present[ACTION_TRACE_OUTPUT]) {
 		tool->record = osnoise_init_trace_tool(ops->tracer);

