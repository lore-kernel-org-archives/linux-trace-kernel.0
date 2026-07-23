Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FFE3E0C4D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792851; cv=none; b=usbqXOVHJph9qcfVF5VJttKq2dz8hwDl1FJjFYnqo1QdsmBoeZabSc2NTAulllj7DeUcZYQtO79+L3+aiJ2omkHQByQdwlAZaUBl+5sl1SzzFn6H2KFf2srLF/SkwGLTvccIKIeK9JxVEDcLo9YLbqD0uhyEHgQSu068O+Ec8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792851; c=relaxed/simple;
	bh=wdoYB9ksSQhCXncTt4fxSxJ3Mz7TvFITOT54NotPTXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CrM4QcC3nYkJamyC9W06ArEzwPbGZ5aacRxhY6kXQJWnTr/yfz1sPqbMUFgijGHEEvD0K0GOXMeDOIDWU0vxwFkoD1e46JoSqOw0YZcBF9EcdjnSe/JW1zm7G+WxUubNkP25+HEluFNSWT92t01lVQ+pVZmUF7w5sMEOwXCBf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7XrfCEk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7XrfCEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784792848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NS4LZld37qPIOcoXEkiVMtyQomhnvEW3v8Emy4S5hTY=;
	b=G7XrfCEk3efJ/vb981Pb6TFiHRzP/bPxYrimeGLJoeEbJ9FfpuWyCDlmDsmYfHCIRIG2fO
	vbuLpXoVEffbxFYIW+zeZcleHOZaNOFxEVH6sPYwUD0xkxO7QIm5w3ReFdpxzfdkTyTHt4
	bEBgqjVPeD9/S6kF3LOghawihBPyUO0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407--7MBmvfoPSCataVvgTb57Q-1; Thu,
 23 Jul 2026 03:47:24 -0400
X-MC-Unique: -7MBmvfoPSCataVvgTb57Q-1
X-Mimecast-MFC-AGG-ID: -7MBmvfoPSCataVvgTb57Q_1784792843
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 543C5182FA23;
	Thu, 23 Jul 2026 07:47:23 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBA37180029A;
	Thu, 23 Jul 2026 07:47:19 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 16/17] selftests/verification: Rearrange the wwnr_printk test
Date: Thu, 23 Jul 2026 09:45:33 +0200
Message-ID: <20260723074534.43521-17-gmonaco@redhat.com>
In-Reply-To: <20260723074534.43521-1-gmonaco@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: l2tCn8W52nNHiM5AZoWjLcIfQCCKM4c0k4wQ7pSViZE_1784792843
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The wwnr_printk test expects no reactions in some situations, after
fixing the bash assertion, the test is failing because expecting no
reaction after a previous step had reactions is flaky without making
sure all buffers are flushed.

Wait for reactions to be over when expected by polling dmesg for an
interval without any rv message.
Also simplify the load function to stop loads as soon as a reaction
occurs, this limits the number of lines to flush and makes tests overall
faster and more stable.

Reviewed-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V5:
    * Move wait for flush to avoid wwnr/printk selftest to hang
    V4:
    * Wait for dmesg to flush all messages after reactions

 .../verification/test.d/rv_wwnr_printk.tc     | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
index 96de95edb530..17e1edfb3902 100644
--- a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
+++ b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
@@ -4,11 +4,29 @@
 # requires: available_reactors wwnr:monitor printk:reactor stress-ng:program
 
 load() { # returns true if there was a reaction
-	local lines_before num
+	local lines_before num load_pid ret
 	num=$((($(nproc) + 1) / 2))
 	lines_before=$(dmesg | wc -l)
-	stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q
-	dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr does not allow event"
+	stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q &
+	load_pid=$!
+	timeout 5 dmesg -w | tail -n +$((lines_before + 1)) | \
+		grep -m 1 -q "rv: monitor wwnr does not allow event"
+	ret=$?
+	kill "$load_pid" || true
+	wait "$load_pid" || true
+	return $ret
+}
+
+# loads may flood the ringbuffer, wait for all pending printks (timeout at 2 minutes)
+wait_dmesg_flush() {
+	local last_before last_after
+	for _ in $(seq 400); do
+		last_before=$last_after
+		last_after=$(dmesg | grep "rv:" | tail -n 1 || true)
+		[ "$last_before" = "$last_after" ] && return 0
+		sleep .3
+	done
+	return 1
 }
 
 echo 1 > monitors/wwnr/enable
@@ -17,12 +35,16 @@ echo printk > monitors/wwnr/reactors
 load
 
 echo 0 > monitoring_on
+wait_dmesg_flush
+
 ! load || false
 echo 1 > monitoring_on
 
 load
 
 echo 0 > reacting_on
+wait_dmesg_flush
+
 ! load || false
 echo 1 > reacting_on
 
-- 
2.55.0

