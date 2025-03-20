Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB106224B04
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462750; cv=none; b=MLqi1c+Ij6d7GR9x2GkVqOpcPjZU0zYqGUnjkBTzcAm7mkAurfUTF+DZaCCvIsArqM7voeNs/6P8joOE9Gib2lrQO7/VIhlSrC0pHuFYZFCzll4JVH/NycZ0RHIG7cxILm5i0q7OnOcxGYOoRMwpW8NS37jvuj+3WTd6DN72Dps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462750; c=relaxed/simple;
	bh=afK5kfyLJ+jIjJ4vwjb3JDpdVL0cAE/6NVYqfX8hiBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTESof0VY1L+07nizq0KXBQYJTOlB4/Lte8KvyQaPWrplIwVF/AOUZMLMqx+88NCBGV8eIVbvDJEmQkSTMtaa7LvScbAE3H8glfy6PUhBf7JS7HQzudqBS98jEDMAZ6JRlaSWQP3UlZUcMFF6RFZFiKtTzIeWlJ782kr2h5Ytmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAOoyvJ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAOoyvJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742462747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wj+SBQ7tiNK5u+4wmenajZgLWXoMWGnFcZQdGUZeTQ=;
	b=BAOoyvJ3KfylcYqeOGUMA5/smO2ucRB2Ct7k+Xw9l+kKb9S/nKK7d7QQyTPoF9zMiTN1nX
	ke5XBTaHANzESiwVUH33InOXWU8k/SR8xKM54r1hz6xyCY0C9jlieVWrpN2BNpFtRt6a0t
	SeTr4BJp9bdexlf7ZBJZZpJ13EpHYyI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-XLPrVcufPTGkUeNvrHuEJg-1; Thu,
 20 Mar 2025 05:25:44 -0400
X-MC-Unique: XLPrVcufPTGkUeNvrHuEJg-1
X-Mimecast-MFC-AGG-ID: XLPrVcufPTGkUeNvrHuEJg_1742462743
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F96519560B1;
	Thu, 20 Mar 2025 09:25:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.73])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB22819560AF;
	Thu, 20 Mar 2025 09:25:40 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6/6] rtla/tests: Test setting default options
Date: Thu, 20 Mar 2025 10:25:00 +0100
Message-ID: <20250320092500.101385-7-tglozar@redhat.com>
In-Reply-To: <20250320092500.101385-1-tglozar@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add function to test engine to test with pre-set osnoise options, and
use it to test whether osnoise period (as an example) is set correctly.

The test works by pre-setting a high period of 10 minutes and stop on
threshold. Thus, it is easy to check whether rtla is properly resetting
the period to default: if it is, the test will complete on time, since
the first sample will overflow the threshold. If not, it will time out.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh | 26 ++++++++++++++++++++++++++
 tools/tracing/rtla/tests/osnoise.t |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 5db8aa4bc031..b1697b3e3f52 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -61,6 +61,32 @@ check() {
 	fi
 }
 
+check_with_osnoise_options() {
+	# Do the same as "check", but with pre-set osnoise options.
+	# Note: rtla should reset the osnoise options, this is used to test
+	# if it indeed does so.
+	# Save original arguments
+	arg1=$1
+	arg2=$2
+
+	# Apply osnoise options (if not dry run)
+	if [ -n "$TEST_COUNT" ]
+	then
+		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
+		shift
+		while shift
+		do
+			[ "$1" == "" ] && continue
+			option=$(echo $1 | cut -d '=' -f 1)
+			value=$(echo $1 | cut -d '=' -f 2)
+			echo "option: $option, value: $value"
+			echo "$value" > "/sys/kernel/tracing/osnoise/$option" || return 1
+		done
+	fi
+
+	NO_RESET_OSNOISE=1 check "$arg1" "$arg2"
+}
+
 set_timeout() {
 	TIMEOUT="timeout -v -k 15s $1"
 }
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 86596e547893..e5995c03c790 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -16,4 +16,10 @@ check "verify the  --trace param" \
 check "verify the --entries/-E param" \
 	"osnoise hist -P F:1 -c 0 -r 900000 -d 1M -b 10 -E 25"
 
+# Test setting default period by putting an absurdly high period
+# and stopping on threshold.
+# If default period is not set, this will time out.
+check_with_osnoise_options "apply default period" \
+	"osnoise hist -s 1" period_us=600000000
+
 test_end
-- 
2.48.1

