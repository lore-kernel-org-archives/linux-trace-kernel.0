Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BA2F39B4;
	Sun,  7 Jun 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780817409; cv=none; b=DfP0ldrM924duMHudAaw4b0XRC5VuFGauEE5bWrWkMV+1/fQ7CMv7abDVMQNo24ALj/F+IGz2V7kfEbomSI4PqZwksuMPKVQTjzicnnaDoIg17v9z8KMGP+uAfLstTlZUsS9MYkMd223uYuYp6RxStd5IvKOQHMro4Ezwwm2raM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780817409; c=relaxed/simple;
	bh=EIVnlWTnHln2Wag6ziDjE0AZSlMzz0t8b3BEMBYgzIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuzh1DUkUh02vlZQrQYe0PIXfgFpoOyQljE+dGnWfRKn5i44qcbQ64dXc+h2EFXhdvt6mVrKohiX9zDcUpOmEGbHRIIMp3gbuuv6wlwKtdR/RV8i5zpNfBLBBILpr6u3ikmguDc0bpjXiT/gYlCF8C5z/+w+BtI+QmBONz0B88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=gLqdF+KH; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="gLqdF+KH"
Received: from hwang4-g16.. (unknown [120.244.199.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5B2704204A;
	Sun,  7 Jun 2026 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1780817085;
	bh=MTQ1uFkHflg1N4pmfm0c7KCjP6xZaLhbavIryo1F36A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=gLqdF+KHuMigbdeRiDAExikFkbFgkFpIqGgTg6fnD9iIghjlsjMKBxHOVE6sUw/X3
	 1B7iUcNKZBPirO9DzdV7/uzSwvTR+mseYQKSllAdhkjoHMKzWL2TFtVhF4TRVd+Zmi
	 J5csvX8XjHE+TS6k1PDKTq0U6xeUu+t0Bx+cJ+gV4/zZ7+cPIiv5pYLhx4shKdhOmd
	 m4lTcwpvIaVy+TdUh2SxjU+7cknuBB//WCJeHT8LcWKvXIOu4tVf5UiyPGug7GQzSS
	 EJfX77JJyyR2iYQPvDVLTLq2kZuGFFx+h7l/LU7+MHck5jncxu7IIvXuUs99HjIFMf
	 kwIbOfilFJyOVHJUkva42Ab/KUh3J7wc5+NlPx6DOL8fuWXasb3OIUprpl02GkYuYb
	 GzKXs6fwC9MN355auRZ8BCfF+U4QnBJDqVt+dZ1x8No484Hhdp6pkvanYIdzMCJltg
	 feS8LhFvlGzRrYeePVQ1pha0MSnh9bZmp7pHgqyAgMlpEGfwSD4afzb4/tOvVXN3uF
	 jIjFKDhtgOs1miaU/WhcJewLyr/eI/824jh8fBz5rIG5z9q9CTMK3QqG+96UW0u374
	 1HvaHSU83IVX+kKPMr7+eW1z54iLs5LMEfvvECNvrKeOEKCnON9CeDqB2TqyLoMA3/
	 CO5bgT1gsQsvaDhIsTgL3IZk=
From: Hui Wang <hui.wang@canonical.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	pjw@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	shuah@kernel.org,
	wangfushuai@baidu.com,
	linux-kselftest@vger.kernel.org
Cc: hui.wang@canonical.com
Subject: [PATCH 2/2] selftests/ftrace: Account for 8-byte aligned trace_marker_raw events
Date: Sun,  7 Jun 2026 15:24:31 +0800
Message-ID: <20260607072431.125633-3-hui.wang@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607072431.125633-1-hui.wang@canonical.com>
References: <20260607072431.125633-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_marker_raw.tc assumes that the raw marker payload length
reported in trace_pipe is the result of int((id + 3) / 4) * 4, but
that is not true on kernels with CONFIG_HAVE_64BIT_ALIGNED_ACCESS
enabled.

With forced 8-byte alignment, the ring buffer event forces 8-byte
alignment. The event length is stored in array[0], the payload data
and id are placed in a struct raw_data_entry which is stored starting
at array[1]. In this case, the printed payload data length is 8*N+4
bytes.

To make the testcase pass in this case, add a kconfig_enabled() helper
and use it to detect CONFIG_HAVE_64BIT_ALIGNED_ACCESS so
trace_marker_raw.tc can calculate the expected length correctly.

Assisted-by: Copilot:gpt-5.5
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 .../ftrace/test.d/00basic/trace_marker_raw.tc | 16 +++++++--
 .../testing/selftests/ftrace/test.d/functions | 33 +++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index 8e905d4fe6dd..beda0f8627b3 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -15,6 +15,11 @@ is_little_endian() {
 }
 
 little=`is_little_endian`
+raw_data_align=4
+
+if kconfig_enabled CONFIG_HAVE_64BIT_ALIGNED_ACCESS; then
+       raw_data_align=8
+fi
 
 make_str() {
 	id=$1
@@ -60,7 +65,8 @@ test_multiple_writes() {
 	echo stop > trace_marker
 
 	# Check to make sure the number of entries is the id (rounded up by 4)
-	awk '/.*: # [0-9a-f]* / {
+	# or is (((id + 3) rounded by 8) + 4) if raw_data_align is 8
+	awk -v data_align=$raw_data_align '/.*: # [0-9a-f]* / {
 			print;
 			cnt = -1;
 			for (i = 0; i < NF; i++) {
@@ -69,8 +75,12 @@ test_multiple_writes() {
 					i++;
 					cnt = strtonum("0x" $i);
 					num = NF - (i + 1);
-					# The number of items is always rounded up by 4
-					cnt2 = int((cnt + 3) / 4) * 4;
+					# The number of items is rounded up by 4
+					# or is (8 * N + 4) if data_align is 8
+					if (data_align == 4)
+						cnt2 = int((cnt + 3) / 4) * 4;
+					else
+						cnt2 = int((cnt + 3) / 8) * 8 + 4;
 					if (cnt2 != num) {
 						exit 1;
 					}
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 826141e299e5..0f778087d81b 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -177,6 +177,39 @@ check_awk_strtonum() { # strtonum is GNU awk extension
     awk 'BEGIN{strtonum("0x1")}'
 }
 
+# a helper to check if a kconfig is enabled or not
+# return value: 0 (if kconfig is enabled)
+#               1 (if kconfig is not enabled)
+#               2 (if the config files don't exist or are unreadable)
+kconfig_enabled() { # config-name
+    local config="$1"
+    local uname_r=`uname -r`
+    local config_file
+
+    case "$config" in
+    CONFIG_*) ;;
+    *) config="CONFIG_$config" ;;
+    esac
+
+    if [ -f /proc/config.gz ] && zgrep --version >/dev/null 2>&1; then
+        zgrep -Eq "^${config}=(y|m)$" /proc/config.gz 2>/dev/null
+        return $?
+    fi
+
+    for config_file in \
+        /boot/config-$uname_r \
+        /lib/modules/$uname_r/config \
+        /lib/modules/$uname_r/build/.config
+    do
+        if [ -f "$config_file" ]; then
+            grep -Eq "^${config}=(y|m)$" "$config_file"
+            return $?
+        fi
+    done
+
+    return 2
+}
+
 LOCALHOST=127.0.0.1
 
 yield() {
-- 
2.43.0

