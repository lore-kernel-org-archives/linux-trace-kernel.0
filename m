Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93A26E144
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890782; cv=none; b=NfIsE4Z9/szr5CSp1661MAuHyF5VBAOQl69GNn5MawrxfIuFjrmQbz9hq/Oz5DOKjLKn7n9RMtpKO2+fqiHa1erwETV6fynNjyQ+Gsbxk7+b5Rcn2eogUNZhW+Pk6uKOJkkIU3GPY0ZPR3SB35fxkTsjkt908M8RQAZRgRuukH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890782; c=relaxed/simple;
	bh=T3WqaKFajOXYI4xT/HHQzwQadyk92+xJJiewco4RkMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDqQB6xRCaHFrhm5xO1YgzM8dFuxrO6wd0X+txmVcH7qDZ+s5SSsjesqqZFok/8YeIxRTUHJPbuazA9lh5p9XZDsx3vQM09Spa/G0sMo5CS3VswYys3jFoUKsoGXWXPzDh7Hm96EsRxUdVnWtbkFooLlY1EBrJA0AOm2sRk40bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c17Iime3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c17Iime3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrj69v0wMbrjqyVL8ZJgdms9U8Tlsf91aA0vGu2Q1FM=;
	b=c17Iime3fJHD0dnoUPTTm83N+ii+zJdHbom2TPgdOiwCuWxtl9WRnZvQ+lOKVKJ7AlyY75
	jq8y3YWeI3H10DW5Jbl7qsJd2nsG8G8+I/w41/GQjm0rQHBPGGJmDRzPdyohErYJQvlX6u
	hq0O+K4674MkGpUY+ymf34GzadIRBeQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-4Crv1OGnO8iO2TC5875xpw-1; Tue,
 18 Feb 2025 09:59:38 -0500
X-MC-Unique: 4Crv1OGnO8iO2TC5875xpw-1
X-Mimecast-MFC-AGG-ID: 4Crv1OGnO8iO2TC5875xpw_1739890777
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67F421801A29;
	Tue, 18 Feb 2025 14:59:37 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4D141800362;
	Tue, 18 Feb 2025 14:59:33 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 8/8] rtla/timerlat: Test BPF mode
Date: Tue, 18 Feb 2025 15:58:59 +0100
Message-ID: <20250218145859.27762-9-tglozar@redhat.com>
In-Reply-To: <20250218145859.27762-1-tglozar@redhat.com>
References: <20250218145859.27762-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Using the RTLA_NO_BPF environmental variable, execute rtla-timerlat
tests both with and without BPF support to cover both paths.

If rtla is built without BPF or the osnoise:timerlat_sample trace event
is not available, test only the non-BPF path.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index e86f40e5749e..e939ff71d6be 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -4,7 +4,20 @@ source tests/engine.sh
 test_begin
 
 set_timeout 2m
+timerlat_sample_event='/sys/kernel/tracing/events/osnoise/timerlat_sample'
 
+if ldd $RTLA | grep libbpf >/dev/null && [ -d "$timerlat_sample_event" ]
+then
+	# rtla build with BPF and system supports BPF mode
+	no_bpf_options='0 1'
+else
+	no_bpf_options='1'
+fi
+
+# Do every test with and without BPF
+for option in $no_bpf_options
+do
+export RTLA_NO_BPF=$option
 check "verify help page" \
 	"timerlat --help"
 check "verify -s/--stack" \
@@ -23,5 +36,6 @@ check "verify -c/--cpus" \
 	"timerlat hist -c 0 -d 30s"
 check "hist test in nanoseconds" \
 	"timerlat hist -i 2 -c 0 -n -d 30s"
+done
 
 test_end
-- 
2.48.1

