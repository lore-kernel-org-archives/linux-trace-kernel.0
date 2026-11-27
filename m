Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793608;
	b=q6VE2UkaP26ExjvQFlPyz4/6MiQeIovKtPn7sdp08g7Ppc+U9dxkIHmUuqU3ubHg13TE
	 PI7bxA8ylatCfmI5QULT7sVXOakPUHp+SDEDKlyZEgnlYKq+YQXCuQjGBVNfL82pNGXB/
	 FpzndlZY0l/eWAg8uSbvNnp6UD+NP9cjej0e7rB12+KDCOTVIstGuKgJdeLmfPoTZQdUO
	 xfJNTBDJODZ6KubbvLvhpMA3K1rkWMeP+rX7MKXkJYoHPI7ZaxUBHQWeaSY37553g8Txb
	 +vB6/aT0AMgu1PKMBDXb6XJfid2i4Tb7Lu1AKcleZl66uEkrCyX5oujlSMYCK8qkg7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793608;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=/GnUrfOswQvB6I9HfRtOPxKT0JFPLWdnN1Pg+eNzUq0=;
	b=0ozoDbQt7HkMo4zYR3DiKUnhaK71HCldSgI9djnOaIS3jXB5b7KXg9RtvCXB3WUCo1kE
	 jkZKTaGNojv5F5JnNNluAP6nKdVxqfibwMm0grtK6LdkUaQigogvh8dDx82FQmXbSNUUL
	 EHvFB0YKpG7AY/2UEpCg8Wf9NaRWMtw3pPbMDWh9MWEyDPK7sNElfJdFYCEQYxIi26Njv
	 /vVXenA/Cr74V8i+gg3fZ7HMZA/4hJCEmO0PT7kuV54DDc4IkuDp5GQ8Hz2mLIzokQV1i
	 BBY+zJEKoXS1cRzJN0INtlDO8LXSAXEI+HVnoBfuh4PAhztPYIEwgctEFdtJS7P+4tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dsGc+5vv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8D606A6A4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8E8D606A6A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dsGc+5vv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GnUrfOswQvB6I9HfRtOPxKT0JFPLWdnN1Pg+eNzUq0=;
	b=dsGc+5vvGgqWLCygSz7hctbvPFK49G0wv2VNytSV7moceoYPygpfbD/3/D0VhcPKizU+9k
	NdlNvePkjsyaa8r+ZImBUOsQRqx4EeLhqdvPj4XWJse8qlb5XWv9l+krJDLIqGGrS8hzZb
	F2pirIDlvDiggetnAyoI0sDUFxNsJko=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-hRtPShvUPZ-tViyWXke4TA-1; Fri,
 27 Nov 2026 15:33:23 +0000
X-MC-Unique: hRtPShvUPZ-tViyWXke4TA-1
X-Mimecast-MFC-AGG-ID: hRtPShvUPZ-tViyWXke4TA_1795793602
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C8091956079;
	Fri, 27 Nov 2026 15:33:22 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86E711955F76;
	Fri, 27 Nov 2026 15:33:20 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 10/10] Documentation/rtla: Document auto-analysis timestamps
Date: Fri, 27 Nov 2026 16:32:06 +0100
Message-ID: <20261127153206.134322-11-tglozar@redhat.com>
In-Reply-To: <20261127153206.134322-1-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yyiCkFmXfymUcNupkmMaSQJ64g2WnIHuLyC8TpzEElQ_1795793602
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Update the rtla-timerlat-top example to show the new auto-analysis
header, with the time elapsed since the beginning of the measurement and
the sequence number of the sample that hit the stop condition.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/rtla-timerlat-top.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 05959f1a4661b..58469a0b78dfa 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -76,7 +76,7 @@ higher is found::
    22 #12319     |        0         0         1        11 |        8         3        10        22
    23 #12320     |       28         0         1        28 |       41         3        11        41
   rtla timerlat hit stop tracing
-  ## CPU 23 hit stop tracing, analyzing it ##
+  [  0d 00:00:03.482] ## CPU 23 hit stop tracing, analyzing it ## (seqnum 4211)
   IRQ handler delay:                                        27.49 us (65.52 %)
   IRQ latency:                                              28.13 us
   Timerlat IRQ duration:                                     9.59 us (22.85 %)
@@ -109,6 +109,13 @@ higher is found::
     Max timerlat IRQ latency from idle: 17.48 us in cpu 4
   Saving trace to timerlat_trace.txt
 
+The value in brackets is the time elapsed since the beginning of the
+measurement on that CPU, in days, hours, minutes, seconds and milliseconds,
+followed by the sequence number of the timerlat sample that hit the stop
+condition. Both identify the sample that caused the trace to stop, which is
+useful when tracing is not stopped on the first occurrence, for example with
+**--on-threshold continue**.
+
 In this case, the major factor was the delay suffered by the *IRQ handler*
 that handles **timerlat** wakeup: *65.52%*. This can be caused by the
 current thread masking interrupts, which can be seen in the blocking
-- 
2.56.1

