Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260755;
	b=XkO491/cqkJh/M7Pn7NJdFWxAYCZlc8/5lOYBRSPOhiD2ZpJ2DRAfGZM1UaYNjPNPYSk
	 VEvqcX7BaOHm3YFRwzsiBfkHx1oqQSzMLOsCb4xOMZDsbak+6MiBiFg6tXhIQ/jfwLq9J
	 pWNivwGdo7kvDLSHC3UK9hEm/JwKDRqk8dV1AEMG19UaNZ+nYf4vQcHfwgcIZXe4idU4F
	 xFmzuZ8VnQ/sNaf3HhhgH+miS1dG5nz7vNyk4/kaO45N5FcRvSlPo3hbWrETdd9xE8z4I
	 4enI65iA9yyi4yA2xvdmjpj4sXrL4dsYQbh4evIEj2Vd1i2RQurJzZ6AjCq5v6G1qUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8S5/KqNfuIt27SJJNZdfEe4DOCxa4rr3UivWTDl1Z8Y=;
	b=ELqMNmsyD6g2idNdwvvlpphTMhhqeigIYpHUAPW5Y3s2GZArJ4zi1zz3N5fTsRBB5k2q
	 ZPBbA4908uorMHBfEPqbTbjd+95FL07jGIQ15Ofx7e/Ugp6DSEWiiVU6KHy5OCbXJxfHm
	 WiOplQDY02gq2A+6FeJXlF5608HmEmxXGXuAV6nK+AP8sceGyG+AW7FMXpGRpe85b+lle
	 uBCPq6ZkNy+MPb+EngV/n+KMFePE871rIxAf0/GIa/PDexkS2Zf/eI64hIh6xiRb6kp+o
	 QKc1L15UqTGTZc0ZzFeQHllWlhUiqLv9Xtw61Ei5nZrP7nRqCI47WPcqyZoBL9Kc8TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PkUddhVr;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD5606A320
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 11:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11CD5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PkUddhVr
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b41e5a1719so692181a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 03:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260754; x=1795865554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8S5/KqNfuIt27SJJNZdfEe4DOCxa4rr3UivWTDl1Z8Y=;
        b=PkUddhVrl1K8nFVNaQ2QtEKIb42WmIKcT7K+GX5lkAdXBr3zwbFRb291hkVlXL65Ao
         Oo0CfwmA8DjRvJKGQB4ahTkPBUndK4CsLYsDSIf1FrNHynsNrhxZVk3qG45F744lB1tq
         mMnQw+hMZ8ytZmYS5syooPOWmabUwIPVxqmhQ+S6b2PKsRKuYff6VaTkrAGnvBLrUn2t
         bPjUIj8GDIPaRN9CRCHzSoPNqS2BzksOcNnL2ir6TOciivvo0ZmIyYPDU0q3Uy6OVqE3
         JadJO3tQdFUTnF1ppFGRPWnRpaidpoSZYW0+L5pFR+dr+ljh+WSUfx8HZL3JmSg7sv81
         lHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260754; x=1795865554;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8S5/KqNfuIt27SJJNZdfEe4DOCxa4rr3UivWTDl1Z8Y=;
        b=adxY17rwjMifGxbEcZoiThwit7KVIsik6KpE7B7zsdMmhEhG5OqCraIc/8WiU520zn
         6B2E7Wdw+i6J8dzb4DkIOfJX6BizmX6jjEndQ8bv648ym8GGo6kfNj9OXydLFOTrGFST
         rGVBM35IJc7cEIlUwNT2cAlexTDzyuqR0Nbb7WnXSnm8bUJuB6O6e4XtNcSDrxZ2b6fg
         3QaghWBPcA3wlYmFKyoaKhZUcjvjwDkowvn0iC+CLTW9jEPi5W8jvVa4VTo3QftrOXvk
         uerllKzMQSBpo04qs6jvExjRvD8272M66P+7YFd1rKl/Na5yG8nJbS709Nr2Nrqj2KoL
         kjaA==
X-Gm-Message-State: APuU4Z/PpuXlJWVO9zuEgQslpdP4LCCH81ziwtYuK53+X9s2eU8wquOG
	SoY+xzKYy+V6kKea+DoMaZPytQv4QzORnrYg80DscJQfKhwyvQYqI8g3WtBK1g==
X-Gm-Gg: AZFdTZeGrzfvpz1CJWSuPi6swt17OiIP2mnrp2mHUNBmmBddtzoX6c6ZTK7yAG2CpTy
	ezJQHYPgXvfg5ScILhvk9VArbSxQq7gnJSAHTZZlVltzonTCrus0D/i20e1d+wLPw/PWIhPo2X6
	QTJTcmu+HWM8BWMbb3HOYKdFABKy0Q3FoXAsIVFRGY8VjpaFejBQh8o6y8phr2kFsQg4q50ErOE
	fSk8OzPjc1dJS7y2Wq7PjWKjQ5xKh58vLXLR7AjjamdxFPdH7lKHmYIM8fwzFwE/X5ZjLp7RSFQ
	uCMyg9XGKlckNcfx9crJ40CKTiCvVD4AIRQg7krZDSk91/18rSDf/9o0H9QOih43hrZAdKJA16s
	/x3ghw7IQkI8CJt4oVqJMt1pPdqfeeBAlcS3DJ+lDfEMdzdqtKND4TfuPNMvqrv+MQfoxc9Bppa
	yODtSQhwHl9CIRC60GOrjXNkGoYm0nwApbSyl2y3iG9cWRogam7APT1Zn6uwCTcE+pYlCungNJZ
	k/eYDNPaHzu561JuKDLUCCDw0rQAFMSCkCewn8IpxQq+SrqZoYZTLwXeztWbf1NfToZL9FJmDcN
	vPgO6/eDU1Qnqm5LjhkmSXkXTCVfeGK/5wO/9CqsVcADwA==
X-Received: by 2002:a17:90b:2cce:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3b41c982ee6mr5452196a91.46.1795260754374;
        Sat, 21 Nov 2026 03:32:34 -0800 (PST)
Received: from [127.0.1.1] ([2408:840d:6830:46f1:7c60:7a01:9164:e1a0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm11340835a91.15.2026.11.21.03.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:32:33 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] rtla: handle SIGTERM during a run
Date: Sat, 21 Nov 2026 19:31:27 +0800
Message-ID: <328ecfadb98649f317985124b6b49bae2d356bcf.1795258353.git.chaosheng.qu.linux@gmail.com>
In-Reply-To: <cover.1795258353.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795258353.git.chaosheng.qu.linux@gmail.com>
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

rtla installs a handler for SIGINT, and for SIGALRM when a duration is
given, but not for SIGTERM.  A run stopped by the system - a shutdown or
a service manager - therefore dies without going through the cleanup
path and leaves its tracefs instance behind, so the next invocation
finds the instance name in use.

Install the same handler for SIGTERM, and restore the default
disposition in unset_signals().

Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between osnoise/timerlat and hist/top")
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 tools/tracing/rtla/src/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 8c7f5e75b..b86a60076 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -39,6 +39,7 @@ static void stop_trace(int sig)
 static void set_signals(struct common_params *params)
 {
 	signal(SIGINT, stop_trace);
+	signal(SIGTERM, stop_trace);
 	if (params->duration) {
 		signal(SIGALRM, stop_trace);
 		alarm(params->duration);
@@ -51,6 +52,7 @@ static void set_signals(struct common_params *params)
 static void unset_signals(struct common_params *params)
 {
 	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
 	if (params->duration) {
 		alarm(0);
 		signal(SIGALRM, SIG_DFL);
-- 
2.43.0


